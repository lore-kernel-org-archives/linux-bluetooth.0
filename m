Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Keyboarch encryption howto?
References: <200411241701.07891.cijoml@volny.cz> <1101313747.27351.122.camel@pegasus>
In-Reply-To: <1101313747.27351.122.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200411242141.53437.cijoml@volny.cz>
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
Date: Wed, 24 Nov 2004 21:41:52 +0100

Hi Marcel,

starting hidd --server -E and reconnecting the keyboard totally freezes my 
keyboard, mouse not worked too.
After killing hidd, mouse reconnected, but keyboard not. It started to work 
after removing the batteries :)

Do you want me to send hcidump -x, you have this keyboard I think

M.

Dne st 24. listopadu 2004 17:29 Marcel Holtmann napsal(a):
> Hi Michal,
>
> > is there any howto where described how to start encryption on BT
> > keyboard?
>
> there exists a hidd version that can enable the keyboard encryption
> after the connection (-E switch). I haven't really tried it and it maybe
> not work as expected with some devices. This should be fixed some time
> with the new policy manager inside the kernel.
>
> > Is my MS keyboard (CSR based) supported?
>
> Yes, it supports encryption.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
