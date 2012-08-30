Return-Path: <cyrus@holtmann.org>
From: Vani-dineshbhai PATEL X <vani.patel@stericsson.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 30 Aug 2012 07:10:21 +0200
Subject: [PATCH BlueZ V6 5/5] AVRCP: Add handler for browsing pdu
Message-ID: <747C1E83C744F44E9ACFB89FAEEC2C7B23D4AD959B@EXDCVYMBSTM005.EQ1STM.local>
References: <747C1E83C744F44E9ACFB89FAEEC2C7B23D4A4EACA@EXDCVYMBSTM005.EQ1STM.local>
In-Reply-To: <747C1E83C744F44E9ACFB89FAEEC2C7B23D4A4EACA@EXDCVYMBSTM005.EQ1STM.local>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From c4bb95c4abf053bb727940c9c64a6fccb91234db Mon Sep 17 00:00:00 2001
From: Vani Patel <vani.patel@stericsson.com>
Date: Fri, 24 Aug 2012 16:36:00 +0530
Subject: [PATCH BlueZ V6 5/5] AVRCP: Add handler for browsing pdu

Implement generic handling of browsing
PDU IDs
---
audio/avctp.c |   27 ++++++++++++++++++--
audio/avrcp.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
2 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index 6005962..bc656d7 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -480,13 +480,12 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
                                                               gpointer data)
{
               struct avctp *session = data;
-              uint8_t  *buf;
+              uint8_t  *buf, *operands;
               struct avctp_header *avctp;
-              int ret;
+              int ret, packet_size, operand_count, sock;

                buf = avctp_read_data(&ret, session->browsing_mtu,
                                                                                               session->browsing_io);
-
               if (buf == NULL)
                               goto failed;

@@ -495,9 +494,31 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,

                avctp = (struct avctp_header *) buf;

+              DBG("AVCTP transaction %u, packet type %u, C/R %u, IPID %u, "
+                                              "PID 0x%04X",
+                                              avctp->transaction, avctp->packet_type,
+                                              avctp->cr, avctp->ipid, ntohs(avctp->pid));
+
               if (avctp->packet_type != AVCTP_PACKET_SINGLE)
                               goto failed;

+              operands = buf + AVCTP_HEADER_LENGTH;
+              ret -= AVCTP_HEADER_LENGTH;
+              operand_count = ret;
+
+              packet_size = AVCTP_HEADER_LENGTH;
+              avctp->cr = AVCTP_RESPONSE;
+              if (browsing_handler)
+                              packet_size += browsing_handler->cb(session, avctp->transaction,
+                                              operands, operand_count, browsing_handler->user_data);
+
+              if (packet_size != 0) {
+                              sock = g_io_channel_unix_get_fd(session->browsing_io);
+                              ret = write(sock, buf, packet_size);
+                              if (ret != packet_size)
+                                              goto failed;
+              }
+
               g_free(buf);
               return TRUE;

diff --git a/audio/avrcp.c b/audio/avrcp.c
index cd374a5..239ba25 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -94,6 +94,10 @@
#define AVRCP_ABORT_CONTINUING                  0x41
#define AVRCP_SET_ABSOLUTE_VOLUME           0x50

+#define AVRCP_INVALID_BROWSING_PDU       0x00
+
+#define AVRCP_GENERAL_REJECT                                         0xA0
+
/* Capabilities for AVRCP_GET_CAPABILITIES pdu */
#define CAP_COMPANY_ID                       0x02
#define CAP_EVENTS_SUPPORTED         0x03
@@ -141,6 +145,12 @@ struct avrcp_header {
#error "Unknown byte order"
#endif

+struct avrcp_browsing_header {
+              uint8_t browsing_pdu;
+              uint16_t param_len;
+} __attribute__ ((packed));
+#define AVRCP_BROWSING_HEADER_LENGTH 3
+
#define AVRCP_MTU    (AVC_MTU - AVC_HEADER_LENGTH)
#define AVRCP_PDU_MTU         (AVRCP_MTU - AVRCP_HEADER_LENGTH)

@@ -164,7 +174,9 @@ struct avrcp_player {
               struct audio_device *dev;

                unsigned int control_handler;
+              unsigned int browsing_handler;
               uint16_t registered_events;
+              uint8_t transaction;
               uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
               struct pending_pdu *pending_pdu;

@@ -1078,6 +1090,15 @@ static struct control_pdu_handler {
                               { },
};

+static struct pdu_browsing_handler {
+              uint8_t browsing_pdu;
+              void (*func) (struct avrcp_player *player,
+                                                                              struct avrcp_browsing_header *pdu);
+              } browsing_handlers[] = {
+                              { AVRCP_INVALID_BROWSING_PDU,
+                                                                              NULL },
+};
+
/* handle vendordep pdu inside an avctp packet */
static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
                                                                               uint8_t *code, uint8_t *subunit,
@@ -1137,6 +1158,49 @@ err_metadata:
               return AVRCP_HEADER_LENGTH + 1;
}

+static size_t handle_browsing_pdu(struct avctp *session,
+                                                                              uint8_t transaction, uint8_t *operands,
+                                                                              size_t operand_count, void *user_data)
+{
+              struct avrcp_player *player = user_data;
+              struct pdu_browsing_handler *b_handler;
+              struct avrcp_browsing_header *avrcp_browsing = (void *) operands;
+              uint8_t status;
+
+              operand_count += AVRCP_BROWSING_HEADER_LENGTH;
+
+              for (b_handler = browsing_handlers; b_handler; b_handler++) {
+                              if (b_handler->browsing_pdu == AVRCP_INVALID_BROWSING_PDU) {
+                                              b_handler = NULL;
+                                              break;
+                              }
+                              if (b_handler->browsing_pdu == avrcp_browsing->browsing_pdu)
+                                              break;
+              }
+
+              if (!b_handler) {
+                              avrcp_browsing->browsing_pdu = AVRCP_GENERAL_REJECT;
+                              status = AVRCP_STATUS_INVALID_COMMAND;
+                              goto err;
+              }
+
+              if (!b_handler->func) {
+                              status = AVRCP_STATUS_INVALID_PARAM;
+                              avrcp_browsing->param_len = htons(sizeof(status));
+                              goto err;
+              }
+
+              player->transaction = transaction;
+              b_handler->func(player, avrcp_browsing);
+              return AVRCP_BROWSING_HEADER_LENGTH + ntohs(avrcp_browsing->param_len);
+
+err:
+              avrcp_browsing->param_len = htons(sizeof(status));
+              memcpy(&operands[AVRCP_BROWSING_HEADER_LENGTH], &status,
+                                                                                                              (sizeof(status)));
+              return AVRCP_BROWSING_HEADER_LENGTH + sizeof(status);
+}
+
size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands)
{
               struct avrcp_header *pdu = (void *) operands;
@@ -1236,6 +1300,10 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
                                               avctp_unregister_pdu_handler(player->control_handler);
                                               player->control_handler = 0;
                               }
+                              if (player->browsing_handler) {
+                                              avctp_unregister_browsing_pdu_handler();
+                                              player->browsing_handler = 0;
+                              }

                                break;
               case AVCTP_STATE_CONNECTING:
@@ -1247,6 +1315,12 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
                                                                                                               AVC_OP_VENDORDEP,
                                                                                                               handle_vendordep_pdu,
                                                                                                               player);
+                              if (!player->browsing_handler)
+                                              player->browsing_handler =
+                                                                              avctp_register_browsing_pdu_handler(
+                                                                                                              handle_browsing_pdu,
+                                                                                                              player);
+
                               break;
               case AVCTP_STATE_CONNECTED:
                               rec = btd_device_get_record(dev->btd_dev, AVRCP_TARGET_UUID);
-- 
1.7.5.4

Regards,
Vani
