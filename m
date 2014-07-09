Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 0/3] Bluetooth: SMP fixes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404922691-3881-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 9 Jul 2014 18:25:14 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0773145D-E504-4D3F-BB29-89661452BCFF@holtmann.org>
References: <1404922691-3881-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Here's a set of patches I ended up creating when testing HoG
> reconnections. Now that we react to any direct advertising report when
> connectable it's particularly important that we have the user
> interaction semantics for incoming connections right.
> 
> Strictly speaking the Core spec simply tells us to use "just-works" when
> no side has MITM required, so these changes should be checked against
> current PTS and Android CTS tests. That said, imo this is still doing a
> just-works pairing but simply with an extra user consent for proceeding
> with the pairing for incoming requests.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (3):
>      Bluetooth: Always confirm incoming SMP just-works requests
>      Bluetooth: Fix forcing SMP just-works with no-bonding
>      Bluetooth: Fix incorrect clearing of SMP_FLAG_INITIATOR
> 
> net/bluetooth/smp.c | 24 +++++++++++-------------
> 1 file changed, 11 insertions(+), 13 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

