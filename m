Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] BT-Sco
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41A74FE0.6020006@suche.org>
References: <41A22C0B.4050008@xmission.com>	<41A234FA.7020303@xmission.com>
	 <20041123033429.132bf84b.henryk@ploetzli.ch>
	 <41A2B331.4010001@xmission.com>
	 <20041123070621.50569968.henryk@ploetzli.ch>
	 <41A3471C.4000602@xmission.com>
	 <20041123203836.046fb4f4.henryk@ploetzli.ch>
	 <41A3ACE2.4030501@xmission.com>  <41A74FE0.6020006@suche.org>
Content-Type: text/plain
Message-Id: <1101481147.6514.10.camel@pegasus>
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
Date: Fri, 26 Nov 2004 15:59:07 +0100

Hi Thomas,

> here is an optimized version of btsco.c it es rewriten for Linux only.
> Is does not need libbluetooth or libasound.
> It is event driven but currently use fixed MAC

the source code size of this version is amazing, but the coding style is
crap. Sorry to say that.

Don't use {{{ and include some newlines. Actually follow the kernel
coding style.

Why do you rewrite the function from libbluetooth and libasound. Simply
use them, because these are shared library and they are loaded anyway.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
