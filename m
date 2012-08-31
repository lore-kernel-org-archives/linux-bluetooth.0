Return-Path: <cyrus@holtmann.org>
Date: Fri, 31 Aug 2012 10:54:58 -0700
From: Gustavo Padovan <gustavo@padovan.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use GFP_KERNEL in read_index_list
Message-ID: <20120831175458.GA5599@joana>
References: <1346396746-3479-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346396746-3479-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

* Szymon Janc <szymon.janc@tieto.com> [2012-08-31 09:05:46 +0200]:

> read_index_list is executed by user thread running in kernel-mode
> thus is allowed to sleep.
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/mgmt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
