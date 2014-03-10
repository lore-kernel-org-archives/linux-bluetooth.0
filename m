Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/20] More Android Handsfree work
Date: Mon, 10 Mar 2014 12:50:27 +0100
Message-ID: <4829378.fZmx4WoeCi@uw000953>
In-Reply-To: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
References: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Saturday 08 of March 2014 01:19:44 Szymon Janc wrote:
> Hi,
> 
> This patchset adds support for basic handsfree functionality.
> 
> What is done:
>  - indicators (without callheld)
>  - placing, accepting, cancelling calls etc.
>  - vendor (unknown) AT command handling
>  - extended error codes
>  - DTMF codes
>  - query current calls
>  - voice recognition on/off
>  - disabling echo cancellation
>  - subscriber and operator identification
> 
> Missing features:
>  - proper three way calling support (AT+CHLD is supported but callheld
>    and CCWA are missing).
>  - WBS and codec negotiation
>  - audio
> 
> 

Updated version of this patchset (fixing comments from Marcel) is now upstream.

-- 
Best regards, 
Szymon Janc
