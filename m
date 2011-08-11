Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Aug 2011 18:06:33 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: cmtp: Fix deadlock in session deletion
Message-ID: <20110811210633.GD19699@joana>
References: <1312555461.2172.5.camel@THOR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312555461.2172.5.camel@THOR>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

* Peter Hurley <peter@hurleysoftware.com> [2011-08-05 10:44:21 -0400]:

> Commit fada4ac339 introduced the usage of kthread API.
> kthread_stop is a blocking function which returns only when
> the thread exits. In this case, the thread can't exit because it's
> waiting for the write lock, which is being held by cmtp_del_connection()
> which is waiting for the thread to exit -- deadlock.
> 
> Revert cmtp_reset_ctr to its original behavior: non-blocking signalling
> for the session to terminate.
> 
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  net/bluetooth/cmtp/capi.c |    3 ++-
>  net/bluetooth/cmtp/cmtp.h |    1 +
>  net/bluetooth/cmtp/core.c |    5 +++--
>  3 files changed, 6 insertions(+), 3 deletions(-)

Applied, thanks.

	Gustavo
