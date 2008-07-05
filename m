Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1215241201.17606.7.camel@localhost>
References: <1215241201.17606.7.camel@localhost>
Date: Sat, 05 Jul 2008 19:21:35 +0200
Message-Id: <1215278495.4349.23.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Forward and Backward keys on presenter
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Rui,

> I have a microsoft notebook presenter mouse 8000
> (http://www.microsoft.com/hardware/Presenter/productdetails.aspx?pid=085) and I have managed to have it working (as a mouse). When switching to presenter mode, the multimedia keys work (volume up and down), but the forward and backword keys do not. I tried to get the key codes with xev, but nothing shows up. Even the scan code (with showkey -s or with getscancode - http://keytouch.sourceforge.net/) nothing shows up.
> 
> However, with hcidump I can see that something goes through:
> 
> (as a mouse)
> > 02 32 20 0B 00 07 00 41 00 A1 11 00 FF 00 00 00 
> > 02 32 20 0B 00 07 00 41 00 A1 11 00 FE FF 00 00 
> > 02 32 20 0B 00 07 00 41 00 A1 16 00 00 0F 00 00 
> > 04 14 06 00 2E 00 00 00 00 
> > 02 32 20 0B 00 07 00 41 00 A1 16 00 00 00 00 00 
> (switching to presenter)
> > 04 14 06 00 2E 00 02 A2 00 
> > 04 14 06 00 32 00 00 00 00 
> > 04 14 06 00 32 00 02 4E 00 
> (pressing forward key)
> > 02 32 20 0B 00 07 00 41 00 A1 16 00 00 00 00 00 
> > 02 32 20 0B 00 07 00 41 00 A1 16 00 00 00 00 00 
> (switching to mouse)
> > 04 14 06 00 32 00 00 00 00 
> > 04 14 06 00 32 00 02 1E 00 
> > 04 14 06 00 32 00 00 00 00 
> > 04 14 06 00 32 00 02 4E 00 
> 
> (as a mouse)
> > ACL data: handle 50 flags 0x02 dlen 11
>     L2CAP(d): cid 0x0041 len 7 [psm 0]
>       A1 16 00 00 08 00 00 
> > HCI Event: Mode Change (0x14) plen 6
>   00 32 00 00 00 00 
> > HCI Event: Mode Change (0x14) plen 6
>   00 32 00 02 1E 00 
> > ACL data: handle 50 flags 0x02 dlen 11
>     L2CAP(d): cid 0x0041 len 7 [psm 0]
>       A1 16 00 00 00 00 00 
> (switching to presenter)
> > HCI Event: Mode Change (0x14) plen 6
>   00 32 00 00 00 00 
> > HCI Event: Mode Change (0x14) plen 6
>   00 32 00 02 4E 00 
> (pressing forward key)
> > ACL data: handle 50 flags 0x02 dlen 11
>     L2CAP(d): cid 0x0041 len 7 [psm 0]
>       A1 16 00 00 0E 00 00 
> > HCI Event: Mode Change (0x14) plen 6
>   00 32 00 00 00 00 
> > HCI Event: Mode Change (0x14) plen 6
>   00 32 00 02 1E 00 
> > ACL data: handle 50 flags 0x02 dlen 11
>     L2CAP(d): cid 0x0041 len 7 [psm 0]
>       A1 16 00 00 00 00 00 
> (back to mouse mode)
> > HCI Event: Mode Change (0x14) plen 6
>   00 32 00 00 00 00 
> > HCI Event: Mode Change (0x14) plen 6
>   00 32 00 02 4E 00 
> 
> I do not know how to interpret this information. Does anyone knows if
> the problem is related to the bluetooth part or to X?
> Is there any possibility of getting it working?

the generic HID driver inside the kernel will handle this part. So to
convert all buttons, it might need some quirks to be setup. However I
have no idea which ones are needed since I don't have one of these
devices at home for testing.

Regards

Marcel



-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
