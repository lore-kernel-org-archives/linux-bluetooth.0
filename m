Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Nov 2013 18:47:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android: Rename hidhost HAL related IPC API to match
 service name
Message-ID: <20131107164701.GB30100@x220.p-661hnu-f1>
References: <1383841024-11965-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383841024-11965-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Nov 07, 2013, Szymon Janc wrote:
> Use 'Android HAL name' string from IPC doc as base for names.
> ---
>  android/hal-hidhost.c | 72 +++++++++++++++++++++---------------------
>  android/hal-msg.h     | 80 +++++++++++++++++++++++------------------------
>  android/hid.c         | 86 ++++++++++++++++++++++++++-------------------------
>  3 files changed, 120 insertions(+), 118 deletions(-)

All three patches have been applied. Thanks.

Johan
