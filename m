Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Jan 2014 16:32:19 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] shared: Fix memory leaks in mgmt_unref
Message-ID: <20140109143219.GB16810@x220.p-661hnu-f1>
References: <1389277030-2131-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389277030-2131-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Jan 09, 2014, Szymon Janc wrote:
> Destroy notify and pending lists on freeing mgmt. Those two lists
> cannot be destroyed in same place as reply and request queues due
> to being used in can_read_data().
> 
> Fix following valgrind reports:
> 
> 24 bytes in 1 blocks are definitely lost in loss record 70 of 212
>    at 0x4C2C494: calloc (in /usr/lib/valgrind/
>        vgpreload_memcheck-amd64-linux.so)
>    by 0x46B5E2: queue_new (queue.c:46)
>    by 0x46C3CA: mgmt_new (mgmt.c:407)
>    by 0x46C4B5: mgmt_new_default (mgmt.c:466)
>    by 0x45FB45: adapter_init (adapter.c:6237)
>    by 0x40A4F1: main (main.c:534)
> 
> 24 bytes in 1 blocks are definitely lost in loss record 71 of 212
>    at 0x4C2C494: calloc (in /usr/lib/
>        valgrind/vgpreload_memcheck-amd64-linux.so)
>    by 0x46B5E2: queue_new (queue.c:46)
>    by 0x46C3D8: mgmt_new (mgmt.c:417)
>    by 0x46C4B5: mgmt_new_default (mgmt.c:466)
>    by 0x45FB45: adapter_init (adapter.c:6237)
>    by 0x40A4F1: main (main.c:534)
> ---
>  src/shared/mgmt.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
