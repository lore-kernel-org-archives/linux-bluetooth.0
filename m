Return-Path: <cyrus@holtmann.org>
Date: Mon, 25 Jan 2010 16:06:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: papukaija <papukaija@skynet.be>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Feature request: remember bluetooth on/off setting
Message-ID: <20100125140609.GA6616@jh-x301>
References: <a69c0aba1001230519v3a197d9cq7942599e3a371168@mail.gmail.com>
 <20100123172550.GA18667@jh-x301>
 <a69c0aba1001231101i3d093edfh94ebd007e6713692@mail.gmail.com>
 <20100123191419.GA19717@jh-x301>
 <a69c0aba1001250552t22bcd736q8d7cf9e466e2b994@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a69c0aba1001250552t22bcd736q8d7cf9e466e2b994@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jan 25, 2010, papukaija wrote:
> > I'm running latest git here and works fine for me. Could it be that you
> > have some other component in your system that's always powering on
> > Bluetooth?
> 
> Maybe gnome's bluetooth applet doesn't read this setting or maybe it's
> ignoring the setting completely.

The applet is not supposed to know about the setting. It's just supposed
to toggle the Powered property for an adapter through the SetProperty
D-Bus method that bluetoothd exports.

Johan
