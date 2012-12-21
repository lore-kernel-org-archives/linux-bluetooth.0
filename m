Return-Path: <cyrus@holtmann.org>
Date: Sat, 22 Dec 2012 00:17:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/4] core: Use ERROR_INTERFACE instead of
 org.bluez.Error
Message-ID: <20121221221710.GA5776@x220.ger.corp.intel.com>
References: <1356107103-18039-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1356107103-18039-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Dec 21, 2012, Anderson Lizardo wrote:
> This will simplify changing interface name later (e.g. adding
> versioning).
> ---
>  src/adapter.c |    4 ++--
>  src/agent.c   |    5 +++--
>  src/device.c  |    2 +-
>  3 files changed, 6 insertions(+), 5 deletions(-)

All four patches have been applied, though I removed the comment about
versioning in this one as I don't think anything like that will be done
for the errors.

Johan
