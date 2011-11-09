Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH] Add missing colon after case statement
Date: Wed,  9 Nov 2011 14:14:40 +0100
Message-Id: <1320844480-16499-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mgmt/main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mgmt/main.c b/mgmt/main.c
index 500827c..6c1d015 100644
--- a/mgmt/main.c
+++ b/mgmt/main.c
@@ -339,7 +339,7 @@ static void type2str(uint8_t type, char *str, size_t len)
 	case MGMT_ADDR_BREDR:
 		strncpy(str, "BR/EDR", len);
 		break;
-	case MGMT_ADDR_LE_PUBLIC
+	case MGMT_ADDR_LE_PUBLIC:
 		strncpy(str, "LE Public", len);
 		break;
 	case MGMT_ADDR_LE_RANDOM:
-- 
1.7.4.1

