Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Tue, 1 Nov 2011 14:12:42 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	anderson.lizardo@openbossa.org
Subject: Re: [PATCH v2] Bluetooth: hidp: Fix module reference cleanup
Message-ID: <20111101161242.GE2580@joana>
References: <CAJdJm_NYEiw21=XwSCsqHtGjK18r6SXAJcLVdAG0LPEB6a9Wdg@mail.gmail.com>
 <1319985223-6043-1-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319985223-6043-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Herrmann <dh.herrmann@googlemail.com> [2011-10-30 15:33:43 +0100]:

> Calling module_put(THIS_MODULE) is *never* safe when we cannot go sure that we
> own at least two references. This is because the call may unload our module
> before it returns and then the "return" will jump into invalid memory.
> 
> Gladly, module.h provides a wrapper for kthread-users: module_put_and_exit().
> This puts our module and then exits the kthread without returning to the module.
> 
> This patch fixes the hidp kthread to use this wrapper instead of manually
> freeing its own reference. See nfsd or lockd for other kthreads using this.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
> V2: Fix error path of kthread_run(). We now take the module reference inside the
> kthread. This is safe because the caller will wait for us until we set
> "waiting_for_startup" to 0. Thanks to Anderson Lizardo for pointing this out.
> 
>  net/bluetooth/hidp/core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

This one doesn't apply anymore, please rebase. Thanks.

	Gustavo
