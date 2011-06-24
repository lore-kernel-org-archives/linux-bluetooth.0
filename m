Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <75C285AD-9C2B-4F57-A998-D1346A68AEEE@signove.com>
References: <1308661408-8364-1-git-send-email-sancane@gmail.com>
	<C521DA9B-E3C6-46F2-834E-6E33C12B18C7@signove.com>
	<BANLkTikNQac7UsMgKdnoVR7kVQSV6tVn6g@mail.gmail.com>
	<A2B092BC-BE3C-4C0A-917D-0253EF23943A@signove.com>
	<BANLkTik9muPgh_Xx3UTh7rEpzj-C7fVxuQ@mail.gmail.com>
	<544C7016-5346-4C99-AEA9-C91AA84E3A42@signove.com>
	<BANLkTim60FHUp0B+2LkrsEG9vW4awFvvwQ@mail.gmail.com>
	<75C285AD-9C2B-4F57-A998-D1346A68AEEE@signove.com>
Date: Fri, 24 Jun 2011 07:27:53 -0700
Message-ID: <BANLkTi=YHkhEiffbRuXWyqKa_Xw31W6JXw@mail.gmail.com>
Subject: Re: [RFC] Health Thermometer Profile API
From: mike tsai <mikeyhtsai@gmail.com>
To: Elvis Pfutzenreuter <epx@signove.com>
Cc: Santiago Carot <sancane@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jun 24, 2011 at 6:20 AM, Elvis Pfutzenreuter <epx@signove.com> wrote:
>>> (cut)
>>
>> Coming back to this issue. I was just wondering that we may not need
>> worried about this issue because the same case may occurs at GATT
>> level. I mean, an application using GATT could disturb the behaviour
>> of other one when it enables/disables characteristics.
>
> Ok, but then the risk is clear. My feeling is that people are already
> "toning down" this API because of this. (One of the reasons my patch
> to add descriptor manipulation capability was rejected is that it was
> not meant to be a complete API and effort should go to profile-specific
> APIs. Without this, you can't toggle notifications and indications
> using generic GATT API anyway.)
>
>>
>> Because of any application can enable/disable characteristics we don't
>> need to worry about to manage this in the Thermometer API. Remember
>> that in other threads in the mailing list people were speaking about
>> making a D-Bus API for GATT. Those applications using GATT could
>> enable notification for measures and disable it. On account of this,
>> it will be inevitable collisions in the use cases.
>>
>> For this reason I think that the Thermometer API should be the most
>> permissive possible. If any application disable intermediate or final
>> measures, the PropertyChanged signal will be triggered, well, there is
>> no problem, if there are agents interested in such measures they only
>> will have to enable the proterty in the API once again as usual.
>
> I can see two apps monitoring PropertyChanged to enforce opposite
> states of notification. It would create a lot of heat.
>
>> To summarize, I think we should add the properties to enable and
>> disable intermediate and final measures and to leave to applications
>> to take deccisions about how they are going to behave when this stuff
>> happen.
>
> I remember Marcel saying once that applications always do the wrong
> thing when given the chance :) In this respect, our opinions are
> pretty much opposite; IMHO one application must not have a way to
> create a problem to others. Notification interval is impossible to
> insulate, for there is just one per device, but we can do better for
> toggling of notifications.
>
> It would be nice to have more opinions on this.
could we apply an 'OR' logic to this inside the profile? Each
application will have its own property setting.
So if App-A enables both, then it will receive both immediate/.final
temperatures indication/notification.
if App-B enables only final, then it receives final temperature indication only.
There are still the issue of how profile can "wake up" application(s)
when notification/indication come.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
