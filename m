Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Feb 2015 10:21:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] monitor: Factor out channel selection to separate
 function
Message-ID: <20150219082109.GA22981@t440s.lan>
References: <1424295992-29506-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424295992-29506-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Feb 18, 2015, Szymon Janc wrote:
> This allows to have conditions check in single place.
> ---
>  monitor/l2cap.c | 85 +++++++++++++++++----------------------------------------
>  1 file changed, 25 insertions(+), 60 deletions(-)

Both patches have been applied. Thanks.

Johan
