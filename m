Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Jun 2014 14:22:12 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] android/gatt: Fix wrong initial value
Message-ID: <20140612112210.GD27592@aemeltch-MOBL1>
References: <1402569825-27168-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CABD6X-+BNF20ghcnuSnJSRByhtzCNrNK+NRKym2SSkZ5xFWUpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABD6X-+BNF20ghcnuSnJSRByhtzCNrNK+NRKym2SSkZ5xFWUpw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jun 12, 2014 at 01:05:45PM +0200, Marcin Kraglak wrote:
> Hi Andrei,
> 
> On 12 June 2014 12:43, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > Initialize value_len to -1 since otherwise check value_len >= 0 does not
> > make sense.
> > ---
> >  android/gatt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/android/gatt.c b/android/gatt.c
> > index 8da77d0..8260a8d 100644
> > --- a/android/gatt.c
> > +++ b/android/gatt.c
> > @@ -4147,7 +4147,7 @@ static void read_requested_attributes(void *data, void *user_data)
> >         struct request_processing_data *process_data = user_data;
> >         uint32_t permissions;
> >         uint8_t *value, error;
> > -       int value_len = 0;
> > +       int value_len = -1;
> 
> What will happen if check_device_permissions will fail?

nothing? Should we send message?

Best regards 
Andrei Emeltchenko 

