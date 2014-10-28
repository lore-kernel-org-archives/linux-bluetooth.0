Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/handsfree: Delay SCO connection after codec negotiation
Date: Tue, 28 Oct 2014 12:27:48 +0100
Message-Id: <1414495668-27321-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If SCO connection is created in same interation as OK response to
AT+BCC it may happen that SCO will connect before OK is send. Some
headset units don't handle this and reject SCO connection.

To fix that we delay SCO connection into next mainloop iteration.

Issue found on UPF49.

> ACL Data RX: Handle 2 flags 0x02 dlen 15                   [hci0] 2572.477715
      Channel: 66 len 11 [PSM 23 mode 0] {chan 2}
        19 ef 0f 41 54 2b 42 43 43 0d 55                 ...AT+BCC.U
< HCI Command: Setup Synchronous Co.. (0x01|0x0028) plen 17  [hci0] 2572.482384
        Handle: 2
        Transmit bandwidth: 8000
        Receive bandwidth: 8000
        Max latency: 13
        Setting: 0x0003
          Input Coding: Linear
          Input Data Format: 1's complement
          Input Sample Size: 8-bit
          # of bits padding at MSB: 0
          Air Coding Format: Transparent Data
        Retransmission effort: Optimize for link quality (0x02)
        Packet type: 0x0380
          3-EV3 may not be used
          2-EV5 may not be used
          3-EV5 may not be used
> HCI Event: Command Status (0x0f) plen 4                    [hci0] 2572.482903
      Setup Synchronous Connection (0x01|0x0028) ncmd 1
        Status: Success (0x00)
< ACL Data TX: Handle 2 flags 0x00 dlen 14                   [hci0] 2572.490198
      Channel: 6978 len 10 [PSM 3 mode 0] {chan 9}
        1b ef 0d 0d 0a 4f 4b 0d 0a 8f                    .....OK...
> HCI Event: Number of Completed Packets (0x13) plen 5       [hci0] 2572.493311
        Num handles: 1
        Handle: 2
        Count: 1
> HCI Event: Synchronous Connect Complete (0x2c) plen 17     [hci0] 2572.494013
        Status: Connection Rejected due to Unacceptable BD_ADDR (0x0f)
        Handle: 4
        Address: 20:68:9D:30:7B:9F (Liteon Technology Corporation)
        Link type: eSCO (0x02)
        Transmission interval: 0x00
        Retransmission window: 0x00
        RX packet length: 0
        TX packet length: 0
        Air mode: CVSD (0x02)
---
 android/handsfree.c | 50 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 356dbe0..a42e0a0 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -140,6 +140,7 @@ struct hf_device {
 
 	GIOChannel *sco;
 	guint sco_watch;
+	guint delay_sco;
 };
 
 static const struct indicator inds_defaults[] = {
@@ -254,6 +255,9 @@ static void device_destroy(struct hf_device *dev)
 	if (dev->sco_watch)
 		g_source_remove(dev->sco_watch);
 
+	if (dev->delay_sco)
+		g_source_remove(dev->delay_sco);
+
 	if (dev->sco) {
 		g_io_channel_shutdown(dev->sco, TRUE, NULL);
 		g_io_channel_unref(dev->sco);
@@ -1003,6 +1007,27 @@ static bool connect_sco(struct hf_device *dev)
 	return true;
 }
 
+static gboolean connect_sco_delayed(void *data)
+{
+	struct hf_device *dev = data;
+
+	DBG("");
+
+	dev->delay_sco = 0;
+
+	if (connect_sco(dev))
+		return FALSE;
+
+	/*
+	 * we try connect to negotiated codec. If it fails, and it isn't
+	 * CVSD codec, try connect CVSD
+	 */
+	if (dev->negotiated_codec != CODEC_ID_CVSD)
+		select_codec(dev, CODEC_ID_CVSD);
+
+	return FALSE;
+}
+
 static void at_cmd_bcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
@@ -1025,13 +1050,10 @@ static void at_cmd_bcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 			select_codec(dev, 0);
 			return;
 		}
-		/*
-		 * we try connect to negotiated codec. If it fails, and it isn't
-		 * CVSD codec, try connect CVSD
-		 */
-		if (!connect_sco(dev) && dev->negotiated_codec != CODEC_ID_CVSD)
-			select_codec(dev, CODEC_ID_CVSD);
 
+		/* Delay SCO connection so that OK response is send first */
+		if (dev->delay_sco == 0)
+			dev->delay_sco = g_idle_add(connect_sco_delayed, dev);
 		return;
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
@@ -1069,8 +1091,12 @@ static void at_cmd_bcs(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 
-		/* Connect sco with negotiated parameters */
-		connect_sco(dev);
+		/*
+		 * Delay SCO connection so that OK response is send first,
+		 * then connect with negotiated parameters.
+		 */
+		if (dev->delay_sco == 0)
+			dev->delay_sco = g_idle_add(connect_sco_delayed, dev);
 		return;
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
@@ -1741,8 +1767,14 @@ failed:
 
 static bool disconnect_sco(struct hf_device *dev)
 {
-	if (!dev->sco)
+	if (!dev->sco) {
+		if (dev->delay_sco) {
+			g_source_remove(dev->delay_sco);
+			dev->delay_sco = 0;
+		}
+
 		return false;
+	}
 
 	set_audio_state(dev, HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTING);
 
-- 
1.9.3

