Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/6] android/handsfree-client: Implement events skeleton
Date: Tue, 23 Sep 2014 16:12:35 +0200
Message-ID: <4661897.JSDFMGLL5d@uw000953>
In-Reply-To: <1411137051-28904-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1411137051-28904-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Friday 19 of September 2014 16:30:45 Lukasz Rymanowski wrote:
> This set adds missing events for handsfree client ipc.
> It also contains some fixes based on Luiz comments
> 
> Lukasz Rymanowski (6):
>   android/hal-ipc-api: Fix location size and add missing feature list
>   android/handsfree-client: Fix defines for action command
>   android/handsfree-client: Implement hf client events
>   android/handsfree-client: Implement hf client events
>   android/handsfree-client: Implement hf client events
>   android/handsfree-client: Implement hf client events
> 
>  android/hal-handsfree-client.c | 295 +++++++++++++++++++++++++++++++++++++++++
>  android/hal-ipc-api.txt        |  36 ++++-
>  android/hal-msg.h              | 208 ++++++++++++++++++++++++++++-
>  3 files changed, 531 insertions(+), 8 deletions(-)
> 

All patches applied (after fixing few typos), thanks. 

-- 
Best regards, 
Szymon Janc
