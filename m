Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Sep 2014 10:31:20 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: Arman Uguray <armansito@chromium.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Scott James Remnant <keybuk@google.com>
Subject: Re: [RFC] need for new scan api for bluetooth low energy.
Message-ID: <20140917073120.GB7640@t440s.lan>
References: <CAD0=r8yozB8eMdJOuffUeQZVFVf5xEXnP5tCt+k3m0e9wzMxiA@mail.gmail.com>
 <735FD32E-BD15-4CE1-8D9C-44B8EC56DF7A@holtmann.org>
 <CAHrH25Q6XqsLjGyfoXwimrap9=kKHOQn-G=k4Fz6HXmEPJ7EtQ@mail.gmail.com>
 <20140917051457.GA4671@t440s.P-661HNU-F1>
 <CAD0=r8x-=O7XAqQF_wBHQEqSkfifzgWW2AagW2EvsDUtM-E_ow@mail.gmail.com>
 <20140917065252.GA5554@t440s.lan>
 <CAD0=r8z9g+F7Z9X_8PE4jk3JbA+oLj9Of33RSqxiRd0dn9AnXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAD0=r8z9g+F7Z9X_8PE4jk3JbA+oLj9Of33RSqxiRd0dn9AnXQ@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Sep 17, 2014, Jakub Pawlowski wrote:
> >> My use case include scanning for non-paired, non-connected devices,
> >> checking RSSI value and deciding about connection based on
> >> advertisement content, so that won't work. Am I right ?
> >
> > If you know the bdaddr that you're interested in in advance we should be
> > able to tweak the Add Device command to do what you want (e.g. disable
> > duplicate filtering in the case of Action=0x00 entries). However, if
> > what you need is general scanning for any devices (also previously
> > unknown ones) then Add Device doesn't really fit in (since it takes a
> > known bdaddr). For that we'd either need to consider allowing BDADDR_ANY
> > as an accepted parameter or then we'd need to define a new mgmt command.
> >
> 
> Unfortunately my case include previously unknown devices. I decide
> wether I should connect (without pairing) based on advertised service
> and RSSI power only. BDADDR_ANY seems good solution. Or maybe we can
> add some parameter that will force not using controller-side whitelist
> for scan?

With the BDADDR_ANY solution that'd be the trigger not to use the
controller-side white list. Simply disabling the controller side white
list isn't enough since the kernel would still filter out unknown
addresses and never send Device Found mgmt events.

Johan
