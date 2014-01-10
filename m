Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v4 0/4] Add support for NAP role
Date: Fri, 10 Jan 2014 12:34:27 +0100
Message-ID: <2585431.tm7x4Ta0z7@uw000953>
In-Reply-To: <1389181593-9683-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1389181593-9683-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Wednesday 08 of January 2014 13:46:29 Ravi kumar Veeramally wrote:
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
>  android/pan.c | 346 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 334 insertions(+), 12 deletions(-)

For the records, please fix issues pointed on IRC and resend.

-- 
Best regards, 
Szymon Janc
