Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fredrik Noring <noring@nocrew.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1127025473.14893.51.camel@yeti>
Mime-Version: 1.0
Subject: [Bluez-devel] Multiple user/device model?
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 18 Sep 2005 08:37:53 +0200

Hi,

Can multiple users have different sets of Bluetooth devices? I.e.
something like this:

    /home/peter/.bluetooth/devices/00:11:22:33:44:55/linkkeys
    /home/maria/.bluetooth/devices/99:88:77:66:55:44/linkkeys

With the following properties:

    1. User pairing and device management don't require
       administrative (root) privileges.
    2. Peter cannot remove/modify Maria's devices and vice versa.
    3. Would be excellent if Peter and Maria could use Bluetooth
       simultaneously, but good enough if only one at the time.

Any thoughts?

Thanks,
Fredrik




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
