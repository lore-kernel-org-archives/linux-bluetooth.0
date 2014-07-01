Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC] Bluetooth: Fallback to SCO on error code 0x10 (Connection Accept Timeout).
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404107701-19096-1-git-send-email-kiran.kumar@linaro.org>
Date: Tue, 1 Jul 2014 11:47:53 +0200
Cc: linux-bluetooth@vger.kernel.org, Nick Pelly <npelly@google.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	John Stultz <john.stultz@linaro.org>
Message-Id: <BDFDBD3E-14F8-4716-9781-CC2B3EF0F030@holtmann.org>
References: <1404107701-19096-1-git-send-email-kiran.kumar@linaro.org>
To: Kiran Kumar Raparthy <kiran.kumar@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kiran,

> Fallback to SCO on error code 0x10 (Connection Accept Timeout).

no need to duplicate the subject line here.

> This is to support the Motorola HF850 carkit which reports the error code 0x10
> for an eSCO attempt, even though it advertises eSCO support.
> 
> With this patch we will retry with a SCO connection, which succeeds.
> 
> This is one of the number of patches from the Android AOSP common.git tree,
> which is used on almost all Android devices.  I wanted to submit it for review
> to see if it should go upstream.

such comments for the reviews belong after the diffstat.

> 
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Nick Pelly <npelly@google.com>
> [kiran: Added context to commit message]
> Signed-off-by: Kiran Kumar Raparthy <kiran.kumar@linaro.org>

I said this before and let me repeat this, please only submit this to linux-bluetooth mailing list. There is no point in spamming LKML or netdev since nobody there will actually review your patch.

> ---
> net/bluetooth/hci_event.c | 1 +
> 1 file changed, 1 insertion(+)

Patch has been applied to bluetooth-next tree.

Regards

Marcel

