Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 0/3] Bluetooth: Security related fixes for SMP
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1402999659-4969-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 17 Jun 2014 12:25:10 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <27135E5F-6950-4BD4-BDB0-86E9BB61A523@holtmann.org>
References: <1402999659-4969-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Here's a set of patches to fix handling of MITM requirement and the
> pending_sec_level value for hci_conn.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (3):
>      Bluetooth: Fix overriding higher security level in SMP
>      Bluetooth: Refactor authentication method lookup into its own function
>      Bluetooth: Fix rejecting pairing in case of insufficient capabilities
> 
> net/bluetooth/smp.c | 60 +++++++++++++++++++++++++++++++++++++++------------
> 1 file changed, 46 insertions(+), 14 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

