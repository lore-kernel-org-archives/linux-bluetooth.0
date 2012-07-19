Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Jul 2012 13:23:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: mgmt: Fix possible NULL dereference
Message-ID: <20120719102306.GA15933@x220>
References: <1342691392-4006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342691392-4006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Jul 19, 2012, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> hdev might be dereferenced in handler->func functions.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/mgmt.c |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 2a0f695..48a83c9 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2801,14 +2801,15 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
>  		goto done;
>  	}
>  
> -	if (hdev)
> +	if (hdev) {
>  		mgmt_init_hdev(sk, hdev);
>  
> -	cp = buf + sizeof(*hdr);
> +		cp = buf + sizeof(*hdr);
>  
> -	err = handler->func(sk, hdev, cp, len);
> -	if (err < 0)
> -		goto done;
> +		err = handler->func(sk, hdev, cp, len);
> +		if (err < 0)
> +			goto done;
> +	}
>  
>  	err = msglen;

Nack.

hdev is supposed to be NULL for some of the commands/handlers
(read_version, read_index_list, etc). With your change these mgmt
commands couldn't be called anymore. There's also a check for this
higher up in the mgmt_control function to ensure that hdev is not NULL
for other handlers:

        if ((hdev && opcode < MGMT_OP_READ_INFO) ||
                        (!hdev && opcode >= MGMT_OP_READ_INFO)) {
                err = cmd_status(sk, index, opcode,
                                 MGMT_STATUS_INVALID_INDEX);
                goto done;
        }

Johan
