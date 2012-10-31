Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] AVCTP: Fix scope of transactions to be per channel
Date: Wed, 31 Oct 2012 12:04:57 +0200
Message-Id: <1351677897-2580-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

As per AVRCP spec:

  "It should be noted that transaction labels are scoped to an AVCTP
  channel, so an AVRCP specific AV/C command and an AVRCP specific
  browsing command may be outstanding at the same time with the same
  transaction label."
---
 audio/avctp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index 5f6a677..6ba25e4 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -150,6 +150,7 @@ struct avctp_pending_req {
 struct avctp_channel {
 	struct avctp *session;
 	GIOChannel *io;
+	uint8_t transaction;
 	guint watch;
 	uint16_t imtu;
 	uint16_t omtu;
@@ -1224,17 +1225,16 @@ static struct avctp_pending_req *pending_create(struct avctp_channel *chan,
 						GDestroyNotify destroy)
 {
 	struct avctp_pending_req *p;
-	static uint8_t transaction = 0;
 
 	p = g_new0(struct avctp_pending_req, 1);
 	p->chan = chan;
-	p->transaction = transaction;
+	p->transaction = chan->transaction;
 	p->process = process;
 	p->data = data;
 	p->destroy = destroy;
 
-	transaction++;
-	transaction %= 16;
+	chan->transaction++;
+	chan->transaction %= 16;
 
 	return p;
 }
-- 
1.7.11.7

