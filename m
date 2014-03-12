Return-Path: <cyrus@holtmann.org>
Date: Wed, 12 Mar 2014 13:22:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 01/10] emulator: Minor style fix
Message-ID: <20140312112215.GA7489@localhost.P-661HNU-F1>
References: <1394406363-6751-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1394406363-6751-2-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394406363-6751-2-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Mon, Mar 10, 2014, Lukasz Rymanowski wrote:
> ---
>  emulator/btdev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index b54f91e..2cf8f89 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -709,8 +709,8 @@ static void inquiry_complete(struct btdev *btdev, uint8_t status)
>  			ir.rssi = -60;
>  			memcpy(ir.data, btdev_list[i]->ext_inquiry_rsp, 240);
>  
> -			send_event(btdev, BT_HCI_EVT_EXT_INQUIRY_RESULT,
> -							&ir, sizeof(ir));
> +			send_event(btdev, BT_HCI_EVT_EXT_INQUIRY_RESULT, &ir,
> +								sizeof(ir));
>  			continue;
>  		}
>  
> @@ -738,8 +738,8 @@ static void inquiry_complete(struct btdev *btdev, uint8_t status)
>  			memcpy(ir.dev_class, btdev_list[i]->dev_class, 3);
>  			ir.clock_offset = 0x0000;
>  
> -			send_event(btdev, BT_HCI_EVT_INQUIRY_RESULT,
> -							&ir, sizeof(ir));
> +			send_event(btdev, BT_HCI_EVT_INQUIRY_RESULT, &ir,
> +								sizeof(ir));
>  		}
>          }

I wouldn't bother with this one. The reason these two variables have
been put on the same line is that they are tightly related to each
other.

Johan
