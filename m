Return-Path: <cyrus@holtmann.org>
Message-id: <919F33058BA546BA91090A7991629B24@sisodomain.com>
From: Jaganath <jaganath.k@samsung.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
References: <1329832632-3681-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1329832632-3681-8-git-send-email-mikel.astiz.oss@gmail.com>
 <921769CBC00A43F9A939E3FA39843F27@sisodomain.com>
 <236C00190BB34FF5B78832896F9E9947@sisodomain.com>
 <CABBYNZ+uxo6Sze7EG6Q-e+A-MK4AGFBJvC3YMW86fThRg0dSeA@mail.gmail.com>
In-reply-to: <CABBYNZ+uxo6Sze7EG6Q-e+A-MK4AGFBJvC3YMW86fThRg0dSeA@mail.gmail.com>
Subject: Re: [PATCH obexd v2 7/8] client: fix canceling queued transfers
Date: Wed, 22 Feb 2012 17:54:09 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

--------------------------------------------------
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Sent: Wednesday, February 22, 2012 5:45 PM
To: "Jaganath" <jaganath.k@samsung.com>
Cc: "Mikel Astiz" <mikel.astiz.oss@gmail.com>; 
<linux-bluetooth@vger.kernel.org>; "Mikel Astiz" <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH obexd v2 7/8] client: fix canceling queued transfers

> Hi Jaganath,
>
> On Wed, Feb 22, 2012 at 1:59 PM, Jaganath <jaganath.k@samsung.com> wrote:
>>> If transfer->obex is unrefed here then the queued ABORT packet will not 
>>> be
>>> sent.
>>> This will create problem with PTS which requires ABORT command before
>>> transport disconnection
>>
>>
>> Sorry. I think my comment is invalid since refcount will not be zero in 
>> this
>> case.
>
> Yep, this is the transfer reference, btw what test are you referring
> to? I don't remember having problem with PTS in case of OpenOBEX and
> we didn't wait any abort to be sent, but perhaps that is because
> OpenOBEX had the blocking write logic while gobex wait for POLL_OUT,

Correct. Because of POLL_OUT logic only it is not working. It was working 
earlier
with OpenOBEX.

> perhaps we should flush when disconnecting. Anyway PTS is pretty lame
> since the abort request is useless if it is followed by a disconnect.

I agree. But I think we should pass PTS test of qualification.

>
> -- 
> Luiz Augusto von Dentz
> --

Regards
Jaganath

> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html 

