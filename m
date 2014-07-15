Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Jul 2014 17:45:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] monitor: Write btsnoop before processing packet
Message-ID: <20140715144513.GB22120@t440s.P-661HNU-F1>
References: <1405426698-27365-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405426698-27365-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Jul 15, 2014, Szymon Janc wrote:
> In case of parser crash packet should still be present in
> btsnoop file. This allows to reproduce crash and provide fix.
> ---
>  monitor/control.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
