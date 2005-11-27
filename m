Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Jumpy cursor with Wacom Graphire Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051127184902.GD15156@polar.elf12.net>
References: <20051008132533.GA954@polar.elf12.net>
	 <20051127174209.GB15156@polar.elf12.net> <1133115990.13629.1.camel@blade>
	 <20051127184902.GD15156@polar.elf12.net>
Content-Type: text/plain
Message-Id: <1133119580.13629.13.camel@blade>
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
Date: Sun, 27 Nov 2005 20:26:20 +0100

Hi Robert,

> > > I'm picking up this thread because it is still unresolved...
> > > 
> > > 1) Finally I could update from 2.6.12-mh3 to 2.6.14-mh2.
> > >    With that I can prove Marcel wrong without repeating myself once
> > >    again: the tablet works as bad as before; no visible difference
> > >    between these two patched kernels.
> > > 
> > > 2) I would like to get some answers to my questions below. Marcel,
> > >    why are you ignoring them?
> > 
> > I think that I need the tablet by myself to do any further analysis.
> 
> That's an option. You live in Germany? How much weeks do you estimate?
> What are you going to resolve? The tablet can be switched to a wacom
> mode where it actually reports absolute data and other details which
> makes it usable as a tablet...
> 
> For me it wouldn't be my first kernel hacking, and I thought about
> "repairing" the HID mode first would be a good excersise before going
> further...
> 
> Of course I could dig into all the details on my own, but I would be
> faster with a tutor. - So I actually don't understand why you still don't
> answer my questions. Should I copy them again?

maybe the HID inside the Wacom is broken and needs a special quirk. This
wouldn't be the first time. However also the Linux HID code can be at
fault here. You still haven't send in enough information about that
device to tell.

Use "hcitool info..." and "sdptool browse --raw" to get some more
information about the device.

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
