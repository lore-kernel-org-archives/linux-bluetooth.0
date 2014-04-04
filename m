Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAN_7+YY9oVjPOy2sY0prooPsPNd35ck_-VNp=70ZQdeatLjcbQ@mail.gmail.com>
References: <1396518234-8375-1-git-send-email-marcin.kraglak@tieto.com>
	<CAJdJm_P+OjFYyggY4g_TTZJ7V1H7a46k45KntCZxnTwFRCE4ZA@mail.gmail.com>
	<CAN_7+YZ=nOKxgCkg6Ok85610yTEr307qWyTubDh32cJgEmgsOQ@mail.gmail.com>
	<CAJdJm_P2VQwB+N1-Ew8j4K27Absfi6BTBHJBKznkkBWwkpU5zA@mail.gmail.com>
	<CAN_7+YY9oVjPOy2sY0prooPsPNd35ck_-VNp=70ZQdeatLjcbQ@mail.gmail.com>
Date: Fri, 4 Apr 2014 10:34:48 -0400
Message-ID: <CAJdJm_NkE+eG8c=jeWGXY3+ovc8nwx6jqQei0RVZ5pfuiqNZ8A@mail.gmail.com>
Subject: Re: [RFC] gatt: Add API for creating services
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
Cc: Marcin Kraglak <marcin.kraglak@tieto.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Fri, Apr 4, 2014 at 10:03 AM, Lukasz Rymanowski >>> Actually, also
ATT encoding and decoding could be common part.
>>
>> I can't find ATT decoding/encoding on the Android HAL headers. Are you
>> sure this is not handled internally by Android HAL?
>
> What I meant is that we have to do ATT encoding/decoding in the
> daemon. Android is getting only
> read/write callbacks with value
>
> Therefore, code for ATT enc/dec could be common.

Ok, it is clearer for me now. I was misunderstanding the direction of
notifications on the android/hal-ipc-api.txt document.

I'll send the RFC API soon.

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
