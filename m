Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKT1EBdLu5ZBhaXWE208q4ctotd8vF1DyTBOY9hQVwKkpewEGw@mail.gmail.com>
References: <CACj007=vVUEwvaqr7JhMqJ8VK95j2epK+1_Z+_cJ=1-+UwVnGw@mail.gmail.com>
	<CAKT1EBdLu5ZBhaXWE208q4ctotd8vF1DyTBOY9hQVwKkpewEGw@mail.gmail.com>
Date: Sun, 25 Dec 2011 15:48:01 +0530
Message-ID: <CA+_sZW_oPNJBEd2uVkrodC4M8nYN4C8dEaMmWPSdT+cCuBEgvA@mail.gmail.com>
Subject: Re: [RFC BlueZ]Proximity Monitor Discussion
From: vishal agarwal <vishal.bluez@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: Hemant Gupta <hemantgupta.ste@gmail.com>,
	Anderson Briglia <anderson.briglia@openbossa.org>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio/Hemant,

Some time back I initiated a thread
"[RFC] FindMe: Proposal to have separate dbus interface"

Because BlueZ is not aware of whether ImmediateAlert is written for
PathLoss or for FindMe, in this RFC I proposed to have seperate
interfaces for proximity and FindMe profiles. Having seperate
interfaces for these profiles will also solve the problem. Doing
things this way will make things more clear. Also there will be scope
for future enhancements in both the profiles.
Same approach can be used while sending back the
signal(PropertyChanged signal). if ImmediateAlert is written for
Proximity interface then signal will be sent on that interface
otherwise on the FindMe interface.

any views, opinions on this?


Thanks
Vishal

On 12/22/11, Claudio Takahasi <claudio.takahasi@openbossa.org> wrote:
> Hi Hemant,
>
>>> The timer is there to trigger overwriting the value if it is already
>>> "none" or to disable the alert. The behavior in the remote side can be
>>> implementation specific, the user can also interfere disabling the
>>> alert(eg: pressing a button).
>>> My point is: think in the UI elements behavior to implement the Find
>>> Me Locator APP. It is easy to implement a event driven action than add
>>> timers in the APP to control/block the user to press the
>>> button(control states).
>>>
>>> Does it help if we add a new property? eg: ImmediateAlertTimeout, zero
>>> means disabled.
>>>
>>> When both are enabled it not possible to determine which service
>>> triggered the IAS alert. If my previous suggestion doesn't help, I
>>> don't see another way to keep both services qualifiable unless we
>>> remove the timer and move the logic to the upper layer(I'd like to
>>> avoid if possible).
>>
>> After doing some more study and analysis at my end, I have come to
>> following points in case
>> both Proximity and FindMe services are supported by remote device
>> - There is no need of timer for immediate alert service if this is
>> initiated by Path Loss.
>> - Timer to be used only if this is triggered for FindMe. Once timer is
>> fired, the immediate alert is set to none and ATT connection is
>> maintained as Proximity Profile is still connected.
>>
>> In case only FindMe Profile is supported on remote device.
>> - Timer is triggered, and on expiration, ATT connection is
>> disconnected in accordance with FindMe Specification
>> - Before timer is fired, if user of Monitor sets alert level to None,
>> same is sent to remote side for stopping the alert.
>>
>> In short we need the following things to support the above use cases -
>> 1) An extra parameter in Immediate alert SetProperty to determine if
>> this alert is for Proximity or FindMe Profile.
>> 2) Mechanism to disconnect the ATT connection if only FindMe is
>> supported on remote device (Currently there is no provision to
>> disconnect the ATT connection in monitor.c, except explicit call to
>> monitor_destroy, which I think is not intended for that)
>>
>> Please let me know you views on this.
>
> If the remote supports both services, there is no way in the
> client(Proximity plugin) to figure out which scenario is happening.
> The upper layer(app external to BlueZ) implements the logic to control
> the ImmediateAlertLevel. My suggestion are:
> 1) add a new property ImmediateAlertTimeout
> 2) or split ImmediateAlertLevel into: FindMeLevel and PathLossLevel
> mapping into the same remote characteristic.
>
> Opinions?
>
> BR,
> Claudio
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
