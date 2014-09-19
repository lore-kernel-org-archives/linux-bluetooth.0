Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJcxjrfV=cs7S-ZGnNSqUxRMD=dA-NfPupA8ZqKK4+RKQ@mail.gmail.com>
References: <OF599C7E7B.0DAEF4D4-ON65257D56.0050A3C9-65257D56.0050B958@tcs.com>
	<CABBYNZJcxjrfV=cs7S-ZGnNSqUxRMD=dA-NfPupA8ZqKK4+RKQ@mail.gmail.com>
Date: Fri, 19 Sep 2014 19:59:53 +0530
Message-ID: <CABL=VJNxSGAE_dyrNZz5YmdjfCMSv=-jQ1sSdiS0rYjxawr4YQ@mail.gmail.com>
Subject: Re: Missing of SCO packet indications (i.e BT_GET_CAPABILITIES
 ,BT_OPEN ,BT_SET_CONFIGURATION and BT_START_STREAM ) during a phone call
From: Vinod Rayapudi <vinodrayapudi@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Vinod Rayapudi <vinod.rayapudi@tcs.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	autoanswer@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Thanks for your time to understand the issue and thanks for your reply too.

Due to d-bus dependency (d-bus with 1.6 is mandatory for bluez 5.xx) ,
we are working with Bluez 4.xx series.
In soon, we will be shifting to bluez-5.

I would like to know, are there some issues with unix socket ipc w.r.t bluez ?

Is it possible  to fix this issue with existing bluez 4.xx version ?
Inputs are valuable to me. I will try to modify and check the behavior
based any inputs/suggestions.

Thanks & Regards,
Vinod.

On Thu, Sep 18, 2014 at 3:29 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Wed, Sep 17, 2014 at 5:41 PM, Vinod Rayapudi <vinod.rayapudi@tcs.com> wrote:
>> Hi All,
>>
>> I have an Issue w.r.t SCO packets.
>>
>> I have connected a phone which support both A2DP and Handsfree profiles.
>> During call, I don't see any sco packet indication.
>>
>> I have added logs in Bluez- 'unix.c' file.
>>
>> From the logs I understood that, all SCO packet indications and initiations like BT_GET_CAPABILITIES ,BT_OPEN ,BT_SET_CONFIGURATION and BT_START_STREAM etc are triggered from client_cb() callback function.
>> In this case, I don't see any such kind of packet transmission.
>> How to correct this behavior ?
>>
>> If the phone has both active A2DP and Handsfree connections, then this issue occurs.
>>
>> Can anyone help me, how to correct this issue.
>
> It sounds that you are talking about a very old BlueZ version that
> used to have unix socket IPC, this is no longer supported so I suggest
> you move to BlueZ 5 if you want some support from upstream.
>
>
> --
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
