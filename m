Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 00/15] android/handsfree-clien: Second set of HFP HF
Date: Wed, 19 Nov 2014 15:09:12 +0100
Message-ID: <8190720.HXmhygjjRF@uw000953>
In-Reply-To: <1416390228-28330-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1416390228-28330-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Wednesday 19 of November 2014 10:43:33 Lukasz Rymanowski wrote:
> In this set all mising signaling part is implemented.
> Tested on UPF 49 as well.
> 
> SCO part will come in next set.
> 
> v2:
> * Addressed Szymon comments
> * Added patch fixing index type in IPC call action command (01/15)
> 
> Lukasz Rymanowski (15):
>   android/handsfree-client: Fix index type in call action command
>   android/handsfree-client: Add handle start/stop vr
>   android/handsfree-client: Add volume control handling
>   android/handsfree-client: Add handling dial command
>   android/handsfree-client: Add call action implementation
>   android/handsfree-client: Implement query current calls
>   android/handsfree-client: Add handling +CLCC
>   android/handsfree-client: Add support for +CIEV events
>   android/handsfree-client: Send indicators val we got during SLC setup
>   android/handsfree-client: Add support to get operator name
>   android/handsfree-client: Send to AG that we do support long name
>   android/handsfree-client: Retrieve subscriber number information
>   android/handsfree-client: Implement send DTMF codes
>   android/handsfree-client: Implement handling AT+BINP and +BINP
>   android/handsfree-client: Implement codec negotiations
> 
>  android/hal-msg.h          |   2 +-
>  android/handsfree-client.c | 833 +++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 802 insertions(+), 33 deletions(-)
> 

Patch-set applied (with some small fixes), thanks.

-- 
Best regards, 
Szymon Janc
