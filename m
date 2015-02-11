Return-Path: <cyrus@holtmann.org>
Message-ID: <54DB29D5.1070301@endlessm.com>
Date: Wed, 11 Feb 2015 10:07:17 +0000
From: Mario Sanchez Prada <mario@endlessm.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Larry.Finger@lwfinger.net
Subject: Re: No SCO packets while trying to use a Bluetooth headset
References: <54D4D012.4050108@endlessm.com>	<54D9D9B1.30800@endlessm.com> <CABBYNZ+QQdL1t-m32R6kuWvKSdnyXVAgyWmiXY5UvFh=1kAMpg@mail.gmail.com>
In-Reply-To: <CABBYNZ+QQdL1t-m32R6kuWvKSdnyXVAgyWmiXY5UvFh=1kAMpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 10/02/15 12:05, Luiz Augusto von Dentz wrote:
> [...]
> I think your controller is not properly setup for SCO over HCI
> routing, probably Windows does that so while the controller is still
> powered it will work but as soon as you power it down it will loose
> these settings. 

That makes sense, thanks for the hint, I'll follow that lead and see what I can do with it.

> I guess you will need to find what commands these are,
> from the logs it seems the Windows driver is doing something that
> wireshark cannot decode, perhaps it is not really HCI as it claims to
> be.

I'll take a closer look to those logs again, and probably will try to capture new ones to see if I manage to capture more (and more interesting) traffic that way. So far I've been using USBPcap for that, but perhaps there's a better way to capture BT traffic in Windows, so I'll check that too just in case.

Thanks,
Mario 
