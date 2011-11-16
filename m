Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Nov 2011 16:23:34 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Add missing cmd_complete for
 mgmt_load_link_keys
Message-ID: <20111116182333.GG16865@joana>
References: <1321021134-31809-1-git-send-email-johan.hedberg@gmail.com>
 <1321021134-31809-3-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321021134-31809-3-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-11-11 16:18:54 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> The command complete event was completely missing for this command.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Patches 1 and 3 are applied. thanks.

	Gustavo
