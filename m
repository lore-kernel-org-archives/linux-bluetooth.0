Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-Bus patching session opened
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0509221213392b9976@mail.gmail.com>
References: <1127399305.5344.36.camel@blade>
	 <e1effdeb0509221213392b9976@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1127418921.12287.29.camel@blade>
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
Date: Thu, 22 Sep 2005 21:55:21 +0200

Hi Claudio,

> I have some comments and questions:
>  
> 1. Multiple bluetooth adapters
> This is an old discussion but we didn't written it in a stone.
> Do you plan support address multiple local adapter or not?
> If yes, we have to plan how define the object path. My suggestion
> is insert the device id in the path(org/bluez/dev_id/hci, 
> org/bluez/dev_id/pan, ...).

my idea is that dev_id is only used inside the kernel and by bluetoothd
and that the D-Bus interface never exposes it. We should use device
names like "hci0" etc. or the device address. In generell the address in
unique and we should use it wherever possible, but with some tricks you
can have the same address attached to the same machine. However this
case is really not normal.

So I think we will use paths like org/bluez/hci0/ or with an address
like org/bluez/00:11:22:33:44:55/. For the default adapter we can use
the path org/bluez/default/.

> 2. Non D-Bus systems
> You wrote in an old email: "bluetoothd should combine hcid and sdpd".
> I didn't understand the scope of this assertion. IMHO in the future 
> for D-Bus enable systems bluetoothd should provide hcid, sdpd and 
> profiles services(D-Bus). 
> hcid features include control initialize/register) adapters and 
> provide D-Bus services for get adapter infos and basic task like 
> inquiry, scan, remote name, ..
> sdpd services include register/unregister local services, control
> incomming connections and D-Bus services for search services.
> Regarding sdp services, is it necessary provide a D-Bus service for
> register/unregister services or we have to use sdp_connect + 
> sdp_device_record_register?
> 
> As long as I could understand, bluetoothd will not be only a 
> D-Bus service provider, but it must support NON D-Bus clients too.
> Is that correct?

I thought that it would be a good idea to have an additional interface,
but I am not sure if that makes sense. Everything is going to use D-Bus
and so bluetoothd might only expose its interface over D-Bus. This will
make the development a lot easier.

> 3. API version
> We have to think how keep the backward compatibility among
> the future BlueZ D-Bus services versions. I my opinion we have three
> options:
>  - create a initialization service for bluetoothd where we 
>    can check the version.
>  - insert an extra arguments in each method call(request)
>  - define different interface name based on the API version

We can add a service to check the API version. That shouldn't be a big
problem.

> 4. Introspect
> It's becomming common implement a Introspectable interface that
> make possible get a xml string describing the provided services. 
> It can be a good feature support it.

>>From my point I try to avoid using XML wherever possible.

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
