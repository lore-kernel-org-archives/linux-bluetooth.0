Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Make bluetooth-properties fit on smaller displays
From: Bastien Nocera <hadess@hadess.net>
To: Jim Carter <jimc@math.ucla.edu>
Cc: David Sainty <david.sainty@dtsp.co.nz>, Mario_Limonciello@Dell.com,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0810010904570.18937@simba.math.ucla.edu>
References: <FA7963CC89065B49AED46A6F797F0FA6F28694@AUSX3MPC128.aus.amer.dell.com>
	 <1222679240.1825.14.camel@violet.holtmann.net>
	 <1222679724.3311.53.camel@cookie.hadess.net>
	 <FA7963CC89065B49AED46A6F797F0FA6F28698@AUSX3MPC128.aus.amer.dell.com>
	 <1222701730.3311.76.camel@cookie.hadess.net> <48E1DCA8.2040005@dtsp.co.nz>
	 <1222762649.1825.56.camel@violet.holtmann.net>
	 <48E1E9D3.8050202@dtsp.co.nz>
	 <FA7963CC89065B49AED46A6F797F0FA6F2869C@AUSX3MPC128.aus.amer.dell.com>
	 <48E2A4D5.8020509@dtsp.co.nz>
	 <Pine.LNX.4.64.0810010904570.18937@simba.math.ucla.edu>
Content-Type: text/plain
Date: Wed, 01 Oct 2008 17:33:00 +0100
Message-Id: <1222878780.3311.226.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2008-10-01 at 09:26 -0700, Jim Carter wrote:
> On Wed, 1 Oct 2008, David Sainty wrote:
> 
> > xdpyinfo says the DPI is 100x101... heh...
> > 
> >  dimensions:    800x480 pixels (203x121 millimeters)
> >  resolution:    100x101 dots per inch
> > 
> > In reality it's around 133dpi (153mm x 92mm).
> 
> I'm sure the erratic sizing comes from nonuniform font selection.
<snip>

What does all that have to do with the discussion at hand?

> I wonder if the Bluetooth applet follows this rule?  Judging from the 
> discussion, most likely it does, and it's then at the mercy of the distro's 
> setup.

There's resolution independence patches ready to be merged into GTK+.
See:
http://bugzilla.gnome.org/show_bug.cgi?id=546711

> Judging the screenshots that were shown, I think the landscape layout (new) 
> is more practical for the N810.

The N810 doesn't use bluez-gnome.

>   However, the smallest screen I have to 
> deal with at work is the Palm Treo 650 at 320x320px.

Which doesn't run Linux, or bluez-gnome, does it?

>   It wouldn't be 
> running Linux, but if it were, both orientations would be equally bad.  I 
> suspect that handheld devices are the most likely to have Bluetooth 
> accessories, since they have the most limitation in power and USB ports, so 
> special effort should be put in to fit any dialog boxes reliably on the 
> small screens, assuming the distro provides defaults that make this 
> possible.

Please don't go off on tangents. There's a pretty clear discussion
happening, I don't think we want to hear ramblings about other devices
that don't even use bluez-gnome.

