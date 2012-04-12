Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 08/19] hciconfig: Remove unwanted NULL termination
Date: Thu, 12 Apr 2012 20:32:59 +0530
Message-id: <1334243001-17016-9-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Null termination is already doing inside the function
hci_read_local_name().
---
 tools/hciconfig.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index f1458b9..d618aa7 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -623,8 +623,6 @@ static void cmd_name(int ctl, int hdev, char *opt)
 				name[i] = '.';
 		}
 
-		name[248] = '\0';
-
 		print_dev_hdr(&di);
 		printf("\tName: '%s'\n", name);
 	}
-- 
1.7.4.1

