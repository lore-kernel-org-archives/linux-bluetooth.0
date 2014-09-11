Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/4] android/hf-client: API fixes
Date: Thu, 11 Sep 2014 12:17:37 +0200
Message-ID: <1477172.5pA5BI0JMS@uw000953>
In-Reply-To: <1410347494-22084-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410347494-22084-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Wednesday 10 of September 2014 13:11:30 Lukasz Rymanowski wrote:
> Couple of fixes to hf-client api.
> 
> Those patches previously where a part of bigger set
> [PATCH 00/39] android: HF Client initial implementation
> but on Luiz request I split it into smaller sets.
> 
> Lukasz Rymanowski (4):
>   android/hal-ipc-api: Use 2 bytes for location in dial memory
>   android/hal-ipc-api: Use Tone instead of Code DTMF
>   android/hal-ipc-api: Add missing peer features parameter
>   android/hal-ipc-api: Fix define for HF-Client
> 
>  android/hal-ipc-api.txt | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 

Applied. Thanks. 

-- 
Best regards, 
Szymon Janc
