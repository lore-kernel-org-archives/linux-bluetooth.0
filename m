Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 0/3] Fix L2CAP command reject PDUs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381910801-3130-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 16 Oct 2013 10:16:57 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5E3135CB-20AF-4625-87E2-0D2407F740A9@holtmann.org>
References: <1381910801-3130-1-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The L2CAP command reject PDU is required to have some extra data for
> "invalid MTU" and "invalid CID" cases. These patches fixes the code to
> always return the right kind of PDU.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (3):
>      Bluetooth: Fix L2CAP "Command Reject: Invalid CID" response
>      Bluetooth: Remove unused command reject mapping for EMSGSIZE
>      Bluetooth: Remove useless l2cap_err_to_reason function
> 
> net/bluetooth/l2cap_core.c | 54 +++++++++++++++++++++------------------------
> 1 file changed, 25 insertions(+), 29 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

