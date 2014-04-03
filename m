Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 0/5] Client descriptor operations
Date: Thu, 03 Apr 2014 16:27:43 +0200
Message-ID: <2163675.S7c8QgyWaV@uw000953>
In-Reply-To: <1396365567-17339-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1396365567-17339-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tuesday 01 of April 2014 17:19:22 Jakub Tyszkowski wrote:
> v2 changes:
> 	* Rebased on top of latest changes and cleanups.
> 	* Function flow was redesigned to minimize label jumps.
> 
> Jakub Tyszkowski (5):
>   android/gatt: Add queue for characteristic descriptors caching
>   android/gatt: Handle get descriptor client command
>   android/gatt: Add descriptors sending and caching for client
>   android/gatt: Add client read descriptor handler
>   android/gatt: Add client write descriptor handler
> 

I've pushed all patches (with quite a few fixes and cleanups though), thanks.

-- 
Best regards, 
Szymon Janc
