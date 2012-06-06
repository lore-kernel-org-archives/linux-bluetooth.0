Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Jun 2012 16:21:21 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vishal Agarwal <vishal.agarwal@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: LE pairing is finished if error in connection
Message-ID: <20120606082121.GA12117@x220>
References: <1338956756-18699-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338956756-18699-1-git-send-email-vishal.agarwal@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishal,

On Wed, Jun 06, 2012, Vishal Agarwal wrote:
> For BR/EDR pairing is assumed to be finished when connection is
> done. For LE if connection is successful it did not necessarily
> mean that pairing is also done but if the connection is unsuccessful
> it should be assumed that pairing procedure is also finished.
> This patch registers a newfunction with connect_cfm_cb callback for
> LE link which sends the pairing complete signal to user space if
> connection is unsuccessful.
> 
> Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
> ---
>  net/bluetooth/mgmt.c |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)

The patch looks ok'ish to me but I'd at least change the commit message
summary line into the form "Fix LE pairing completion with connection
failure" (or something similar) to make it clear that this is a fix and
something that needs to go to 3.5.

Johan
