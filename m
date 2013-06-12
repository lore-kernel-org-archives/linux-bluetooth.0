Return-Path: <cyrus@holtmann.org>
Date: Wed, 12 Jun 2013 10:34:40 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org
Subject: Re: [PATCH] lib: Fix two size constants
Message-ID: <20130612073401.GE19392@aemeltch-MOBL1>
References: <1370985402-27535-1-git-send-email-deymo@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370985402-27535-1-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Tue, Jun 11, 2013 at 02:16:42PM -0700, Alex Deymo wrote:
> Fixes the value of RESET_FAILED_CONTACT_COUNTER_RP_SIZE and
> RESET_FAILED_CONTACT_COUNTER_RP_SIZE macros to respect the
> associated struct.
> ---
> 
> Hi! I was playing with the libbluetooth and found these two constants
> wrongly defined. I actually checked with the Core spec that the structs
> are fine... but I still have a very very naive question:
> 
> Why don't you use sizeof(some_struct) and be happy???

This sounds very reasonable! I could not understand this myself.

Best regards 
Andrei Emeltchenko 

> 
> Thanks!
> Alex.
> 
>  lib/hci.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/hci.h b/lib/hci.h
> index 56c9316..898cf52 100644
> --- a/lib/hci.h
> +++ b/lib/hci.h
> @@ -1350,7 +1350,7 @@ typedef struct {
>  	uint8_t		status;
>  	uint16_t	handle;
>  } __attribute__ ((packed)) reset_failed_contact_counter_rp;
> -#define RESET_FAILED_CONTACT_COUNTER_RP_SIZE 4
> +#define RESET_FAILED_CONTACT_COUNTER_RP_SIZE 3
>  
>  #define OCF_READ_LINK_QUALITY		0x0003
>  typedef struct {
> @@ -1764,7 +1764,7 @@ typedef struct {
>  	uint16_t	handle;
>  	uint8_t		encrypt;
>  } __attribute__ ((packed)) evt_encrypt_change;
> -#define EVT_ENCRYPT_CHANGE_SIZE 5
> +#define EVT_ENCRYPT_CHANGE_SIZE 4
>  
>  #define EVT_CHANGE_CONN_LINK_KEY_COMPLETE	0x09
>  typedef struct {
> -- 
> 1.8.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
