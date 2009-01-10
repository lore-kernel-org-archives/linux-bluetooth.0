Return-Path: <cyrus@holtmann.org>
Message-ID: <664d43d60901100347ve9c7c42r4d47e3b7e52ce2ee@mail.gmail.com>
Date: Sat, 10 Jan 2009 13:47:35 +0200
From: event <event.riga@gmail.com>
To: menno <jongerenchaos@zonnet.nl>
Subject: Re: About HFP Gateway profile patch
Cc: "Zhao Forrest" <forrest.zhao@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <7752.83.160.35.87.1231526092.squirrel@webmail.xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <7752.83.160.35.87.1231526092.squirrel@webmail.xs4all.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 2009-01-09, menno <jongerenchaos@zonnet.nl> wrote:
> Is it possible that this problem (to use this function 100%) is in
> relation with this bug (big latency with audio)?
> http://bugs.digium.com/view.php?id=12567
>
>
>> On 2009-01-09, Zhao Forrest <forrest.zhao@gmail.com> wrote:
>>> Hi Event,
>>>
>>> I'm working on BlueZ integration for Moblin2.0(http://moblin.org/).
>>> Your patch for HFP Gateway profile is really a good start and we need
>>> the support for HFP Gateway profile in BlueZ to do the integration
>>> work. Could you please share the information of when you plan to push
>>> this patch into BlueZ? Or do you need our help to push this patch into
>>> BlueZ?
>>>
>>> Thanks,
>>> Forrest
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe
>>> linux-bluetooth"
>>> in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> Hello Forrest,
>>
>> The only thing which is missing for basic part is little
>> infrastructure support for voice data transfer. I hope I can do it in
>> no more then 2-3 weeks.
>>
>> --
>> Vale,
>> Leonid Movshovich
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
>
>

Hi menno,

The implementation could suffer from the bug you mentioined. But i'm
currently really far for such tests.

Vale,
Leonid Movshovich
