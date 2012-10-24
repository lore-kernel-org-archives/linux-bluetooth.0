Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Oct 2012 11:04:17 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix having bogus entries in
 mgmt_read_index_list reply
Message-ID: <20121024130417.GF13884@joana>
References: <1350666646-6276-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350666646-6276-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2012-10-19 20:10:46 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
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

Patch has been applied to bluetooth.git. Thanks.

	Gustavo
