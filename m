Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <4.3.2-J.20040613230727.0638bee8@emi.s-direct.com>
To: bluez-users@lists.sourceforge.net
From: Tetsuo Shiraishi <tetsu@s-direct.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Subject: [Bluez-users] hcid pin problem
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 14 Jun 2004 00:08:14 +0900

Hello,

I could not get pin_helper to work, 
since I upgraded to bluez-utils-2.7 from bluez-utils-2.3.

Using system
- sh4-linux
- patch-2.4.24-mh5.gz 
- bluez-libs-2.7.tar.gz 
- bluez-utils-2.7.tar.gz 
- pin_helper in hcid.conf

I modified bluez-utils-2.7 as follows, so it work fine.

--- bluez-utils-2.7/hcid/security.c	Sun May  9 19:39:43 2004
+++ bluez-utils-2.7_mod/hcid/security.c	Sun Jun 13 22:53:29 2004
@@ -236,7 +236,7 @@
 {
 	pin_code_reply_cp pr;
 	struct sigaction sa;
-	char addr[12], str[255], *pin, name[20];
+	char addr[18], str[255], *pin, name[20];
 	FILE *pipe;
 	int ret, len;
 
Thanks,

Tetsuo 

//
//　　　白石哲夫　tetsu@s-direct.com
//　　　　　　　　tshiro@arion.ocn.ne.jp
//



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
