Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-U95OZfoBOoXiWm17T2P0"
Date: Tue, 06 Mar 2007 12:43:32 +0000
Message-Id: <1173185012.10237.7.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] Simple typo fix for bluez-utils
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-U95OZfoBOoXiWm17T2P0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Patch attached
-- 
Bastien Nocera <hadess@hadess.net> 

--=-U95OZfoBOoXiWm17T2P0
Content-Disposition: attachment; filename=bluez-utils-typo.patch
Content-Type: text/x-patch; name=bluez-utils-typo.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: hcid/dbus-api.txt
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-api.txt,v
retrieving revision 1.107
diff -u -p -r1.107 dbus-api.txt
--- hcid/dbus-api.txt	5 Mar 2007 14:43:04 -0000	1.107
+++ hcid/dbus-api.txt	6 Mar 2007 12:45:26 -0000
@@ -827,7 +827,7 @@ Methods		string GetAddress()
 			includes an inquiry procedure and remote device name
 			resolving.
 
-			On start up this process will generate a DiscoveryStart
+			On start up this process will generate a DiscoveryStarted
 			signal and then return RemoteDeviceFound and also
 			RemoteNameUpdated signals. If the procedure has been
 			finished an DiscoveryCompleted signal will be sent.

--=-U95OZfoBOoXiWm17T2P0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-U95OZfoBOoXiWm17T2P0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-U95OZfoBOoXiWm17T2P0--
