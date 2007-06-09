Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1834493166@web.de>
References: <1834493166@web.de>
Date: Sat, 09 Jun 2007 10:25:19 +0200
Message-Id: <1181377519.6872.28.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bluez-utils on old kernel
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Philipp,

> one more question since the bluez-Page provides kernel patches for the 2.6 kernel-tree I thought I could start to patch the bluetooth
> subsystem to a more recent level.
> But as far as  I can see there are only the latest patches available. So my question is do you (Marcel) have a history of patches 
> since you are hacking the kernel for quite some time now (thanks for that).

I do have a full list of kernel patches, the released ones are still
downloadable. The broken out patches are stored on my private machine
and they are not published. Use Git to extract them from the main tree.

And I mentioned this before, the 2.4 series is unmaintained and
unsupported. Nowadays I don't even do backports for older 2.6 kernels
anymore. It is not worth it, because it takes quite some time.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
