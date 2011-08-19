Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1313666245.17513.9.camel@THOR>
References: <1313627847.10336.9.camel@THOR>
	<CABBYNZJwn5CrY73-+kJK5jn9+B0V-Jx0Q+-NVH4BJVSLm7dDbA@mail.gmail.com>
	<1313666245.17513.9.camel@THOR>
Date: Fri, 19 Aug 2011 06:52:30 -0400
Message-ID: <CAJdJm_OxbhXeLckhSFAnatYEE0ikKNVKxb=2wjEQ5vnMWjPYdQ@mail.gmail.com>
Subject: Re: [RFC v2 1/5] Bluetooth: Only schedule LE tx links if LE-capable
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Thu, Aug 18, 2011 at 7:17 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On Thu, 2011-08-18 at 03:43 -0400, Luiz Augusto von Dentz wrote:
>> Any reasons why you choose to not add the check inside hci_sched_le?
>
> Only to make it really obvious that LE transmission is not required on
> the vast majority of BT controllers :)

... yet. Are you aware LE is not optional on Bluetooth 4.0? Therefore
any modern BT device claiming to support 4.0 will have LE support on
its controller (host support is another thing).

But I suppose we will still see plenty of 2.1 devices for a long time...

My two cents,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
