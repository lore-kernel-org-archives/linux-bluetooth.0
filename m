Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Dec 2012 11:22:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/3] adapter: Fix unplugging adapter bug
Message-ID: <20121207092250.GA31796@x220>
References: <1354837273-31712-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354837273-31712-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Thu, Dec 06, 2012, Andre Guedes wrote:
> If we unplug an adapter in powered on state, once it is plugged
> again, it doesn't go to powered on state as expected. This bug
> happens because Powered info is stored when the adapter is
> unplugged from the system.
> 
> This patch fixes this bug by only storing adapter info if mode
> changing was requested by user application via D-Bus interface.
> This patch basically reverts the changes in commit
> 985d8ac397a7c332c1badcb95430a167ec93e9e7 where the bug was
> introduced.
> ---
>  src/adapter.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

All three patches have been applied (with a couple of coding style
improvements which don't change the logic). Thanks.

Johan
