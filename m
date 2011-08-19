Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Fri, 19 Aug 2011 09:36:29 -0400
Subject: Re: [RFC v2 1/5] Bluetooth: Only schedule LE tx links if LE-capable
Message-ID: <1313760989.2585.54.camel@THOR>
References: <1313627847.10336.9.camel@THOR>
	 <CABBYNZJwn5CrY73-+kJK5jn9+B0V-Jx0Q+-NVH4BJVSLm7dDbA@mail.gmail.com>
	 <1313666245.17513.9.camel@THOR>
	 <CAJdJm_OxbhXeLckhSFAnatYEE0ikKNVKxb=2wjEQ5vnMWjPYdQ@mail.gmail.com>
In-Reply-To: <CAJdJm_OxbhXeLckhSFAnatYEE0ikKNVKxb=2wjEQ5vnMWjPYdQ@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Fri, 2011-08-19 at 06:52 -0400, Anderson Lizardo wrote:
> Hi Peter,
> 
> On Thu, Aug 18, 2011 at 7:17 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> > On Thu, 2011-08-18 at 03:43 -0400, Luiz Augusto von Dentz wrote:
> >> Any reasons why you choose to not add the check inside hci_sched_le?
> >
> > Only to make it really obvious that LE transmission is not required on
> > the vast majority of BT controllers :)
> 
> ... yet. Are you aware LE is not optional on Bluetooth 4.0? Therefore
> any modern BT device claiming to support 4.0 will have LE support on
> its controller (host support is another thing).

I was aware of that, but that's an important point you make.

> But I suppose we will still see plenty of 2.1 devices for a long time...

As I noted to Andre earlier, this particular test will be unnecessary
when Luiz's proposal (using the LE connection count to bypass LE
scheduling when 0). I feel Luiz's approach is the more effective
approach anyway.

Regards,
Peter Hurley
