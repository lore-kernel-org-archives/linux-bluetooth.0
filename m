Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Profiles and Service publicing
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <cuvg8v$6qs$1@sea.gmane.org>
References: <cuvg8v$6qs$1@sea.gmane.org>
Content-Type: text/plain
Message-Id: <1109027993.7626.41.camel@pegasus>
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
Date: Tue, 22 Feb 2005 00:19:53 +0100

Hi,

> The following SDP transaction is repeating again and again until the 
> headset gets tired:
> 
>  > ACL data: handle 0x0029 flags 0x02 dlen 19
>      L2CAP(d): cid 0x0040 len 15 [psm 1]
>          SDP SS Req: tid 0x49 len 0xa
>            pat uuid-32 0x1112 (AG)
>            max 0x28
>            cont 00
> < ACL data: handle 0x0029 flags 0x02 dlen 14
>      L2CAP(d): cid 0x0040 len 10 [psm 1]
>          SDP SS Rsp: tid 0x49 len 0x5
>            tot 0x0 cur 0x0
>            cont 00
> 
> The first is a SDP_ServiceSearch Request from the headset looking for a 
> service with UUID  of value 0x1112 (corresponds to AudioGateway).
> The second is a SDP_ServiceSearch Response from BlueZ saying that the 
> requested service is not found in the SDP database nor nothing even 
> similar, which is really true because I have not add this service 
> ("sdptool add AG" is not supported)

if the headset ends up in a loop like this, then the implementation of
the headset profile inside the headset has a bug. It is that simple,
because they should be able to handle a non existing audio gateway
record nicely.

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
