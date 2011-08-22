Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Aug 2011 15:01:51 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Antti Julku <antti.julku@nokia.com>
Cc: ext Marcel Holtmann <marcel@holtmann.org>, johan.hedberg@gmail.com,
	ext Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add mgmt command for fast connectable mode
Message-ID: <20110822180151.GB21949@joana>
References: <1308737516-3303-1-git-send-email-antti.julku@nokia.com>
 <1309309092.2208.25.camel@aeonflux>
 <CAHMBquWSLjzKKyM2xuMUakHeBb-FMLUWXLj2_Tz4Ye1MWj37qw@mail.gmail.com>
 <CAKT1EBfQaTSjQe6sZnC5Wx52iPmyo6SSfYD0Ci+_qb1Dbq32+g@mail.gmail.com>
 <4E3A5BFB.1050201@nokia.com>
 <4E425061.6080206@nokia.com>
 <1312984559.3373.122.camel@aeonflux>
 <4E4E592C.7060103@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E4E592C.7060103@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antti,

* Antti Julku <antti.julku@nokia.com> [2011-08-19 15:38:04 +0300]:

> 
> Hi Marcel,
> 
> On 08/10/2011 04:55 PM, ext Marcel Holtmann wrote:
> >I recap, then fast connectable mode is something that is controlled by
> >one or multiple profiles. So this is just really a on/off switch. And if
> >we support it then all profiles should just use the same settings for
> >it. So far correct? Or do we need different values/parameters on a per
> >profile basis?
> 
> All profiles use same settings currently, probably no need to have
> different configurations for profiles.
> 
> >
> >If I just assume the above, then we need a set of commands that can
> >configure the settings of fast connectable mode. And that is done once
> >when we start bluetoothd. After that it is really just toggle on and
> >toggle off. And bluetoothd internally can keep a reference count for
> >that.
> >
> >And then it makes sense to do the same for LE and BR/EDR. It is either
> >on or off. Just the initial parameter set for LE is configured
> >differently.
> 
> So one command which switches fast connectable on/off for both BR
> and LE? And two for configuration?  Maybe something like this?
> 
> Set Fast Connectable Command
> ============================
> 
> Command Code:           0x0001F
> Controller Index:       <controller id>
> Command Parameters:     Enable (1 Octet)
> Return Parameters:      Status (1 octet)
> 
> Configure BR Fast Connectable Mode Command
> ==========================================
> 
> Command Code:           0x00020
> Controller Index:       <controller id>
> Command Parameters:     Page_scan_type (1 Octet)
>                         Page_scan_interval (1 Octet)
> Return Parameters:      Status (1 octet)
> 
> Configure LE Fast Connectable Mode Command
> ==========================================
> 
> Command Code:           0x00021
> Controller Index:       <controller id>
> Command Parameters:     Adv_interval (1 Octet)
>                         ...and maybe some other settings if needed
> Return Parameters:      Status (1 octet)

Can't both command be merged into one? LE Advertisement could be a scan type.
But this won't work if we need more settings for LE.

	Gustavo
