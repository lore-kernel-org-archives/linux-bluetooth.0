Return-Path: <cyrus@holtmann.org>
From: Lukasz Pawlik <lucas.pawlik@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Pawlik <lucas.pawlik@gmail.com>
Subject: [PATCH] Fix problem with handling CHLD=0 command
Date: Tue, 19 Oct 2010 14:32:04 +0200
Message-Id: <1287491524-8384-1-git-send-email-lucas.pawlik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch change handling of CHLD=0 command. Previously both calls
(held and waiting) were terminated when HS sent CHLD=0. Now all held
calls will be released or only incoming call will be rejected without
affecting any held calls.
---
 audio/telephony-maemo6.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index f4dfbde..33fd13f 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -784,8 +784,11 @@ void telephony_call_hold_req(void *telephony_device, const char *cmd)
 
 	switch (cmd[0]) {
 	case '0':
-		foreach_call_with_status(CSD_CALL_STATUS_HOLD, release_call);
-		foreach_call_with_status(CSD_CALL_STATUS_WAITING,
+		if (find_call_with_status(CSD_CALL_STATUS_WAITING))
+			foreach_call_with_status(CSD_CALL_STATUS_WAITING,
+								release_call);
+		else
+			foreach_call_with_status(CSD_CALL_STATUS_HOLD,
 								release_call);
 		break;
 	case '1':
-- 
1.7.0.4

