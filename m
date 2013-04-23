Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Apr 2013 20:31:38 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_get_cmd_complete() can be static
Message-ID: <20130423233138.GC1697@joana>
References: <1366464271-3067-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366464271-3067-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2013-04-20 16:24:31 +0300]:

> From: Fengguang Wu <fengguang.wu@intel.com>
> 
> There are new sparse warnings show up in
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next master
> head:   a0b644b0385fa58ca578f6dce4473e8a8e6f6c38
> commit: 75e84b7c522c6e07964cd1f5bf28535768a1e9fa Bluetooth: Add __hci_cmd_sync() helper function
> date:   13 days ago
> 
> >> net/bluetooth/hci_core.c:82:16: sparse: symbol 'hci_get_cmd_complete' was not declared. Should it be static?
> 
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> Acked-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_core.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
