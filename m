Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rejecting or accepting connection request
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <11D888B5FA88D9409851B71E8D3206D1016624@doar.commil.com>
References: <11D888B5FA88D9409851B71E8D3206D1016624@doar.commil.com>
Content-Type: text/plain
Message-Id: <1112719745.12406.74.camel@notepaq>
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
Date: Tue, 05 Apr 2005 18:49:05 +0200

Hi Tzahi,

> I'm trying to build an application which accepts or rejects incoming
> connections according to the requesting device's bd_Addr. My
> application compares the requesting device's bd_Addr to a list and if
> the address is in the list, the application accepts the request.
> Otherwise, it rejects it.
> I have set the event filter to EVT_CONN_REQEUST (and
>  EVT_CONN_COMPLETE and EVT_DISCONN_COMPLETE) and I'm using select()
> followed by read() to get the events. My problem is that for every
> EVT_CONN_REQ I receive, the hci interface automatically accepts it.
> I've tried to set the link_mode with different values using the
> hciconfigure but it didn't help.
>  
> It seems that the only way I can make this bd_addr filtering is by
> disconnecting the connections with un-listed bd_addreses. Am I right?
> any ideas?

what you are talking about will be handled by an in-kernel policy
manager, but actually this code is far away from being finished at the
moment. And you must do this inside the kernel, because it is not the
job of the userspace to handle HCI connections.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
