Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEZxfGP4M-qcxfUWbTXiayD=u+eO-VECcSSE-uueNLvRvtcQNQ@mail.gmail.com>
References: <CAFHyJTpWdNvKgvx8SGRWBVyR7PjR=kCZMjyUuFL+rb1D5_wmLA@mail.gmail.com>
 <CABBYNZL37MnF-iXkPo1XP=v4eVXQV-OuxyRSqkY3m1q1Q0Tawg@mail.gmail.com>
 <CAFHyJTrCdi_C2zhg-4XLZPR9PTdRX8BuhWbt0=Zmv0JMpvHKfw@mail.gmail.com> <CAEZxfGP4M-qcxfUWbTXiayD=u+eO-VECcSSE-uueNLvRvtcQNQ@mail.gmail.com>
From: "op7ic \\x00" <op7ica@gmail.com>
Date: Tue, 15 Nov 2016 10:51:07 +0000
Message-ID: <CAFHyJToBuopcSE6-LoVXAPH8mTq=CJ8MDgBrLtdx_YBiHUrFhw@mail.gmail.com>
Subject: Re: multiple buffer overflows and out-of-bound reads
To: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I got couple in btmon and I started looking at BO's in btmon too.

FWIW whenever the code base is shared similar bugs will appear. You
notice that a lot of BO issues reported are for example due to
unchecked memcpy or just lack of boundary verification on arrays etc .
Once you hit that point same bug appears.




On Tue, Nov 15, 2016 at 10:41 AM, Fran=C3=A7ois Beaufort
<beaufort.francois@gmail.com> wrote:
> FWIW, I have been witnessing btmon buffer overflows this morning but
> can't reproduce anymore.
>
> On Tue, Nov 15, 2016 at 10:25 AM, op7ic \x00 <op7ica@gmail.com> wrote:
>> alright will do - thanks for replying.
>>
>> On Tue, Nov 15, 2016 at 9:18 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi,
>>>
>>> On Mon, Nov 14, 2016 at 7:06 PM, op7ic \x00 <op7ica@gmail.com> wrote:
>>>> Hello list,
>>>>
>>>> I have been playing with hcidump tool recently and came across
>>>> following bugs coming from either out-of-bound reads or buffer
>>>> overflows  (see attached reports).
>>>>
>>>> There are couple more I`m working on and will send these later.
>>>
>>> I guess we want these to be tested against btmon, hcidump is a deprecat=
ed.
>>>
>>> --
>>> Luiz Augusto von Dentz
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetoot=
h" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
