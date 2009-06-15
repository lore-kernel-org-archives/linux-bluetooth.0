Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Remove hid2hci from bluez
From: Bastien Nocera <hadess@hadess.net>
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4A365725.5070503@dell.com>
References: <6BE8CE7840AC9F459EF5A0693CA2744D5DB52E@ausx3mpc138.aus.amer.dell.com>
	 <1245022400.11069.6101.camel@localhost.localdomain>
	 <4A365725.5070503@dell.com>
Content-Type: text/plain
Date: Mon, 15 Jun 2009 15:28:29 +0100
Message-Id: <1245076109.11069.7011.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2009-06-15 at 09:13 -0500, Mario Limonciello wrote:
> Hi Bastien:
> 
> Bastien Nocera wrote:
> > I really wonder how good an idea that is, given that, ultimately, we'd
> > want to remove hid2hci from everything, and handle the switching from
> > within bluetoothd.
> >   
> This is a conflicting goal with the on-demand stuff I feel.  You can't
> have the on-demand stuff and this working if the BT radio is only
> exposed after the device switches modes.

Why? Instead of calling hid2hci, it would launch bluetoothd --udev, like
the other rules. Problem solved.

> > If we had specs for the devices (or at least rev-eng'ed specs), we'd
> > need to do link keys management, and switching the devices to hci mode
> > from within the same codebase.
> >   
> I agree here, but I don't see the docs showing up anytime soon.
> > So I'd rather hid2hci didn't go into udev-extras, and stayed in bluez
> > until a better solution comes along.
> >   
> Why?  What's it's benefit living in the bluez tree?  By moving to
> udev-extras, it now lives in /lib/udev and will work even if the /usr
> gets mounted on NFS late.

If that's the only benefit, then, frankly, who cares.

The main point is that people with an interested in Bluetooth will need
to go and fetch the code, and ask for patches to be committed.

We're losing direct commit access to the code, and gaining something
that could have been achieved in the distro package.

> > (Still no luck on getting specs from Broadcom about the Dell adapters at
> > least?)
> >   
> I'll send another ping to ask about these again, but I wouldn't hold my
> breath.
> 
> Regards
> 

