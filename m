Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problem with l2test, rctest
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <becc9d2c050915091830e5a609@mail.gmail.com>
References: <becc9d2c05091505534b795f7b@mail.gmail.com>
	 <becc9d2c05091506452748d6a0@mail.gmail.com>
	 <1126792737.3505.6.camel@station6.example.com>
	 <becc9d2c050915091830e5a609@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1126801476.15633.2.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Thu, 15 Sep 2005 18:24:36 +0200

Hi Andrea,

> the client is on arm-based embedded linux box, and
> when i try to compile hcidump i get these errors:
> 
> 
> gcc -DHAVE_CONFIG_H -I. -I. -I..    -I/usr/include -Wall -O2 -c `test
> -f 'parser.c' || echo './'`parser.c
> gcc -DHAVE_CONFIG_H -I. -I. -I..    -I/usr/include -Wall -O2 -c `test
> -f 'lmp.c' || echo './'`lmp.c
> gcc -DHAVE_CONFIG_H -I. -I. -I..    -I/usr/include -Wall -O2 -c `test
> -f 'hci.c' || echo './'`hci.c
> hci.c: In function `write_ext_inquiry_response_dump':
> hci.c:854: error: `write_ext_inquiry_response_cp' undeclared (first
> use in this function)
> hci.c:854: error: (Each undeclared identifier is reported only once
> hci.c:854: error: for each function it appears in.)
> hci.c:854: error: `cp' undeclared (first use in this function)
> hci.c: In function `command_dump':
> hci.c:1064: error: `OCF_WRITE_EXT_INQUIRY_RESPONSE' undeclared (first
> use in this function)
> hci.c: In function `read_ext_inquiry_response_dump':
> hci.c:1379: error: `read_ext_inquiry_response_rp' undeclared (first
> use in this function)
> hci.c:1379: error: `rp' undeclared (first use in this function)
> hci.c: In function `cmd_complete_dump':
> hci.c:1667: error: `OCF_READ_EXT_INQUIRY_RESPONSE' undeclared (first
> use in this function)
> hci.c:1694: error: `OCF_WRITE_EXT_INQUIRY_RESPONSE' undeclared (first
> use in this function)
> hci.c: In function `extended_inq_result_dump':
> hci.c:2229: error: `extended_inquiry_info' undeclared (first use in
> this function)
> hci.c:2229: error: `info' undeclared (first use in this function)
> hci.c:2238: error: `EXTENDED_INQUIRY_INFO_SIZE' undeclared (first use
> in this function)
> hci.c: In function `event_dump':
> hci.c:2393: error: `EVT_EXTENDED_INQUIRY_RESULT' undeclared (first use
> in this function)
> make[1]: *** [hci.o] Error 1
> make[1]: Leaving directory `/root/bluez-hcidump-1.25/parser'
> make: *** [install-recursive] Error 1
> 
> 
> 
> do you know what i miss ?

read the ChangeLog file.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
