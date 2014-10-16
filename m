Return-Path: <cyrus@holtmann.org>
Message-ID: <1413445653.2705.128.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH] Bluetooth: Incorrect locking when sending data in
 softirq
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 16 Oct 2014 10:47:33 +0300
In-Reply-To: <543EDD20.8050508@hurleysoftware.com>
References: <1413376985-25812-1-git-send-email-jukka.rissanen@linux.intel.com>
		 <543E7414.8090209@hurleysoftware.com>
	 <1413379948.2705.120.camel@jrissane-mobl.ger.corp.intel.com>
	 <543EDD20.8050508@hurleysoftware.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On ke, 2014-10-15 at 16:46 -0400, Peter Hurley wrote:

> That's happening because 6lowpan.c:send_mcast_pkt() is disabling
> interrupts with the read_lock_irqsave() before calling send_pkt().
> 
> It's unclear browsing through the lowpan driver why the
> irqflags save/restore read_lock flavors are being used; is there a
> place where the bluetooth core is calling the driver in atomic
> context (ie., where interrupts are disabled)?
> 
> The devices_lock/bt_6lowpan_devices list looks ideal for
> converting to RCU.
> 
> Regards,
> Peter Hurley
> 
> PS - list_for_each_entry_safe() is only required when the reference
> to the list entry may become invalid _while_ still iterating the list.
> So not necessary in peer_lookup_conn(), lookup_peer(), lookup_dev(),
> peer_lookup_chan(), peer_lookup_ba(), send_mcast_pkt(), maybe others.
> 

Thanks for the explanations, these were very valuable. I will
investigate the RCU conversion and fixes to list handling.


Cheers,
Jukka


