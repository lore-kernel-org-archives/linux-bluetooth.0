Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Robert Siemer <Robert.Siemer@backsla.sh>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: Jumpy cursor with Wacom Graphire Bluetooth
Message-ID: <20051128022901.GK15156@polar.elf12.net>
References: <20051127184902.GD15156@polar.elf12.net> <1133119580.13629.13.camel@blade> <20051127213835.GF15156@polar.elf12.net> <1133128569.13629.28.camel@blade> <20051127230444.GG15156@polar.elf12.net> <1133133083.13629.43.camel@blade> <20051127234927.GI15156@polar.elf12.net> <1133136167.13629.58.camel@blade> <20051128015303.GJ15156@polar.elf12.net> <1133143721.13629.67.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1133143721.13629.67.camel@blade>
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
Date: Mon, 28 Nov 2005 03:29:01 +0100

> The encryption and authentication should be no problem at all. I used
> this for most devices, but it is off for a mouse or pointer like device
> by default. The reason is that these devices can't input their PIN and a
> default PIN is weak anyhow.

Of course. But if you can assure that during pairing nobody was
sniffing, you are on the safe side afterwards. That means open 1 minute
only or open during the whole product lifetime...

> Check with "hcidump -X -V" what happens.

I will, but not this night... (-:

> > The switch between the modes is done with a "set report mode feature"
> > call. 
> 
> Question is what is default?

HID. Because the wacom people told me and addionally the tablet actually
works with bluez. - But it does not send packets until the mouse/pen got
moved at least 6 "pixel" in one direction. (See my first email in this
thread). That means: I move the mouse, but hcidump is not showing
anything. - I have to move it some millimeters before it does see
something...

If it's not HID, wacom mode wouldn't it be, either. 

> > > >         Attribute 0x0206
> > > >                 Sequence
> > > >                         Sequence
> > > >                                 UINT8 0x22
> > > >                                 String 05 01 09 02 a1 01 85 02 09 01 a1
> > > > 00 05 09 19 01 29 03 15 00 25 01 95 03 75 01 81 02 95 01 75 05 81 01 05
> > > > 01 09 30 09 31 09 38 15 81 25 7f 75 08 95 03 81 06 c0 c0 05 0d 09 01 a1
> > > > 01 85 03 a1 00 06 00 ff 09 01 15 00 26 ff 00 75 08 95 07 81 02 c0 09 02
> > > > 85 03 95 01 b1 02 09 03 85 04 95 01 b1 02 09 04 85 05 95 01 b1 02 09 05
> > > > 85 06 95 01 b1 02 09 06 85 07 95 01 b1 02 09 07 85 08 95 01 b1 02 09 08
> > > > 85 09 95 01 b1 02 c0

> The attribute 0x0206 contains the report descriptor with id 0x22. This
> descriptor defines the actual reports send from/to the device. This is
> nothing SDP specific. It is pure HID, but Bluetooth holds this data in
> the SDP database.

I'm trying to follow the spec up to this point, but don't expect
anything before christmas... <-:

> > > You wrote something about a switch. Is there a difference in the SDP
> > > records if you choose a different setting?
> > 
> > I think I was talking about the two modes mentioned above. As hardware
> > there are only buttons: two "mouse buttons", a power button and a
> > "pairing" button.
> 
> What does the pairing button do? It makes the device discoverable and
> pairable, right?

I think so. It is already a "long time" ago, because some things did
work with the pairing auth/enc switched on, but it did not end up
working (to the level it does without)...


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
