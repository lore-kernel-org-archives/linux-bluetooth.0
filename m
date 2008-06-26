Return-Path: <cyrus@holtmann.org>
Message-ID: <e378cfb20806260738h70567942r1ae96fb723d12bb9@mail.gmail.com>
Date: Thu, 26 Jun 2008 20:08:07 +0530
From: "Nel D" <newatlinux@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] AVRCP failure
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

Hi,
  Am using the current bluez-{utils/libs} and a 2.6.24-19-generic
(hardy) kernel.

Am trying to stream A2Dp data on my motorola S9 headset. When i run
hcid, i see the following lines.


hcid[18926]: link_key_request (sba=00:13:64:11:74:83, dba=00:0A:3D:36:E2:54)
hcid[18926]: Can't open input device: No such file or directory (2)
hcid[18926]: AVRCP: failed to init uinput for Motorola S9


I am able to hear music with ease, but i would still like to know what
causes this warning,, what am i missing (some modules).?

thanks in advance,
 nel !!

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
