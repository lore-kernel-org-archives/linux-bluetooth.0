Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Failed to connect to SDP server on
	00:10:60:A4:89:15: Function not implemented
From: Marcel Holtmann <marcel@holtmann.org>
To: filipe_abrantes <filipe_abrantes@netcabo.pt>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <5CD2BD8F1F23A943BAEBE96AB20C24980549DD3E@VS1.hdi.tvcabo>
References: <5CD2BD8F1F23A943BAEBE96AB20C24980549DD3E@VS1.hdi.tvcabo>
Content-Type: text/plain
Message-Id: <1077818189.2849.3.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 26 Feb 2004 18:56:29 +0100

Hi Filipe,

> [root@ee99217 bluez-sdp-1.5]# sdptool search GN
> Inquiring ...
> Failed to connect to SDP server on 00:10:60:A4:89:15: Function not implemented
> 
> if i try this i get :
> 
> [root@ee99217 bluez-sdp-1.5]# pand --connect 00:10:60:A4:89:15 --nosdp
> 
> Feb 26 17:16:34 ee99217 pand[8447]: PAN daemon ver 1.1
> Feb 26 17:16:34 ee99217 pand[8447]: Connecting to 00:10:60:A4:89:15
> Feb 26 17:16:37 ee99217 pand[8447]: Connect to 00:10:60:A4:89:15 failed. Function not implemented(38)

show us the output of "hciconfig -a" on both sides.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
