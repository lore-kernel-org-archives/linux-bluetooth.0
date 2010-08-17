Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Aug 2010 17:19:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] gwobex: fix misuse of
 OBEX_SetCustomData/OBEX_GetCustomData
Message-ID: <20100817141934.GB16071@jh-x301>
References: <1282053510-18102-1-git-send-email-luiz.dentz@gmail.com>
 <1282053510-18102-2-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282053510-18102-2-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Aug 17, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> Those function should only be used in case of custom transport which is
> not the case since we are using fd transport here.
> 
> To fix that it now uses OBEX_SetUserData/OBEX_GetUserData which are not
> associate with any transport in particular.
> ---
>  gwobex/gw-obex.c   |    2 +-
>  gwobex/obex-priv.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

This one has also been pushed to the obexd upstream tree. Also remember
to update the upstream gwobex tree at gitorious.org.

Johan
