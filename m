Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 17/20] audio/avdtp: Add delay reporting in capabilities
Date: Fri, 27 Feb 2015 17:03:05 +0200
Message-Id: <1425049388-18333-18-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/audio/avdtp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 64e09fd..c0ded8d 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1427,6 +1427,12 @@ static gboolean avdtp_getcap_cmd(struct avdtp *session, uint8_t transaction,
 		g_free(cap);
 	}
 
+	if (get_all && sep->delay_reporting) {
+		ptr[0] = AVDTP_DELAY_REPORTING;
+		ptr[1] = 0x00;
+		rsp_size += 2;
+	}
+
 	g_slist_free(caps);
 
 	return avdtp_send(session, transaction, AVDTP_MSG_TYPE_ACCEPT, cmd,
-- 
2.1.0

