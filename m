Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Jan 2014 17:57:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 0/7] sixaxis: Don't mark USB plugged device as trusted
Message-ID: <20140109155703.GA20418@x220.p-661hnu-f1>
References: <1389139348-3552-1-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389139348-3552-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Jan 08, 2014, Szymon Janc wrote:
> This serie removes marking USB plugged sixaxis DS3 devices as trusted.
> Now agent is asked for service authorization before device is connected
> over BT. This is to address conserns about possibly crafted USB devices.
> 
> This is implemented in PATCH 1. Rest are fixes for bugs that were uncovered
> due this change and client functionality that I've found missing while
> testing this.
> 
> Comments and testing are welcome.
> 
> -- 
> BR
> Szymon Janc
> 
> 
> Szymon Janc (7):
>   sixaxis: Don't mark USB plugged device as trusted
>   input: Fix crash on authorization reply with first sixaxis connection
>   input: Fix check if device is sixaxis in auth_callback
>   input: Fix connecting new trusted sixaxis device
>   client: Add untrust command
>   client: Add block command
>   client: Add unblock command
> 
>  client/main.c           | 93 +++++++++++++++++++++++++++++++++++++++++++++++++
>  plugins/sixaxis.c       |  1 -
>  profiles/input/server.c | 37 ++++----------------
>  3 files changed, 99 insertions(+), 32 deletions(-)

All patches have been applied. Thanks.

Johan
