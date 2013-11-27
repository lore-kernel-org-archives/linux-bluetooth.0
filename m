Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Nov 2013 12:52:49 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 6/6] android: Do not dereference possible NULL pointer
Message-ID: <20131127105249.GA16389@x220.p-661hnu-f1>
References: <1385474750-18331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1385474750-18331-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385474750-18331-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Nov 26, 2013, Andrei Emeltchenko wrote:
> eir might be NULL, do not derefernce it in debug and print instead
> pointer.
> ---
>  android/bluetooth.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index aa684bd..77ce519 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -916,8 +916,8 @@ static void mgmt_device_found_event(uint16_t index, uint16_t length,
>  	flags = btohl(ev->flags);
>  
>  	ba2str(&ev->addr.bdaddr, addr);
> -	DBG("hci%u addr %s, rssi %d flags 0x%04x eir_len %u eir %u",
> -				index, addr, ev->rssi, flags, eir_len, *eir);
> +	DBG("hci%u addr %s, rssi %d flags 0x%04x eir_len %u eir %p",
> +				index, addr, ev->rssi, flags, eir_len, eir);
>  
>  	confirm_name = flags & MGMT_DEV_FOUND_CONFIRM_NAME;

I'd just remove printing the eir pointer value completely since it
doesn't really give us anything. Since this is such a trivial thing I
pushed a patch to fix this myself.

Johan
