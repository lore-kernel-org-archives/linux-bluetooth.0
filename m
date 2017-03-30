Return-Path: <groeck@google.com>
MIME-Version: 1.0
In-Reply-To: <aa6d3cab51e14de2b467e9da07296275@SC-EXCH02.marvell.com>
References: <1490878364-2735-1-git-send-email-huxm@marvell.com>
 <1490878364-2735-2-git-send-email-huxm@marvell.com> <CABXOdTeG0G0Fjww49U0fbyPzpo9czP21YoTdUwyQ+ar4A756cg@mail.gmail.com>
 <aa6d3cab51e14de2b467e9da07296275@SC-EXCH02.marvell.com>
From: Guenter Roeck <groeck@google.com>
Date: Thu, 30 Mar 2017 08:00:50 -0700
Message-ID: <CABXOdTfMHnXAmGzO4z4SuX8u+n=eNB73tssdNCtdw8yBp5qpqg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH 2/2] Bluetooth: btmrvl: remove unnecessary
 wakeup interrupt number sanity check
To: Xinming Hu <huxm@marvell.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	Amitkumar Karwar <akarwar@marvell.com>, Cathy Luo <cluo@marvell.com>,
	Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Mar 30, 2017 at 6:17 AM, Xinming Hu <huxm@marvell.com> wrote:
> Hi Guenter,
>
>> -----Original Message-----
>> From: Guenter Roeck [mailto:groeck@google.com]
>> Sent: 2017=E5=B9=B43=E6=9C=8830=E6=97=A5 20:58
>> To: Xinming Hu
>> Cc: Linux Bluetooth; Marcel Holtmann; Amitkumar Karwar; Cathy Luo; Guent=
er
>> Roeck
>> Subject: [EXT] Re: [PATCH 2/2] Bluetooth: btmrvl: remove unnecessary wak=
eup
>> interrupt number sanity check
>>
>> External Email
>>
>> ----------------------------------------------------------------------
>> On Thu, Mar 30, 2017 at 5:52 AM, Xinming Hu <huxm@marvell.com> wrote:
>> > Sanity check of interrupt number in interrupt handler is unnecessary
>> > and confusion, remove it.
>> >
>> > Signed-off-by: Xinming Hu <huxm@marvell.com>
>> > Signed-off-by: Guenter Roeck <groeck@chromium.org>
>>
>> Do you possibly mean "Reported-by:" ?
>
> The patch is prepared based on your suggestions on https://issuetracker.g=
oogle.com/issues/35647652
>

This means that either "Reported-by:" or "Suggested-by:" would be
appropriate, but not "Signed-off-by:".

Thanks,
Guenter

> Thanks
> Simon
>>
>> > Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
>> > ---
>> >  drivers/bluetooth/btmrvl_sdio.c | 9 +++------
>> >  1 file changed, 3 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/drivers/bluetooth/btmrvl_sdio.c
>> > b/drivers/bluetooth/btmrvl_sdio.c index 6166888..7a26961 100644
>> > --- a/drivers/bluetooth/btmrvl_sdio.c
>> > +++ b/drivers/bluetooth/btmrvl_sdio.c
>> > @@ -62,12 +62,9 @@ static irqreturn_t btmrvl_wake_irq_bt(int irq, void
>> > *priv)  {
>> >         struct btmrvl_plt_wake_cfg *cfg =3D priv;
>> >
>> > -       if (cfg->irq_bt >=3D 0) {
>> > -               pr_info("%s: wake by bt", __func__);
>> > -               cfg->wake_by_bt =3D true;
>> > -               disable_irq_nosync(irq);
>> > -       }
>> > -
>> > +       pr_info("%s: wake by bt", __func__);
>> > +       cfg->wake_by_bt =3D true;
>> > +       disable_irq_nosync(irq);
>> >         return IRQ_HANDLED;
>> >  }
>> >
>> > --
>> > 1.8.1.4
>> >
