Return-Path: <cyrus@holtmann.org>
Date: Mon, 19 Jul 2010 15:40:18 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Move bit-field var to data->flags
Message-ID: <20100719184017.GA13327@vigoh>
References: <1279311633-12131-1-git-send-email-gustavo@padovan.org>
 <AANLkTilHzxBXd2KemlUhfJPnqVjDS5eIbkC_JWc-aKwm@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTilHzxBXd2KemlUhfJPnqVjDS5eIbkC_JWc-aKwm@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

* Anderson Lizardo <anderson.lizardo@openbossa.org> [2010-07-19 13:19:52 -0400]:

> Hi Gustavo,
> 
> On Fri, Jul 16, 2010 at 4:20 PM, Gustavo F. Padovan <gustavo@padovan.org> wrote:
> > @@ -810,7 +810,7 @@ static void btusb_work(struct work_struct *work)
> >        int err;
> >
> >        if (hdev->conn_hash.sco_num > 0) {
> > -               if (!data->did_iso_resume) {
> > +               if (!test_bit(BTUSB_DID_ISO_RESUME, &data->flags)) {
> >                        err = usb_autopm_get_interface(data->isoc);
> >                        if (err < 0) {
> >                                clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> > @@ -818,7 +818,7 @@ static void btusb_work(struct work_struct *work)
> >                                return;
> >                        }
> >
> > -                       data->did_iso_resume = 1;
> > +                       set_bit(BTUSB_DID_ISO_RESUME, &data->flags);
> >                }
> >                if (data->isoc_altsetting != 2) {
> >                        clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> 
> Just wondering ... could test_and_set_bit() be used here (instead of
> test_bit() + set_bit()) ?

No, because usb_autopm_get_interface() can return a error. In that case
we shall not set the bit.

-- 
Gustavo F. Padovan
http://padovan.org
