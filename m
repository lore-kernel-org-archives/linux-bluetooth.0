Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Bluetooth: Set auth method to just works for no mitm and
 displayonly
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180216133007.5224-1-grzegorz.kolodziejczyk@codecoup.pl>
Date: Fri, 16 Feb 2018 16:54:21 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <97C7B48A-90EF-4327-8327-79F62358592F@holtmann.org>
References: <20180216133007.5224-1-grzegorz.kolodziejczyk@codecoup.pl>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

> Don't bother user space with no input capabilities with confirmation
> request.
> 
>> ACL Data RX: Handle 3585 flags 0x02 dlen 11
>      SMP: Pairing Request (0x01) len 6
>        IO capability: KeyboardDisplay (0x04)
>        OOB data: Authentication data not present (0x00)
>        Authentication requirement: Bonding, No MITM, Legacy, No Keypresses (0x01)
>        Max encryption key size: 16
>        Initiator key distribution: EncKey IdKey Sign (0x07)
>        Responder key distribution: EncKey IdKey Sign (0x07)
>> HCI Event: LE Meta Event (0x3e) plen 12
>      LE Read Remote Used Features (0x04)
>        Status: Unsupported Remote Feature / Unsupported LMP Feature (0x1a)
>        Handle: 3585
>        Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> < ACL Data TX: Handle 3585 flags 0x00 dlen 16
>        LE L2CAP: Connection Parameter Update Request (0x12) ident 1 len 8
>        Min interval: 24
>        Max interval: 40
>        Slave latency: 0
>        Timeout multiplier: 2000
> @ MGMT Event: User Confirmation Request (0x000f) plen 12
>        LE Address: 4E:29:AB:D8:25:39 (Resolvable)
>        Confirm hint: 0x01
>        Value: 0x00000000
> < ACL Data TX: Handle 3585 flags 0x00 dlen 11
>      SMP: Pairing Response (0x02) len 6
>        IO capability: DisplayOnly (0x00)
>        OOB data: Authentication data not present (0x00)
>        Authentication requirement: Bonding, No MITM, Legacy, No Keypresses (0x01)
>        Max encryption key size: 16
>        Initiator key distribution: EncKey IdKey Sign (0x07)
>        Responder key distribution: EncKey Sign (0x05)
> 
> Signed-off-by: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
> ---
> net/bluetooth/smp.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index ede1a68098f1..cac56153b7b5 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -893,7 +893,8 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
> 
> 	/* Don't bother user space with no IO capabilities */
> 	if (smp->method == JUST_CFM &&
> -	    hcon->io_capability == HCI_IO_NO_INPUT_OUTPUT)
> +	    (hcon->io_capability == HCI_IO_NO_INPUT_OUTPUT ||
> +	    hcon->io_capability == HCI_IO_DISPLAY_ONLY))
> 		smp->method = JUST_WORKS;

I leave this up to Johan to decide if this is our desired behavior or not, but if we go ahead with that, then the comment above also needs changing. And it also needs to be a more elaborate comment explaining the reasoning.

Regards

Marcel

