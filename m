Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Dec 2014 10:15:59 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/3] unit/gatt: Fix using possible negative return value
Message-ID: <20141204081557.GA5790@aemeltch-MOBL1>
References: <1417615733-7350-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CABBYNZKRXORa_7d+aaFfw7HOHvG8MsNRQNu0gR8wvG3SuGwOPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZKRXORa_7d+aaFfw7HOHvG8MsNRQNu0gR8wvG3SuGwOPQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Dec 03, 2014 at 08:35:41PM +0200, Luiz Augusto von Dentz wrote:
> Hi Andrei,
> 
> On Wed, Dec 3, 2014 at 4:08 PM, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > ---
> >  unit/test-gatt.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/unit/test-gatt.c b/unit/test-gatt.c
> > index 03a66b9..f20da91 100644
> > --- a/unit/test-gatt.c
> > +++ b/unit/test-gatt.c
> > @@ -648,11 +648,11 @@ static void test_server(gconstpointer data)
> >
> >         len = write(context->fd, pdu.data, pdu.size);
> >
> > +       g_assert_cmpint(len, ==, pdu.size);
> > +
> >         if (g_test_verbose())
> >                 util_hexdump('<', pdu.data, len, test_debug, "GATT: ");
> >
> > -       g_assert_cmpint(len, ==, pdu.size);
> > -
> >         execute_context(context);
> >  }
> >
> > --
> > 1.9.1
> 
> What changes does this make?

You do not use negative len in case of error in util_hexdump()

Best regards 
Andrei Emeltchenko 

