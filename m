Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 Dec 2011 21:08:14 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/7 v2] Bluetooth: Add timer for automatically disabling
 the service cache
Message-ID: <20111215000814.GA22803@samus>
References: <1323902861-15990-1-git-send-email-johan.hedberg@gmail.com>
 <1323902861-15990-6-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323902861-15990-6-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 00:47 Thu 15 Dec, johan.hedberg@gmail.com wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> We do not want the service cache to be enabled indefinitely after
> mgmt_read_info is called. The solve this a timer is added which will

Minor nitpick: "To solve this".

> automatically disable the cache if mgmt_set_dev_class isn't called
> within 5 seconds of calling mgmt_read_info.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>

Cheers,
-- 
Vinicius
