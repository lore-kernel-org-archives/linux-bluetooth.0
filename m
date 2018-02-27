Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Bluetooth: Fix missing encryption refresh on Security
 Request
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180226144153.3727-1-szymon.janc@codecoup.pl>
Date: Tue, 27 Feb 2018 13:45:59 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1E47A294-32B6-4825-8B30-27E0AB567C59@holtmann.org>
References: <20180226144153.3727-1-szymon.janc@codecoup.pl>
To: Szymon Janc <szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> If Security Request is received on connection that is already encrypted
> with sufficient security master should perform encryption key refresh
> procedure instead of just ignoring Slave Security Request
> (Core Spec 5.0 Vol 3 Part H 2.4.6).
> 
>> ACL Data RX: Handle 3585 flags 0x02 dlen 6
>      SMP: Security Request (0x0b) len 1
>        Authentication requirement: Bonding, No MITM, SC, No Keypresses (0x09)
> < HCI Command: LE Start Encryption (0x08|0x0019) plen 28
>        Handle: 3585
>        Random number: 0x0000000000000000
>        Encrypted diversifier: 0x0000
>        Long term key: 44264272a5c426a9e868f034cf0e69f3
>> HCI Event: Command Status (0x0f) plen 4
>      LE Start Encryption (0x08|0x0019) ncmd 1
>        Status: Success (0x00)
>> HCI Event: Encryption Key Refresh Complete (0x30) plen 3
>        Status: Success (0x00)
>        Handle: 3585
> 
> Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
> ---
> net/bluetooth/smp.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

