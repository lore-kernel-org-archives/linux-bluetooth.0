Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 18 Feb 2007 10:47:50 -0800 (PST)
From: tim culwins <mail0123456789101112@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20070218122948.GA4968@elmicha>
MIME-Version: 1.0
Message-ID: <574108.24179.qm@web31701.mail.mud.yahoo.com>
Subject: Re: [Bluez-users] ./configure tells me dbus is required
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Thanks for all the help.
so i uninstalled 3.7 and ran make install on 3.9. but
i couldnt get it to auto reconnect my mouse or
keyboard. so i ran make uninstall and reinstalled 3.7
but i still cant get it to auto reconnect. heres my
output from make install, can anyone tell me whats
going on? also after i installed 3.9 i started getting
little pop up windows telling me if i was in
discoverable mode or not...


Making install in eglib
make[1]: Entering directory
`/home/arc/bluez-utils-3.9/eglib'
make[2]: Entering directory
`/home/arc/bluez-utils-3.9/eglib'
make[2]: Nothing to be done for `install-exec-am'.
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory
`/home/arc/bluez-utils-3.9/eglib'
make[1]: Leaving directory
`/home/arc/bluez-utils-3.9/eglib'
Making install in common
make[1]: Entering directory
`/home/arc/bluez-utils-3.9/common'
make[2]: Entering directory
`/home/arc/bluez-utils-3.9/common'
make[2]: Nothing to be done for `install-exec-am'.
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory
`/home/arc/bluez-utils-3.9/common'
make[1]: Leaving directory
`/home/arc/bluez-utils-3.9/common'
Making install in sdpd
make[1]: Entering directory
`/home/arc/bluez-utils-3.9/sdpd'
make[2]: Entering directory
`/home/arc/bluez-utils-3.9/sdpd'
test -z "/usr/local/sbin" || mkdir -p --
"/usr/local/sbin"
  /bin/bash ../libtool --mode=install /usr/bin/install
-c 'sdpd' '/usr/local/sbin/sdpd'
/usr/bin/install -c sdpd /usr/local/sbin/sdpd
test -z "/usr/local/share/man/man8" || mkdir -p --
"/usr/local/share/man/man8"
 /usr/bin/install -c -m 644 './sdpd.8'
