Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <2de46576041207221162e8ba29@mail.gmail.com>
From: Manjunath Prabhu <manjunath.mp@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] HCI send and receive
In-Reply-To: <1102484088.9988.24.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <2de46576041207211852e826cc@mail.gmail.com>
	 <1102484088.9988.24.camel@pegasus>
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
Date: Wed, 8 Dec 2004 11:41:11 +0530

Hi Marcel,


On Wed, 08 Dec 2004 06:34:48 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Manjunath,
> 
> > I want to set up an HCI connection between 2 dongles, see the default
> > packet type at connection, then send data. Now keeping the existing
> > connection, I want to change packet type and  then send data....Is
> > this possible????
> 
> I don't see what you expect from this, but it is possible.

What i am expecting is a measure of varying throughput with change in
packet type.

> 
> > Should I write small programs just to send and receive data with known
> > payload....then I can establish a connection using hcitool and use
> > these programs to send and receive data passing the connection handle
> > as the parameter. Is this right??
> 
> All API commands you need are there and you can always use the HCI raw
> socket. It is a H:4 based, one command or data packet per read/write
> interface. 
I am ignorant about this.....are you saying HCI raw socket provides
the one command or data packet per read/write interface....can you
elaborate...
 
And it is a good idea to send L2CAP conform ACL data packets.
Does this mean it would be a L2CAP connection as you send some chips
expect L2CAp frames???
Regards,
Manjunath
> 
> Regards
> 
> Marcel
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
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
