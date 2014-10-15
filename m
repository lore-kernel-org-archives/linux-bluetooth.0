Return-Path: <cyrus@holtmann.org>
Message-ID: <543EEE10.2010000@hurleysoftware.com>
Date: Wed, 15 Oct 2014 17:58:40 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Alexander Aring <alex.aring@gmail.com>
CC: Jukka Rissanen <jukka.rissanen@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Incorrect locking when sending data in softirq
References: <1413376985-25812-1-git-send-email-jukka.rissanen@linux.intel.com> <543E7414.8090209@hurleysoftware.com> <1413379948.2705.120.camel@jrissane-mobl.ger.corp.intel.com> <543EDD20.8050508@hurleysoftware.com> <20141015215324.GB17138@omega>
In-Reply-To: <20141015215324.GB17138@omega>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 10/15/2014 05:53 PM, Alexander Aring wrote:
> Hi Peter,
> 
> On Wed, Oct 15, 2014 at 04:46:24PM -0400, Peter Hurley wrote:
> ...
>>
>> That's happening because 6lowpan.c:send_mcast_pkt() is disabling
>> interrupts with the read_lock_irqsave() before calling send_pkt().
>>
>> It's unclear browsing through the lowpan driver why the
>> irqflags save/restore read_lock flavors are being used; is there a
>> place where the bluetooth core is calling the driver in atomic
>> context (ie., where interrupts are disabled)?
>>
> 
> In my opinion bt_xmit is called in atomic context. Make the stacktrace
> sense now?

I don't think so.

The network layer is very careful about keeping interrupts enabled
and calling network drivers from softirq, so that spin_lock_bh() is
typically all that's required.

> It's the callback 'ndo_start_xmit' of 'struct net_device_ops' [0].

The send_mcast_pkt() isn't showing in the stack trace because it's
being inlined; and send_mcast_pkt() is definitely disabling interrupts
and calling send_pkt().

Regards,
Peter Hurley

