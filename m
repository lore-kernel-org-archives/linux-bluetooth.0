Return-Path: <cyrus@holtmann.org>
From: Jacob Siverskog <jacob@teenageengineering.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	Jacob Siverskog <jacob@teenageengineering.com>
Subject: [PATCH] core: Add ControllerMode to list of supported options
Date: Tue, 21 Oct 2014 13:28:27 +0200
Message-Id: <1413890907-23341-1-git-send-email-jacob@teenageengineering.com>
In-Reply-To: <3055BAC9-79FC-42D1-B8ED-292E8B5D2665@holtmann.org>
References: <3055BAC9-79FC-42D1-B8ED-292E8B5D2665@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Prevent warning message 'Unknown key ControllerMode in main.conf'.
---
 src/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/main.c b/src/main.c
index 191dc11..061060d 100644
--- a/src/main.c
+++ b/src/main.c
@@ -79,6 +79,7 @@ static const char * const supported_options[] = {
 	"ReverseServiceDiscovery",
 	"NameResolving",
 	"DebugKeys",
+	"ControllerMode",
 };
 
 GKeyFile *btd_get_main_conf(void)
-- 
1.8.3.2
