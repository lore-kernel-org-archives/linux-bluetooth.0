Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Nov 2013 10:45:57 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 03/16] android/socket: Add connect signal to socket
Message-ID: <20131118084557.GA30170@x220.p-661hnu-f1>
References: <1384763179-2218-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1384763179-2218-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384763179-2218-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Nov 18, 2013, Andrei Emeltchenko wrote:
> Connect signal is used to pass information to framework that socket
> is accepted.
> ---
>  android/hal-msg.h |    2 ++
>  android/socket.h  |    7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index 44fd5c8..9e3a81f 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -232,6 +232,8 @@ struct hal_cmd_sock_connect {
>  	uint8_t  flags;
>  } __attribute__((packed));
>  
> +/* Bluetooth Hidhost HAL api */
> +

This part seems unrelated to this patch?

Johan
