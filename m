Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050222151413.99069.qmail@web53206.mail.yahoo.com>
From: Filipa Duarte <filipa_duarte@yahoo.com>
Subject: Re: [Bluez-users] Running L2CAP & HCI layers without OS
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1109066407.8506.11.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Tue, 22 Feb 2005 07:14:13 -0800 (PST)

Hi Marcel,

--- Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Filipa,
> 
> > It seams that my question about the l2cap and hci
> > layers implemented in User Space is not so stupid
> > after all! ;)
> 
> you should spent some time to think about hardware
> abstraction and the
> right interface to L2CAP, RFCOMM etc. and then this
> looks stupid again.
> Actually the OpenBT Bluetooth stack had exactly
> these two problems.

You are right, I did not explain why I want to run
l2cap and hci layers without OS...

In my research I need to implement the Bluetooth
protocol in reconfigure hardware (FPGA, ASIC, etc). To
do this I need to run the protocol stack without OS.

> 
> > Could anyone give me directions on how to run
> these
> > layers without OS? One solution, I think, would be
> to
> > change the l2cap and the hci files in order on not
> to
> > have any OS call (that was actually what I as
> doing,
> > which is quite a heavy work!). But it seams that
> there
> > is an easy way (thanks Marcel, for pointing that
> > out!).
> 
> There is no easy way and actually I don't see any
> need for it. Feel free
> to start another Bluetooth stack, but this mailing
> list is about the
> BlueZ and Linux and not any other operating system.

I really would like to be able to develop a new
protocol stack... but unfortunately my knowledge of
linux or bluetooth is not enough for that ;))

So, from your answer I suppose the only way of having
the l2cap and hci layers running without OS is doing
what I am doing (change the code of these layers to
avoid the system calls), right? 


Regards,

Filipa


		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - Get yours free! 
http://my.yahoo.com 
 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
