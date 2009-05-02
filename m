Return-Path: <cyrus@holtmann.org>
Date: Sun, 3 May 2009 02:36:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Moving adapter_ops registration to adapter.c.
Message-ID: <20090502233607.GA24254@jh-x301>
References: <1241019601-7757-1-git-send-email-alok.barsode@azingo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1241019601-7757-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alok,

On Wed, Apr 29, 2009, alokbarsode@gmail.com wrote:
> From: Alok Barsode <alok.barsode@azingo.com>
> 
> ---
>  src/adapter.c |   35 +++++++++++++++++++++++++++++++++++
>  src/adapter.h |   10 ++++++++++
>  src/main.c    |    2 +-
>  src/manager.c |   35 -----------------------------------
>  src/manager.h |    8 --------
>  5 files changed, 46 insertions(+), 44 deletions(-)

This patch is now pushed with some minor fixes.

Johan
