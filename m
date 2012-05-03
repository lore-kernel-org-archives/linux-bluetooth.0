Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 May 2012 03:06:35 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v1 2/5] Bluetooth: Remove unused hci_le_ltk_neg_reply()
Message-ID: <20120503060635.GG16030@joana>
References: <1334940151-9519-1-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334940151-9519-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

* Syam Sidhardhan <s.syam@samsung.com> [2012-04-20 22:12:31 +0530]:

> No one is using hci_le_ltk_neg_reply() in bluetooth subsystem.
> 
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
>  include/net/bluetooth/hci_core.h |    2 --
>  net/bluetooth/hci_conn.c         |   14 --------------
>  2 files changed, 0 insertions(+), 16 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
