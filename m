Return-Path: <cyrus@holtmann.org>
Date: Thu, 23 Feb 2012 12:53:06 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: mgmt: Fix return value of add/remove_uuid
Message-ID: <20120223145306.GB2972@joana>
References: <1330005781-8185-1-git-send-email-johan.hedberg@gmail.com>
 <1330005781-8185-2-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330005781-8185-2-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2012-02-23 16:03:01 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> The Add/Remove UUID commands should return the device class instead of
> an empty parameter list.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)

Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

	Gustavo
