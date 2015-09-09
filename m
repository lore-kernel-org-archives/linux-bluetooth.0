Return-Path: <cyrus@holtmann.org>
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH] Bluetooth: remove SCO fragments on connection close
Date: Wed,  9 Sep 2015 15:10:55 +0100
Message-Id: <1441807855-17685-1-git-send-email-kubax.t.pawlak@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SCO packet reassembler may have a fragment of SCO packet, from
previous connection, cached and not removed when SCO connection
is ended. Packets from new SCO connection are then going to be
attached to that fragment, creating an invalid SCO packets.

Controllers like Intel's WilkinsPeak are always fragmenting
SCO packet into 3 parts (#1, #2, #3). Packet #1 contains
SCO header and audio data, others just audio data. if there is
a fragment cached from previous connection, i.e. #1, first
SCO packet from new connection is going to be attached to it
creating packet consisting of fragments #1-#1-#2. This will
be forwarded to upper layers. After that, fragment #3 is going
to be used as a starting point for another SCO packet.
It does not contain a SCO header, but the code expects it,
casts a SCO header structure on it, and reads whatever audio
data happens to be there as SCO packet length and handle.
>From that point on, we are assembling random data into SCO
packets. Usually it recovers quickly as initial audio data
usually contains mostly zeros (muted stream), but setups
of over 4 seconds were observed.
Issue manifests itself by printing on the console:
Bluetooth: hci0 SCO packet for unknown connection handle 48
Bluetooth: hci0 SCO packet for unknown connection handle 2560
Bluetooth: hci0 SCO packet for unknown connection handle 12288
It may also show random handles if audio data was non-zeroed.
Hcidump shows SCO packets with random length and handles.

Few messages with handle 0 at connection creation are OK
for some controllers (like WilkinsPeak), as there are SCO packets
with zeroed handle at the beginning (possible controller bug).
Few of such messages at connection end, with a handle looking
OK (around 256, 512, 768 ...) is also OK, as these are last
SCO packets that were assembled and sent up, before connection
was broken, but were not handled in time.

Signed-off-by: Kuba Pawlak <kubax.t.pawlak@intel.com>
---
 drivers/bluetooth/btusb.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9521b7bcc22d61b7690a928bc09500c883fe5495..e712be14cd745bf32149bee037d727c2fed2fcef 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -516,6 +516,18 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 	return err;
 }
 
+static int btusb_remove_sco_fragment(struct btusb_data *data)
+{
+	int err = 0;
+
+	spin_lock(&data->rxlock);
+	kfree_skb(data->sco_skb);
+	data->sco_skb = NULL;
+	spin_unlock(&data->rxlock);
+
+	return err;
+}
+
 static int btusb_recv_isoc(struct btusb_data *data, void *buffer, int count)
 {
 	struct sk_buff *skb;
@@ -777,6 +789,7 @@ static void btusb_isoc_complete(struct urb *urb)
 			}
 		}
 	} else if (urb->status == -ENOENT) {
+		btusb_remove_sco_fragment(data);
 		/* Avoid suspend failed when usb_kill_urb */
 		return;
 	}
-- 
1.9.3

