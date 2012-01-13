Return-Path: <cyrus@holtmann.org>
Message-ID: <4F105375.6010107@bmw-carit.de>
Date: Fri, 13 Jan 2012 16:53:25 +0100
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC obexd 00/10] Major API changes in obex-client
References: <1322143742-31182-1-git-send-email-mikel.astiz@bmw-carit.de> <CABBYNZLtFnm9RTBfn2s9hdtwWHF=hXQgP+p+cMR_Uch+ErvuyA@mail.gmail.com>
In-Reply-To: <CABBYNZLtFnm9RTBfn2s9hdtwWHF=hXQgP+p+cMR_Uch+ErvuyA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> I will be doing some cleanups before we integrate this code, some are
> based on your mega patch that  you have sent (actually it never made
> to the list due to its size), but I would like to separate the
> transport code to modules e.g. bluetooth like we did for obexd so the
> session just call e.g. .connect/.disconnect and the driver takes care
> of the transport details such as requesting a session and discovering
> records, this should simplify quite a lot session.c

I agree it would be convenient to have a simplified session.c. Right now 
there is definitely too much in there.

I am about to finish a split of the mega-patch you mention, trying to 
separate the internal changes from the dbus-related changes, as we 
discussed. You may want to wait until I send this new proposal.

> The only problem is how we gonna interpret the address, by default it
> should be Bluetooth but perhaps we should support urls for other
> transport e.g. usb://, how about that?

Sounds fine to me.

Cheers,
Mikel

