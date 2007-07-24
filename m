Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1185293793.3641.129.camel@cookie.hadess.net>
References: <1185293793.3641.129.camel@cookie.hadess.net>
Content-Type: multipart/mixed; boundary="=-zGKBIC7ryjorOxnyj3sh"
Date: Tue, 24 Jul 2007 17:20:05 +0100
Message-Id: <1185294005.3641.132.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Make BluetoothClient work on all adapters
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-zGKBIC7ryjorOxnyj3sh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2007-07-24 at 17:16 +0100, Bastien Nocera wrote:
> With this patch, we can now pass a NULL as the adapter to work with all
> the adapters. This is for use in the upcoming patch for the selector
> widget.

And a tiny patch to fix the test-client's compilation.

-- 
Bastien Nocera <hadess@hadess.net> 

--=-zGKBIC7ryjorOxnyj3sh
Content-Disposition: attachment; filename=bluez-gnome-fix-test-client.patch
Content-Type: text/x-patch; name=bluez-gnome-fix-test-client.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff --git a/common/test-client.c b/common/test-client.c
index ac32e80..68e8a82 100644
--- a/common/test-client.c
+++ b/common/test-client.c
@@ -144,7 +144,7 @@ int main(int argc, char *argv[])
 
 	gtk_main();
 
-	bluetooth_client_destroy(client);
+	g_object_unref(client);
 
 	return 0;
 }


--=-zGKBIC7ryjorOxnyj3sh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--=-zGKBIC7ryjorOxnyj3sh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-zGKBIC7ryjorOxnyj3sh--
