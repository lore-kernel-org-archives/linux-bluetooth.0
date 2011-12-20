Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 20 Dec 2011 09:35:37 +0530
Message-ID: <CACj007=vVUEwvaqr7JhMqJ8VK95j2epK+1_Z+_cJ=1-+UwVnGw@mail.gmail.com>
Subject: [RFC BlueZ]Proximity Monitor Discussion
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	Anderson Briglia <anderson.briglia@openbossa.org>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio, Anderson,

> Please sync with Anderson Briglia, he already sent a RFC to the ML
> some months ago.
> In the Bluetooth Summit(Prague), we decided to not proceed with RSSI
> monitor emulation in the kernel until we have a clear idea or spec
> defining how the controllers will implement RSSI monitoring.
Could you please provide some details about what was discussed in the summit.

> The ideia was to provide transparency, the userspace doesn't need to
> know if RSSI monitoring is emulated or not.

As per my understanding the BT spec (4.0, Volume 2, Part E, Section
7.5.4) the HCI_Read_RSSI command can be used to retrieve the RSSI from
the controller. In our case, I have tested it against ST-Ericsson BT
controller  and it works in our case. Are you suggesting that until we
know how the RSSI is determined in controller, we should not implement
this functionality in kernel ? I ask this because in Proximity Spec,
it is mentioned that the monitor should use appropriate calculations
to prevent false alerts on reporter, so if we leave this to layer
above BlueZ to do this part, then we are pretty independent with the
approach of implementation of Path Loss RSSI Monitoring in BlueZ and
Kernel.

If I misunderstood anything please clarify.


> The timer is there to trigger overwriting the value if it is already
> "none" or to disable the alert. The behavior in the remote side can be
> implementation specific, the user can also interfere disabling the
> alert(eg: pressing a button).
> My point is: think in the UI elements behavior to implement the Find
> Me Locator APP. It is easy to implement a event driven action than add
> timers in the APP to control/block the user to press the
> button(control states).
>
> Does it help if we add a new property? eg: ImmediateAlertTimeout, zero
> means disabled.
>
> When both are enabled it not possible to determine which service
> triggered the IAS alert. If my previous suggestion doesn't help, I
> don't see another way to keep both services qualifiable unless we
> remove the timer and move the logic to the upper layer(I'd like to
> avoid if possible).

After doing some more study and analysis at my end, I have come to
following points in case
both Proximity and FindMe services are supported by remote device
- There is no need of timer for immediate alert service if this is
initiated by Path Loss.
- Timer to be used only if this is triggered for FindMe. Once timer is
fired, the immediate alert is set to none and ATT connection is
maintained as Proximity Profile is still connected.

In case only FindMe Profile is supported on remote device.
- Timer is triggered, and on expiration, ATT connection is
disconnected in accordance with FindMe Specification
- Before timer is fired, if user of Monitor sets alert level to None,
same is sent to remote side for stopping the alert.

In short we need the following things to support the above use cases -
1) An extra parameter in Immediate alert SetProperty to determine if
this alert is for Proximity or FindMe Profile.
2) Mechanism to disconnect the ATT connection if only FindMe is
supported on remote device (Currently there is no provision to
disconnect the ATT connection in monitor.c, except explicit call to
monitor_destroy, which I think is not intended for that)

Please let me know you views on this.

-- 
Best Regards
Hemant Gupta
ST-Ericsson India
