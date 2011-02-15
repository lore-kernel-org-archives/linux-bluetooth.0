Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Feb 2011 11:14:55 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Fix not stopping name resolving when discovery is
 suspended
Message-ID: <20110215141455.GA18768@jh-x301>
References: <1297678882-26893-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297678882-26893-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Feb 14, 2011, Luiz Augusto von Dentz wrote:
> During device creation if discovery is active we suspend it to avoid
> interfering with pairing, but although it attempt to cancel name request
> there could be one already completed which would cause next name on the
> list to be requested.
> ---
>  src/adapter.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)

All three patches (v2 of 2/3) have been pushed upstream. Thanks.

Johan
