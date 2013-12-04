Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Dec 2013 14:14:31 -0200
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 10/31] Bluetooth: Refactor L2CAP connect rejection to its
 own function
Message-ID: <20131204161431.GA2210@molly.amr.corp.intel.com>
References: <1386166287-13693-1-git-send-email-johan.hedberg@gmail.com>
 <1386166287-13693-11-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386166287-13693-11-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 16:11 Wed 04 Dec, Johan Hedberg wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> We'll need to have a separate code patch for LE based connection

Nitpick: 'path' instead of 'patch'.

> rejection so it's cleaner to move out the response construction code
> into its own function (and later a second one for LE).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>

Cheers,
-- 
Vinicius
