Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Dec 2012 22:15:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] mgmt-api: Remove not needed restriction on add/remove
 OOB data
Message-ID: <20121213201506.GA19914@x220.P-661HNU-F1>
References: <1355407852-22047-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1355407852-22047-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Dec 13, 2012, Szymon Janc wrote:
> Those commands don't send any HCI commands to controller so there is no
> need to restrict them to only powered up controller. This also clarify
> that provided OOB data is persistent over power down/up toggles.
> ---
>  doc/mgmt-api.txt | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied. Thanks.

Johan
