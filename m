Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC] LE General Discovery Procedure
From: Brian Gix <bgix@codeaurora.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <AANLkTi=px0CQY+W9PqrjMHZGQ6RdXgbd-iQo=K8AA_H6@mail.gmail.com>
References: <AANLkTi=px0CQY+W9PqrjMHZGQ6RdXgbd-iQo=K8AA_H6@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Tue, 21 Dec 2010 12:24:36 -0800
Message-ID: <1292963076.14993.57.camel@sealablnx02.qualcomm.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, 2010-12-21 at 17:12 -0300, Claudio Takahasi wrote:
> Hi folks,
> 
[snip]
> We may need to represent the Broadcaster devices creating a D-Bus
> device object, it is still unclear to me at the moment. So I have
> three suggestions(I prefer the first):
> 1. Report Peripheral and Broadcaster using DeviceFound() signal and
> add an property to identify the role. eg: Broadcaster=false/true

I also prefer this solution. The higher layer app or entity should then
filter out any devices that it is not interested in, and should be
examining the properties of all the devices reported to it.  Along with
a Broadcaster property, there should be other properties that indicate
other details such as Pubic/Private addresses, etc.

> 2. Ignore the Broadcaster devices. Means that it will not be possible
> to call CreateDevice for these devices.

Don't like this idea, because at some point BlueZ we be used in a device
which *will* need to be aware of the existence of Broadcaster devices.
And the CreateDevice paradigm is probably to best way to represent these
remote devices.

> 3. Add a config option to change the discovery behavior to ignore
> Broadcaster devices. For qualification test only.

Not a good idea. At the end of the day, a device should be qualifiable
regardless of it's configuration.

> 
> If we choose the first, for qualification test I guess it will be
> enough to add an extra filter to ignore the broadcaster devices in the
> BlueZ test script.

I agree.

> 
> Regards,
> Claudio

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

