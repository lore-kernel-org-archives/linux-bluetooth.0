Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Jul 2014 14:36:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/5] android/tester-ng: Fix not freeing porperties value
Message-ID: <20140725113607.GA30968@t440s.P-661HNU-F1>
References: <1406285106-14588-1-git-send-email-jakub.tyszkowski@tieto.com>
 <1406285106-14588-5-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406285106-14588-5-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Fri, Jul 25, 2014, Jakub Tyszkowski wrote:
> This fixes 3 valgrind reports like:
> 
> 8 bytes in 2 blocks are definitely lost in loss record 7 of 47
> ==8437==    at 0x4C2AB80: malloc (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==8437==    by 0x5089610: g_malloc (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.4000.0)
> ==8437==    by 0x50A0B57: g_memdup (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.4000.0)
> ==8437==    by 0x40E94E: create_property (tester-main.c:623)
> ==8437==    by 0x40F96C: ssp_request_cb (tester-main.c:741)
> ==8437==    by 0x5F70E5A: notification_handler (hal-ipc.c:125)
> ==8437==    by 0x534B181: start_thread (pthread_create.c:312)
> ==8437==    by 0x565C30C: clone (clone.S:111)
> ---
>  android/tester-main.c | 3 +++
>  1 file changed, 3 insertions(+)

All patches in this set have been applied. Thanks.

Johan
