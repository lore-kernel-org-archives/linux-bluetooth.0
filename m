Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/3] android: Improve of handling stop discovery
Date: Thu, 13 Mar 2014 15:25:42 +0100
Message-ID: <5989114.fhmm5T3hvb@uw000953>
In-Reply-To: <1394406397-6843-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1394406397-6843-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Monday 10 of March 2014 00:06:34 Lukasz Rymanowski wrote:
> Following patches improves handling of stop discovery in scenario of
> big inflow of device found events.
> 
> v2:
> * Fix confirm name callback
> 
> Lukasz Rymanowski (3):
>   android: Add tracking for pending confirm name command
>   android: Cancel all pending confirm name before stop discovery
>   android: Send confirm name request with mgmt_send
> 
>  android/bluetooth.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 46 insertions(+), 4 deletions(-)
> 
> 

All patches applied, thanks.

-- 
Best regards, 
Szymon Janc
