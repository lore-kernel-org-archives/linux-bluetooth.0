Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Nov 2011 15:25:11 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hidp: Fix module reference cleanup
Message-ID: <20111101172511.GM2580@joana>
References: <20111101161242.GE2580@joana>
 <1320164870-13797-1-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320164870-13797-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Herrmann <dh.herrmann@googlemail.com> [2011-11-01 17:27:50 +0100]:

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
> Calling __module_get() inside the kthread is safe as the hidp module will always
> wait until the kthread sets "waiting_for_startup" to 0.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
> V3: I rebased on top of bluetooth-next plus the patches already pending on the
> ML. It should apply cleanly now. Otherwise, just tell me what tree to use for
> the rebase ;) Or try "git am -3 ..."
> 
>  net/bluetooth/hidp/core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

	Gustavo
