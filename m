Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluez-utils-2.15 install
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050408071216.92567.qmail@web52408.mail.yahoo.com>
References: <20050408071216.92567.qmail@web52408.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1112958900.26175.9.camel@pegasus>
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
Date: Fri, 08 Apr 2005 13:15:00 +0200

Hi Jose,

> in the 'README' of bluez-utils-2.15, it says:
> 
> In order to compile Bluetooth utilities you need
> following software packages:
> 	- Linux Bluetooth protocol stack (BlueZ)
> 	- GCC compiler
> 	- USB library
> 	- Lexical Analyzer (flex, lex)
> 	- YACC (yacc, bison, byacc)
> 
> how do i find if item 1, i.e., the Linux Bluetooth
> protocol stack (BlueZ) is installed on my PC?what
> should i check for?
> 
> and how do i install or find if: USB library is
> installed?what do i check for?
> 
> iam working on suse 9.1, kernel 2.6.4-52-smp

the SuSE 9.1 kernel contains the needed BlueZ modules, but they are not
up-to-date. The USB library is available as package over YaST.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
