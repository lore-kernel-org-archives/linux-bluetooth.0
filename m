Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <ac72cfc80502190517509a7859@mail.gmail.com>
From: Emiliano Heyns <emiliano.heyns@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] hcitool scan times
In-Reply-To: <4216700F.5010106@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <ac72cfc805021801246a15de74@mail.gmail.com>
	 <421638BC.2020808@gmx.ch> <ac72cfc8050218143042696ba4@mail.gmail.com>
	 <4216700F.5010106@gmx.ch>
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
Date: Sat, 19 Feb 2005 14:17:17 +0100

On Fri, 18 Feb 2005 23:45:35 +0100, Marco Trudel <mtrudel@gmx.ch> wrote:
> > OK, thanks. This could actually work to my benefit if I disable the
> > hcitool cache --
> 
> you're welcome...
> 
> > the device could take the time the user takes from
> > walking into range to being at the device for detecting,
> 
> I don't know what you mean with this...
>
>  > if you walk
> > out of range before that you were only passing the device. Good. Now I
> > only have to look at average office walking speeds to see how great I
> > want this radius to be :)
> 
> I don't understand that as well, but it sounds very interesting. Can you
> explain what you're doing? Just curious...

We have a kiosk where you have to select your name from a list before
you can do anything useful. You pick your name from a scrollist. What
I want to try is to install a bluetooth adapter on the device, allow
people to register their BT toys (phone, palm, whatever), and have the
device scan for BT devices in the vicinity. If it recognizes a
registered device, it could pre-select your name from the list, for
convenience.

If BT scan was super-fast, anyone standing at the device would be
bothered by anyone else passing by with a BT gadget active. With a 13
sec discovery time, and given the right range,  passers-by would be
out of range before actually being picked up. And if the range is just
wide enough, the scan would start at the edge of that range, and would
finish some seconds after you're standing at the device. It'd take
some tweaking, but since people usually slow their pace before
stopping, it could work.

 > by the way: do you know that a device does not have to answer to an
> inquiry? if a device is busy or just decides to not answer to an inquiry,
> that's ok (defined in bluetooth specification, my experience showed this as
> well)...

If we'll be using this (it's just a friday afternoon experiment at
this point) it's just an add-on for convenience. There will actually
only be a minority of our users that will be carrying active BT
gadgets.

Emiliano


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
