Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120113150746.GB1336@aemeltch-MOBL1>
References: <1326457010-10216-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1326460723.6454.264.camel@aeonflux>
	<20120113150746.GB1336@aemeltch-MOBL1>
Date: Sun, 15 Jan 2012 19:10:27 -0200
Message-ID: <CAA37ikbKAtde5RHEkvhaipkW3fiZYDOS8Ya1bHa7ywNqo3LhDQ@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Use flush_work instead of cancel_work
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Jan 13, 2012 at 1:07 PM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> Hi Marcel,
>
> On Fri, Jan 13, 2012 at 02:18:43PM +0100, Marcel Holtmann wrote:
>> Hi Andrei,
>>
>> > Fix deadlock when cancelling delayed work.
>> >
>> > [ =A0584.676126] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > [ =A0584.676126] [ INFO: possible circular locking dependency detected=
 ]
>> > [ =A0584.676126] 3.2.0-rc2niko+ #44
>> > [ =A0584.676126] -----------------------------------------------------=
--
>> > [ =A0584.676126] kworker/u:1/30 is trying to acquire lock:
>> > [ =A0584.676126] =A0(&hdev->lock){+.+.+.}, at: [<f81f001c>] hci_conn_t=
imeout+0x6c/0x190 [bluetooth]
>> > [ =A0584.676126]
>> > [ =A0584.676126] but task is already holding lock:
>> > [ =A0584.676126] =A0((&(&conn->disc_work)->work)){+.+...}, at: [<c1065=
a78>] process_one_work+0x108/0x460
>> > [ =A0584.676126]
>> > [ =A0584.676126] which lock already depends on the new lock.
>> > [ =A0584.676126]
>> > [ =A0584.676126]
>> > [ =A0584.676126] the existing dependency chain (in reverse order) is:
>> > [ =A0584.676126]
>> > [ =A0584.676126] -> #1 ((&(&conn->disc_work)->work)){+.+...}:
>> > [ =A0584.676126] =A0 =A0 =A0 =A0[<c1086748>] lock_acquire+0x88/0x110
>> > [ =A0584.676126] =A0 =A0 =A0 =A0[<c1066041>] wait_on_work+0x61/0x210
>> > [ =A0584.676126] =A0 =A0 =A0 =A0[<c106630a>] __cancel_work_timer+0x6a/=
0x110
>> > [ =A0584.676126] =A0 =A0 =A0 =A0[<c10663c0>] cancel_delayed_work_sync+=
0x10/0x20
>> > [ =A0584.676126] =A0 =A0 =A0 =A0[<f81f935b>] hci_event_packet+0x3b2b/0=
x4610 [bluetooth]
>> > [ =A0584.676126] =A0 =A0 =A0 =A0[<f81ea78e>] hci_rx_work+0x20e/0x4c0 [=
bluetooth]
>> > [ =A0584.676126] =A0 =A0 =A0 =A0[<c1065aec>] process_one_work+0x17c/0x=
460
>> > [ =A0584.676126] =A0 =A0 =A0 =A0[<c10672e4>] worker_thread+0x124/0x2c0
>> > [ =A0584.676126] =A0 =A0 =A0 =A0[<c106be44>] kthread+0x84/0x90
>> > [ =A0584.676126] =A0 =A0 =A0 =A0[<c1567f42>] kernel_thread_helper+0x6/=
0x10
>> > [ =A0584.676126]
>> > [ =A0584.676126] -> #0 (&hdev->lock){+.+.+.}:
>> > [ =A0584.676126] =A0 =A0 =A0 =A0[<c10852cd>] __lock_acquire+0xc0d/0x1a=
b0
>> > [ =A0584.676126] =A0 =A0 =A0 =A0[<c1086748>] lock_acquire+0x88/0x110
>> > [ =A0584.676126] =A0 =A0 =A0 =A0[<c155de50>] mutex_lock_nested+0x70/0x=
320
>> > [ =A0584.676126] =A0 =A0 =A0 =A0[<f81f001c>] hci_conn_timeout+0x6c/0x1=
90 [bluetooth]
>> > [ =A0584.676126] =A0 =A0 =A0 =A0[<c1065aec>] process_one_work+0x17c/0x=
460
>> > [ =A0584.676126] =A0 =A0 =A0 =A0[<c10672e4>] worker_thread+0x124/0x2c0
>> > [ =A0584.676126] =A0 =A0 =A0 =A0[<c106be44>] kthread+0x84/0x90
>> > [ =A0584.676126] =A0 =A0 =A0 =A0[<c1567f42>] kernel_thread_helper+0x6/=
0x10
>> > [ =A0584.676126]
>> > [ =A0584.676126] other info that might help us debug this:
>> > [ =A0584.676126]
>> > [ =A0584.676126] =A0Possible unsafe locking scenario:
>> > [ =A0584.676126]
>> > [ =A0584.676126] =A0 =A0 =A0 =A0CPU0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0CPU1
>> > [ =A0584.676126] =A0 =A0 =A0 =A0---- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0----
>> > [ =A0584.676126] =A0 lock((&(&conn->disc_work)->work));
>> > [ =A0584.676126] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0lock(&hdev->lock);
>> > [ =A0584.676126] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0lock((&(&conn->disc_work)->work));
>> > [ =A0584.676126] =A0 lock(&hdev->lock);
>> > [ =A0584.676126]
>> > [ =A0584.676126] =A0*** DEADLOCK ***
>> > [ =A0584.676126]
>> > [ =A0584.676126] 2 locks held by kworker/u:1/30:
>> > [ =A0584.676126] =A0#0: =A0(hdev->name){.+.+.+}, at: [<c1065a78>] proc=
ess_one_work+0x108/0x460
>> > [ =A0584.676126] =A0#1: =A0((&(&conn->disc_work)->work)){+.+...}, at: =
[<c1065a78>] process_one_work+0x108/0x460
>> >
>> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>> > ---
>> > =A0net/bluetooth/hci_conn.c | =A0 =A02 +-
>> > =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> Acked-by: Marcel Holtmann <marcel@holtmann.org>
>
> Apparently it does not fix it completely, the reason might be hci_dev_loc=
k
> in hci_conn_timeout. Maybe instead of lock we could use hold/put?
>
> I will investigate this issue further.

I believe the real problem is to have a _sync() call for cancelling or
flushing the delayed work. While you are at it can you try if using
__cancel_delayed_work() fixes the problem, please? I guess with the
recent move to workqueues some _sync() calls were added that might
lead to deadlocks. I'm even thinking we might wanna replace all
cancel_dealyed_work_sync() calls with __cancel_dealyed_work() ones
would be good. I don't have time to test now, but if you do, please
try this too. Thanks a lot.

> Best regards
> Andrei Emeltchenko

Best regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
