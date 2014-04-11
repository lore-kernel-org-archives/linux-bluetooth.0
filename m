Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 1/2] Bluetooth: Fix triggering BR/EDR L2CAP Connect too early
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1397242952-3997-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 11 Apr 2014 14:38:12 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5F85C81E-F98E-4E0E-B731-CEDD2980A339@holtmann.org>
References: <1397242952-3997-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Commit 1c2e004183178 introduced an event handler for the encryption key
> refresh complete event with the intent of fixing some LE/SMP cases.
> However, this event is shared with BR/EDR and there we actually want to
> act only on the auth_complete event (which comes after the key refresh).
> 
> If we do not do this we may trigger an L2CAP Connect Request too early
> and cause the remote side to return a security block error.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 6 ++++++
> 1 file changed, 6 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

