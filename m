Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Jan 2012 14:35:36 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Use flush_work instead of cancel_work
Message-ID: <20120116123534.GB14019@aemeltch-MOBL1>
References: <1326457010-10216-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1326460723.6454.264.camel@aeonflux>
 <20120113150746.GB1336@aemeltch-MOBL1>
 <CAA37ikbKAtde5RHEkvhaipkW3fiZYDOS8Ya1bHa7ywNqo3LhDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAA37ikbKAtde5RHEkvhaipkW3fiZYDOS8Ya1bHa7ywNqo3LhDQ@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Sun, Jan 15, 2012 at 07:10:27PM -0200, Ulisses Furquim wrote:
...
> >> > [  584.676126] ======================================================
> >> > [  584.676126] [ INFO: possible circular locking dependency detected ]
> >> > [  584.676126] 3.2.0-rc2niko+ #44
> >> > [  584.676126] -------------------------------------------------------
...
> >> > [  584.676126]  Possible unsafe locking scenario:
> >> > [  584.676126]
> >> > [  584.676126]        CPU0                    CPU1
> >> > [  584.676126]        ----                    ----
> >> > [  584.676126]   lock((&(&conn->disc_work)->work));
> >> > [  584.676126]                                lock(&hdev->lock);
> >> > [  584.676126]                                lock((&(&conn->disc_work)->work));
> >> > [  584.676126]   lock(&hdev->lock);
> >> > [  584.676126]
> >> > [  584.676126]  *** DEADLOCK ***
> >> > [  584.676126]
> >> > [  584.676126] 2 locks held by kworker/u:1/30:
> >> > [  584.676126]  #0:  (hdev->name){.+.+.+}, at: [<c1065a78>] process_one_work+0x108/0x460
> >> > [  584.676126]  #1:  ((&(&conn->disc_work)->work)){+.+...}, at: [<c1065a78>] process_one_work+0x108/0x460
> > Apparently it does not fix it completely, the reason might be hci_dev_lock
...
> > in hci_conn_timeout. Maybe instead of lock we could use hold/put?
> >
> > I will investigate this issue further.
> 
> I believe the real problem is to have a _sync() call for cancelling or
> flushing the delayed work. While you are at it can you try if using
> __cancel_delayed_work() fixes the problem, please? I guess with the
> recent move to workqueues some _sync() calls were added that might
> lead to deadlocks. I'm even thinking we might wanna replace all
> cancel_dealyed_work_sync() calls with __cancel_dealyed_work() ones
> would be good. I don't have time to test now, but if you do, please
> try this too. Thanks a lot.

I've tested cancel_delayed_work and it works in my set of tests. It does
not report deadlock (at least here ;)).

I've just sent modified RFC v2.

Best regards 
Andrei Emeltchenko 
