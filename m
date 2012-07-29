Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Jul 2012 18:42:36 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix not setting class of device in adapter
Message-ID: <20120729164236.GA27092@x220>
References: <1343214893-28310-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1343214893-28310-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Jul 25, 2012, Szymon Janc wrote:
> Set class of device in adapter when new class is received from kernel.
> This fix adapters property Class being always zero.
> ---
>  lib/mgmt.h    |    4 ++++
>  src/adapter.c |   23 ++++++++++++++---------
>  src/adapter.h |    2 +-
>  src/mgmt.c    |   33 +++++++++++++++++++++++++++++++--
>  4 files changed, 50 insertions(+), 12 deletions(-)

This patch doesn't compile:

src/adapter.c: In function ‘btd_adapter_class_changed’:
src/adapter.c:698:21: error: assignment makes integer from pointer without a cast [-Werror]

Please fix and resend.

Johan
