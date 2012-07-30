Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Jul 2012 13:52:55 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Fix not setting class of device in adapter
Message-ID: <20120730105255.GA11295@x220.ger.corp.intel.com>
References: <1343638879-31253-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343638879-31253-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Jul 30, 2012, Szymon Janc wrote:
> Set class of device in adapter when new class is received from kernel.
> This fix adapters property Class being always zero.
> ---
>  lib/mgmt.h    |    4 ++++
>  src/adapter.c |   25 +++++++++++++++----------
>  src/adapter.h |    2 +-
>  src/mgmt.c    |   33 +++++++++++++++++++++++++++++++--
>  4 files changed, 51 insertions(+), 13 deletions(-)

Applied. Thanks.

Johan
