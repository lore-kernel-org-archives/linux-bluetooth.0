Return-Path: <cyrus@holtmann.org>
Subject: Re: Another pass at adapter naming
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Thu, 26 May 2011 17:56:11 +0100
In-Reply-To: <BANLkTikexf4ED_wRwVd68e_pjRUA=LFJTw@mail.gmail.com>
References: <1306419070.2010.244.camel@novo.hadess.net>
	 <1306421410.2669.0.camel@novo.hadess.net>
	 <BANLkTikvWsxgN2C7yFyr8z3bmwvD9-h=1g@mail.gmail.com>
	 <1306426375.2669.1.camel@novo.hadess.net>
	 <BANLkTikexf4ED_wRwVd68e_pjRUA=LFJTw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1306428972.2669.4.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2011-05-26 at 19:46 +0300, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Thu, May 26, 2011 at 7:12 PM, Bastien Nocera <hadess@hadess.net> wrote:
> > On Thu, 2011-05-26 at 19:00 +0300, Luiz Augusto von Dentz wrote:
> >> Hi Bastien,
> >>
> >> On Thu, May 26, 2011 at 5:50 PM, Bastien Nocera <hadess@hadess.net> wrote:
> >> > On Thu, 2011-05-26 at 15:11 +0100, Bastien Nocera wrote:
> >> >> As discussed on IRC,
> >> >>
> >> >> inotify is now required, and we force hci0 (or the first device) to be
> >> >> named after the pretty hostname.
> >> >>
> >> >> Note that the GATT call isn't removed, it's now done in
> >> >> adapter_update_local_name().
> >> >
> >> > As discussed again, removed the default adapter special casing, and
> >> > we'll just call hci0 with the pretty name.
> >>
> >> Does this means that the user cannot change permanently its adapter
> >> name when pretty hostname is available? In that case I would suggest
> >> having the stored name before pretty name otherwise if bluetoothd is
> >> restarted the adapter name will be reset to pretty hostname again.
> >
> > I don't see that as a problem. In which cases exactly would you want the
> > device name to be different from the pretty hostname?
> 
> Well that change the current behavior which is to restore the last
> name set, so if I set the name to FooBar1 and restart the device I
> want FooBar1 back after boot not pretty hostname, otherwise we can
> just make Name property read-only.

I'd like a use case, not corner cases where things might not work
exactly as you think it should, which I'm guessing there should be
plenty.

> In other words, if we want to be consistent there is only 2 options:
> 
> 1. Allow the user application to change the adapter name, the order
> then should be stored name > pretty hostname > name configured on
> main.conf.
> 
> 2. Do no allow user to change adapter name directly if pretty hostname
> exists, Name property should be made read-only (breaks API?), user can
> only change the adapter name via pretty hostname.

If you don't have a pretty hostname, we use the stored name. I don't
really see the need to have those levels of indirection.

What's the use case for needing to change the adapter name when pretty
hostname is used?

