Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] HCI send and receive
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <2de46576041207221162e8ba29@mail.gmail.com>
References: <2de46576041207211852e826cc@mail.gmail.com>
	 <1102484088.9988.24.camel@pegasus>
	 <2de46576041207221162e8ba29@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1102491144.9988.28.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 08 Dec 2004 08:32:24 +0100

Hi Manjunath,

> > > I want to set up an HCI connection between 2 dongles, see the default
> > > packet type at connection, then send data. Now keeping the existing
> > > connection, I want to change packet type and  then send data....Is
> > > this possible????
> > 
> > I don't see what you expect from this, but it is possible.
> 
> What i am expecting is a measure of varying throughput with change in
> packet type.

I don't see for what this will be good, but you can simply set the same
packet type on both sides with hciconfig and then use l2test or rctest
for measuring. Or create a PAN and use standard IP tools.

> > > Should I write small programs just to send and receive data with known
> > > payload....then I can establish a connection using hcitool and use
> > > these programs to send and receive data passing the connection handle
> > > as the parameter. Is this right??
> > 
> > All API commands you need are there and you can always use the HCI raw
> > socket. It is a H:4 based, one command or data packet per read/write
> > interface. 
> I am ignorant about this.....are you saying HCI raw socket provides
> the one command or data packet per read/write interface....can you
> elaborate...

It is as I said. You can write/read H:4 on a HCI raw socket.
 
> And it is a good idea to send L2CAP conform ACL data packets.
> Does this mean it would be a L2CAP connection as you send some chips
> expect L2CAp frames???

I think some chips do and actually also the remote Bluetooth stack might
expect L2CAP.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
