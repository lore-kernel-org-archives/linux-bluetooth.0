Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Oct 2013 16:32:51 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Fix compiler flags with Android version
Message-ID: <20131030143251.GA3493@x220.p-661hnu-f1>
References: <1383142958-27510-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383142958-27510-1-git-send-email-jerzy.kasenberg@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerzy,

On Wed, Oct 30, 2013, Jerzy Kasenberg wrote:
> This fixes commit that removed PLATFORM_SDK_VERSION when building
> haltest. Now all android targets get this define.
> ---
>  android/Android.mk |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
