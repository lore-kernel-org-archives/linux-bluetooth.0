Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-devel] rejecting or accepting connection request
Message-ID: <11D888B5FA88D9409851B71E8D3206D101662C@doar.commil.com>
From: "Tzahi Efrati" <tzah@commil.com>
To: <bluez-devel@lists.sourceforge.net>
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
Date: Wed, 6 Apr 2005 20:00:12 +0200

Hi Marcel,

Thanks for the answer. I changed hci_conn_request_evt() to simply return
without doing anything, and hci_conn_complete_evt() to allocate (using
hci_add_conn()) the hci_conn struct. So far it seems to work with no
side-effects.

Regards,
Tzahi

-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Tuesday, April 05, 2005 7:49 PM
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] rejecting or accepting connection request

Hi Tzahi,

> I'm trying to build an application which accepts or rejects incoming=20
> connections according to the requesting device's bd_Addr. My=20
> application compares the requesting device's bd_Addr to a list and if=20
> the address is in the list, the application accepts the request.
> Otherwise, it rejects it.
> I have set the event filter to EVT_CONN_REQEUST (and =20
> EVT_CONN_COMPLETE and EVT_DISCONN_COMPLETE) and I'm using select()=20
> followed by read() to get the events. My problem is that for every=20
> EVT_CONN_REQ I receive, the hci interface automatically accepts it.
> I've tried to set the link_mode with different values using the=20
> hciconfigure but it didn't help.
> =20
> It seems that the only way I can make this bd_addr filtering is by=20
> disconnecting the connections with un-listed bd_addreses. Am I right?
> any ideas?

what you are talking about will be handled by an in-kernel policy
manager, but actually this code is far away from being finished at the
moment. And you must do this inside the kernel, because it is not the
job of the userspace to handle HCI connections.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide Read honest & candid
reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
