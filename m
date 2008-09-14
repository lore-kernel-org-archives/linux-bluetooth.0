Return-Path: <cyrus@holtmann.org>
Message-ID: <48CCCA22.5090001@free.fr>
Date: Sun, 14 Sep 2008 10:24:02 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Sniff mode issues regarding Sony	Ericsson	headsets:
 kernel	patch proposal.
References: <48BEE75C.9050008@free.fr>	 <1220471377.6714.52.camel@californication>  <48CC2BEE.7020207@free.fr> <1221350729.6695.72.camel@californication>
In-Reply-To: <1221350729.6695.72.camel@californication>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi Fabien,
> 
>> Here are patches against 2.6.27-rc6 and latest bluez git that add 
>> support for point 1 below.
> 
> problem with these patches is that they are a layer violation between
> L2CAP and HCI. 

Yes that is true but that is nothing that isn't already existing. Same 
trick is used for L2CAP_CONNINFO.

I'm gonna try to improve that.

> It should also work on incoming and outgoing connections
> the same way. 

I'm not following you there...

> Also when using socket options, I prefer that we set them
> and store the value and the execute it once the connections is up.

Agreed. I was just too lazy to do that :-)

> 
> Personally I prefer if we would enhance hci_send_acl() to indicate that
> we expect it got get out of any power state before processing this data
> packet.
> 
> And of course this socket option also has to work for RFCOMM.

That's pretty much useless as i don't know if that will ever get used.
However that's not much work, i can do it if that makes you happy. ;-)

Do you have any comments on the user-land side or is it how you see things ?

Cheers,

Fabien
