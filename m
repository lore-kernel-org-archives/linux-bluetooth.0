Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Belkin F8T002 PC Card problem with Bluez
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: "Alexandre Jousset@NL" <mid@gtmp.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <3F50803C.607@gtmp.org>
References: <3F4F6BF2.6080303@gtmp.org>
	<1062170277.27784.138.camel@pegasus> <3F4F70B1.20200@gtmp.org>
	<3F50803C.607@gtmp.org>
Message-Id: <1062425807.13729.162.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 01 Sep 2003 16:16:41 +0200
Content-Type: text/plain

Hi Alexandre,

> 	I tried with setserial to set ttyS4 to irq 3 (it gave me this value
> once when doing setserial autoconfig) -> hang.
> 
> 	I tried with setserial to set port to 0x4010 (as listed as second I/O
> ports region with lspci), no error but hciconfig hci0 up fails with timeout.
> 
> 	With the original setup (irq 11 and ports at 0x4000, as the serial
> module set them and the config that put the lines h4_recv: Unknown HCI
> packet type xx), I wrote a small C program to read ttyS4 and print the
> numbers on stdout. I noticed some reccurrent value so I told the program
> to put a newline before each value 18. The output is :
> 
> -----------------------------------------------------------
> 18 20 e8 36 be f0
> 18 20 e8 36 be f8
> 18 20 e8 36 be f8
> 18 20 e8 36 ef 0f
> 18 24 e8 36 ef f0
> 18 24 e8 36 ef f0
> 18 20 e8 9b be f8
> 18 20 e8 36 ef 0f ff
> 18 20 e8 36 ef 0f ff
> 18 20 e8 9b be f8
> 18 24 e8 36 ef f0
> 18 20 e8 36 ef 0f
> 18 24 e8 36 ef d0
> 18 20 e8 36 ef d0
> 18 20 e8 9b be f8
> 18 20 e8 9b be f8
> 18 20 e8 9b be f8
> 18 20 e8 36 ef 0f
> 18 20 e8 36 ef 0f
> 18 20 e8 36 ef 0f
> 18 20 e8 9b be f8
> 18 20 e8 36 ef 0f ff
> 18 20 e8 9b be f8
> 18 20 e8 36 ef 41
> 18 20 e8 36 ef 0f
> 18 20 e8 36 ef 0f
> -----------------------------------------------------------
> 
> 	So that must mean something but I don't know what. The first octet is
> always 18, the second is either 20 or 24, the third always e8, the
> fourth either 36 or 9b, the fifth either be or ef, the sixth either 0f
> or d0 or f8 and when it is 0f it is sometimes followed by ff...

I think this is the BCSP protocol, but with wrong terminal settings or a
wrong baud rate. Try to attach your device with BCSP and different baud
rate settings and replug it every time to have a clean state.

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
