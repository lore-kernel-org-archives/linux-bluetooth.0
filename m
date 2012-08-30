Return-Path: <cyrus@holtmann.org>
From: Vani-dineshbhai PATEL X <vani.patel@stericsson.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 30 Aug 2012 07:09:56 +0200
Subject: [PATCH BlueZ V6 4/5] AVRCP: Register/Unregister Browsing handler
Message-ID: <747C1E83C744F44E9ACFB89FAEEC2C7B23D4AD959A@EXDCVYMBSTM005.EQ1STM.local>
References: <747C1E83C744F44E9ACFB89FAEEC2C7B23D4A4EAC9@EXDCVYMBSTM005.EQ1STM.local>
In-Reply-To: <747C1E83C744F44E9ACFB89FAEEC2C7B23D4A4EAC9@EXDCVYMBSTM005.EQ1STM.local>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From b9980403f222d3f56ec1a0046e7bd13d06828976 Mon Sep 17 00:00:00 2001
From: Vani Patel <vani.patel@stericsson.com>
Date: Thu, 2 Aug 2012 17:05:03 +0530
Subject: [PATCH BlueZ V6 4/5] AVRCP: Register/Unregister Browsing handler

Add functions to register and unregister Browsing
handler
---
audio/avctp.c |   24 ++++++++++++++++++++++++
audio/avctp.h |    8 ++++++++
2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index a159498..ed6efbe 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -157,6 +157,11 @@ struct avctp_pdu_handler {
               unsigned int id;
};

+struct avctp_browsing_pdu_handler {
+              avctp_browsing_pdu_cb cb;
+              void *user_data;
+};
+
static struct {
               const char *name;
               uint8_t avc;
@@ -176,6 +181,7 @@ static GSList *callbacks = NULL;
static GSList *servers = NULL;
static GSList *control_handlers = NULL;
static uint8_t id = 0;
+static struct avctp_browsing_pdu_handler *browsing_handler = NULL;

 static void auth_cb(DBusError *derr, void *user_data);

@@ -1252,6 +1258,18 @@ unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_control_pdu_cb cb,
               return handler->id;
}

+unsigned int avctp_register_browsing_pdu_handler(avctp_browsing_pdu_cb cb,
+                                                                                                              void *user_data)
+{
+              unsigned int id = 0;
+
+              browsing_handler = g_new(struct avctp_browsing_pdu_handler, 1);
+              browsing_handler->cb = cb;
+              browsing_handler->user_data = user_data;
+
+              return ++id;
+}
+
gboolean avctp_unregister_pdu_handler(unsigned int id)
{
               GSList *l;
@@ -1270,6 +1288,12 @@ gboolean avctp_unregister_pdu_handler(unsigned int id)
               return FALSE;
}

+gboolean avctp_unregister_browsing_pdu_handler()
+{
+              g_free(browsing_handler);
+              return TRUE;
+}
+
struct avctp *avctp_connect(const bdaddr_t *src, const bdaddr_t *dst)
{
               struct avctp *session;
diff --git a/audio/avctp.h b/audio/avctp.h
index b80e300..3e1dabe 100644
--- a/audio/avctp.h
+++ b/audio/avctp.h
@@ -83,6 +83,10 @@ typedef size_t (*avctp_control_pdu_cb) (struct avctp *session,
typedef gboolean (*avctp_rsp_cb) (struct avctp *session, uint8_t code,
                                                                               uint8_t subunit, uint8_t *operands,
                                                                               size_t operand_count, void *user_data);
+typedef size_t (*avctp_browsing_pdu_cb) (struct avctp *session,
+                                                                              uint8_t transaction,
+                                                                              uint8_t *operands, size_t operand_count,
+                                                                              void *user_data);

 unsigned int avctp_add_state_cb(avctp_state_cb cb, void *user_data);
gboolean avctp_remove_state_cb(unsigned int id);
@@ -98,6 +102,10 @@ unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_control_pdu_cb cb,
                                                                                                               void *user_data);
gboolean avctp_unregister_pdu_handler(unsigned int id);

+unsigned int avctp_register_browsing_pdu_handler(avctp_browsing_pdu_cb cb,
+                                                                                                              void *user_data);
+
+gboolean avctp_unregister_browsing_pdu_handler();
int avctp_send_passthrough(struct avctp *session, uint8_t op);
int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
                                                               uint8_t code, uint8_t subunit,
-- 
1.7.5.4

Regards,
Vani
