Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Jumpy cursor with Wacom Graphire Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051127230444.GG15156@polar.elf12.net>
References: <20051008132533.GA954@polar.elf12.net>
	 <20051127174209.GB15156@polar.elf12.net> <1133115990.13629.1.camel@blade>
	 <20051127184902.GD15156@polar.elf12.net> <1133119580.13629.13.camel@blade>
	 <20051127213835.GF15156@polar.elf12.net> <1133128569.13629.28.camel@blade>
	 <20051127230444.GG15156@polar.elf12.net>
Content-Type: text/plain
Message-Id: <1133133083.13629.43.camel@blade>
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
Date: Mon, 28 Nov 2005 00:11:23 +0100

Hi Robert,

> > > > maybe the HID inside the Wacom is broken and needs a special quirk. This
> > > > wouldn't be the first time. However also the Linux HID code can be at
> > > > fault here. You still haven't send in enough information about that
> > > > device to tell.
> > > > 
> > > > Use "hcitool info..." and "sdptool browse --raw" to get some more
> > > > information about the device.
> > > 
> > > panorama:/etc/udev# sdptool browse --raw
> > > Inquiring ...
> > > 
> > > 
> > > Should there be something? ("local" or the tablet address do the same:
> > > empty)
> > 
> > put in the address of the tablet. I need to see the full record.
> 
> I did that already:
> 
>  panorama:/etc/udev# sdptool browse --raw 00:13:C2:00:11:2C
>  panorama:/etc/udev# sdptool browse --raw local            
>  panorama:/etc/udev# pgrep sdpd
>  21177
>  panorama:/etc/udev# 

the do "sdptool search --bdaddr 00:13:C2:00:11:2C --raw <hid|did>" and
see what comes out.

> > > My questions were:
> > >  -Who is making the connectinon? (hidp kernel module?)
> > 
> > The tablet is requesting the connection and hidd answers it and then
> > hands over the socket descriptors to the hidp kernel module to run the
> > HIDP on it.
> > 
> > >  -Who can/could influence it's outcome? (hidd userspace daemon? Plays
> > >   hcid an important role?)
> > 
> > None of them has anything to do with it. The only important things are
> > to enable rswitch and sniff in the link policy.
> 
> I mean, (from the answer of the first question) any parameters of the
> connection (don't know much right now...) are in the influence of hidd
> only. - So, hidd can deny the connection or try to modify attributes of
> it, right?

Look at /usr/include/bluetooth/hidp.h the struct hidp_connadd_req is
used to handover the connection from hidd to hidp. For report mode
protocol the report descriptor is an important thing. It is done this
way, because you need SDP to retrieve it.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
