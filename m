Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACj007n47KuT4uzJMDnHc2KKy_Mog469QvvrRm5mAE54Q6Y7Ug@mail.gmail.com>
References: <CACj007n47KuT4uzJMDnHc2KKy_Mog469QvvrRm5mAE54Q6Y7Ug@mail.gmail.com>
Date: Wed, 14 Dec 2011 10:33:48 -0400
Message-ID: <CAJdJm_OnyeExrgvainhqPMUgV9C2QU08PafyXZa9-oJxgkEaEg@mail.gmail.com>
Subject: Re: [RFC BlueZ]Proximity Monitor: Immediate Alert Timeout
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Hemant Gupta <hemantgupta.ste@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

On Wed, Dec 14, 2011 at 10:18 AM, Hemant Gupta
<hemantgupta.ste@gmail.com> wrote:
> Hi,
>
> I am working on Proximity Monitor Role using BlueZ 4.96 + and have a
> query on the need for Timeout in case of Immediate Alert in file
> proximity/monitor.c.
>
> I feel that this timer is not required, because this will lead to
> following scenario in case of Proximity Profile:
>
> If Path loss has occurred and Immediate Alert has been written, then
> after Timeout (5 seconds), Proximity Monitor will set immediate alert
> level to “none”, which will indicate to Proximity Reporter that Path
> Loss is now within threshold, which actually might not be the case.

I think this timeout is causing more harm than good (sometimes due to
temporary latency between the two writes, the "none" alert level may
arrive right after the previous level, which may cause the reporter to
remain silent), so I agree with you. But I will wait for Claudio's
opinion as he implemented this timeout in the first place :)

> As per Sec 4.6 of Proximity Profile Spec,
> “If the path loss falls below a threshold set on the Proximity Monitor
> it shall write in the Alert Level characteristic of the Immediate
> Alert service, using the GATT Write Without Response sub-procedure, to
> cause the Proximity Reporter to end the alert. When the path loss is
> below the threshold the Proximity Monitor should stop alerting.”
>
> So this means that the proximity monitor should not change the alert
> level to “None” until the path loss is above Threshold.

I think it is better to not have BlueZ itself change the alert level
to "none", instead the application can do this when it detects the
path loss above Threshold. This can be easily achieved by monitoring
the "SignalLevel" property changes on the Proximity API, and writing
to ImmediateAlertLevel as necessary. After all, the threshold is
dependent on the application settings.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
