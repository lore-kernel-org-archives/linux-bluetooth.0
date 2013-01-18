Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Jan 2013 03:07:25 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/4] Bluetooth: Fix using system-global workqueue when
 not necessary
Message-ID: <20130118050725.GA13059@joana>
References: <1358195633-29303-1-git-send-email-johan.hedberg@gmail.com>
 <1358195633-29303-4-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1358195633-29303-4-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2013-01-14 22:33:52 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> There's a per-HCI device workqueue (hdev->workqueue) that should be used
> for general per-HCI device work (except hdev->req_workqueue that's for
> hci_request() related work). This patch fixes places using the
> system-global work queue and makes them use the hdev->workqueue instead.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_core.c |    4 ++--
>  net/bluetooth/mgmt.c     |    3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)

Patches 1 to 3 have been applied to bluetooth-next. Thanks.

	Gustavo
