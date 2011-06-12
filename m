Return-Path: <cyrus@holtmann.org>
Date: Sun, 12 Jun 2011 03:39:53 +0200
From: YuGiOhJCJ Mailing-List <yugiohjcj-mailinglist@laposte.net>
To: linux-bluetooth@vger.kernel.org
Subject: bluetooth headset on linux
Message-Id: <20110612033953.d0eaedd9.yugiohjcj-mailinglist@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hello,

My bluetooth headset is Philips SHB9000 :
$ hcitool scan
Scanning ...
	00:1E:7C:01:0A:5E	Philips SHB9000

I use bluez 4.94.

When I try to bind with hcitool my computer with my headset, it failed :
$ hcitool dev
Devices:
	hci0	00:22:43:B7:BB:F0
$ sudo hcitool cc 00:1E:7C:01:0A:5E
$ hcitool con
Connections:

When I try to bind with rfcomm my computer with my headset, it failed :
$ rfcomm 
rfcomm0: 00:1E:7C:01:0A:5E channel 0 clean
$ sudo rfcomm release hci0
$ rfcomm
$ sudo rfcomm -A -E bind 00:22:43:B7:BB:F0 00:1E:7C:01:0A:5E
$ rfcomm 
rfcomm0: 00:1E:7C:01:0A:5E channel 1 clean 
$ sudo rfcomm -A -E connect 00:22:43:B7:BB:F0 00:1E:7C:01:0A:5E
Can't connect RFCOMM socket: Operation now in progress

So, I found an other way : http://bluetooth-alsa.sourceforge.net/
But when I install plugz, as explained on the web site, I got an error :
$ make
make  all-recursive
make[1]: Entering directory `/home/yugiohjcj/documents/downloads/software/cvs/plugz'
Making all in avdtp
make[2]: Entering directory `/home/yugiohjcj/documents/downloads/software/cvs/plugz/avdtp'
/bin/sh ../libtool --tag=CC   --mode=link gcc -I/usr/include -Wall   -o avtest avtest.o -lbluetooth libavdtp.a -lbluetooth -lbluetooth
../libtool: line 681: X--tag=CC: command not found
../libtool: line 714: libtool: ignoring unknown tag : command not found
../libtool: line 681: X--mode=link: command not found
../libtool: line 831: *** Warning: inferring the mode of operation is deprecated.: command not found
../libtool: line 832: *** Future versions of Libtool will require -mode=MODE be specified.: command not found
../libtool: line 1985: X-I/usr/include: No such file or directory
../libtool: line 1985: X-Wall: command not found
../libtool: line 2149: Xavtest: command not found
../libtool: line 2154: X/tmp/xorg/lib:/usr/local/lib:/usr/lib/qt4/lib: No such file or directory
../libtool: line 2161: Xavtest: command not found
../libtool: line 2169: mkdir /.libs: No such file or directory
mkdir: cannot create directory `/.libs': Permission denied
make[2]: *** [avtest] Error 1
make[2]: Leaving directory `/home/yugiohjcj/documents/downloads/software/cvs/plugz/avdtp'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/yugiohjcj/documents/downloads/software/cvs/plugz'
make: *** [all] Error 2

Finally, I can't use my bluetooth headset on linux... I am disappointed, but I am sure you can help me :-)
Can you help me with my  bluetooth headset on linux, please?

Thank you.

