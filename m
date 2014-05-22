Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/4] android/gatt: Read/Write improvements
Date: Thu, 22 May 2014 16:26:31 +0200
Message-ID: <5191416.CSRDNHAon4@uw000953>
In-Reply-To: <1400757465-11522-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400757465-11522-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thursday 22 of May 2014 13:17:41 Lukasz Rymanowski wrote:
> This set improves read/write operations from characteristics managed
> by Android server application.
> 
> 
> Lukasz Rymanowski (3):
>   android/gatt: Improve handling pending read/write requests
>   android/gatt: Fix minor style code issue
>   android/gatt: Use pending request for write req and prep write
> 
> Marcin Kraglak (1):
>   android/gatt: Use common framework for processing read_by_group_type
>     request
> 
>  android/gatt.c | 139 ++++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 79 insertions(+), 60 deletions(-)
> 

All patches applied, thanks.

-- 
Best regards, 
Szymon Janc
