Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Aug 2011 18:05:33 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	Jaikumar Ganesh <jaikumar@google.com>
Subject: Re: [PATCH v2] Bluetooth: bnep: Fix deadlock in session deletion
Message-ID: <20110811210532.GC19699@joana>
References: <1312555295.2172.2.camel@THOR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312555295.2172.2.camel@THOR>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

* Peter Hurley <peter@hurleysoftware.com> [2011-08-05 10:41:35 -0400]:

> Commit f4d7cd4a4c introduced the usage of kthread API.
> kthread_stop is a blocking function which returns only when
> the thread exits. In this case, the thread can't exit because it's
> waiting for the write lock, which is being held by bnep_del_connection()
> which is waiting for the thread to exit -- deadlock.
> 
> Use atomic_t/wake_up_process instead to signal to the thread to exit.
> 
> Signed-off-by: Jaikumar Ganesh <jaikumar@google.com>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  net/bluetooth/bnep/bnep.h |    1 +
>  net/bluetooth/bnep/core.c |    9 +++++----
>  2 files changed, 6 insertions(+), 4 deletions(-)

Applied, thanks.

	Gustavo
