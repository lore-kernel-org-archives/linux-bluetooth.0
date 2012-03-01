Return-Path: <cyrus@holtmann.org>
Date: Thu, 1 Mar 2012 00:57:57 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] Bluetooth: mgmt: Add missing hci_dev locking to
 set_le()
Message-ID: <20120301035757.GB19829@joana>
References: <1330574135-5889-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330574135-5889-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2012-02-29 19:55:35 -0800]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> The set_le() function was missing hci_dev locking which is e.g. critical
> for the mgmt pending command adding/removing.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   17 ++++++++++-------
>  1 files changed, 10 insertions(+), 7 deletions(-)

Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

	Gustavo
