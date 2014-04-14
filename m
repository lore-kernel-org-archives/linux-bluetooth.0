Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
	claudio.takahasi@openbossa.org, anderson.lizardo@openbossa.org,
	armansito@chromium.org
Subject: Re: [PATCH 00/10] android/gatt: GATT Client write types support
Date: Mon, 14 Apr 2014 16:23:09 +0200
Message-ID: <2909135.azPjR6oIy3@uw000953>
In-Reply-To: <1397340031-29711-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397340031-29711-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Sunday 13 of April 2014 00:00:21 Lukasz Rymanowski wrote:
> This patch set adds support for different write types.
> For this I had to expose some additional API from attrib.
> 
> Only signed write left to implement.
> 
> This patch set also do some code cleaning.
> 
> Lukasz Rymanowski (10):
>   attrib: Add API for reliable write
>   attrib: Expose write execute
>   android/gatt: Add helper to create descr_data
>   android/gatt: Avoid double helper struct for read/write characteristic
>   android/gatt: Add helper to create characteristic op data
>   android/gatt: Fix error msg
>   android/gatt: Daemon accepts only default write type
>   android/gatt: Add support for reliable write
>   android/gatt: Add support for write execute
>   android/gatt: Add support for write without response
> 
>  android/gatt.c | 264 ++++++++++++++++++++++++++++++++++++++++++---------------
>  attrib/gatt.c  |  24 ++++++
>  attrib/gatt.h  |   8 ++
>  3 files changed, 226 insertions(+), 70 deletions(-)
> 
> 

Patches 3-7 are now pushed. Thanks.

I moved GATT write types definitions to HAL IPC.

-- 
Best regards, 
Szymon Janc
