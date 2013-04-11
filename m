Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Apr 2013 16:37:42 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use GFP_KERNEL in sco_conn_add
Message-ID: <20130411193742.GC28775@joana>
References: <1365690946-28050-1-git-send-email-claudio.takahasi@openbossa.org>
 <1365690946-28050-4-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365690946-28050-4-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

* Claudio Takahasi <claudio.takahasi@openbossa.org> [2013-04-11 11:35:45 -0300]:

> This patch changes the memory allocation flags in the sco_conn_add
> function, replacing the type to GFP_KERNEL. This function is executed
> in process context and it is not called inside an atomic section.
> 
> Signed-off-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
> ---
>  net/bluetooth/sco.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
