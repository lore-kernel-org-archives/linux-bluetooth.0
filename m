Return-Path: <cyrus@holtmann.org>
Date: Fri, 24 Feb 2012 18:49:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] sbc: fix "always_inline function might not be inlinable"
 warning
Message-ID: <20120224164901.GB14214@x220.P-661HNU-F1>
References: <1330085596-3645-1-git-send-email-siarhei.siamashka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330085596-3645-1-git-send-email-siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

On Fri, Feb 24, 2012, Siarhei Siamashka wrote:
> "__attribute__((always_inline))" does not replace "inline" and they
> still need to be used together. This fixes "always_inline function
> might not be inlinable [-Wattributes]" warning in gcc 4.7
> ---
>  sbc/sbc_primitives.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
