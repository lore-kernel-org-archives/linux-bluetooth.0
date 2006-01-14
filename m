Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43C9629D.8010405@emajor.net>
From: Ehab El Maraghy <e_elmaraghy@emajor.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] ISSC USB dongle Bluetooth problem (Patching the Kernel)
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 14 Jan 2006 22:44:13 +0200

Hi All
I have sent a mail couple of days ago concerning that ISSC chip is not 
able to operate on Kernel 2.4.20-8
One thing I did not try at that time which is patching the kernel
I downloaded the patch ¨patch-2.4.20-mh18.gz¨
Trying to apply the patch I got the following message

[root@Ehab src]# patch -p0 < patch-2.4.20-mh18.gz
can't find file to patch at input line 4
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|diff -urN linux-2.4.20/arch/sparc64/kernel/ioctl32.c 
linux-2.4.20-mh18/arch/sparc64/kernel/ioctl32.c
|--- linux-2.4.20/arch/sparc64/kernel/ioctl32.c 2002-11-29 
00:53:12.000000000 +0100
|+++ linux-2.4.20-mh18/arch/sparc64/kernel/ioctl32.c    2004-08-01 
16:31:28.000000000 +0200
--------------------------
File to patch:

Kernel source is in folder called linux-2.4.20-8 not 2.4.20
should I change overy instant in the patch file to add -8 ?

Whats the next step ?  make menuconfig ?





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
