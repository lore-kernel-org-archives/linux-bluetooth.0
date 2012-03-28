Return-Path: <cyrus@holtmann.org>
Message-id: <92E41BADC60A47078497F773B81DD3A4@sisodomain.com>
From: "chethan.tn" <chethan.tn@samsung.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <12002429.87611332309390515.JavaMail.weblogic@epml17>
 <CABBYNZKbykUbpaci7KAcbkxdth0cZJNDGM2hC5TPsyDZg5skQA@mail.gmail.com>
In-reply-to: <CABBYNZKbykUbpaci7KAcbkxdth0cZJNDGM2hC5TPsyDZg5skQA@mail.gmail.com>
Subject: Re: [PATCH] avrcp: Handle of GetPlayerApplicationSettingAttributeText
 pdu
Date: Wed, 28 Mar 2012 07:57:30 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

--------------------------------------------------
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Sent: Wednesday, March 21, 2012 10:53 PM
To: <chethan.tn@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] avrcp: Handle of 
GetPlayerApplicationSettingAttributeText pdu

> Hi,
>
> On Wed, Mar 21, 2012 at 2:56 AM, CHETHAN TN <chethan.tn@samsung.com> 
> wrote:
>>
>> In the above patch the function "attr_to_str" have been taken from 
>> audio/media.c file.
>> Since there migth be few functions that will be used commonly in 
>> audio/avrcp.c and audio/media.c why can't
>> such funtions moved to a common file?.
>
> Actually we might want to handle this in media.c, so perhaps we can
> reuse the callback to gets an attribute or create a new one to fetch
> the text in case of this being dynamically, otherwise just have it
> inline in avrcp.h might be fine.
>
>
> -- 
> Luiz Augusto von Dentz

Thanks for you valuable information.
I agree on your suggestions and implement it as inline functions in avrcp.h.

Regards
Chethan 

