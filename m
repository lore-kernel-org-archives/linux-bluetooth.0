Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/2] Remove wrong checking for legacy devices
Date: Thu, 28 Apr 2011 19:34:30 -0300
Message-Id: <1304030070-6575-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1304030070-6575-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1304030070-6575-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Infer that the found device is a legacy device based on the presence
of its name in the storage is wrong.
---
 src/event.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/src/event.c b/src/event.c
index 5373e33..b873000 100644
--- a/src/event.c
+++ b/src/event.c
@@ -481,8 +481,6 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 
 	if (data)
 		legacy = FALSE;
-	else if (name == NULL)
-		legacy = TRUE;
 	else if (read_remote_features(local, peer, NULL, features) == 0) {
 		if (features[0] & 0x01)
 			legacy = FALSE;
-- 
1.7.5.rc3

