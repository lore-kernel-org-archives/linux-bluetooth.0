Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Oct 2012 14:27:07 +0800
From: Gustavo Padovan <gustavo@padovan.org>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/4] Bluetooth: Use __constant modifier for RFCOMM PSM
Message-ID: <20121011062707.GB15051@joana>
References: <1349887169-20880-1-git-send-email-s.syam@samsung.com>
 <1349887169-20880-4-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349887169-20880-4-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

* Syam Sidhardhan <s.syam@samsung.com> [2012-10-10 22:09:29 +0530]:

> Since the RFCOMM_PSM is constant, __constant_cpu_to_le16() is
> the right go here.
> 
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
>  net/bluetooth/rfcomm/core.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch 3 and 4 have been applied to bluetooth-next. Thanks.

	Gustavo
