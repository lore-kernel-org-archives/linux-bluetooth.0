Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <421C9696.8000201@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Fl=E1vio?= <flavio.henriques@gmail.com>
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] TPL (transmit power level)
References: <de33c8be0502160425215158ad@mail.gmail.com>
    <1109028291.7626.45.camel@pegasus>
    <de33c8be050221181635c1a751@mail.gmail.com> <421B64F5.8090100@csr.com>
    <de33c8be05022211203fa795e3@mail.gmail.com>
In-Reply-To: <de33c8be05022211203fa795e3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Wed, 23 Feb 2005 14:43:34 +0000

Flávio wrote:
> I can´t connect with the news group (news.csr.com)! So i hope that you
> could help me in some question:

news.csr.com is just a standard NNTP server. Most programs should
connect without any problems (Outlook Express, Netscape (or Firefox or
similar), gnus, tin and many others).

> Is there anyway for me to change the step size of the tpl to a smaller
> number (2 dBm)?
> And have more range in the values of tpl?

That's not possible without lots of expensive equipment to measure the
output power accurately. It's not something we recommend that users do.

Also, it's not generally a useful thing to do - why do you want to do
it?

> Where can i find newest versions of firmware and there changes ? (in
> conceptronic site don´t have)

You listed the following about your device:

> chip version : BlueCore2 ;
                 ^^^^^^^^^ Doesn't look right
> HCI 17,11 ;
>
> SCO mapping : HCI ;
> HCI ver:1,1 ;
> HCI rev: 0X460;
> LMP ver:1,1 ;
> LMP subver:0X460

Software version 0x460 is a build for ROM devices which implies you have
a ROM part and so you will not be able to upgrade.

The chip version should have been identified as BlueCore3-ROM - I'm not
sure why it wasn't.

> I try to find information about firmware used in my dongle and it´s
> very dificult..almost nothing!

What is it you want to know? BlueZ will identify the device. Apart
from that, it's a Bluetooth dongle, it does Bluetooth stuff.

	- Steven
-- 


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

**********************************************************************



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
