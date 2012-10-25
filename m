Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Oct 2012 13:08:19 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/6] Bluetooth: Fix unnecessary EIR update during
 powering on
Message-ID: <20121025150819.GB1764@joana>
References: <1351112996-9597-1-git-send-email-johan.hedberg@gmail.com>
 <1351112996-9597-5-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1351112996-9597-5-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2012-10-25 00:09:54 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> When powered on the EIR data gets updated as the last step by mgmt.
> Therefore avoid an update when getting a local name update as that's
> part of the normal HCI init sequence.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Patch 1, 2 and 4 have been applied to bluetooth-next. Thanks.

	Gustavo
