Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 17 Jan 2017 12:35:06 +0530 (IST)
From: Mallikarjun Phulari <p.mallikarjun@globaledgesoft.com>
To: Maxime Chevallier <maxime.chevallier@smile.fr>
Cc: linux-bluetooth@vger.kernel.org, luiz dentz <luiz.dentz@gmail.com>
Message-ID: <947643683.19966188.1484636706688.JavaMail.zimbra@globaledgesoft.com>
In-Reply-To: <1482402965-9462-1-git-send-email-maxime.chevallier@smile.fr>
References: <1482402965-9462-1-git-send-email-maxime.chevallier@smile.fr>
Subject: Re: [PATCH 1/2] tools/btgatt-client: Fix set-security interactive
 command
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi i am running heart-rate service using gatt-server.
And i am using gatttool as client.
gatt-server with default security level "low" is working fine.
But when try different security levels "medium" and "high" with -s option, it is not connecting with the gatttool.

What might be the problem??

Thanks & Regards
Mallikarjun Phulari

----- Original Message -----
From: "Maxime Chevallier" <maxime.chevallier@smile.fr>
To: linux-bluetooth@vger.kernel.org
Cc: "luiz dentz" <luiz.dentz@gmail.com>, "Maxime Chevallier" <maxime.chevallier@smile.fr>
Sent: Thursday, December 22, 2016 4:06:04 PM
Subject: [PATCH 1/2] tools/btgatt-client: Fix set-security interactive command

Fix the interactive "set-security" command in btgatt-client, that would
always fail due to bad initialization of argv buffer :

[GATT client]# set-security 2
Usage: set_security <level>
level: 1-3
e.g.:
        set-sec-level 2
---
 tools/btgatt-client.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 40a03b1..afe00aa 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -1198,8 +1198,7 @@ static void set_security_usage(void)
 
 static void cmd_set_security(struct client *cli, char *cmd_str)
 {
-	char *argvbuf[1];
-	char **argv = argvbuf;
+	char *argv[2];
 	int argc = 0;
 	char *endptr = NULL;
 	int level;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Disclaimer:- The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy all copies of this message and any attachments. The views expressed in this E-mail message (including the enclosure/(s) or attachment/(s) if any) are those of the individual sender, except where the sender expressly, and with authority, states them to be the views of GlobalEdge. Before opening any mail and attachments please check them for viruses .GlobalEdge does not accept any liability for virus infected mails.

