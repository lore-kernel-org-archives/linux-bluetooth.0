Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 09/10] gap: Map Appearance value 0x0000 to unknown
Date: Wed, 15 Aug 2012 11:20:06 -0300
Message-Id: <1345040407-17767-10-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345040407-17767-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345040407-17767-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to Bluetooth SIG Assigned numbers, Appearance characteristic
value 0x0000 is designated to "unknown".
---
 src/dbus-common.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/dbus-common.c b/src/dbus-common.c
index 7e1bc94..fb55027 100644
--- a/src/dbus-common.c
+++ b/src/dbus-common.c
@@ -247,6 +247,8 @@ const char *class_to_icon(uint32_t class)
 const char *gap_appearance_to_icon(uint16_t appearance)
 {
 	switch ((appearance & 0xffc0) >> 6) {
+	case 0x00:
+		return "unknown";
 	case 0x01:
 		return "phone";
 	case 0x02:
-- 
1.7.8.6

