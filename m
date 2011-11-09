Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Nov 2011 12:38:31 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Bluetooth: Remove redundant hci_dev comparisons in
 mgmt lookups
Message-ID: <20111109143831.GI25584@joana>
References: <1320839938-24873-1-git-send-email-johan.hedberg@gmail.com>
 <1320839938-24873-2-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320839938-24873-2-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-11-09 13:58:57 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> Now that pending commands are hci_dev specific there's no need to check
> whether a command matches hci_dev when iterating through them.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   15 ++-------------
>  1 files changed, 2 insertions(+), 13 deletions(-)

Patch 1 and 2 were applied, thanks. 
I'll leave patch 3 here for more one or two days in case someone has a comment
to do. It's fine with me btw.

	Gustavo