'/usr/local/share/man/man8/sdpd.8'
make[2]: Leaving directory
`/home/arc/bluez-utils-3.9/sdpd'
make[1]: Leaving directory
`/home/arc/bluez-utils-3.9/sdpd'
Making install in hcid
make[1]: Entering directory
`/home/arc/bluez-utils-3.9/hcid'
make  install-am
make[2]: Entering directory
`/home/arc/bluez-utils-3.9/hcid'
make[3]: Entering directory
`/home/arc/bluez-utils-3.9/hcid'
test -z "/usr/local/sbin" || mkdir -p --
"/usr/local/sbin"
  /bin/bash ../libtool --mode=install /usr/bin/install
-c 'hcid' '/usr/local/sbin/hcid'
/usr/bin/install -c hcid /usr/local/sbin/hcid
test -z "/etc/bluetooth" || mkdir -p --
"/etc/bluetooth"
 /usr/bin/install -c -m 644 'hcid.conf'
'/etc/bluetooth/hcid.conf'
test -z "/usr/local/share/man/man5" || mkdir -p --
"/usr/local/share/man/man5"
 /usr/bin/install -c -m 644 './hcid.conf.5'
'/usr/local/share/man/man5/hcid.conf.5'
test -z "/usr/local/share/man/man8" || mkdir -p --
"/usr/local/share/man/man8"
 /usr/bin/install -c -m 644 './hcid.8'
'/usr/local/share/man/man8/hcid.8'
test -z "/var/lib/bluetooth" || mkdir -p --
"/var/lib/bluetooth"
make[3]: Leaving directory
`/home/arc/bluez-utils-3.9/hcid'
make[2]: Leaving directory
`/home/arc/bluez-utils-3.9/hcid'
make[1]: Leaving directory
`/home/arc/bluez-utils-3.9/hcid'
Making install in daemon
make[1]: Entering directory
`/home/arc/bluez-utils-3.9/daemon'
make[2]: Entering directory
`/home/arc/bluez-utils-3.9/daemon'
make[2]: Nothing to be done for `install-exec-am'.
test -z "" || mkdir -p -- ""
test -z "/etc/dbus-1/system.d" || mkdir -p --
"/etc/dbus-1/system.d"
 /usr/bin/install -c -m 644 'bluetooth.conf'
'/etc/dbus-1/system.d/bluetooth.conf'
test -z "" || mkdir -p -- ""
make[2]: Leaving directory
`/home/arc/bluez-utils-3.9/daemon'
make[1]: Leaving directory
`/home/arc/bluez-utils-3.9/daemon'
Making install in transfer
make[1]: Entering directory
`/home/arc/bluez-utils-3.9/transfer'
make[2]: Entering directory
`/home/arc/bluez-utils-3.9/transfer'
make[2]: Nothing to be done for `install-exec-am'.
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory
`/home/arc/bluez-utils-3.9/transfer'
make[1]: Leaving directory
`/home/arc/bluez-utils-3.9/transfer'
Making install in network
make[1]: Entering directory
`/home/arc/bluez-utils-3.9/network'
make[2]: Entering directory
`/home/arc/bluez-utils-3.9/network'
make[2]: Nothing to be done for `install-exec-am'.
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory
`/home/arc/bluez-utils-3.9/network'
make[1]: Leaving directory
`/home/arc/bluez-utils-3.9/network'
Making install in serial
make[1]: Entering directory
`/home/arc/bluez-utils-3.9/serial'
make[2]: Entering directory
`/home/arc/bluez-utils-3.9/serial'
make[2]: Nothing to be done for `install-exec-am'.
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory
`/home/arc/bluez-utils-3.9/serial'
make[1]: Leaving directory
`/home/arc/bluez-utils-3.9/serial'
Making install in input
make[1]: Entering directory
`/home/arc/bluez-utils-3.9/input'
make[2]: Entering directory
`/home/arc/bluez-utils-3.9/input'
make[2]: Nothing to be done for `install-exec-am'.
test -z "" || mkdir -p -- ""
test -z "" || mkdir -p -- ""
make[2]: Leaving directory
`/home/arc/bluez-utils-3.9/input'
make[1]: Leaving directory
`/home/arc/bluez-utils-3.9/input'
Making install in audio
make[1]: Entering directory
`/home/arc/bluez-utils-3.9/audio'
make[2]: Entering directory
`/home/arc/bluez-utils-3.9/audio'
make[2]: Nothing to be done for `install-exec-am'.
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory
`/home/arc/bluez-utils-3.9/audio'
make[1]: Leaving directory
`/home/arc/bluez-utils-3.9/audio'
Making install in print
make[1]: Entering directory
`/home/arc/bluez-utils-3.9/print'
make[2]: Entering directory
`/home/arc/bluez-utils-3.9/print'
make[2]: Nothing to be done for `install-exec-am'.
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory
`/home/arc/bluez-utils-3.9/print'
make[1]: Leaving directory
`/home/arc/bluez-utils-3.9/print'
Making install in sync
make[1]: Entering directory
`/home/arc/bluez-utils-3.9/sync'
make[2]: Entering directory
`/home/arc/bluez-utils-3.9/sync'
make[2]: Nothing to be done for `install-exec-am'.
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory
`/home/arc/bluez-utils-3.9/sync'
make[1]: Leaving directory
`/home/arc/bluez-utils-3.9/sync'
Making install in tools
make[1]: Entering directory
`/home/arc/bluez-utils-3.9/tools'
make[2]: Entering directory
`/home/arc/bluez-utils-3.9/tools'
test -z "/usr/local/bin" || mkdir -p --
"/usr/local/bin"
  /bin/bash ../libtool --mode=install /usr/bin/install
-c 'hcitool' '/usr/local/bin/hcitool'
/usr/bin/install -c hcitool /usr/local/bin/hcitool
  /bin/bash ../libtool --mode=install /usr/bin/install
-c 'l2ping' '/usr/local/bin/l2ping'
/usr/bin/install -c l2ping /usr/local/bin/l2ping
  /bin/bash ../libtool --mode=install /usr/bin/install
-c 'sdptool' '/usr/local/bin/sdptool'
/usr/bin/install -c sdptool /usr/local/bin/sdptool
  /bin/bash ../libtool --mode=install /usr/bin/install
