Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 10/16] android: Add Android Makefile for libbluetooth
Date: Mon, 30 Sep 2013 14:14:09 +0200
Message-ID: <6873848.d8uRT0mZyA@uw000953>
In-Reply-To: <20130930073222.GC10262@aemeltch-MOBL1>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <CAJdJm_OYf-QjS9iS6vON7jw8biq0_8g0KpoHBW_-Gb0-U6w3Pg@mail.gmail.com> <20130930073222.GC10262@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> > On Fri, Sep 27, 2013 at 10:12 AM, Andrei Emeltchenko
> > <Andrei.Emeltchenko.news@gmail.com> wrote:
> > > +# to suppress the "pointer of type 'void *' used in arithmetic" warning
> > > +LOCAL_CFLAGS += -Wno-pointer-arith
> > > +
> > > +# to suppress the "missing initializer near initialization" warning
> > > +LOCAL_CFLAGS += -Wno-missing-field-initializers
> > > +
> > > +# to suppress the "may be used uninitialized in this function" warning
> > > +LOCAL_CFLAGS += -Wno-maybe-uninitialized
> > 
> > I wonder why you are suppressing all those warnings. Do you plan to
> > re-enable them once the implementation is more complete?
> 
> I think most warnings are the same as in standard BlueZ build. At some
> point those issue must be resolved IMO.

There seems to be a bug in sdp_set_profile_descs() error path, for some reason
gcc 4.6 on my box doesn't generate warning, yet android one does.
Will send a patch for that in a moment.

-- 
Szymon Janc


