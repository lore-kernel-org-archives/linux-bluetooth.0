Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Oct 2011 19:35:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Fix possible crash when indicating progress
Message-ID: <20111003163529.GA3369@fusion.localdomain>
References: <1317656596-15972-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317656596-15972-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Oct 03, 2011, Luiz Augusto von Dentz wrote:
> The amount of transferred bytes should only be updated after it has
> been sent.
> ---
>  client/transfer.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
