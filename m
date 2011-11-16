Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Nov 2011 15:16:29 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Add public/random LE address information
 to mgmt messages
Message-ID: <20111116171629.GA16865@joana>
References: <1320839938-24873-1-git-send-email-johan.hedberg@gmail.com>
 <1320839938-24873-3-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320839938-24873-3-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-11-09 13:58:58 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> It's necessary to know the distinction between public and random LE
> addresses so the mgmt interface also needs to distinguish between them.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |   14 ++++++++------
>  include/net/bluetooth/mgmt.h     |    4 ++--
>  net/bluetooth/hci_event.c        |   21 ++++++++++++---------
>  net/bluetooth/mgmt.c             |   35 ++++++++++++++++++++++-------------
>  4 files changed, 44 insertions(+), 30 deletions(-)

This patch doesn't apply anymore, please rebase.

	Gustavo
