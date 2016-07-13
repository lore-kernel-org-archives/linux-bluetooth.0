Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 13 Jul 2016 08:37:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] doc/mgmt-api: Add Authentication Failure code to
 Disconnected event
Message-ID: <20160713053741.GB27711@t440s.P-661HNU-F1>
References: <1466762356-4171-1-git-send-email-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466762356-4171-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Jun 24, 2016, Szymon Janc wrote:
> This error code will be set if authentication (enabling encryption)
> failed with 'PIN or Key Missing' error. This will allow userspace
> to take actions (eg ask user for consent for rebonding) when remote
> device lost bond.
> ---
>  doc/mgmt-api.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied. Thanks.

Johan
