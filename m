Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] add device entry for Broadcom Valentine combo card
From: Marcel Holtmann <marcel@holtmann.org>
To: Al Cho <acho@suse.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	acho@novell.com, jlee@novell.com, oneukum@suse.com
Date: Wed, 16 Nov 2011 18:19:32 +0900
In-Reply-To: <CAKzePaqwKbg8oZ6ULcdXdnYAkLU+k6o3bQWVaLUfCEDrH2994g@mail.gmail.com>
References: <2eb6d1b761a3fddea28294959bde7e9c7ef88043.1319086508.git.acho@suse.com>
	 <20111031191809.GB10164@joana>
	 <CAKzePaqwKbg8oZ6ULcdXdnYAkLU+k6o3bQWVaLUfCEDrH2994g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321435176.15441.528.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Al,

> > * Cho, Yu-Chen <acho@suse.com> [2011-10-20 12:58:29 +0800]:
> >
> >> This device declares itself to be vendor specific
> >> It therefore needs to be added to the device table
> >> to make btusb bind.
> >
> > It would be good to have the output of usb-devices for this specific device in
> > the commit message.
> 
> Would you please kindly explain what is "the output of usb-device" to me?
> The patch is for Broadcom Valentine 802.11bgn 1x1 wireless and
> bluetooth combo card.

open an xterm and type "usb-devices", then press return. And we want to
see the part about this device.

Regards

Marcel


