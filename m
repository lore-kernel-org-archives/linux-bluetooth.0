Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327999384-16094-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1327999384-16094-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1327999384-16094-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 31 Jan 2012 09:31:45 -0300
Message-ID: <CACJA=fWD6wOnNT4jFvGQAP3hRo0AKWAoiZTHZsfmGvp+6JdxOg@mail.gmail.com>
Subject: Re: [RESEND 1/3] Bluetooth: Use cancel_work instead of cancel_work_sync
From: Andre Guedes <andre.guedes@openbossa.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Jan 31, 2012 at 5:43 AM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Fix deadlock when cancelling delayed work.
>
> [  584.676126] ======================================================
> [  584.676126] [ INFO: possible circular locking dependency detected ]
> [  584.676126] 3.2.0-rc2niko+ #44
> [  584.676126] -------------------------------------------------------
> [  584.676126] kworker/u:1/30 is trying to acquire lock:
> [  584.676126]  (&hdev->lock){+.+.+.}, at: [<f81f001c>] hci_conn_timeout+0x6c/0x190 [bluetooth]
> [  584.676126]
> [  584.676126] but task is already holding lock:
> [  584.676126]  ((&(&conn->disc_work)->work)){+.+...}, at: [<c1065a78>] process_one_work+0x108/0x460
> [  584.676126]
> [  584.676126] which lock already depends on the new lock.
> [  584.676126]
> [  584.676126]
> [  584.676126] the existing dependency chain (in reverse order) is:
> [  584.676126]
> [  584.676126] -> #1 ((&(&conn->disc_work)->work)){+.+...}:
> [  584.676126]        [<c1086748>] lock_acquire+0x88/0x110
> [  584.676126]        [<c1066041>] wait_on_work+0x61/0x210
> [  584.676126]        [<c106630a>] __cancel_work_timer+0x6a/0x110
> [  584.676126]        [<c10663c0>] cancel_delayed_work_sync+0x10/0x20
> [  584.676126]        [<f81f935b>] hci_event_packet+0x3b2b/0x4610 [bluetooth]
> [  584.676126]        [<f81ea78e>] hci_rx_work+0x20e/0x4c0 [bluetooth]
> [  584.676126]        [<c1065aec>] process_one_work+0x17c/0x460
> [  584.676126]        [<c10672e4>] worker_thread+0x124/0x2c0
> [  584.676126]        [<c106be44>] kthread+0x84/0x90
> [  584.676126]        [<c1567f42>] kernel_thread_helper+0x6/0x10
> [  584.676126]
> [  584.676126] -> #0 (&hdev->lock){+.+.+.}:
> [  584.676126]        [<c10852cd>] __lock_acquire+0xc0d/0x1ab0
> [  584.676126]        [<c1086748>] lock_acquire+0x88/0x110
> [  584.676126]        [<c155de50>] mutex_lock_nested+0x70/0x320
> [  584.676126]        [<f81f001c>] hci_conn_timeout+0x6c/0x190 [bluetooth]
> [  584.676126]        [<c1065aec>] process_one_work+0x17c/0x460
> [  584.676126]        [<c10672e4>] worker_thread+0x124/0x2c0
> [  584.676126]        [<c106be44>] kthread+0x84/0x90
> [  584.676126]        [<c1567f42>] kernel_thread_helper+0x6/0x10
> [  584.676126]
> [  584.676126] other info that might help us debug this:
> [  584.676126]
> [  584.676126]  Possible unsafe locking scenario:
> [  584.676126]
> [  584.676126]        CPU0                    CPU1
> [  584.676126]        ----                    ----
> [  584.676126]   lock((&(&conn->disc_work)->work));
> [  584.676126]                                lock(&hdev->lock);
> [  584.676126]                                lock((&(&conn->disc_work)->work));
> [  584.676126]   lock(&hdev->lock);
> [  584.676126]
> [  584.676126]  *** DEADLOCK ***
> [  584.676126]
> [  584.676126] 2 locks held by kworker/u:1/30:
> [  584.676126]  #0:  (hdev->name){.+.+.+}, at: [<c1065a78>] process_one_work+0x108/0x460
> [  584.676126]  #1:  ((&(&conn->disc_work)->work)){+.+...}, at: [<c1065a78>] process_one_work+0x108/0x460
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> ---
> v2 - use cancel_delayed_work instead of cancel_delayed_work_sync following
> recommendation from Ulisses Furquim
> ---
>  net/bluetooth/hci_conn.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 67c94c4..7ec6e54 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -433,7 +433,7 @@ int hci_conn_del(struct hci_conn *conn)
>
>        del_timer(&conn->idle_timer);
>
> -       cancel_delayed_work_sync(&conn->disc_work);
> +       cancel_delayed_work(&conn->disc_work);

I'm afraid we must use _sync variant here. disc_work is not supposed to
be running after hci_conn is deleted.

BTW, I believe we already addressed this issue in patches [PATCH 1/2]
Bluetooth: Fix potential deadlock and [PATCH 2/2] Bluetooth: Remove
unneeded locking. These patches are now pushed upstream. Could you
verify if this lockdep message is still occurring in johan's bluetooth-next
tree?

BR,

Andre
