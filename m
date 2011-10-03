Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Oct 2011 11:56:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] AVRCP: fix changed notification
Message-ID: <20111003085646.GF8956@fusion.localdomain>
References: <1317316050-12855-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1317316050-12855-2-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317316050-12855-2-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Sep 29, 2011, Lucas De Marchi wrote:
> We sure want to send notifications only when section is not NULL.
> Otherwise we either crash or do not send the expected notification.
> ---
>  audio/avrcp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Thanks. This patch has been applied.

Johan
