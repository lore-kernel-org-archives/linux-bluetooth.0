Return-Path: <cyrus@holtmann.org>
Message-ID: <1323966479.1965.81.camel@aeonflux>
Subject: Re: [PATCH] Correct structures for AMP Assoc Read
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 15 Dec 2011 17:27:59 +0100
In-Reply-To: <1323942483-24779-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1323942483-24779-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Make struct names similar to kernel and remove static array since
> fragment length can be other size than HCI_MAX_NAME_LENGTH, which
> is for totally different purpose.
> ---
>  lib/hci.h |   11 +++++------
>  1 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/hci.h b/lib/hci.h
> index 51184ee..48692fa 100644
> --- a/lib/hci.h
> +++ b/lib/hci.h
> @@ -1382,17 +1382,16 @@ typedef struct {
>  #define OCF_READ_LOCAL_AMP_ASSOC	0x000A
>  typedef struct {
>  	uint8_t		handle;
> -	uint16_t	length_so_far;
> -	uint16_t	assoc_length;
> +	uint16_t	len_so_far;
> +	uint16_t	max_len;
>  } __attribute__ ((packed)) read_local_amp_assoc_cp;
> -#define READ_LOCAL_AMP_ASSOC_CP_SIZE 5
> +
>  typedef struct {
>  	uint8_t		status;
>  	uint8_t		handle;
> -	uint16_t	length;
> -	uint8_t		fragment[HCI_MAX_NAME_LENGTH];
> +	uint16_t	rem_len;
> +	uint8_t		frag[0];
>  } __attribute__ ((packed)) read_local_amp_assoc_rp;
> -#define READ_LOCAL_AMP_ASSOC_RP_SIZE 252
>  
>  #define OCF_WRITE_REMOTE_AMP_ASSOC	0x000B
>  typedef struct {

I am fine with these changes.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


