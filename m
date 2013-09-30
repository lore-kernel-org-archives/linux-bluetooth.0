Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Sep 2013 10:32:43 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 10/16] android: Add Android Makefile for libbluetooth
Message-ID: <20130930073222.GC10262@aemeltch-MOBL1>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1380291161-10232-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAJdJm_OYf-QjS9iS6vON7jw8biq0_8g0KpoHBW_-Gb0-U6w3Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_OYf-QjS9iS6vON7jw8biq0_8g0KpoHBW_-Gb0-U6w3Pg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Fri, Sep 27, 2013 at 02:01:31PM -0400, Anderson Lizardo wrote:
> Hi Andrei,
> 
> On Fri, Sep 27, 2013 at 10:12 AM, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > +# to suppress the "pointer of type 'void *' used in arithmetic" warning
> > +LOCAL_CFLAGS += -Wno-pointer-arith
> > +
> > +# to suppress the "missing initializer near initialization" warning
> > +LOCAL_CFLAGS += -Wno-missing-field-initializers
> > +
> > +# to suppress the "may be used uninitialized in this function" warning
> > +LOCAL_CFLAGS += -Wno-maybe-uninitialized
> 
> I wonder why you are suppressing all those warnings. Do you plan to
> re-enable them once the implementation is more complete?

I think most warnings are the same as in standard BlueZ build. At some
point those issue must be resolved IMO.

Best regards 
Andrei Emeltchenko 
