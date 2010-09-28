Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Sep 2010 16:41:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix emitting TransferCompleted twice
Message-ID: <20100928134138.GA27986@jh-x301>
References: <1285679962-10367-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285679962-10367-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Sep 28, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> This is caused by REQDONE and latter disconnect generating duplicate
> signals in case of opp.
> 
> To fix this now we check if the object is valid before proceeding.
> ---
>  src/manager.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Thanks. The patch has been pushed upstream.

Johan
