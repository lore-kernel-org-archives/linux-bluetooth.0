Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Aug 2012 14:29:47 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, jaganath.k@samsung.com
Subject: Re: [PATCH] Bluetooth: debug: Correct the PSM printing
Message-ID: <20120821172947.GA17005@joana>
References: <1343413282-8901-1-git-send-email-s.syam@samsung.com>
 <1343413282-8901-2-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343413282-8901-2-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

* Syam Sidhardhan <s.syam@samsung.com> [2012-07-27 23:51:22 +0530]:

> Earlier we were printing chan->psm before assigning any value.
> 
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
>  net/bluetooth/l2cap_core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
