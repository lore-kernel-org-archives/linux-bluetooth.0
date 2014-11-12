Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 0/4] android/handsfree-client: First set of HFP HF
Date: Wed, 12 Nov 2014 09:44:20 +0100
Message-ID: <117985205.5TPvZBy3tM@uw000953>
In-Reply-To: <1415728377-20880-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415728377-20880-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Tuesday 11 of November 2014 18:52:53 Lukasz Rymanowski wrote:
> In this set service record, slc creation and incoming/outgoing
> connection support has been added.
> 
> This code has been tested on UPF49.
> 
> v2:
> * Handle Szymon comments
> * Fix for checking codec negotiation support in 4/7
> 
> v3:
> * fix for cleanup hfp_hf_server in case of sdp record creation failure.
> 
> Lukasz Rymanowski (4):
>   android/handsfree-client: Add incoming connection handling
>   android/handsfree-client: Add SLC creation procedure
>   android/handsfree-client: Add support for outgoing connection
>   android/handsfree-client: Handle disconnect command
> 
>  android/handsfree-client.c | 907 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 898 insertions(+), 9 deletions(-)
> 

All patches applied, thanks.
 
-- 
Best regards, 
Szymon Janc
