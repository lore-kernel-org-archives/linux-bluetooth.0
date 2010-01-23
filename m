Return-Path: <cyrus@holtmann.org>
Date: Sat, 23 Jan 2010 21:14:19 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: papukaija <papukaija@skynet.be>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Feature request: remember bluetooth on/off setting
Message-ID: <20100123191419.GA19717@jh-x301>
References: <a69c0aba1001230519v3a197d9cq7942599e3a371168@mail.gmail.com>
 <20100123172550.GA18667@jh-x301>
 <a69c0aba1001231101i3d093edfh94ebd007e6713692@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <a69c0aba1001231101i3d093edfh94ebd007e6713692@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Jan 23, 2010, papukaija wrote:
> > On Sat, Jan 23, 2010, papukaija wrote:
> >> I rarely use bluetooth devices, so I turn bluetooth off until I need
> >> it. Every time I start my system (netbook; Samsung nc10) up again and
> >> log in again, I manually turn bluetooth off again.  I'd like
> >> bluetoothd to remember whether I last had bluetooth off or on, and use
> >> that same setting the next time.
> >
> > bluetoothd already has this feature. You just need to make sure that
> > RememberPowered=true in /etc/bluetooth/main.conf
> >
> > Johan
> >
> >
> 
> In that case this feature doesn't work. I'm using Ubuntu Netbook Remix
> v. 9.10 (Karmic) and I have "RememberPowered=true in
> /etc/bluetooth/main.conf".

I'm running latest git here and works fine for me. Could it be that you
have some other component in your system that's always powering on
Bluetooth?

Johan
