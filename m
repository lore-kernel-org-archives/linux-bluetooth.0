Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <a8e1da1002200017t6e856c7cu1300ac5b3b3a43b@mail.gmail.com>
References: <35c90d961002172104q3af1ca8p850004f8b93e8af7@mail.gmail.com>
	<a8e1da1002200017t6e856c7cu1300ac5b3b3a43b@mail.gmail.com>
From: Nick Pelly <npelly@google.com>
Date: Sun, 21 Feb 2010 13:00:36 -0800
Message-ID: <35c90d961002211300s25507542y9b73724881be5540@mail.gmail.com>
Subject: Re: Kernel panic in rfcomm_run - unbalanced refcount on
	rfcomm_session
To: Dave Young <hidave.darkstar@gmail.com>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Feb 20, 2010 at 12:17 AM, Dave Young <hidave.darkstar@gmail.com> wrote:
> On Thu, Feb 18, 2010 at 1:04 PM, Nick Pelly <npelly@google.com> wrote:
>> Since 2.6.32 we are seeing kernel panics like:
>>
>> [10651.110229] Unable to handle kernel paging request at virtual
>> address 6b6b6b6b
>> [10651.111968] Internal error: Oops: 5 [#1] PREEMPT
>> [10651.113952] CPU: 0    Tainted: G        W   (2.6.32-59979-gd0c97db #1)
>> [10651.114624] PC is at rfcomm_run+0xa04/0xdbc
>> <...>
>> [10651.406188] [<c031ad24>] (rfcomm_run+0xa04/0xdbc) from [<c006ce30>]
>> (kthread+0x78/0x80)
>> [10651.406585] [<c006ce30>] (kthread+0x78/0x80) from [<c002793c>]
>> (kernel_thread_exit+0x0/0x8)
>>
>> (rfcomm_run() is all inlined so theres not much of a stack trace))
>
> Could you make rfcomm_process_sessions to be not inlined, and get new
> kernel logs?

I'm not using a stock kernel, so i'm not sure how the kernel trace
will help, but the un-inlined stack that I decoded against my vmlinux
is:

>> This is a use-after-free on struct rfcomm_session s in the call chain
>> rfcomm_run() -> rfcomm_process_sessions() -> rfcomm_process_dlcs() ->
>> list_for_each_safe(p, n, &s->dlcs)


PS - 9e726b17422b is definitely not the root cause, we've now seen the
same crash with this patch reverted (but it is much harder to
reproduce with 9e726b17422b reverted).

Nick
