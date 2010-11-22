Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101122173447.GA23109@vigoh>
References: <1290423434-2920-1-git-send-email-anderson.lizardo@openbossa.org>
	<20101122173447.GA23109@vigoh>
Date: Mon, 22 Nov 2010 14:05:58 -0400
Message-ID: <AANLkTin3PrqF=rVOctK7o9mm8gB-N-Gyw+xDR6BujV5_@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Fix error handling for l2cap_init()
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Mon, Nov 22, 2010 at 1:34 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> * Anderson Lizardo <anderson.lizardo@openbossa.org> [2010-11-22 06:57:14 -0400]:
>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>> index 18a802c..7980e24 100644
>> --- a/net/bluetooth/l2cap.c
>> +++ b/net/bluetooth/l2cap.c
>> @@ -4875,8 +4875,10 @@ static int __init l2cap_init(void)
>>               return err;
>>
>>       _busy_wq = create_singlethread_workqueue("l2cap");
>> -     if (!_busy_wq)
>> -             goto error;
>> +     if (!_busy_wq) {
>> +             err = -ENOMEM;
>> +             goto error_busy_wq;
>> +     }
>
> I prefer if you move the workqueue creation to after the
> hci_register_proto block. That will make things easier.

I wonder if that might not introduce a race condition, because after
hci_register_proto() new connections may already arrive?

Or is it guaranteed to only happen after l2cap_init() has finished?

If not, I can make this change without problem.

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
