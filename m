Return-Path: <cyrus@holtmann.org>
Message-id: <ECBBD030DA3E48CFA22F05E0E75896A2@sisodomain.com>
From: Jaganath <jaganath.k@samsung.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1328182441-14892-1-git-send-email-jaganath.k@samsung.com>
 <CABBYNZJYyqtD+0c6YYALx8bON3A_S3bXH29K07OFJcq=ZrJCOw@mail.gmail.com>
 <F077852F86D84892A3B10767242C50BC@sisodomain.com>
 <CABBYNZLVFFP2v0hXEwrxONGr-t-1i5g6rPxVe_G-wrKM2P=8HQ@mail.gmail.com>
In-reply-to: <CABBYNZLVFFP2v0hXEwrxONGr-t-1i5g6rPxVe_G-wrKM2P=8HQ@mail.gmail.com>
Subject: Re: [PATCH obexd 3/4] irmc: Fix length parameter of strncpy
Date: Thu, 09 Feb 2012 16:46:43 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

--------------------------------------------------
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Sent: Thursday, February 09, 2012 4:37 PM
To: "Jaganath" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH obexd 3/4] irmc: Fix length parameter of strncpy

> Hi Jaganath,
>
> On Fri, Feb 3, 2012 at 2:22 PM, Jaganath <jaganath.k@samsung.com> wrote:
>> I checked IRMC spec and could not find any length restriction.
>> For "sn" spec says "The format of the field is manufacturer dependent."
>> and for "manu" and "model" the acceptable value is string.
>
> The patch is not exactly wrong, but I fear that if we really start
> reading this information from somewhere, which I guess it is whole
> point here, then this fixed length may need some change.

Correct. This patch is just a fix to a static tool reported issue

Regards
Jaganath

> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html 

