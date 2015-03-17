Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] Bluetooth: Add workaround for broken OS X legacy SMP pairing
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426440844-11908-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 17 Mar 2015 11:00:24 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <AA12CC10-9528-4287-988A-2796FA64A7F6@holtmann.org>
References: <1426440844-11908-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> OS X version 10.10.2 (and possibly older versions) doesn't support LE
> Secure Connections but incorrectly copies all authentication request
> bits from a Security Request to its Pairing Request. The result is that
> an SC capable initiator (such as BlueZ) will think OS X intends to do SC
> when in fact it's incapable of it:
> 
> < ACL Data TX: Handle 3585 flags 0x00 dlen 6
>      SMP: Security Request (0x0b) len 1
>        Authentication requirement: Bonding, No MITM, SC, No Keypresses (0x09)
>> ACL Data RX: Handle 3585 flags 0x02 dlen 11
>      SMP: Pairing Request (0x01) len 6
>        IO capability: KeyboardDisplay (0x04)
>        OOB data: Authentication data not present (0x00)
>        Authentication requirement: Bonding, No MITM, SC, No Keypresses (0x09)
>        Max encryption key size: 16
>        Initiator key distribution: EncKey (0x01)
>        Responder key distribution: EncKey IdKey Sign (0x07)
> < ACL Data TX: Handle 3585 flags 0x00 dlen 11
>      SMP: Pairing Response (0x02) len 6
>        IO capability: NoInputNoOutput (0x03)
>        OOB data: Authentication data not present (0x00)
>        Authentication requirement: Bonding, No MITM, SC, No Keypresses (0x09)
>        Max encryption key size: 16
>        Initiator key distribution: EncKey (0x01)
>        Responder key distribution: EncKey Sign (0x05)
> 
> The pairing eventually fails when we get an unexpected Pairing Confirm
> PDU instead of a Public Key PDU:
> 
>> ACL Data RX: Handle 3585 flags 0x02 dlen 21
>      SMP: Pairing Confirm (0x03) len 16
>        Confim value: bcc3bed31b8f313a78ec3cce32685faf
> 
> It is only at this point that we can speculate that the remote doesn't
> really support SC. This patch creates a workaround for the just-works
> model, however the MITM case is unsolvable because the OS X user has
> already been requested to enter a PIN which we're now expected to
> randomly generate and show the user (i.e. a chicken-and-egg problem).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++------
> 1 file changed, 67 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

