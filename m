Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Oct 2010 11:15:41 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Pull request git://gitorious.org/bluez-mcap-hdp/mcap-hdp.git
 for_upstream
Message-ID: <20101012101541.GA25086@jh-x301>
References: <AANLkTi=Ogzb3kUX7O4fz-w9gNpU9PCyTFo0GnhfePjC6@mail.gmail.com>
 <20101011213154.GA12131@jh-x301>
 <AANLkTik8k84qwMM3nHc4z2gVWm6Vo0HaLME2PEcwMyeg@mail.gmail.com>
 <20101012093531.GA22165@jh-x301>
 <AANLkTikPOQm0MBQVL7Ax=v8nfp5wJCY+W5=9Fqn384Ur@mail.gmail.com>
 <AANLkTikapHztx_w9mWxotJBuofYHnxMExd88V+8ng40E@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikapHztx_w9mWxotJBuofYHnxMExd88V+8ng40E@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jose,

On Tue, Oct 12, 2010, Jose Antonio Santos Cadenas wrote:
> >> On Tue, Oct 12, 2010, Jose Antonio Santos Cadenas wrote:
> >>> I'm sorry but I can't connect to the IRC rigth now. Nevertheless, I
> >>> think that I've found the issues:
> >>>
> >>> - The iochannel should be unrefereed when the watcher is explicitly removed
> >>
> >> Yes, though do you need to have a reference at all? As long as you have
> >> the GLib watch callback GLib itself holds a reference, so if you don't
> >> need one just remove chan->echo_chan and do an unref after calling
> >> add_watch.
> >
> > Sorry I've forgot this one. Gonna solve it.
> 
> Solved, I've removed the chan->echo_chan attribute and directly unref
> the io_channel once the watcher is set.

Thanks. The patches have now been pushed upstream.

Johan