-c 'ciptool' '/usr/local/bin/ciptool'
/usr/bin/install -c ciptool /usr/local/bin/ciptool
test -z "/usr/local/sbin" || mkdir -p --
"/usr/local/sbin"
  /bin/bash ../libtool --mode=install /usr/bin/install
-c 'hciattach' '/usr/local/sbin/hciattach'
/usr/bin/install -c hciattach
/usr/local/sbin/hciattach
  /bin/bash ../libtool --mode=install /usr/bin/install
-c 'hciconfig' '/usr/local/sbin/hciconfig'
/usr/bin/install -c hciconfig
/usr/local/sbin/hciconfig
  /bin/bash ../libtool --mode=install /usr/bin/install
-c 'hid2hci' '/usr/local/sbin/hid2hci'
/usr/bin/install -c hid2hci /usr/local/sbin/hid2hci
test -z "/usr/local/share/man/man1" || mkdir -p --
"/usr/local/share/man/man1"
 /usr/bin/install -c -m 644 './hcitool.1'
'/usr/local/share/man/man1/hcitool.1'
 /usr/bin/install -c -m 644 './l2ping.1'
'/usr/local/share/man/man1/l2ping.1'
 /usr/bin/install -c -m 644 './sdptool.1'
'/usr/local/share/man/man1/sdptool.1'
 /usr/bin/install -c -m 644 './ciptool.1'
'/usr/local/share/man/man1/ciptool.1'
test -z "/usr/local/share/man/man8" || mkdir -p --
"/usr/local/share/man/man8"
 /usr/bin/install -c -m 644 './hciattach.8'
'/usr/local/share/man/man8/hciattach.8'
 /usr/bin/install -c -m 644 './hciconfig.8'
'/usr/local/share/man/man8/hciconfig.8'
 /usr/bin/install -c -m 644 './hid2hci.8'
'/usr/local/share/man/man8/hid2hci.8'
make[2]: Leaving directory
`/home/arc/bluez-utils-3.9/tools'
make[1]: Leaving directory
`/home/arc/bluez-utils-3.9/tools'
Making install in rfcomm
make[1]: Entering directory
`/home/arc/bluez-utils-3.9/rfcomm'
make  install-am
make[2]: Entering directory
`/home/arc/bluez-utils-3.9/rfcomm'
make[3]: Entering directory
`/home/arc/bluez-utils-3.9/rfcomm'
test -z "/usr/local/bin" || mkdir -p --
"/usr/local/bin"
  /bin/bash ../libtool --mode=install /usr/bin/install
-c 'rfcomm' '/usr/local/bin/rfcomm'
/usr/bin/install -c rfcomm /usr/local/bin/rfcomm
test -z "/etc/bluetooth" || mkdir -p --
"/etc/bluetooth"
 /usr/bin/install -c -m 644 'rfcomm.conf'
'/etc/bluetooth/rfcomm.conf'
test -z "/usr/local/share/man/man1" || mkdir -p --
"/usr/local/share/man/man1"
 /usr/bin/install -c -m 644 './rfcomm.1'
'/usr/local/share/man/man1/rfcomm.1'
make[3]: Leaving directory
`/home/arc/bluez-utils-3.9/rfcomm'
make[2]: Leaving directory
`/home/arc/bluez-utils-3.9/rfcomm'
make[1]: Leaving directory
`/home/arc/bluez-utils-3.9/rfcomm'
Making install in dund
make[1]: Entering directory
`/home/arc/bluez-utils-3.9/dund'
make[2]: Entering directory
`/home/arc/bluez-utils-3.9/dund'
test -z "/usr/local/bin" || mkdir -p --
"/usr/local/bin"
  /bin/bash ../libtool --mode=install /usr/bin/install
-c 'dund' '/usr/local/bin/dund'
/usr/bin/install -c dund /usr/local/bin/dund
test -z "/usr/local/share/man/man1" || mkdir -p --
"/usr/local/share/man/man1"
 /usr/bin/install -c -m 644 './dund.1'
