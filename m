Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Apr 2013 16:43:48 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: Remove unneeded parameter
Message-ID: <20130411194348.GF28775@joana>
References: <1365690946-28050-3-git-send-email-claudio.takahasi@openbossa.org>
 <1365699350-22314-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365699350-22314-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

* Claudio Takahasi <claudio.takahasi@openbossa.org> [2013-04-11 13:55:50 -0300]:

> This patch removes the status parameter of the l2cap_conn_add function.
> The parameter 'status' is always 0.
> 
> Signed-off-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
> ---
>  net/bluetooth/l2cap_core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
