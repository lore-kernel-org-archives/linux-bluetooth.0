Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Feb 2011 18:38:32 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Remove unused MTU variable in Gattrib struct
Message-ID: <20110224213832.GC1055@jh-x301>
References: <1298582452-18032-1-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298582452-18032-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Thu, Feb 24, 2011, Bruna Moreira wrote:
> The MTU variable in Gattrib struct was not beind used for any operation
> so it should be removed.
> ---
>  attrib/gattrib.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)

Thanks. Pushed upstream after a couple of typo fixes in the commit
message.

Johan
