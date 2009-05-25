Return-Path: <cyrus@holtmann.org>
Message-ID: <4A1AF7B0.4020701@hartkopp.net>
Date: Mon, 25 May 2009 21:55:28 +0200
From: Oliver Hartkopp <oliver@hartkopp.net>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: possible recursive locking in 2.6.30-rc6
References: <4A1A9D1D.2050301@hartkopp.net>
In-Reply-To: <4A1A9D1D.2050301@hartkopp.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Oliver Hartkopp wrote:
> Hi all,
> 

This is another trace after having a successful connection and after
terminating this connection after 40 secs with the latest 2.6.30-rc7.

When the kernel config is needed please give me a note.

Tnx,
Oliver


[   52.331965] PPP generic driver version 2.4.2
[   57.917179] PPP BSD Compression module registered
[   57.964543] PPP Deflate Compression module registered
[   97.634897]
[   97.634901] =============================================
[   97.638773] [ INFO: possible recursive locking detected ]
[   97.638773] 2.6.30-rc7 #23
[   97.638773] ---------------------------------------------
[   97.638773] bluetooth/2505 is trying to acquire lock:
[   97.669944]  (bluetooth){+.+.+.}, at: [<c0130c14>] flush_work+0x28/0xb0
[   97.669944]
[   97.669944] but task is already holding lock:
[   97.669944]  (bluetooth){+.+.+.}, at: [<c0130424>] worker_thread+0x149/0x25e
[   97.669944]
[   97.669944] other info that might help us debug this:
[   97.669944] 2 locks held by bluetooth/2505:
[   97.669944]  #0:  (bluetooth){+.+.+.}, at: [<c0130424>]
worker_thread+0x149/0x25e
[   97.669944]  #1:  (&conn->work_del){+.+...}, at: [<c0130424>]
worker_thread+0x149/0x25e
[   97.669944]
[   97.669944] stack backtrace:
[   97.669944] Pid: 2505, comm: bluetooth Not tainted 2.6.30-rc7 #23
[   97.669944] Call Trace:
[   97.669944]  [<c03d5ab1>] ? printk+0xf/0x11
[   97.669944]  [<c0140d9a>] __lock_acquire+0x7ce/0xb1b
[   97.669944]  [<c0141177>] lock_acquire+0x90/0xad
[   97.669944]  [<c0130c14>] ? flush_work+0x28/0xb0
[   97.669944]  [<c0130c2e>] flush_work+0x42/0xb0
[   97.669944]  [<c0130c14>] ? flush_work+0x28/0xb0
[   97.669944]  [<f87f8966>] del_conn+0x1c/0x84 [bluetooth]
[   97.669944]  [<c0130469>] worker_thread+0x18e/0x25e
[   97.669944]  [<c0130424>] ? worker_thread+0x149/0x25e
[   97.669944]  [<f87f894a>] ? del_conn+0x0/0x84 [bluetooth]
[   97.669944]  [<c0133843>] ? autoremove_wake_function+0x0/0x33
[   97.669944]  [<c01302db>] ? worker_thread+0x0/0x25e
[   97.669944]  [<c013355a>] kthread+0x45/0x6b
[   97.669944]  [<c0133515>] ? kthread+0x0/0x6b
[   97.669944]  [<c01034a7>] kernel_thread_helper+0x7/0x10


> i'm sometimes working with BT DUN with a Nokia 6210 Navigator.
> 
> Last weekend anything must gone wrong, so my mobile was not able to create a
> ppp link with DUN this morning. After updating the driver and BT-chip firmware
> of my Dell 830 laptop and several pairing attempts i was able to kick it to
> work again ... :-]
> 
> And i needed to move the channel from '5' to '3' in /etc/bluetooth/rfcomm.conf
> - i assume the Nokia Windows Software re-configured this in the process of
> re-installing their SW when updating the Windows drivers ... don't know.
> 
> In the meantime (when the paring or anything else was broken) i discovered
> this kernel message about a locking issue.
> 
> Is this a known problem?
> 
> Regards,
> Oliver
> 
> ps. Please CC me as i did not subcribe the list. Tnx
> 
> =============================================
> [ INFO: possible recursive locking detected ]
> 2.6.30-rc6-02911-gbb803cf #16
> ---------------------------------------------
> bluetooth/2518 is trying to acquire lock:
>  (bluetooth){+.+.+.}, at: [<c0130c14>] flush_work+0x28/0xb0
> 
> but task is already holding lock:
>  (bluetooth){+.+.+.}, at: [<c0130424>] worker_thread+0x149/0x25e
> 
> other info that might help us debug this:
> 2 locks held by bluetooth/2518:
>  #0:  (bluetooth){+.+.+.}, at: [<c0130424>] worker_thread+0x149/0x25e
>  #1:  (&conn->work_del){+.+...}, at: [<c0130424>] worker_thread+0x149/0x25e
> 
> stack backtrace:
> Pid: 2518, comm: bluetooth Not tainted 2.6.30-rc6-02911-gbb803cf #16
> Call Trace:
>  [<c03d64d9>] ? printk+0xf/0x11
>  [<c0140d96>] __lock_acquire+0x7ce/0xb1b
>  [<c0141173>] lock_acquire+0x90/0xad
>  [<c0130c14>] ? flush_work+0x28/0xb0
>  [<c0130c2e>] flush_work+0x42/0xb0
>  [<c0130c14>] ? flush_work+0x28/0xb0
>  [<f8b84966>] del_conn+0x1c/0x84 [bluetooth]
>  [<c0130469>] worker_thread+0x18e/0x25e
>  [<c0130424>] ? worker_thread+0x149/0x25e
>  [<f8b8494a>] ? del_conn+0x0/0x84 [bluetooth]
>  [<c0133843>] ? autoremove_wake_function+0x0/0x33
>  [<c01302db>] ? worker_thread+0x0/0x25e
>  [<c013355a>] kthread+0x45/0x6b
>  [<c0133515>] ? kthread+0x0/0x6b
>  [<c01034a7>] kernel_thread_helper+0x7/0x10
> 

