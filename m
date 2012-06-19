Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120619030935.GC1679@joana>
References: <1339612935-2851-1-git-send-email-devendra.aaru@gmail.com>
	<20120619030935.GC1679@joana>
Date: Tue, 19 Jun 2012 09:56:46 +0530
Message-ID: <CAHdPZaMn79msYugB+XbjiGJE-7xr0uKTpG=6mmPwMAVKmRU1tA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Cleanup dtl1_config
From: "devendra.aaru" <devendra.aaru@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>, Devendra Naga <devendra.aaru@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

Thanks for reviewing the patch.

On Tue, Jun 19, 2012 at 8:39 AM, Gustavo Padovan <gustavo@padovan.org> wrot=
e:
> Hi Devendra,
>
> * Devendra Naga <devendra.aaru@gmail.com> [2012-06-14 00:12:15 +0530]:
>
>> the functions always return 0 on sucess and -ve error on failure.
>>
>> This also removes variable i.
>>
>> Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
>> ---
>> =A0drivers/bluetooth/dtl1_cs.c | =A0 =A09 +++------
>> =A01 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
>> index 6e8d961..f532ce2 100644
>> --- a/drivers/bluetooth/dtl1_cs.c
>> +++ b/drivers/bluetooth/dtl1_cs.c
>> @@ -586,22 +586,19 @@ static int dtl1_confcheck(struct pcmcia_device *p_=
dev, void *priv_data)
>> =A0static int dtl1_config(struct pcmcia_device *link)
>> =A0{
>> =A0 =A0 =A0 dtl1_info_t *info =3D link->priv;
>> - =A0 =A0 int i;
>>
>> =A0 =A0 =A0 /* Look for a generic full-sized window */
>> =A0 =A0 =A0 link->resource[0]->end =3D 8;
>> =A0 =A0 =A0 if (pcmcia_loop_config(link, dtl1_confcheck, NULL) < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed;
>>
>> - =A0 =A0 i =3D pcmcia_request_irq(link, dtl1_interrupt);
>> - =A0 =A0 if (i !=3D 0)
>> + =A0 =A0 if (pcmcia_request_irq(link, dtl1_interrupt))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed;
>
> I think this change is wrong, instead you might return i (that should be
> renamed to 'err') when the failed label is accessed. This way you improve=
 the
> error report of this function.
>
You are correct.

You can expect a V2 of this with your comments mentioned.
> =A0 =A0 =A0 =A0Gustavo

Thanks,
Devendra.
