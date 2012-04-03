Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Apr 2012 15:14:26 -0700 (PDT)
From: Jiri Kosina <jkosina@suse.cz>
To: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Cc: David Herrmann <dh.herrmann@googlemail.com>,
	linux-input@vger.kernel.org, chen.ganir@ti.com,
	claudio.takahasi@openbossa.org, linux-bluetooth@vger.kernel.org,
	anderson.lizardo@openbossa.org, marcel@holtmann.org
Subject: Re: [RFC v2 0/1] User-space HID I/O Driver
In-Reply-To: <CAAngNMaOHRRfTy5yT9ys0Cv5yB5t-zEVxwcZWuK64BEA4oRy2g@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1204031513070.9041@pobox.suse.cz>
References: <1332793209-2950-1-git-send-email-dh.herrmann@googlemail.com> <CAAngNMa0npQwBv+y_giRTOeLUMYiEnwWw4-cA+xMiRRsK732Mw@mail.gmail.com> <CAAngNMaOHRRfTy5yT9ys0Cv5yB5t-zEVxwcZWuK64BEA4oRy2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 3 Apr 2012, Joao Paulo Rechi Vita wrote:

> >> This is the second revision of the UHID driver. It basically allows to register
> >> hid_ll_drivers in user-space. This is needed to implement Bluetooth HoG (HID
> >> over GATT) as discussed earlier.
> >>
> >
> > We have a first prototype implementation of the HoG plugin working
> > with the uhid driver \o/
> >
> 
> I'm having problems with modifiers keys (they don't work). The USB-HID
> spec says that for each modifier key pressed a bit have to be set on
> the modifiers byte (byte 2) of the report array. Dumping the data both
> on the HoG plugin on bluetoothd and through hidraw for the created HID
> device shows that these bits are being set correctly.
> 
> Any idea of what could be wrong or additional checks that can be performed?

So hidraw shows the respective bits set properly, but they are not coming 
out of /dev/input/eventX, right?

How about /syse/kernel/debug/hid/<device>/events, does it show the events?

-- 
Jiri Kosina
SUSE Labs
