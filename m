Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Feb 2015 23:09:51 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] tools/btmgmt: Fix end of array checks
Message-ID: <20150212210951.GC14557@t440s.P-661HNU-F1>
References: <1423775115-16386-1-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423775115-16386-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Feb 12, 2015, Szymon Janc wrote:
> all_cmd arrays is not terminated by zeroed element.
> ---
>  tools/btmgmt.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied. Thanks.

Johan
