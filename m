Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1235856937.6074.35.camel@localhost.localdomain>
References: <1235753648-10045-1-git-send-email-philipp.zabel@gmail.com>
	 <1235856937.6074.35.camel@localhost.localdomain>
Date: Sat, 28 Feb 2009 23:16:51 +0100
Message-ID: <74d0deb30902281416v5904957ew1ce029eaf81d5804@mail.gmail.com>
Subject: Re: [PATCH] pcmcia: dtl1_cs: fix pcmcia_loop_config logic
From: pHilipp Zabel <philipp.zabel@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, linux-pcmcia@lists.infradead.org,
	Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Feb 28, 2009 at 10:35 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Philipp,
>
>> pcmcia_loop_config returns 0 on success.
>>
>> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
>> ---
>> =A0drivers/bluetooth/dtl1_cs.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
>> index 901bdd9..e0ee642 100644
>> --- a/drivers/bluetooth/dtl1_cs.c
>> +++ b/drivers/bluetooth/dtl1_cs.c
>> @@ -616,7 +616,7 @@ static int dtl1_config(struct pcmcia_device *link)
>>
>> =A0 =A0 =A0 /* Look for a generic full-sized window */
>> =A0 =A0 =A0 link->io.NumPorts1 =3D 8;
>> - =A0 =A0 if (!pcmcia_loop_config(link, dtl1_confcheck, NULL))
>> + =A0 =A0 if (pcmcia_loop_config(link, dtl1_confcheck, NULL))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed;
>>
>> =A0 =A0 =A0 i =3D pcmcia_request_irq(link, &link->irq);
>
> can you check the other Bluetooth PCMCIA drivers, too.

bluecard_cs doesn't use pcmcia_loop_config. bt3c_cs and btuart_cs both
have something like
	if (!pcmcia_loop_config(...))
		goto found_port;
instead, which looks fine.

> One of the PCMCIA
> subsystem changes might have screwed this up and affects more drivers
> than expected.

"pcmcia: use pcmcia_loop_config in bluetooth drivers"
(ed58872aa33e16a0d5352080e47c65fa14e6ad1c)
only touched bt3_cs, btuart_cs and dtl1_cs.

regards
Philipp
