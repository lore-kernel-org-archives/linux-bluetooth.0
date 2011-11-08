Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Nov 2011 13:10:44 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Add address type fields to mgmt messages
 that need them
Message-ID: <20111108151044.GC25584@joana>
References: <1320700419-4665-1-git-send-email-johan.hedberg@gmail.com>
 <1320700419-4665-3-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320700419-4665-3-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-11-07 23:13:39 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> This patch adds address type info (typically BR/EDR vs LE) to management
> messages that need this. This also ensures conformance to the latest
> management API specification.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |   10 ++++----
>  include/net/bluetooth/mgmt.h     |   23 ++++++++++--------
>  net/bluetooth/hci_event.c        |   20 +++++++++-------
>  net/bluetooth/mgmt.c             |   47 ++++++++++++++++++++++++++++---------
>  4 files changed, 64 insertions(+), 36 deletions(-)

All three patches were applied, thanks.

	Gustavo
