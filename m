Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/9 v3] AVDTP: Do not respond ABORT command with invalid id
Date: Fri, 15 Jun 2012 17:41:39 +0300
Message-Id: <1339771301-24032-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1339771301-24032-1-git-send-email-luiz.dentz@gmail.com>
References: <1339771301-24032-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

AVDTP spec, 8.15.2 Abort Response:

  "If an AVDTP_ABORT_CMD contains an invalid SEID, no response shall be
  sent."
---
 audio/avdtp.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 736eed7..e9dea6c 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -1948,10 +1948,8 @@ static gboolean avdtp_abort_cmd(struct avdtp *session, uint8_t transaction,
 	}
 
 	sep = find_local_sep_by_seid(session->server, req->acp_seid);
-	if (!sep || !sep->stream) {
-		err = AVDTP_BAD_ACP_SEID;
-		goto failed;
-	}
+	if (!sep || !sep->stream)
+		return TRUE;
 
 	if (sep->ind && sep->ind->abort) {
 		if (!sep->ind->abort(session, sep, sep->stream, &err,
-- 
1.7.10.2

