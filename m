Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKT1EBf+YPUggU6FX1EJjCtF7_C3zXCpwq=hG6Q+6DKyEo0=_A@mail.gmail.com>
References: <CACj007n47KuT4uzJMDnHc2KKy_Mog469QvvrRm5mAE54Q6Y7Ug@mail.gmail.com>
	<CAJdJm_OnyeExrgvainhqPMUgV9C2QU08PafyXZa9-oJxgkEaEg@mail.gmail.com>
	<CAKT1EBf+YPUggU6FX1EJjCtF7_C3zXCpwq=hG6Q+6DKyEo0=_A@mail.gmail.com>
Date: Wed, 14 Dec 2011 22:44:17 +0530
Message-ID: <CACj007kkYy8cr5+SppY-BEJYW=0=GGGSh7xGNK-THHopq5tQDg@mail.gmail.com>
Subject: Re: [RFC BlueZ]Proximity Monitor: Immediate Alert Timeout
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Dec 14, 2011 at 10:16 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Hi Hemant,
>
> On Wed, Dec 14, 2011 at 11:33 AM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
>> Hi Hemant,
>>
>> On Wed, Dec 14, 2011 at 10:18 AM, Hemant Gupta
>> <hemantgupta.ste@gmail.com> wrote:
>>> Hi,
>>>
>>> I am working on Proximity Monitor Role using BlueZ 4.96 + and have a
>>> query on the need for Timeout in case of Immediate Alert in file
>>> proximity/monitor.c.
>>>
>>> I feel that this timer is not required, because this will lead to
>>> following scenario in case of Proximity Profile:
>>>
>>> If Path loss has occurred and Immediate Alert has been written, then
>>> after Timeout (5 seconds), Proximity Monitor will set immediate alert
>>> level to “none”, which will indicate to Proximity Reporter that Path
>>> Loss is now within threshold, which actually might not be the case.
>>
>> I think this timeout is causing more harm than good (sometimes due to
>> temporary latency between the two writes, the "none" alert level may
>> arrive right after the previous level, which may cause the reporter to
>> remain silent), so I agree with you. But I will wait for Claudio's
>> opinion as he implemented this timeout in the first place :)
>
> Remember that Immediate Alert Service is used by Path Loss and Find Me.
> How are you testing it if kernel RSSI Monitor patches are not upstream?

I have implemented the RSSI monitoring in kernel and BlueZ and
currently testing the same.
I would upload the same soon on community.
>
> Removing the timeout and write to "none" has a side effect: the remote
> and the local value can have different values if the remote changes
> the value. Alert Level characteristic doesn't support read,
> notification or indication. Probably, all devices disable the alert
> after some seconds to avoid drain the battery or be annoying.
> The main problem is consistency: show to the user the correct value.
Could you please elaborate a bit on this. I don't understand when you say the
remote changes the value ? As per my understanding spec does not mention
anything about consistency between the 2 Proximity devices for the Immediate
alert level.
Also as you mentioned there is no way of notifications, read from
Immediate Alert
Value on remote side, even having timer does not solve the purpose, as
remote side might
have a different timeout on alert (less than 5 seconds).
>
>>
>>> As per Sec 4.6 of Proximity Profile Spec,
>>> “If the path loss falls below a threshold set on the Proximity Monitor
>>> it shall write in the Alert Level characteristic of the Immediate
>>> Alert service, using the GATT Write Without Response sub-procedure, to
>>> cause the Proximity Reporter to end the alert. When the path loss is
>>> below the threshold the Proximity Monitor should stop alerting.”
>>>
>>> So this means that the proximity monitor should not change the alert
>>> level to “None” until the path loss is above Threshold.
>>
>> I think it is better to not have BlueZ itself change the alert level
>> to "none", instead the application can do this when it detects the
>> path loss above Threshold. This can be easily achieved by monitoring
>> the "SignalLevel" property changes on the Proximity API, and writing
>> to ImmediateAlertLevel as necessary. After all, the threshold is
>> dependent on the application settings.
>
> If this change doesn't cause problems to Find Me I agree with removing
> this timeout/write.
I don't think there is issue in case we remove the timer, if remote
device is only supporting FindMe, because the alert should stop as
soon as physical link is disconnected as per IAS specification Section
4.1
This alert continues until one of following conditions occurs:
 - An implementation specific timeout.
 - User interaction on this device.
 -  A new alert level is written.
 - The physical link is disconnected.

Also it is assumed that the remote device would have some
implementation specific timeout for the alert, as mentioned in spec,
so in case we have both proximity and findme supported on remote
device, then the
remote side would stop alerting in case we have findme immediate alert
on target.
>
> Regards,
> Claudio



-- 
Best Regards
Hemant Gupta
ST-Ericsson India
