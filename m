Return-Path: <cyrus@holtmann.org>
Subject: Re: Read Characteristic Value vs. Read Long Characteristic Values
From: Brian Gix <bgix@codeaurora.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <AANLkTi=gZQ2Ps2yoXT7+08E3AruB5pAAy+ib+wBcQY4S@mail.gmail.com>
References: <AANLkTikrjgmAK9pzoJtnNJwQHraiaCnb8XVP55gAEKeH@mail.gmail.com>
	 <1295984785.2656.98.camel@ubuntuLab1>
	 <AANLkTi=4HoUKdda-GCrTQEtLSScuxB4D+btoRy+QsMG_@mail.gmail.com>
	 <AANLkTi=gZQ2Ps2yoXT7+08E3AruB5pAAy+ib+wBcQY4S@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 26 Jan 2011 09:59:22 -0800
Message-ID: <1296064762.2656.137.camel@ubuntuLab1>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Wed, 2011-01-26 at 09:58 -0400, Anderson Lizardo wrote:
> On Wed, Jan 26, 2011 at 9:33 AM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
> > Looks like more a PTS bug, but makes me wonder if it is not better for
> > BlueZ to have separate procedures instead of this "automatic" usage of
> > read blob request ?
> 
> BTW, the test which presented this issue with sending spurious read
> blob request is named "Read Characteristic Descriptors – by client". I
> also can see that the behavior you implemented satisfies both "Read
> Long Characteristic Value - by client" and "Read Long Characteristic
> Descriptor - by client" tests. All theses tests come from the GATT TS
> document.

Can you tell me the specific Test Case number(s) that you are having
difficulty testing?  I do not have a current release of the PTS tool
available to me at this time, although I do know that PTS is developed
in parallel, and is just as prone to bugs as the rest of us. I should be
able to test this stuff against the PTS guys at UPF week after next, and
talk to the guys who are writing it.

Thanks,

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

