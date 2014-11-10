Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/7] android/handsfree-client: First set of HFP HF
Date: Mon, 10 Nov 2014 20:45:37 +0100
Message-ID: <1816531.Kd67TxFnoA@leonov>
In-Reply-To: <1415492659-3296-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415492659-3296-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Sunday 09 of November 2014 01:24:12 Lukasz Rymanowski wrote:
> In this set service record, slc creation and incoming/outgoing
> connection support has been added.
> 
> This code has been tested on UPF49.
> 
> v2:
> * Handle Szymon comments
> * Fix for checking codec negotiation support in 4/7
> 
> Lukasz Rymanowski (7):
>   android/handsfree-client: Typo fix in define name
>   android/handsfree-client: Add service record
>   android/handsfree-client: Add devices queue
>   android/handsfree-client: Add incoming connection handling
>   android/handsfree-client: Add SLC creation procedure
>   android/handsfree-client: Add support for outgoing connection
>   android/handsfree-client: Handle disconnect command
> 
>  android/hal-msg.h          |    2 +-
>  android/handsfree-client.c | 1041
> +++++++++++++++++++++++++++++++++++++++++++- 2 files changed, 1036
> insertions(+), 7 deletions(-)

Patches 1-3 applied, thanks.

-- 
BR
Szymon Janc
