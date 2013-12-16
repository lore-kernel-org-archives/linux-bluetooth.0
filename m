Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Dec 2013 10:07:56 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] emulator/bthost: Fix use after free in bthost_destroy
Message-ID: <20131216080756.GB30922@x220.p-661hnu-f1>
References: <1387137348-5377-1-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387137348-5377-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Sun, Dec 15, 2013, Szymon Janc wrote:
> cmd was dereferenced after free. Use temp pointer for freeing.
> ---
>  emulator/bthost.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
