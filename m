Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <2de46576041206055023c98e57@mail.gmail.com>
From: Manjunath Prabhu <manjunath.mp@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Link Quality
In-Reply-To: <1102339845.9644.23.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <2de465760412060523287f7d5c@mail.gmail.com>
	 <1102339845.9644.23.camel@pegasus>
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
Date: Mon, 6 Dec 2004 19:20:23 +0530

Hi Marcel,


On Mon, 06 Dec 2004 14:30:45 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Manjunath,
> 
> > The LM decides which packets to use to send data based on link quality.
> > How can I read or trace the  packet type I am using currently? Or
> > rather if the packet type changes...will an event be generated? Do the
> > packet types change dynamically......as the link quality varies???
> 
> the link manager has a list of packet types it is able to use and it
> will use them. There exists a command to change the packet types of an
> already created connection and this command will also create an event
> that informs you that the packet types have changed. Besides this you
> can only guess from the size of ACL data packets what packet type the
> link manager is using and this is not an exact science.
> 
> > Can I somehow avoid FEC checks???May be by using DH packets......but I
> > know you say I shouldn't change packet types??? Is there someother
> > method to do so.
> 
> No, because DM1 is always allowed.
After a connection is established, I can change the packet to any of
the DH types and avoid FEC........did you mean that even then DM1 is
allowed.

Does, opening a socket and then connect() at the
L2CAP......automatically establish an HCI connection first and then an
L2CAP connection on top of it??  This is what HCI dump shows..

Can I in someway just create an HCI connection and then pump HCI data
packet with some known payload??? In a way, just pump raw bits.....

Thanks,
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
