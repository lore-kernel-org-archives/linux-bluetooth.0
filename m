Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/4] android: GATT HAL Implementation
Date: Fri, 07 Mar 2014 10:52:42 +0100
Message-ID: <1802559.DphrSMr2P2@uw000953>
In-Reply-To: <1394105279-9165-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1394105279-9165-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thursday 06 of March 2014 12:27:55 Jakub Tyszkowski wrote:
> Patchset adds the initial implementation of Android GATT HAL. This will allow
> to start the actual GATT Service development inside the Android daemon.
> 
> Jakub Tyszkowski (4):
>   android/hal-gatt: Add Client Event handlers
>   android/hal-gatt: Add Client API calls
>   android/hal-gatt: Add Server Event handlers
>   android/hal-gatt: Add Server API calls
> 
>  android/hal-gatt.c | 689 ++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 655 insertions(+), 34 deletions(-)

All patches applied, thanks.

-- 
Best regards, 
Szymon Janc
