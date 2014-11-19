Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 01/16] android/hal-gatt: Implement Android 5 callbacks
Date: Wed, 19 Nov 2014 13:14:13 +0100
Message-ID: <2071138.l2SU8On84y@uw000953>
In-Reply-To: <1416263288-30530-1-git-send-email-szymon.janc@tieto.com>
References: <1416263288-30530-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 17 of November 2014 23:27:53 Szymon Janc wrote:
> This adds IPC handlers for new GATT notifications and implementes
> requiured callbacks.
> ---
>  android/hal-gatt.c | 193 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  android/hal-msg.h  | 113 +++++++++++++++++++++++++++++++
>  2 files changed, 305 insertions(+), 1 deletion(-)
> 

Pushed (with comments from Łukasz fixed).



-- 
Best regards, 
Szymon Janc
