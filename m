Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABUK1aht5D2zW7wW22QaLLJWOkBpD9B+pK9aU_rcYkFByFYZyA@mail.gmail.com>
References: <CABUK1ahRsy+JtP-pqTcHeVSD=OxQ=_Yb29gCKZCzxxa-httdmw@mail.gmail.com>
	<CAMOw1v4U5t+_4hC4PSKy1H5d1dgBpieCXKBy+P7vH2yZ0dMJNg@mail.gmail.com>
	<CABUK1aht5D2zW7wW22QaLLJWOkBpD9B+pK9aU_rcYkFByFYZyA@mail.gmail.com>
Date: Sun, 22 Jul 2012 12:11:02 +0300
Message-ID: <CACumGOJ==Ca2C9xRvYFMPio3ospNWf+0erO8MemgZrfcDTDCcA@mail.gmail.com>
Subject: Re: AVRCPv1.3 NOTIFY from CT per notification from TG
From: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
To: Pavan Savoy <pavan_savoy@sify.com>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan

On Sun, Jul 22, 2012 at 5:07 AM, Pavan Savoy <pavan_savoy@sify.com> wrote:
> Now, I am interested to know whether the "Playing" needs to be
> displayed or something like "Paused" along with another bit of info,
> which is My-Song.
> So, say to begin with I register for track-changed notification, now
> to read the attributes of song again, but If I have to display
> "Paused" then I will have to register for "Play Status" & I can get
> only 1 of them at a time ?

You can register multiple events simultaneously, the only problem is
that you need to register again every time it changes. Apparently this
idea of registration not being persistent came from AV/C spec, while
doing support for VolumeChanged event I actually step in it see patch:
AVRCP: Fix not registering to VolumeChanged event again when notified

Its pretty broken design if you ask me, but one that we have to live with...
