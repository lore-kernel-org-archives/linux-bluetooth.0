Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 May 2012 17:50:14 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/3] core: Use signalfd to handle unix signals
Message-ID: <20120508005014.GA12952@x220.avt.com>
References: <1336435253-19081-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336435253-19081-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, May 07, 2012, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Writing anything to syslog in the signal handler can cause a deadlock
> with any ongoing syslog write.
> 
> This is also aligned with what BlueZ and other projects has been doing.
> ---
>  src/main.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++++++---------
>  1 files changed, 78 insertions(+), 14 deletions(-)

All three patches have been applied. Thanks.

Johan
