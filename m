Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKT1EBesnson8JR+rTFtQyjATUj09QhR99Lg=ouN4aCeJJbviQ@mail.gmail.com>
References: <1332793209-2950-1-git-send-email-dh.herrmann@googlemail.com>
	<CAAngNMa0npQwBv+y_giRTOeLUMYiEnwWw4-cA+xMiRRsK732Mw@mail.gmail.com>
	<CAAngNMaOHRRfTy5yT9ys0Cv5yB5t-zEVxwcZWuK64BEA4oRy2g@mail.gmail.com>
	<alpine.LNX.2.00.1204031513070.9041@pobox.suse.cz>
	<CAAngNMYx4YcC8kEuZkEgojbFLf7BtchTCEDs927P+oqfr_oKnQ@mail.gmail.com>
	<CAKT1EBesnson8JR+rTFtQyjATUj09QhR99Lg=ouN4aCeJJbviQ@mail.gmail.com>
Date: Thu, 26 Apr 2012 19:54:31 +0200
Message-ID: <CANq1E4SZQCjNstK2Fbwce5TxzYkRv=avDbyP7AthvABno76+bA@mail.gmail.com>
Subject: Re: [RFC v2 0/1] User-space HID I/O Driver
From: David Herrmann <dh.herrmann@googlemail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Joao Paulo Rechi Vita <jprvita@openbossa.org>, linux-input@vger.kernel.org,
	chen.ganir@ti.com, linux-bluetooth@vger.kernel.org,
	anderson.lizardo@openbossa.org, marcel@holtmann.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio

On Thu, Apr 26, 2012 at 7:22 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Hi David/Jiri,
[snip]
>
> The basic features are now working, we have tested HoG keyboard and
> mouse. The major features missing related to HID are output/feature
> reports, and suspend.

Output reports should be working. Only thing missing is feature input
reports. They are not implemented yet. However, what driver (except
hidraw and picolcd) uses them?

> My HID knowledge is quite limited but it seems that output reports are
> not working on uhid, at least I didn't see events from the host. Even
> for USB keyboard it doesn't work, do you have any pointers?

Do you actually handle the UHID_OUTPUT and UHID_OUTPUT_EV events from
UHID? I have looked at the HoG code recently and haven't seen any code
that correctly parses UHID_OUTPUT_EV packets? These packets contain
LED (capslock, numlock etc.) updates so the keyboard can actually set
them. They also contain BELL/SOUND codes for such devices. Only other
non-standard stuff is sent through UHID_OUTPUT reports. If there are
problems with it, I can help implementing this.

Regarding UHID, I will send an updated version this weekend which
mainly improves the internal buffer handling. The API will stay the
same, however, I might implement the feature input reports, then
everything should be ready for merging upstream (if the review cycles
go well ;)).

> BR,
> Claudio
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
