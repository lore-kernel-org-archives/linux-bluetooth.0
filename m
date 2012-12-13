Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Dec 2012 22:15:27 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] core: Remove RequestSession and ReleaseSession
Message-ID: <20121213201527.GB19914@x220.P-661HNU-F1>
References: <1355428840-27065-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1355428840-27065-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Dec 13, 2012, Luiz Augusto von Dentz wrote:
> Sessions is no longer used by obexd and the concept is probably not
> relevant anymore since BlueZ 5 don't remember powered state anymore.
> ---
>  doc/adapter-api.txt |  26 +---------
>  src/adapter.c       | 134 ----------------------------------------------------
>  2 files changed, 1 insertion(+), 159 deletions(-)

Both patches have been applied. Thanks.

Johan
