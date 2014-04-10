Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] android/gatt: Fix sending notification for register gatt client
Date: Thu, 10 Apr 2014 11:57:18 +0200
Message-ID: <1496413.xlNYFUqeld@uw000953>
In-Reply-To: <1396872323-19162-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1396872323-19162-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Monday 07 of April 2014 14:05:19 Grzegorz Kolodziejczyk wrote:
> This patch adds missing send notification in case of errors for gatt
> client registration. In case of error status GATT_FAILURE with given in
> cmd UUID is send in notification.
> ---
>  android/gatt.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 

This patch is now pushed, thanks.

-- 
Best regards, 
Szymon Janc
