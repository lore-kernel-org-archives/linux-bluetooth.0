Return-Path: <cyrus@holtmann.org>
Message-ID: <1350667030.1785.0.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Fix having bogus entries in
 mgmt_read_index_list reply
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 19 Oct 2012 10:17:10 -0700
In-Reply-To: <1350666646-6276-1-git-send-email-johan.hedberg@gmail.com>
References: <1350666646-6276-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The mgmt_read_index_list uses one loop to calculate the max needed size
> of its response with the help of an upper-bound of the controller count.
> The second loop is more strict as it checks for HCI_SETUP (which might
> have gotten set after the first loop) and could result in some indexes
> being skipped. Because of this the function needs to readjust the event
> length and index count after filling in the response array.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Cc: stable@vger.kernel.org
> ---
>  net/bluetooth/mgmt.c |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


