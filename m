Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] curious problem with a socket 1.0b card
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050430020331.GA32110@externe.net>
References: <20050430020331.GA32110@externe.net>
Content-Type: text/plain
Message-Id: <1114857277.8836.130.camel@pegasus>
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
Date: Sat, 30 Apr 2005 12:34:37 +0200

Hi Guylhem,

> I'm using a Socket CF+ Rev E (Nokia chipset, hci v. 1.0b) in a Zaurus
> called "collie" running bluez 2.11 to get network connection from a PC
> NAP called "ebox" running bluez 2.10 with a USB dongle (CSR hci v1.1,
> but similar problems happens with a ISSC hci v1.1)
> 
> Here is the strange problem I have. The devices see eachother in
> hcitool scan, but l2ping from collie to ebox doesn't work. ebox can
> l2ping collie. If ebox l2ping collie, during this I can l2ping
> from collie to ebox, use pan, sdptool etc. (why ?!?)
> 
> If I press ctrl-c on either ebox or collie, the other one stops
> l2pinging with a "Connection reset by peer".
> 
> Collie report "Protocol error" when I try to l2ping ebox without
> running l2ping from ebox to collie. If I use the ISSC dongle (keyspan
> bt-2a) it then simply says "Connection timed out".
> 
> If before pressing ctrl-c I have a pand connected, then they can
> l2ping eachother as much as they want.
> 
> The problem of course is pand sdptool etc. doesn't work either.
> Any suggestion ? I tried to change master\slave roles with hciconfig
> hciN lm, but it didn't help
> 
> I'm sure this comes from the hci v 1.0b card from collie because other
> devices work fine (they can l2ping, sdptool browse and pan connect to
> ebox) while collie refuses to l2ping any other device (they can l2ping
> collie !) but my cellphone.
> 
> hcid.conf from the server ebox:
> options {
>         autoinit yes;
>         security auto;
>         pairing multi;
>         pin_helper /etc/bluetooth/givepin;
> }
> device {
>         name "ebox.externe.net";
>         class 0x020100;
>         iscan enable; pscan enable;
>         lm accept,master;
>         lp hold,sniff,park,rswitch;
>         auth enable;
>         encrypt enable;
> }
> 
> 
> hcid.conf from the client collie:
> 
> options {
>         autoinit yes;
>         security auto;
>         pairing multi;
>         pin_helper /etc/bluetooth/givepin;
> }
> device {
>         name "collie.externe.net";
>         class 0x120114;
>         iscan enable; pscan enable;
>         lm accept;
>         lp hold,sniff,park;
>         auth enable;
>         encrypt enable;
> }
> 
> 
> Even more bizzare : Collie can ping my s65 cellphone (after I type its
> pin on the S65) so pin/l2ping should be fine.
> 
> root@collie:/etc/bluetooth# l2ping aa:aa:aa:aa:aa:aa
> Ping: aa:aa:aa:aa:aa:aa from bb:bb:bb:bb:bb:bb (data size 20) ...
> 0 bytes from aa:aa:aa:aa:aa:aa id 0 time 79.80ms
> 0 bytes from aa:aa:aa:aa:aa:aa id 1 time 84.97ms
> 2 sent, 2 received, 0% loss
> root@collie:/etc/bluetooth# l2ping cc:cc:cc:cc:cc:cc
> Can't connect.: Protocol error
> 
> My S65 is aa, colie is bb, ebox is cc. Of course, ebox can l2ping the
> S65
> 
> Collie is a Zaurus using bluez 2.11, ebox is a PC using bluez 2.10.
> Another Zaurus with a CSR hci v.1. can do everything fine.
> 
> The only workaround I've found is :
> . leaving a l2ping to collie running in the background, launched by
> cron. Collie can then use pan, l2ping, sdptool etc.  normally
> 
> . using my reflashed dbt-120 dongle (hci v1.2) to which collie can
> perfectly l2ping, using the very same hcid.conf files (!) - only the
> btaddr is changing. Of course I can't leave my dbt-120 there - I need
> it on another machine for its advanced hid features (boottime support
> for mouse etc.
> 
> Any better solution or workaround would be appreciated. But I'd be
> even more interested if someone could help me understand why all this
> is happening. So far all my googling gave me no result.

check the features of this card. They are limited and if I recall
correctly from memory, the role switch, hold mode etc. are not supported
and thus it makes the using today very hard.

Use "hcidump -X -V" to see why a connection fails. The error code gives
you a good explanation.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
