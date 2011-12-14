Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_OnyeExrgvainhqPMUgV9C2QU08PafyXZa9-oJxgkEaEg@mail.gmail.com>
References: <CACj007n47KuT4uzJMDnHc2KKy_Mog469QvvrRm5mAE54Q6Y7Ug@mail.gmail.com>
	<CAJdJm_OnyeExrgvainhqPMUgV9C2QU08PafyXZa9-oJxgkEaEg@mail.gmail.com>
Date: Wed, 14 Dec 2011 13:46:33 -0300
Message-ID: <CAKT1EBf+YPUggU6FX1EJjCtF7_C3zXCpwq=hG6Q+6DKyEo0=_A@mail.gmail.com>
Subject: Re: [RFC BlueZ]Proximity Monitor: Immediate Alert Timeout
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

On Wed, Dec 14, 2011 at 11:33 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Hemant,
>
> On Wed, Dec 14, 2011 at 10:18 AM, Hemant Gupta
> <hemantgupta.ste@gmail.com> wrote:
>> Hi,
>>
>> I am working on Proximity Monitor Role using BlueZ 4.96 + and have a
>> query on the need for Timeout in case of Immediate Alert in file
>> proximity/monitor.c.
>>
>> I feel that this timer is not required, because this will lead to
>> following scenario in case of Proximity Profile:
>>
>> If Path loss has occurred and Immediate Alert has been written, then
>> after Timeout (5 seconds), Proximity Monitor will set immediate alert
>> level to “none”, which will indicate to Proximity Reporter that Path
>> Loss is now within threshold, which actually might not be the case.
>
> I think this timeout is causing more harm than good (sometimes due to
> temporary latency between the two writes, the "none" alert level may
> arrive right after the previous level, which may cause the reporter to
> remain silent), so I agree with you. But I will wait for Claudio's
> opinion as he implemented this timeout in the first place :)

Remember that Immediate Alert Service is used by Path Loss and Find Me.
How are you testing it if kernel RSSI Monitor patches are not upstream?

Removing the timeout and write to "none" has a side effect: the remote
and the local value can have different values if the remote changes
the value. Alert Level characteristic doesn't support read,
notification or indication. Probably, all devices disable the alert
after some seconds to avoid drain the battery or be annoying.
The main problem is consistency: show to the user the correct value.

>
>> As per Sec 4.6 of Proximity Profile Spec,
>> “If the path loss falls below a threshold set on the Proximity Monitor
>> it shall write in the Alert Level characteristic of the Immediate
>> Alert service, using the GATT Write Without Response sub-procedure, to
>> cause the Proximity Reporter to end the alert. When the path loss is
>> below the threshold the Proximity Monitor should stop alerting.”
>>
>> So this means that the proximity monitor should not change the alert
>> level to “None” until the path loss is above Threshold.
>
> I think it is better to not have BlueZ itself change the alert level
> to "none", instead the application can do this when it detects the
> path loss above Threshold. This can be easily achieved by monitoring
> the "SignalLevel" property changes on the Proximity API, and writing
> to ImmediateAlertLevel as necessary. After all, the threshold is
> dependent on the application settings.

If this change doesn't cause problems to Find Me I agree with removing
this timeout/write.

Regards,
Claudio
