Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Oct 2014 14:14:16 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@gmail.com>
Subject: Re: [PATCH] android/gatt: Fix unneeded increment
Message-ID: <20141006111413.GA26210@aemeltch-MOBL1>
References: <1412581779-22424-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAN_7+YZg2pYzzZZW6j+D918vEpQxe+tfEL0NNciU4wuz0_FD0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAN_7+YZg2pYzzZZW6j+D918vEpQxe+tfEL0NNciU4wuz0_FD0g@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Mon, Oct 06, 2014 at 01:06:49PM +0200, Lukasz Rymanowski wrote:
> Hi Andrei,
> 
> On Mon, Oct 6, 2014 at 9:49 AM, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > ---
> >  android/gatt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/android/gatt.c b/android/gatt.c
> > index dbe067f..ecd1813 100644
> > --- a/android/gatt.c
> > +++ b/android/gatt.c
> > @@ -3169,7 +3169,7 @@ static guint signed_write_cmd(struct gatt_device *dev, uint16_t handle,
> >                 return 0;
> >         }
> >
> > -       bt_update_sign_counter(&dev->bdaddr, LOCAL_CSRK, sign_cnt++);
> > +       bt_update_sign_counter(&dev->bdaddr, LOCAL_CSRK, sign_cnt);
> 
> Your rfc:  "[RFC] android/gatt: Fix sign_cnt increment" shall be used
> instead of this patch.

Yes, it was sent later. I called it RFC since wanted double check from the
code authors.

Best regards 
Andrei Emeltchenko 

