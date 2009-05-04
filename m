Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 May 2009 18:30:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: alokbarsode@gmail.com
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.com,
	Alok Barsode <alok.barsode@azingo.com>
Subject: Re: [PATCH 3/3] Adding stop() functionality to hciops plugin.
Message-ID: <20090504153050.GC28443@jh-x301>
References: <1241449694-17135-1-git-send-email-alok.barsode@azingo.com> <1241449694-17135-2-git-send-email-alok.barsode@azingo.com> <1241449694-17135-3-git-send-email-alok.barsode@azingo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1241449694-17135-3-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alok,

On Mon, May 04, 2009, alokbarsode@gmail.com wrote:
> From: Alok Barsode <alok.barsode@azingo.com>
> 
> ---
>  plugins/hciops.c |   24 ++++++++++++++++++++++++
>  src/adapter.c    |   25 ++++++++++++++-----------
>  src/adapter.h    |    1 +
>  3 files changed, 39 insertions(+), 11 deletions(-)

This patch is fine assuming that we don't want to exit when
adapter_ops_setup fails. Though now it's apparent that the code would get
simpler if we would exit() in that case since then we don't need to have
any "if (adapter_ops)" checks later in the code.

Johan
