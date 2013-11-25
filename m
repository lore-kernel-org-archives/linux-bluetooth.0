Return-Path: <cyrus@holtmann.org>
Date: Mon, 25 Nov 2013 14:47:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/hal-bluetooth: Use static memory for enum
 convertion
Message-ID: <20131125124705.GA5559@x220.p-661hnu-f1>
References: <1385379120-10142-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385379120-10142-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Nov 25, 2013, Szymon Janc wrote:
> There is no need to use dynamic allocation for enum properties
> convertion. Each property type can be present only once in properties
> callback so using static allocation is safe. This also remove need
> for cleanup properties after HAL callback is called making code
> simpler.
> ---
>  android/hal-bluetooth.c | 109 ++++++++++++++++--------------------------------
>  1 file changed, 37 insertions(+), 72 deletions(-)

Applied. Thanks.

Johan
