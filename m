Return-Path: <cyrus@holtmann.org>
Message-ID: <4B7CE8F9.2050301@nokia.com>
Date: Thu, 18 Feb 2010 09:15:05 +0200
From: Ville Tervo <ville.tervo@nokia.com>
MIME-Version: 1.0
To: ext Nick Pelly <npelly@google.com>
CC: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Subject: Re: Kernel panic in rfcomm_run - unbalanced refcount on rfcomm_session
References: <35c90d961002172104q3af1ca8p850004f8b93e8af7@mail.gmail.com>
In-Reply-To: <35c90d961002172104q3af1ca8p850004f8b93e8af7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi nick,

ext Nick Pelly wrote:
> Since 2.6.32 we are seeing kernel panics like:
> 
> [10651.110229] Unable to handle kernel paging request at virtual
> address 6b6b6b6b
> [10651.111968] Internal error: Oops: 5 [#1] PREEMPT
> [10651.113952] CPU: 0    Tainted: G        W   (2.6.32-59979-gd0c97db #1)
> [10651.114624] PC is at rfcomm_run+0xa04/0xdbc
> <...>
> [10651.406188] [<c031ad24>] (rfcomm_run+0xa04/0xdbc) from [<c006ce30>]
> (kthread+0x78/0x80)
> [10651.406585] [<c006ce30>] (kthread+0x78/0x80) from [<c002793c>]
> (kernel_thread_exit+0x0/0x8)
> 
> (rfcomm_run() is all inlined so theres not much of a stack trace))
> 
> This is a use-after-free on struct rfcomm_session s in the call chain
> rfcomm_run() -> rfcomm_process_sessions() -> rfcomm_process_dlcs() ->
> list_for_each_safe(p, n, &s->dlcs). The only way this can happen is if
> there is an unbalanced refcount on the rfcomm session.
> 

I have seen same traces.

> We found that reverting the patch
> 9e726b17422bade75fba94e625cd35fd1353e682 "Bluetooth: Fix rejected
> connection not disconnecting ACL link" fixes the issue for us. The
> patch itself looks ok, I added some logging to check the new refcounts
> in the patch are balanced and they are. However if I remove the new
> calls to rfcomm_session_put() and rfcomm_session_hold() the crash is
> resolved. I also found that we can crash without hitting
> rfcomm_session_timeout(), so its not related to Marcel's recent patch
> to remove the scheduling-while-atomic warning.
> 
> 9e726b17422bade75fba94e625cd35fd1353e682 does lead to a delay in
> calling rfcomm_session_del() due to the extra refcount while waiting
> for the new timeout. I believe that this delay has revealed some more
> subtle problem elsewhere that causes an unbalanced refcount and then
> the kernel panic.
> 
> I have debug kernel logs and hci logs - they are too large to send to
> the list but I can send them directly to anyone interested in
> debugging.
> 
> We see this crash frequently with a number of headsets since 2.6.32,
> but not reliably. I do have a 100% repro case with the Nuvi Garmin,
> with these exact steps:
> 1) Make sure Nuvi is unpaired, Bluez stack is unpaired, and kernel has
> been rebooted since unpairing.
> 2) Initiate device discovery, pairing, and handsfree connection from Nuvi
> 3) Observe HFP rfcomm connect briefly, then disconnect, and kernel panic
> 

Some OBEX cases also trigger this same problem. I don't have exact steps 
right now. I'll try to dig some more information.

-- 
Ville
