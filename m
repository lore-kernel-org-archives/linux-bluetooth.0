Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Apr 2012 13:41:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core: Remove DiscoverSchedulerInterval option from
 main.conf
Message-ID: <20120423104130.GA11747@x220>
References: <1334858615-11750-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334858615-11750-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Apr 19, 2012, Luiz Augusto von Dentz wrote:
> This option was designed to be the time where name resolving would happen
> in between inquiries, but with the introdution of mgmt interface this is
> no longer the case as it treats the discovery as both inquiry/scan + name
> resolving and keeping it just to delay discovery rounds is probably
> useless.
> ---
>  src/adapter.c |    5 ++---
>  src/hcid.h    |    1 -
>  src/main.c    |   10 ----------
>  src/main.conf |    4 ----
>  4 files changed, 2 insertions(+), 18 deletions(-)

Applied. Thanks.

Johan
