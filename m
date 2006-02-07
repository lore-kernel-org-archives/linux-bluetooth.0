Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Compiling bluez-utils for MIPS
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <d6db2b820601281404q11cb9ba0k21116724a9047d7f@mail.gmail.com>
References: <d6db2b820601281404q11cb9ba0k21116724a9047d7f@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1139311187.15160.21.camel@localhost>
Mime-Version: 1.0
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
Date: Tue, 07 Feb 2006 12:19:47 +0100

Hi Michael,

> I'm trying to compile bluez-utils-2.24 project for Linux 2.4.20 that
> runs on MIPS. This cross-compilation was done on my desktop
> Linux 2.6.12. All needed drivers (HCI, RFCOMM, L2CAP) were uploaded to
> the > MIPS-board early (after some patches for kernel 2.4.20 that I
> found in internet). I configured the environment with the following
> variables: 
> export PLATFORM=mipsel-uclibc 
> export BUILD=i386-pc-linux-gnu 
> export HOSTCC=gcc 
> export CROSS_COMPILE=mipsel-uclibc- 
> export LDFLAGS=-Wl,-dynamic-linker,/lib/ld-uClibc.so.0,-soname=libc.so.0 
> and runned ./configure mipsel-linux --build=$BUILD.  
> Making the project was OK, it used "mipsel-linux-gcc", etc., so
> it seemed OK. After uploading all the bluez utilities on the
> MIPS-board, each call  for these utilities (i.e. "hciconfig") failed
> with such a prompt: 
> libc.so.6: aborted attempt to load hciconfig!
> To my understanding, it still used my desktop standard library
> (cause  "libc.so.6" is a symbolic link in /usr/local/lib on my PC)
> instead the libc.so.0 on the MIPS-board. 
> I tryied adding LDFLAG "-soname=libc.so.0", but it did
> not force defining the right library in building executables.
> Could someone help me in configuring this project? What did I miss?

I've never done this and I am not a cross-compiling expert.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
