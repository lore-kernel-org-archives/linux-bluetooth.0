Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 0/5] android: LE device handling improvements
Date: Mon, 24 Mar 2014 14:25:01 +0100
Message-ID: <1712147.kI3Czu9dol@uw000953>
In-Reply-To: <1395664606-32263-1-git-send-email-szymon.janc@tieto.com>
References: <1395664606-32263-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 24 of March 2014 13:36:41 Szymon Janc wrote:
> v3:
> - EIR flags defines are not renamed
> - non-discoverable LE device is filtered only if unknown
> 
> Szymon Janc (5):
>   core: Move EIR flags definitions to eir.h
>   android/bluetooth: Filter out not discoverable LE devices
>   android/bluetooth: Add support for loading LTKs
>   android/bluetooth: Add support for new long term key mgmt event
>   android/bluetooth: Fix handling of BREDR, LE and dual mode devices
> 
>  android/bluetooth.c | 349 ++++++++++++++++++++++++++++++++++++++++++++++------
>  src/adapter.c       |   9 --
>  src/eir.h           |   9 ++
>  3 files changed, 323 insertions(+), 44 deletions(-)
> 
> 

This is now upstream.

-- 
Best regards, 
Szymon Janc
