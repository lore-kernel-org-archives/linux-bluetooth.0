Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1224078893.5268.2962.camel@cookie.hadess.net>
References: <48F1F7C0.4040705@powercraft.nl>
	<1223819361.31961.1763.camel@cookie.hadess.net>
	<48F5E741.7020907@powercraft.nl>
	<1224078893.5268.2962.camel@cookie.hadess.net>
Content-Type: multipart/mixed; boundary="=-R/WrVJmcQ8AsKgECDan2"
Date: Wed, 15 Oct 2008 16:09:25 +0100
Message-Id: <1224083365.5268.3130.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] Re:  Sony Bluetooth BD Remote Control
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-R/WrVJmcQ8AsKgECDan2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2008-10-15 at 14:54 +0100, Bastien Nocera wrote:
> On Wed, 2008-10-15 at 14:51 +0200, Jelle de Jong wrote:
> <snip>
> > I have been working hard to get the bluetooth remote working, but
> > without success. I build new non official debian packages of the latest
> > git. I installed them with success. Loaded the new daemon tried to
> > connect with the bluetooth-wizard but it will not pair/connect. With the
> > hidd system is does connect but the situation is exactly the same as
> > with the ordinal report.
> > 
> > What commands are needed to get the device working? I would like to be
> > able to use xbindings --key to attach commands/keybindings to the keys.
> > 
> > See the attachment for all the steps I did, the new trials are on the
> > end of the documents.
> 
> I mentioned it in the past, I'll mention it again: DO NOT USE HIDD.
> 
> It doesn't have support for the PS3 BD remote. Make sure you have the
> latest git, I fixed the input event generation for the remote yesterday.

As it's just the pairing that doesn't work, the bug was in the wizard.
The code to restrict the PS3 detection to a particular OUI was causing
problems.

Patch attached.

--=-R/WrVJmcQ8AsKgECDan2
Content-Disposition: attachment;
	filename="0001-Add-another-OUI-for-the-PS3-BD-Remote.patch"
Content-Type: text/x-patch;
	name="0001-Add-another-OUI-for-the-PS3-BD-Remote.patch";
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>>From f774ba3252faf2eb49374f53b6c1d3883a99f45b Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 15 Oct 2008 16:07:38 +0100
Subject: [PATCH] Add another OUI for the PS3 BD Remote

Should fix pairing for this type of remote:
http://thread.gmane.org/gmane.linux.bluez.devel/16132/focus=16143
---
 wizard/main.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/wizard/main.c b/wizard/main.c
index 0854913..aba800b 100644
--- a/wizard/main.c
+++ b/wizard/main.c
@@ -209,7 +209,8 @@ static void prepare_callback(GtkWidget *assistant,
 			path = NULL;
 
 		/* Sony PlayStation 3 Remote Control */
-		if (g_str_has_prefix(target_address, "00:19:C1:") == TRUE &&
+		if ((g_str_has_prefix(target_address, "00:19:C1:") == TRUE ||
+		     g_str_has_prefix(target_address, "00:1E:3D:") == TRUE) &&
 					g_str_equal(target_name,
 						"BD Remote Control") == TRUE)
 			path = NULL;
-- 
1.5.5.2


--=-R/WrVJmcQ8AsKgECDan2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--=-R/WrVJmcQ8AsKgECDan2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-R/WrVJmcQ8AsKgECDan2--
