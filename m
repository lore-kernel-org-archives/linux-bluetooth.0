Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] l2cap and multiple connections
From: Marcel Holtmann <marcel@holtmann.org>
To: Vladimeros Vladimerou <vladimer@students.uiuc.edu>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.31.0405141228510.13007-100000@ux7.cso.uiuc.edu>
References: <Pine.GSO.4.31.0405141228510.13007-100000@ux7.cso.uiuc.edu>
Content-Type: text/plain
Message-Id: <1084556506.25099.197.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 14 May 2004 19:41:46 +0200

Hi Vlad,

>  I'm trying to achieve multiple l2cap channels/connections (1 master to 5
> slaves). I'm wondering if anyone knows the method off-hand, so that I
> won't have to look into library and kernel source. I was naively
> trying to bind several sockets to the same address, after issuing a
> "setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));" but
> even if this call returns "Success", the next bind() returns
> "Address already in use". How is this conventionally done?
> Do I have to step down to HCI?

you should step down to a book for socket programming. Which actually
means bind() once and accept() often ;)

>  I'm also wondering if l2cap is the fastest way to send a custom 64-byte
> message to 5 clients (real-time application). Has anyone used SCO for
> such a purpose?

SCO is for audio data only. How often must I repeat this. Maybe eSCO is
able to serve the real-time need, but I am not really sure about it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
