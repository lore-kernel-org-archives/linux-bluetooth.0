Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] audio/avdtp: Fix resuming only the first SEID
Date: Mon, 10 Aug 2015 13:24:25 +0300
Message-Id: <1439202265-24485-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1439202265-24485-1-git-send-email-luiz.dentz@gmail.com>
References: <1439202265-24485-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

AVDTP_Start can contain several Stream Endpoing IDs to be resumed.
---
 android/avdtp.c        | 2 +-
 profiles/audio/avdtp.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/android/avdtp.c b/android/avdtp.c
index 1f79e74..908c0ca 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -1567,7 +1567,7 @@ static gboolean avdtp_start_cmd(struct avdtp *session, uint8_t transaction,
 	for (i = 0; i < seid_count; i++, seid++) {
 		failed_seid = seid->seid;
 
-		sep = find_local_sep_by_seid(session, req->first_seid.seid);
+		sep = find_local_sep_by_seid(session, seid->seid);
 		if (!sep || !sep->stream) {
 			err = AVDTP_BAD_ACP_SEID;
 			goto failed;
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 9c33373..52ee767 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1710,8 +1710,7 @@ static gboolean avdtp_start_cmd(struct avdtp *session, uint8_t transaction,
 	for (i = 0; i < seid_count; i++, seid++) {
 		failed_seid = seid->seid;
 
-		sep = find_local_sep_by_seid(session,
-					req->first_seid.seid);
+		sep = find_local_sep_by_seid(session, seid->seid);
 		if (!sep || !sep->stream) {
 			err = AVDTP_BAD_ACP_SEID;
 			goto failed;
-- 
2.1.0

