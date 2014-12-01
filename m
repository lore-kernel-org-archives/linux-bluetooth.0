Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/5] android/handsfree-client: Add SCO to HFP HF
Date: Mon, 01 Dec 2014 17:14:21 +0100
Message-ID: <5259636.IplPokWT28@uw000953>
In-Reply-To: <1417167445-29099-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1417167445-29099-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Friday 28 of November 2014 10:37:20 Lukasz Rymanowski wrote:
> Last missing piece to HFP HF implementation.
> 
> v2:
> * Handled Szymon comments
> * rebase and minor self review fixes in 2/5
> 
> Lukasz Rymanowski (5):
>   android/handsfree-client: Add SCO to handsfree client
>   android/handsfree-client: Add handle incoming SCO connection
>   android/handsfree-client: Implement audio connect/disconnect
>   android/handsfree-client: Send AT+BCC to start codec negotiation
>   android/README: Update status of HAL HFP HF implementation
> 
>  android/README             |   2 +-
>  android/handsfree-client.c | 191 ++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 180 insertions(+), 13 deletions(-)

All patches applied, thanks.

-- 
Best regards, 
Szymon Janc
