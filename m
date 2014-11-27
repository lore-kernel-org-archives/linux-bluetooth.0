Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1416912448-28177-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1416912448-28177-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Thu, 27 Nov 2014 21:04:38 +0100
Message-ID: <CAN_7+YY4gt8j2k+1duo8oDaCQfYrD+h=4npTE_yfmSpmUK+76w@mail.gmail.com>
Subject: Re: [PATCH 0/5] android/handsfree-client: Add SCO to HFP HF
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Nov 25, 2014 at 11:47 AM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> Last missing piece to HFP HF implementation.
>
> Lukasz Rymanowski (5):
>   android/handsfree-client: Add SCO to handsfree client
>   android/handsfree-client: Add handle incoming SCO connection
>   android/handsfree-client: Implement audio connect/disconnect
>   android/handsfree-client: Send AT+BCC to start codec negotiation
>   android/README: Update status of HAL HFP HF implementation
>

ping

>  android/README             |   2 +-
>  android/handsfree-client.c | 203 ++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 182 insertions(+), 23 deletions(-)
>
> --
> 1.8.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
