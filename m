Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 May 2012 11:58:30 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] Bluetooth: Remove unused hci_le_ltk_reply()
Message-ID: <20120502145830.GA16030@joana>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
 <1334243001-17016-27-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334243001-17016-27-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

* Syam Sidhardhan <s.syam@samsung.com> [2012-04-12 20:33:17 +0530]:

> In this API, we were using sizeof operator for an array
> given as function argument, which is invalid.
> However this API is not used anywhere.
> 
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 -
>  net/bluetooth/hci_conn.c         |   16 ----------------
>  2 files changed, 0 insertions(+), 17 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
