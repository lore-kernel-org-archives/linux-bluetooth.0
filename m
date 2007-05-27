Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4659B8EC.3050708@gentoo.org>
Date: Sun, 27 May 2007 19:59:24 +0300
From: =?UTF-8?B?UGV0dGVyaSBSw6R0eQ==?= <betelgeuse@gentoo.org>
MIME-Version: 1.0
To: gilboad@gmail.com, BlueZ development <bluez-devel@lists.sourceforge.net>
References: <1180273950.15368.42.camel@gilboa-work-dev.localdomain>
In-Reply-To: <1180273950.15368.42.camel@gilboa-work-dev.localdomain>
Subject: Re: [Bluez-devel] Suggesting bluez_pinhelper
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

Gilboa Davara kirjoitti:
> Hello all,
> 
> I'm currently trying to get kdebluetooth reviewed into Fedora Core (and
> RHEL).
> As some of you may be aware, the current version of kdebluetooth has no
> support for recent (>= 3.9) bluez DBUS interface.

Works just fine here.
http://dev.gentoo.org/~betelgeuse/kdebluetoothpin.png

betelgeuse@pena /mnt/checkouts/foobar/openjdk-trunk $ emerge --nodeps
-pv bluez-utils kdebluetooth

These are the packages that would be merged, in order:

[ebuild   R   ] net-wireless/bluez-utils-3.11  USE="cups hal usb -debug
-examples -old-daemons* -test-programs" 0 kB
[ebuild   R   ] net-wireless/kdebluetooth-1.0_beta2-r2  USE="xinerama
-arts -debug -irmc" LINGUAS="fi -bg -br -ca -cs -cy -da -de -el -en_GB
-es -et -fr -ga -gl -hu -is -it -ja -ka -lt -mt -nb -nl -nn -pa -pl -pt
-pt_BR -ro -ru -rw -sk -sr -sr@Latn -sv -ta -tr -uk -zh_CN" 0 kB

Regards,
Petteri
--
Gentoo Bluez maintainer

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
