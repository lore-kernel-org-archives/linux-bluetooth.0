Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Robert Siemer <Robert.Siemer@backsla.sh>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: Jumpy cursor with Wacom Graphire Bluetooth
Message-ID: <20051127213835.GF15156@polar.elf12.net>
References: <20051008132533.GA954@polar.elf12.net> <20051127174209.GB15156@polar.elf12.net> <1133115990.13629.1.camel@blade> <20051127184902.GD15156@polar.elf12.net> <1133119580.13629.13.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1133119580.13629.13.camel@blade>
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
Date: Sun, 27 Nov 2005 22:38:35 +0100

Hi Marcel!

> maybe the HID inside the Wacom is broken and needs a special quirk. This
> wouldn't be the first time. However also the Linux HID code can be at
> fault here. You still haven't send in enough information about that
> device to tell.
> 
> Use "hcitool info..." and "sdptool browse --raw" to get some more
> information about the device.

panorama:/etc/udev# sdptool browse --raw
Inquiring ...


Should there be something? ("local" or the tablet address do the same:
empty)

panorama:/etc/udev# hcitool info 00:13:C2:00:11:2C
Requesting information ...
        BD Address:  00:13:C2:00:11:2C
        Device Name: WACOM Pen Tablet
        LMP Version: 1.2 (0x2) LMP Subversion: 0x5df
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
                <3-slot packets> <5-slot packets> <encryption> <slot offset> 
                <timing accuracy> <role switch> <hold mode> <sniff mode> 
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets> 
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme> 
                <power control> <transparent SCO> <broadcast encrypt> 
                <enhanced iscan> <interlaced iscan> <interlaced pscan> 
                <inquiry with RSSI> <AFH cap. slave> <AFH class. slave> 
                <AFH cap. master> <AFH class. master> <extended features> 


My questions were:
 -Who is making the connectinon? (hidp kernel module?)
 -Who can/could influence it's outcome? (hidd userspace daemon? Plays
  hcid an important role?)
 -Has the latency thing something to do with it?
 -Which spec should I first dig into - Bluetooth or HID?



Thanks,
		Robert


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
