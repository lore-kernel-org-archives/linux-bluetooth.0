Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Jun 2012 23:35:29 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon@janc.net.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] btmgmt: Fix use after free in mgmt_check_pending
Message-ID: <20120607153529.GB25119@x220.docomointertouch.net>
References: <1339011503-28756-1-git-send-email-szymon@janc.net.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339011503-28756-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Jun 06, 2012, Szymon Janc wrote:
> Break loop when pending command was found and callback called.
> ---
>  mgmt/main.c |    1 +
>  1 file changed, 1 insertion(+)

Applied. Thanks.

Johan
