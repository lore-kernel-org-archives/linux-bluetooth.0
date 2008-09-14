Return-Path: <cyrus@holtmann.org>
Message-ID: <48CCE0AF.1090008@free.fr>
Date: Sun, 14 Sep 2008 12:00:15 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Sniff mode issues regarding	Sony	Ericsson	headsets:
 kernel	patch proposal.
References: <48BEE75C.9050008@free.fr>	 <1220471377.6714.52.camel@californication>  <48CC2BEE.7020207@free.fr>	 <1221350729.6695.72.camel@californication>  <48CCCA22.5090001@free.fr> <1221384171.6695.85.camel@californication>
In-Reply-To: <1221384171.6695.85.camel@californication>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

>>>> Here are patches against 2.6.27-rc6 and latest bluez git that add 
>>>> support for point 1 below.
>>> problem with these patches is that they are a layer violation between
>>> L2CAP and HCI. 
>> Yes that is true but that is nothing that isn't already existing. Same 
>> trick is used for L2CAP_CONNINFO.
> 
> no they don't. Look at the code. It is nicely abstracted on how we
> handle the two layers.

Having a closer look to the code, it looks that only write access to HCI 
layer variables is forbidden. There are numerous places in the code 
where L2CAP for instance goes and peeks some HCI values. I think i 
skipped that distinction in my first understanding of the code.

Anyway, i'm gonna stop chatting and starting to fix that too :-).

> 
>>> It should also work on incoming and outgoing connections
>>> the same way. 
>> I'm not following you there...
> 
> We wanna be able to set this on a server socket and also enforce it on a
> connection we created.
> 
>>> Also when using socket options, I prefer that we set them
>>> and store the value and the execute it once the connections is up.
>> Agreed. I was just too lazy to do that :-)
> 
> Lazy doesn't get it upstream :)

lol :-)

> 
>>> Personally I prefer if we would enhance hci_send_acl() to indicate that
>>> we expect it got get out of any power state before processing this data
>>> packet.
>>>

That sounds reasonable...

>>> And of course this socket option also has to work for RFCOMM.
>> That's pretty much useless as i don't know if that will ever get used.
>> However that's not much work, i can do it if that makes you happy. ;-)
> 
> I treat RFCOMM and L2CAP the same. If we implement something for one
> protocol, we do have to do the same for the other.
> 
>> Do you have any comments on the user-land side or is it how you see things ?
> 
> Actually I do have to figure out the exact naming, but it is basically
> set this option once approach. And the kernel will do the rest.
> 
Agreed.

So i'm gonna start coding now to see of things are going...

Cheers,

Fabien
