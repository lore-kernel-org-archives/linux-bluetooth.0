Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 12 Aug 2007 23:24:25 -0700
From: joe@perches.com
To: torvalds@linux-foundation.org, maxk@qualcomm.com, marcel@holtmann.org,
        linux-kernel@vger.kernel.org, bluez-devel@lists.sourceforge.net,
        akpm@linux-foundation.org
Message-ID: <46bff919.Rp2duBBGB6cu6MsA%joe@perches.com>
MIME-Version: 1.0
Subject: [Bluez-devel] [PATCH] [96/2many] MAINTAINERS - BLUETOOTH SUBSYSTEM
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 912950f..763854e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -973,6 +973,9 @@ W:	http://www.bluez.org
 W:	http://www.holtmann.org/linux/bluetooth/
 T:	git kernel.org:/pub/scm/linux/kernel/git/holtmann/bluetooth-2.6.git
 S:	Maintained
+F:	drivers/bluetooth/
+F:	net/bluetooth/
+F:	include/net/bluetooth/
 
 BLUETOOTH RFCOMM LAYER
 P:	Marcel Holtmann

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
