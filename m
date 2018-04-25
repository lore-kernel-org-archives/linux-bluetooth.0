Return-Path: <gregkh@linuxfoundation.org>
Date: Wed, 25 Apr 2018 15:01:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>, Marcel Holtmann <marcel@holtmann.org>,
	"M. Kristall" <mkpdev@gmail.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [4.15 stable regression] "Bluetooth: btusb: Fix quirk for
 Atheros 1525/QCA6174" breaks bluetooth on some devices
Message-ID: <20180425130147.GA20112@kroah.com>
References: <6c97cffb-751f-466d-cd7b-42624fdb18c7@redhat.com>
 <9a752bfc-74bf-25e7-8820-91d1e3163b75@redhat.com>
 <20180425124757.GA29829@kroah.com>
 <e5cbd297-f8b1-2fd0-cd99-cfd39ea55b62@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <e5cbd297-f8b1-2fd0-cd99-cfd39ea55b62@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Apr 25, 2018 at 02:49:59PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 25-04-18 14:47, Greg Kroah-Hartman wrote:
> > On Wed, Apr 25, 2018 at 02:40:37PM +0200, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 18-04-18 15:18, Hans de Goede wrote:
> > > > Hi Takashi, Marcel,
> > > > 
> > > > It seems that this commit:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?h=linux-4.15.y&id=7ec32f585fefd7c154453aa29ccf8fa2a11cc865
> > > > 
> > > > Is breaking bluetooth on some devices, see:
> > > > 
> > > > https://bugzilla.redhat.com/show_bug.cgi?id=1568911
> > > > 
> > > > The problem is the following error now being thrown:
> > > > 
> > > > [   28.466248] Bluetooth: hci0: don't support firmware rome 0x1020200
> > > > 
> > > > Looking at the code I wonder if maybe we need to mask the ver_rom
> > > > with & 0xfff when comparing it to the qca_devices_table[i].rom_version
> > > > filed ?
> > > > 
> > > > Or maybe the commit is actually wrong, or maybe devices with the
> > > > 0cf3:3004 USB id need either the BTUSB_QCA_ROM or BTUSB_ATH3012
> > > > quirk depending on the device and we need to probe this somehow?
> > > 
> > > I've been receiving more complaints from users about this on
> > > various devices, so I think that the 7ec32f585fefd7c154453aa29ccf8fa2a11cc865
> > > commit should be reverted from 4.15.x while we figure this out.
> > > 
> > > Does anyone have any idea how we cam distinguish between the 2
> > > different versions which seem to be hiding between the same USB-id ?
> > 
> > 4.15.y is end-of-life, so there is no more releases being made for it,
> > sorry.
> 
> Ah, right, no problem, Fedora should be moving to 4.16.x soon then
> anyways.

Even if it does, this issue is still there, so it needs to be handled somehow...

thanks,

greg k-h