'/usr/local/share/man/man1/dund.1'
make[2]: Leaving directory
`/home/arc/bluez-utils-3.9/dund'
make[1]: Leaving directory
`/home/arc/bluez-utils-3.9/dund'
Making install in pand
make[1]: Entering directory
`/home/arc/bluez-utils-3.9/pand'
make[2]: Entering directory
`/home/arc/bluez-utils-3.9/pand'
test -z "/usr/local/bin" || mkdir -p --
"/usr/local/bin"
  /bin/bash ../libtool --mode=install /usr/bin/install
-c 'pand' '/usr/local/bin/pand'
/usr/bin/install -c pand /usr/local/bin/pand
test -z "/usr/local/share/man/man1" || mkdir -p --
"/usr/local/share/man/man1"
 /usr/bin/install -c -m 644 './pand.1'
'/usr/local/share/man/man1/pand.1'
make[2]: Leaving directory
`/home/arc/bluez-utils-3.9/pand'
make[1]: Leaving directory
`/home/arc/bluez-utils-3.9/pand'
Making install in hidd
make[1]: Entering directory
`/home/arc/bluez-utils-3.9/hidd'
make[2]: Entering directory
`/home/arc/bluez-utils-3.9/hidd'
test -z "/usr/local/bin" || mkdir -p --
"/usr/local/bin"
  /bin/bash ../libtool --mode=install /usr/bin/install
-c 'hidd' '/usr/local/bin/hidd'
/usr/bin/install -c hidd /usr/local/bin/hidd
test -z "/usr/local/share/man/man1" || mkdir -p --
"/usr/local/share/man/man1"
 /usr/bin/install -c -m 644 './hidd.1'
'/usr/local/share/man/man1/hidd.1'
make[2]: Leaving directory
`/home/arc/bluez-utils-3.9/hidd'
make[1]: Leaving directory
`/home/arc/bluez-utils-3.9/hidd'
Making install in cups
make[1]: Entering directory
`/home/arc/bluez-utils-3.9/cups'
make[2]: Entering directory
`/home/arc/bluez-utils-3.9/cups'
make[2]: Nothing to be done for `install-exec-am'.
test -z "" || mkdir -p -- ""
make[2]: Leaving directory
`/home/arc/bluez-utils-3.9/cups'
make[1]: Leaving directory
`/home/arc/bluez-utils-3.9/cups'
Making install in test
make[1]: Entering directory
`/home/arc/bluez-utils-3.9/test'
make[2]: Entering directory
`/home/arc/bluez-utils-3.9/test'
test -z "/usr/local/bin" || mkdir -p --
"/usr/local/bin"
test -z "/usr/local/sbin" || mkdir -p --
"/usr/local/sbin"
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory
`/home/arc/bluez-utils-3.9/test'
make[1]: Leaving directory
`/home/arc/bluez-utils-3.9/test'
Making install in scripts
make[1]: Entering directory
`/home/arc/bluez-utils-3.9/scripts'
make[2]: Entering directory
`/home/arc/bluez-utils-3.9/scripts'
make[2]: Nothing to be done for `install-exec-am'.
test -z "" || mkdir -p -- ""
test -z "" || mkdir -p -- ""
make[2]: Leaving directory
`/home/arc/bluez-utils-3.9/scripts'
make[1]: Leaving directory
`/home/arc/bluez-utils-3.9/scripts'
make[1]: Entering directory
`/home/arc/bluez-utils-3.9'
make[2]: Entering directory
`/home/arc/bluez-utils-3.9'
make[2]: Nothing to be done for `install-exec-am'.
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory `/home/arc/bluez-utils-3.9'
make[1]: Leaving directory `/home/arc/bluez-utils-3.9'
~/bluez-utils-3.9 


--- Michael Mauch <michael.mauch@gmx.de> wrote:

> tim culwins wrote:
> 
> >    So I ran make install and everything seemed to
> > work. However now when I look in synaptic it tells
> me
> > that 3.7 is still installed. How can I tell if 3.9
> is
> > working?
> 
> If you installed from source and did not make a
> package (.deb), your
> package manager cannot know.
> 
> Tell synaptic to uninstall 3.7, then run "make
> install" again to be sure
> that everything from 3.9 is installed.
> 
> Regards...
> 		Michael
> 
>
-------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get
> the chance to share your
> opinions on IT & business topics through brief
> surveys-and earn cash
>
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 



 
____________________________________________________________________________________
Have a burning question?  
Go to www.Answers.yahoo.com and get answers from real people who know.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
