Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Multiple Bluetooth connections
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <42372E0A.80002@futurlink.com>
References: <42372E0A.80002@futurlink.com>
Content-Type: text/plain
Message-Id: <1110966130.9818.95.camel@pegasus>
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
Date: Wed, 16 Mar 2005 10:42:10 +0100

Hi Pedro,

> In the application that I am developing, I want to send simultaneous 
> OBEX messages to different OBEX servers over Bluetooth. I am using 
> OpenOBEX for this purpose. There are two problems I am facing.
> 
> On the one hand, it seems that there is only room to establish one 
> Bluetooth connection at a time. If I start many OBEX pushes 
> simultaneously, only the first one succeeds. The others fail usually 
> with error "Device or resource busy" (errno=16); sometimes even with 
> "Software caused connection abort" (errno=103). Once the first 
> connection is established and while sending OBEX data, I can establish 
> another connection.
> 
> I just want to make clear that the problem is with the establishment of 
> the connection. I am fully aware that it is possible to handle various 
> on-going connections with no problems and I have succeeded with that. Is 
> there a limitation with Bluetooth or BlueZ that allows only one RFCOMM, 
> L2CAP or HCI connection establishment?

this is a hardware limit and I don't know of any chip that is capable of
establishing two connections at the same time. From what I know this
will never be possible, but you should better ask a radio/baseband
expert for a correct answer.

> On the other hand, some connections die before sending the data, but it 
> seems that the file descriptor of this connection does not receive any 
> notification (I use select() on all file descriptors, with the file 
> descriptor in the read mask). I know that this could be due to a problem 
> with my program, a problem with OpenOBEX or the BlueZ version I am using 
> (it is not the latest). In any case, to track down the cause, I would 
> like to know how can I monitor the Bluetooth connections (at any level, 
> but preferably RFCOMM) that a process (or the whole system) has. What I 
> am looking for is a tool like netstat.

Using poll() or select() is the right way. About what version of the
kernel and library/utils are we talking?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
