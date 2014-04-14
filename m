Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 0/4] android/gatt: GATT client improvements
Date: Mon, 14 Apr 2014 10:14:34 +0200
Message-ID: <2130796.ua3CRje4au@uw000953>
In-Reply-To: <1397227029-12779-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397227029-12779-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Friday 11 of April 2014 16:37:05 Lukasz Rymanowski wrote:
> This patch sets adds:
> * preparation for client listen handling
> * refactor send_client_connect_notify function
> * fix scenario when application unregister client without proper cleaning
> 
> v2:
> * removed listen from this patch set. Will send it later.
> * cleaning of other patches
> 
> v3:
> * added memset in patch 1/5
> 
> v4:
> * rebase
> 
> 
> Lukasz Rymanowski (4):
>   android/gatt: Refactor send_client_connect_notify
>   android/gatt: Fix handling client unregister
>   android/gatt: Move functions up in the file
>   android/gatt: Cleanup device lists
> 
>  android/gatt.c | 210 ++++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 147 insertions(+), 63 deletions(-)
> 

All patches applied (with change we discussed offline), thanks.

-- 
Best regards, 
Szymon Janc
