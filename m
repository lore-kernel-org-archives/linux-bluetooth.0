Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Jun 2012 13:46:34 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vishal Agarwal <vishal.agarwal@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org, naresh.gupta@stericsson.com
Subject: Re: [PATCH v2] Bluetooth: Fix LE pairing completion on connection
 failure
Message-ID: <20120608054634.GA18165@x220>
References: <1339081055-23726-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339081055-23726-1-git-send-email-vishal.agarwal@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jun 07, 2012, Vishal Agarwal wrote:
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

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Note to Gustavo: this is one of the patches that should go to
bluetooth.git as it's important that any known LE bugs get fixed for
3.5.

Johan
