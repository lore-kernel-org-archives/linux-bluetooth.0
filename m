Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Oct 2012 16:13:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] device: Don't use device_get_adapter to access
 device adapter
Message-ID: <20121005131306.GA32427@x220>
References: <1349441679-18557-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349441679-18557-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Oct 05, 2012, Szymon Janc wrote:
> Use struct btd_device directly to access adapter member.
> 
> ---
>  src/device.c |   34 ++++++++++++++--------------------
>  1 file changed, 14 insertions(+), 20 deletions(-)

All patches in this set have been applied. Thanks.

Johan
