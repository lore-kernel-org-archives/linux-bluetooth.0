Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: l2cap ERTM channel shutdown issue on Android 4.4.4 with kernel 3.4 (Nexus 4,5,7)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAMv5Gbc2s-UJEe4cNnQK84g7mo9c8PFLojVq2KMBxrjJuwuR9Q@mail.gmail.com>
Date: Thu, 30 Oct 2014 09:28:25 -0700
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Message-Id: <BEB94108-5369-4103-8983-DB28B931C1FC@holtmann.org>
References: <CAMv5Gbc2s-UJEe4cNnQK84g7mo9c8PFLojVq2KMBxrjJuwuR9Q@mail.gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

> I've been testing PTS 5.3 MCAP profile against Android 4.4.4 on Nexus
> 5 using mcaptest (in bluez/tools/) and I've found a kernel bug with
> closing l2cap ERTM channels.
> 
> I've tested MACP using android 4.4.4 on Nexus 5, kernel in version 3.4
> with 3.17 backports.
> 
> If MCL connection fails or some other error occurs mcaptest get
> stucked and don't react to closing (ctrl+C, ctrl+Z, or even kill
> process). Mcaptest process stuck on Uninterruptible sleep (D) state.
> 
> I debugged kernel space and it happens while shutting down ERTM l2cap
> channel of MCAP. Kernel tries to clear l2cap timers (ack,
> retransmission, monitor) and call l2cap_clear_timer function defined
> in l2cap header. l2cap_clear_timer function try to cancel_delayed_work
> which is in every timer defined. It never gets back from
> cancel_delayed_work (get stuck there) - defined in workqueue.c kernel
> function. After this stuck channel mutex get locked (l2cap_chan_lock)
> in l2cap_conn_del before each channel delete l2cap and it's never
> unlocked (In my case it happens on first timer clear). In meantime
> l2cap_sock_release->l2cap_sock_shutdown happens and it tries to lock
> its own channel mutex - but it can't because it's still locked.
> 
> It works properly on computer with kernel 3.16 with 3.17 backports.
> I've also checked what different in both versions since kernel 3.4 is
> quiet old. In result, cancel_delayed_work (workqueue.c - in kernel)
> function implementation gets knowingly changed in ~3.9 version of
> kernel.
> 
> 
> Bug can be easily reproduced:
> - start mcaptest on device with android: mcaptest -C 4099 -D 4101 -dc
> <some dummy bdaddr>
> after receive error message  "Could not connect MCL: connect error:
> Host is down (112)" I've got stucked - only device restart helps.
> 
> 
> Until we don't get newer kernel for those devices we'll get stucked here.
> 
> Any suggestion how to fix it on our existing 3.4 kernel.
> ps. I've commented those clear timers functions (and it works well)
> for test purposes because they don't have impact for test cases flow
> (this is l2cap channel shutdown phase in ERTM mode).

I have no suggestion. This is something that might be better addressed to LKML since obviously the current kernels are working as expected.

So it would be good if you bisect the exact commit that made this work.

Regards

Marcel

