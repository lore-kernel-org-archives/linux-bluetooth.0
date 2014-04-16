Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/8] android/gatt: Server command handlers
Date: Wed, 16 Apr 2014 10:25:39 +0200
Message-ID: <2074332.MB0R0NcsCt@uw000953>
In-Reply-To: <1397222119-31158-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1397222119-31158-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Friday 11 of April 2014 15:15:11 Jakub Tyszkowski wrote:
> This adds stubs for handling GATT Server's attribute database operations.
> If attribute database API is accepted in proposed state, we will just need to
> trigger db transactions and send proper notifications.
> 
> Jakub Tyszkowski (8):
>   android/gatt: Add find_server_by_id helper
>   android/gatt: Add Server's add_service stub
>   android/gatt: Add Server's add_included_service stub
>   android/gatt: Add Server's add_characteristic stub
>   android/gatt: Add Server's add_descriptor stub
>   android/gatt: Add Server's start_service stub
>   android/gatt: Add Server's stop_service stub
>   android/gatt: Add Server's delete_service stub
> 
>  android/gatt.c | 174 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 164 insertions(+), 10 deletions(-)
> 
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

All patches applied, thanks.

-- 
Best regards, 
Szymon Janc
