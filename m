Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Robert Siemer <Robert.Siemer@backsla.sh>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: Jumpy cursor with Wacom Graphire Bluetooth
Message-ID: <20051128084428.GL15156@polar.elf12.net>
References: <20051127213835.GF15156@polar.elf12.net> <1133128569.13629.28.camel@blade> <20051127230444.GG15156@polar.elf12.net> <1133133083.13629.43.camel@blade> <20051127234927.GI15156@polar.elf12.net> <1133136167.13629.58.camel@blade> <20051128015303.GJ15156@polar.elf12.net> <1133143721.13629.67.camel@blade> <20051128022901.GK15156@polar.elf12.net> <1133146623.13629.74.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1133146623.13629.74.camel@blade>
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
Date: Mon, 28 Nov 2005 09:44:28 +0100

On Mon, Nov 28, 2005 at 03:57:03AM +0100, Marcel Holtmann wrote:
> Hi Robert,
> 
> > > The encryption and authentication should be no problem at all. I used
> > > this for most devices, but it is off for a mouse or pointer like device
> > > by default. The reason is that these devices can't input their PIN and a
> > > default PIN is weak anyhow.
> > 
> > Of course. But if you can assure that during pairing nobody was
> > sniffing, you are on the safe side afterwards. That means open 1 minute
> > only or open during the whole product lifetime...
> 
> this is not fully true. If the device is always visible, connectable and
> pairable then everybody can pair. If this is only true when you press
> the pairing button, then everybody who can reach this button can pair.
> If this device allows multiple pairings, you will never notice.

True. So, lets assume that it doesn't. If it did you could still notice
when it does not connect correctly to your host... - I couldn't image
that it would send the same data over concurrent connections...

> > > Check with "hcidump -X -V" what happens.
> > 
> > I will, but not this night... (-:
> > 
> > > > The switch between the modes is done with a "set report mode feature"
> > > > call. 
> > > 
> > > Question is what is default?
> > 
> > HID. Because the wacom people told me and addionally the tablet actually
> > works with bluez. - But it does not send packets until the mouse/pen got
> > moved at least 6 "pixel" in one direction. (See my first email in this
> > thread). That means: I move the mouse, but hcidump is not showing
> > anything. - I have to move it some millimeters before it does see
> > something...
> 
> If hcidump is showing nothing, then the device is not sending any report
> at all. This means the device is at fault if it is jumpy.

Of course. That's clear. - But still believe that it's possible to
influence it in this behaviour.

> > > > > You wrote something about a switch. Is there a difference in the SDP
> > > > > records if you choose a different setting?
> > > > 
> > > > I think I was talking about the two modes mentioned above. As hardware
> > > > there are only buttons: two "mouse buttons", a power button and a
> > > > "pairing" button.
> > > 
> > > What does the pairing button do? It makes the device discoverable and
> > > pairable, right?
> > 
> > I think so. It is already a "long time" ago, because some things did
> > work with the pairing auth/enc switched on, but it did not end up
> > working (to the level it does without)...
> 
> Don't even think about switching into security mode 3. Use the -E switch
> of hidd instead.

Man page and hidd --help output don't say it: what does the -E switch?



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
