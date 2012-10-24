Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Oct 2012 00:47:21 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/5] Bluetooth: Replace include linux/module.h with
 linux/export.h
Message-ID: <20121024024721.GC13884@joana>
References: <1350999140-7481-1-git-send-email-s.syam@samsung.com>
 <1350999140-7481-3-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350999140-7481-3-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

* Syam Sidhardhan <s.syam@samsung.com> [2012-10-23 19:02:18 +0530]:

> include <linux/export.h> is the right to go here.
> 
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
>  net/bluetooth/cmtp/capi.c |    2 +-
>  net/bluetooth/cmtp/sock.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
