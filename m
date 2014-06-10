Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: Fix SSP acceptor just-works confirmation without MITM
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1402311494-28906-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 10 Jun 2014 11:15:56 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3EFCCB2B-F907-402D-B9F6-182985C7D3AC@holtmann.org>
References: <1402311494-28906-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> From the Bluetooth Core Specification 4.1 page 1958:
> 
> "if both devices have set the Authentication_Requirements parameter to
> one of the MITM Protection Not Required options, authentication stage 1
> shall function as if both devices set their IO capabilities to
> DisplayOnly (e.g., Numeric comparison with automatic confirmation on
> both devices)"
> 
> So far our implementation has done user confirmation for all just-works
> cases regardless of the MITM requirements, however following the
> specification to the word means that we should not be doing confirmation
> when neither side has the MITM flag set.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

