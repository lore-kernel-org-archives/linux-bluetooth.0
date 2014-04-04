Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Apr 2014 10:26:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] client: Add support for printing property of array type
Message-ID: <20140404072637.GB16753@t440s.lan>
References: <1396562278-30114-1-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1396562278-30114-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Apr 03, 2014, Szymon Janc wrote:
> This allows to print UUIDs in user friendly fasion. Only string type
> support is needed.
> 
> [CHG] Device XX:XX:XX:XX:XX:XX UUIDs:
>         00000002-0000-1000-8000-0002ee000002
>         00001101-0000-1000-8000-00805f9b34fb
>         00001103-0000-1000-8000-00805f9b34fb
>         00001104-0000-1000-8000-00805f9b34fb
>         00001105-0000-1000-8000-00805f9b34fb
> 
> instead of:
> 
> [CHG] Device XX:XX:XX:XX:XX:XX UUIDs has unsupported type
> ---
>  client/main.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Applied. Thanks.

Johan
