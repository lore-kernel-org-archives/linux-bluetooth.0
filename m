Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Jun 2012 03:10:09 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Vishal Agarwal <vishal.agarwal@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org, naresh.gupta@stericsson.com
Subject: Re: [PATCH v2] Bluetooth: Fix LE pairing completion on connection
 failure
Message-ID: <20120608061009.GC1546@joana>
References: <1339081055-23726-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339081055-23726-1-git-send-email-vishal.agarwal@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishal,

* Vishal Agarwal <vishal.agarwal@stericsson.com> [2012-06-07 20:27:35 +0530]:

> For BR/EDR pairing is assumed to be finished when connection is
> done. For LE if connection is successful it did not necessarily
> mean that pairing is also done but if the connection is unsuccessful
> it should be assumed that pairing procedure is also finished.
> This patch registers a new function with connect_cfm_cb callback for
> LE link which sends the pairing complete signal to user space if
> connection is unsuccessful.
> 
> Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
> ---
>  net/bluetooth/mgmt.c |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)

Patch has been applied to bluetooth.git. Thanks.

	Gustavo
