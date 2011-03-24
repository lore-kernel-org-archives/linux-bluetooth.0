Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Mar 2011 20:58:37 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	Anderson Briglia <anderson.briglia@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [bluetooth-next 04/15] Bluetooth: Add support for using the
 crypto subsystem
Message-ID: <20110324235836.GA29321@piper>
References: <02fa778ab4292dffba1330e829b0d4029517a21e.1298307667.git.vinicius.gomes@openbossa.org>
 <20110227202041.GG2166@joana>
 <AANLkTi=j3REcNM4bXfFJPamPwqazS5k4eGAJf3BpB_Ya@mail.gmail.com>
 <20110228172801.GB2165@joana>
 <20110303174501.GA10733@piper>
 <20110309225246.GA3009@piper>
 <AANLkTinQh-oM+Dn-j8Rt8s99edozbXFjC-MUwiOLd_y1@mail.gmail.com>
 <4D7FBA0F.7070208@codeaurora.org>
 <AANLkTin_yLAyWjLjqk-5Z-gerWeVxQhk4ONtngqt1zKT@mail.gmail.com>
 <4D8BCEC2.7090309@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D8BCEC2.7090309@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 16:07 Thu 24 Mar, Brian Gix wrote:
> On 3/24/2011 7:14 AM, Claudio Takahasi wrote:
> >Hi all developers interested on LE,
> >

[ ... ]

> >
> >Patches not upstream(bluetooth-next) are available here:
> >git://gitorious.org/bluetooth-next/for-upstream.git
> >
> >Contains patches for SM just works method, advertising cache and MTU.
> 
> Are these rebased off of bluetooth-next on kernel.org?
> 

Now they are.

I also pushed the patches that add support for storing (and using) LTKs
to this repository. It needs a userspace that supports this[1].

I am not sending them for proper review yet, because they depend 
strongly on the first SMP patches. But comments are welcome.

> 
> >BR,
> >Claudio
> 
> 
> -- 
> Brian Gix
> bgix@codeaurora.org
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius

[1] git://gitorious.org/~vcgomes/bluez/vcgomes-bluez.git (branch mgmt)

