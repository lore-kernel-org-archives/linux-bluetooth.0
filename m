Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <b5c638dc05032912313f814461@mail.gmail.com>
From: David Vitrant <prussia@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bluez and billionton pcbtc1
In-Reply-To: <1112117903.9016.103.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <b5c638dc05032815321b2739c5@mail.gmail.com>
	 <1112075117.9016.60.camel@pegasus>
	 <b5c638dc05032907582bf771dc@mail.gmail.com>
	 <1112114217.9016.92.camel@pegasus>
	 <b5c638dc050329084145c6fecd@mail.gmail.com>
	 <1112114986.9016.94.camel@pegasus>
	 <b5c638dc05032908584e207be8@mail.gmail.com>
	 <b5c638dc05032909155d940a3c@mail.gmail.com>
	 <b5c638dc0503290934170df12@mail.gmail.com>
	 <1112117903.9016.103.camel@pegasus>
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
Date: Tue, 29 Mar 2005 15:31:10 -0500

ok well i tried from 9600 to 921600

using the:

hciattach ttyS14 any "number here"

then i did what you said and ran "hcid" and "hciconfig" in every
outpud it's the same (except the RX bytes and errors increase)

am i missing something  or does that mean that my card just doesn't
work with bluez :(

hci0:   Type: UART
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
        DOWN INIT RUNNING
        RX bytes:18 acl:0 sco:0 events:0 errors:18
        TX bytes:4 acl:0 sco:0 commands:1 errors:0



thanks again,
David

On Tue, 29 Mar 2005 19:38:23 +0200, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi David,
> 
> > ok sorry for the update.. i ran this command
> >
> > hciattach ttyS14 any 16550
> >
> > (From the above hints you gave me :) ) and something happenned in dmesg..
> 
> the command can't be right, because 16550 is not a valid baud rate. It
> is the UART type. Use 115200 as baud rate. You have to play with it and
> see if it works.
> 
> Start "hcid" as root and check with "hciconfig" if you see the Bluetooth
> device address. If yes, then your card is working.
> 
> > i think it's working .. gnome-bluetooth manager still gives me the
> > gconf error . and gnome authentication error (no ideas.. and nobody
> > has been able to answer me on what that error is.. plus a google
> > search didn't pull anything up"
> 
> This is the wrong mailing list for a Gnome-Bluetooth questions.
> 
> Regards
> 
> Marcel
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
