Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sun, 22 Nov 2015 16:11:57 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: John Keeping <john@metanate.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] build: Link mcaptest with -lrt
Message-ID: <20151122131157.GA7185@t440s>
References: <1447773671-22497-1-git-send-email-john@metanate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1447773671-22497-1-git-send-email-john@metanate.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

On Tue, Nov 17, 2015, John Keeping wrote:
> profiles/health/mcap.c uses clock_gettime(3) so it needs to be linked
> with -lrt on some systems.
> ---
>  Makefile.tools | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
