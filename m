Return-Path: <emil.lenngren@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFBinCD+P6kBOXjp9YZf8DbsetvF+q6yfp3X+OTRfN_Pv8R88w@mail.gmail.com>
References: <20171117223543.32429-1-martin.blumenstingl@googlemail.com>
 <20171117223543.32429-6-martin.blumenstingl@googlemail.com>
 <109FA59C-9875-4EAA-9DA5-EC811BAA77AE@holtmann.org> <CAFBinCCtHUFMbbSOeKWYSJZKvFbNqhaMOrS-xgzr3E9hbkpnnw@mail.gmail.com>
 <4B23C5B4-DCB8-4B1C-B1BF-A99B1E5E10B0@holtmann.org> <CAFBinCD+P6kBOXjp9YZf8DbsetvF+q6yfp3X+OTRfN_Pv8R88w@mail.gmail.com>
From: Emil Lenngren <emil.lenngren@gmail.com>
Date: Sun, 26 Nov 2017 23:47:45 +0100
Message-ID: <CAO1O6scD4-h+qjWH-_X4xw5HpeNj7Pw78dWT_dNu0CgLzn=KOA@mail.gmail.com>
Subject: Re: [RFC v1 5/8] Bluetooth: btrtl: add support for the RTL8723BS and
 RTL8723DS chips
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh+dt@kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>, "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, linux-sunxi@googlegroups.com,
	linux-amlogic@lists.infradead.org, Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2017-11-26 23:23 GMT+01:00 Martin Blumenstingl
<martin.blumenstingl@googlemail.com>:
>>> c) we have to stick with this config file
> I'm afraid this would be our last option if I can't get b) working
> a datasheet for these chips or some advice from someone who has access
> to the datasheet/knowledge about the internals would be of great help
>

FYI I happen to have the confidential 37 pages long datasheet for
rtl8723ds, but unfortunately it doesn't contain any info about the
format of the config file. I suggest you should reach out to the guys
at NextThing and ask if they have some documentation from Realtek.

/Emil
