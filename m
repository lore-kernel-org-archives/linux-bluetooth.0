Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Dave Young <hidave.darkstar@gmail.com>
In-Reply-To: <20071105045921.GA3556@darkstar.te-china.tietoenator.com>
References: <20071105045921.GA3556@darkstar.te-china.tietoenator.com>
Content-Type: multipart/mixed; boundary="=-jYvkVJrTABd2+jwqR89U"
Date: Mon, 05 Nov 2007 16:01:10 +0100
Message-Id: <1194274870.4437.8.camel@aeonflux>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] [PATCH]bluetooth rfcomm_dev refcount bug fix
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


--=-jYvkVJrTABd2+jwqR89U
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Dave,

> In the rfcomm_tty_hangup the rfcomm_dev refcnt should be dropped later.
> 
> If rfcomm_dev is destructed in tty_hangup function, then the later tty_close function will oops.

your patch removes the complete release on hangup logic. That can't be
right. I think the problem is with calling tty_vhangup() and then
decrementing the reference count. In case we call tty_vhangup and we
have release on hangup we should not delete the device here. What about
the attached patch? Does it solve it?

What are the steps to reproduce this?

Regards

Marcel


--=-jYvkVJrTABd2+jwqR89U
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index e447651..b405b9a 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -425,8 +425,11 @@ static int rfcomm_release_dev(void __user *arg)
 	if (dev->tty)
 		tty_vhangup(dev->tty);
 
-	rfcomm_dev_del(dev);
-	rfcomm_dev_put(dev);
+	if (!test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags)) {
+		rfcomm_dev_del(dev);
+		rfcomm_dev_put(dev);
+	}
+
 	return 0;
 }
 

--=-jYvkVJrTABd2+jwqR89U
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--=-jYvkVJrTABd2+jwqR89U
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-jYvkVJrTABd2+jwqR89U--
