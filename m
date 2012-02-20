Return-Path: <cyrus@holtmann.org>
Message-id: <179A0BD8C217478984FDD1AF6554B874@sisodomain.com>
From: Divya Yadav <divya.yadav@samsung.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1329743814-7172-1-git-send-email-divya.yadav@samsung.com>
 <CABBYNZKT=yrqPbM4-ayOfagq6tWJqb8xnaB7FoG42pmn5LMo+w@mail.gmail.com>
In-reply-to: <CABBYNZKT=yrqPbM4-ayOfagq6tWJqb8xnaB7FoG42pmn5LMo+w@mail.gmail.com>
Subject: Re: [PATCH obexd] Obexd: Add parse apparam support to Obex Put
Date: Mon, 20 Feb 2012 19:22:27 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luiz,

--------------------------------------------------
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Sent: Monday, February 20, 2012 7:09 PM
To: "Divya Yadav" <divya.yadav@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH obexd] Obexd: Add parse apparam support to Obex Put

> Hi Divya,
>
> On Mon, Feb 20, 2012 at 3:16 PM, Divya Yadav <divya.yadav@samsung.com> 
> wrote:
>> Add parse apparam support to Obex put, which is missing in
>> current code.
>> ---
>>  src/obex.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/src/obex.c b/src/obex.c
>> index 5b580d3..f9b7e22 100644
>> --- a/src/obex.c
>> +++ b/src/obex.c
>> @@ -978,6 +978,7 @@ static void cmd_put(GObex *obex, GObexPacket *req, 
>> gpointer user_data)
>>        parse_name(os, req);
>>        parse_length(os, req);
>>        parse_time(os, req);
>> +       parse_apparam(os, req);
>>
>>        if (!os->checked) {
>>                if (!check_put(obex, req, user_data))
>> --
>> 1.7.0.4
>
> Please use "core:" prefix when the patch changes code in src/, btw if
> there are plugins depending on this than it is a real fix and you
> should start with "core: Fix..." otherwise Im fine with the patch even
> if nobody uses apparam for PUT.
>
We will use apparam for PUT in MAP Profile. In MAP we use it for 
MessageStatusUpdate
and UpdateInbox features. I will send the fix again with "core:" prefix 
changes.
> -- 
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html 

