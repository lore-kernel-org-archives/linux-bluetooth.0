Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_NQd06gu26RVhbH+0rDT+VE2FXfrChPoFk37p3AdRNtVA@mail.gmail.com>
References: <1324051799-21439-1-git-send-email-sancane@gmail.com>
	<1324051799-21439-2-git-send-email-sancane@gmail.com>
	<CAKT1EBc=VRa9doQMDsOU+tBTZCrBjcsEkSD9Z_b37wO_CF15dg@mail.gmail.com>
	<CACLukzLoHB5u-Vp6RW1rE1z3HDo1hexw5eVOivQHmfhCwJqzAg@mail.gmail.com>
	<CAJdJm_O=m8L=TB2t8Z3Fc3awDFvAag=+-r4apbfRbTwNgSk7Dg@mail.gmail.com>
	<CACLukzLFmQ1VSDLDj_U0gORAUMLmVQMY_yy-UpzUWhwoNGk1tA@mail.gmail.com>
	<CACLukz+AqSqa5Xuq=pX66Gi5jM4opiMXi7M9-BoePv9h_FCB-w@mail.gmail.com>
	<CAJdJm_NQd06gu26RVhbH+0rDT+VE2FXfrChPoFk37p3AdRNtVA@mail.gmail.com>
Date: Mon, 19 Dec 2011 19:13:21 +0100
Message-ID: <CACLukzKWGA46MoJsikXztPv=_EZFATOk-VNqSAoxej2GCr=zPg@mail.gmail.com>
Subject: Re: [PATCH 01/11] attrib-server: Initial steps to provide
 multi-adapter GATT server support
From: Santiago Carot <sancane@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2011/12/19 Anderson Lizardo <anderson.lizardo@openbossa.org>:
> Hi Santiago,
>
> On Mon, Dec 19, 2011 at 10:54 AM, Santiago Carot <sancane@gmail.com> wrote:
>> Hi,
>>
>> 2011/12/19 Santiago Carot <sancane@gmail.com>:
>>> Hi Anderson,
>>>
>>> 2011/12/19 Anderson Lizardo <anderson.lizardo@openbossa.org>:
>>>> Hi Santiago,
>>>>
>>>> On Mon, Dec 19, 2011 at 10:35 AM, Santiago Carot <sancane@gmail.com> wrote:
>>>>>> Is there race condition here? Remember that plugins can also register
>>>>>> an adapter driver.
>>>>>> If a GATT "plugin" wants to register attributes during the probing the
>>>>>> attribute server needs to be ready.
>>>>>>
>>>>>
>>>>> I know that, remember these are transactional patches towardas
>>>>> multi-adapter support. They only prepare the environment to start
>>>>> coding. The patch 11 fixes this issue. In fact, one could think that
>>>>> it should in this place but when I started coding it I thought it was
>>>>> easier to reutilize functions which were already implemented and
>>>>> change it after multi-adapter started working.
>>>>
>>
>> Sorry: patch 10 is supposed to deal with that :P
>
> Ok. Now it makes sense :) I still had not time to review the full
> series (only took a look on Claudio comments).
>
> Still, I'm not sure adding a whole adapter driver just to remove it
> later on the same series is worth the trouble. Looks like you are
> fixing an issue introduced on the same series.
>
> Is it possible for you to rearrange the series so it is not necessary
> to introduce the adapter driver?

I'll try to redo the patches again, don't worry about that, I have
sent them in this way to be sure I was following the right toward the
multi-adapter suport, I didn't want to spent the time fixing the
patches until being sure that this is the architecture we were looking
for.

Regards.
