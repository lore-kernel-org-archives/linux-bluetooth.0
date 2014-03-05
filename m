Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/8] Initial AT handling for handsfree
Date: Wed, 05 Mar 2014 17:14:59 +0100
Message-ID: <60613875.I24eeAVJF7@uw000953>
In-Reply-To: <1393947130-11999-1-git-send-email-szymon.janc@tieto.com>
References: <1393947130-11999-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 04 of March 2014 16:32:02 Szymon Janc wrote:
> Hi,
> 
> This adds initial minimal set of AT commands to establish SLC connection.
> 
> Szymon Janc (8):
>   android/handsfree: Add support for AT+BRSF command
>   android/handsfree: Add support for AT+CIND command
>   android/handsfree: Add support for AT+CMER command
>   android/handsfree: Distinguish between HSP and HFP connection
>   shared/hfp: Add function to check if reach end of command
>   shared/hfp: Add hfp_gw_result_get_number_default function
>   android/handsfree: Add support for AT+BIA command
>   android/handsfree: Make connection state constants name shorter
> 
>  android/hal-msg.h   |  10 +-
>  android/handsfree.c | 266 +++++++++++++++++++++++++++++++++++++++++++++++++---
>  src/shared/hfp.c    |  20 ++++
>  src/shared/hfp.h    |   4 +
>  4 files changed, 282 insertions(+), 18 deletions(-)

Updated version of those patches is now pushed upstream.

-- 
Best regards, 
Szymon Janc
