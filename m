Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 Oct 2013 11:01:33 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] android/hal: Add support for repacking received IPC data
 to HAL data
Message-ID: <20131031090133.GI1271@x220.p-661hnu-f1>
References: <1383147054-16528-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383147054-16528-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Oct 30, 2013, Szymon Janc wrote:
> Some HAL defined types that are passed as type-len-value in properties
> callback needs to be repacked at runtime to match defined types.
> 
> This is due to HAL using data types without strict refined sizes like
> enums or unpacked structures. This is needed only if data is passed as
> TLV. With data passed to callbacks as parameters compiler will handle
> types convertion.
> 
> Currently only enum types are supported.
> ---
> 
> This is only for received events. Same needs to be done when sending props
> from HAL lib to daemon.
> 
>  android/hal-bluetooth.c | 104 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 96 insertions(+), 8 deletions(-)

Patch looks good enough to me so it's now applied. Thanks.

Johan
