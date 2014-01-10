Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v7 0/4] Add support for NAP role
Date: Fri, 10 Jan 2014 16:12:38 +0100
Message-ID: <7019993.rU2ZKJfp8q@uw000953>
In-Reply-To: <1389363109-6312-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1389363109-6312-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Friday 10 of January 2014 16:11:45 Ravi kumar Veeramally wrote:
> v7: Rebase issue with _v6.
> 
> v6: Fixed Szymon's comments (use snprintf and defines).
> 
> v5: Fixed Szymon's comments and added his fix (crash when bridge create
>     fails).
> 
> v4: Fixed Szymon's and Luiz's comments.
> 
> v3: Fixed Johan's comments (removed fopen, fprintf and used open and write).
> 
> v2: Fixed Johan's comments.
> 
> v1: This patch set add support for NAP role. It register NAP server and create
>   bnep bridge and listen for incoming connections from client devices.
>   On incoming connection request it accepts connection, creates bnep interface
>   and notifies control state and connection state infromation. Removes device
>   on disconnect request. Android related changes are required to enable this
>   role. Patches sent to respective ML.
> 
> Ravi kumar Veeramally (4):
>   android/pan: Register Network Access Point
>   android/pan: Listen for incoming connections and accept in NAP role
>   android/pan: Implement PAN enable HAL api at daemon side
>   android/pan: Remove connected PAN devices on profile unregister call
> 
>  android/pan.c | 339 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 327 insertions(+), 12 deletions(-)
> 

All patches applied, thanks a lot. 

-- 
Best regards, 
Szymon Janc
