Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] apple wireless mouse on apple ibook (g4, builtin
	usb)
From: Marcel Holtmann <marcel@holtmann.org>
To: Sunnan <sunnan@handgranat.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40300408.4070604@handgranat.org>
References: <402D07B8.8030504@handgranat.org>
	 <1076694675.2671.191.camel@pegasus>  <402D1E8C.6020301@handgranat.org>
	 <1076702197.18588.11.camel@pegasus>  <402D381D.1000306@handgranat.org>
	 <1076709007.18588.39.camel@pegasus>  <402D4959.10704@handgranat.org>
	 <1076711341.18588.57.camel@pegasus>  <402D5592.3060907@handgranat.org>
	 <1076714464.18588.95.camel@pegasus>  <402D5EB0.3090601@handgranat.org>
	 <1076720052.18588.147.camel@pegasus> <402E014C.807@handgranat.org>
	 <40300408.4070604@handgranat.org>
Content-Type: text/plain
Message-Id: <1076889578.2840.36.camel@pegasus>
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
Date: Mon, 16 Feb 2004 00:59:38 +0100

Hi Sunnan,

> I still haven't gotten my mouse to work (I know! sorry).
> One of the herrings I'm chasing is the name, is the problem the weird
> characters in the devices name? if so, can it be renamed?

this must be some Apple specific option. I like to know how it can be
done, but it has nothing to do with your device working or not.

> I've been able to find it more often with hcitool by clicking/moving it
> while hcitool is searching.
> 
> Still no success with bthid, it has never given me anything else than
> 
> Feb 15 23:30:04 slowstorm bthid[1035]: Bluetooth HID service started
> Feb 15 23:30:30 slowstorm bthid[1035]: Connection failed: Host is down (112)
> 
> when I try to connect to my mouse with sudo bthid -c 00:0A:95:01:5F:57
> 
> and bthid loves to just exit all the time.

I think this is an endian problem. From the last dump you send me I saw

< ACL data: handle 0x002d flags 0x02 dlen 24
    L2CAP(d): cid 0x42 len 20 [psm 1]
        SDP SSA Req: tid 0x1 len 0xf
          pat uuid-16 0x0012
          max 0xffff
          aid(s) 0xffff - 0x0000
          cont 00 
> ACL data: handle 0x002d flags 0x02 dlen 15
    L2CAP(d): cid 0x42 len 11 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x6
          cnt 0x3 len 0x3 frm->len 0x1 n 0x0
          cont 00 

The UUID of the HID service and the attribute id's of the request are
wrong. If it can't find the SDP record for the HID service, it can't
setup the HID descriptor and make your mouse working, but I don't know
why the bthid process exits.

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
