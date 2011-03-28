Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 Mar 2011 17:51:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Simplify media_owner_remove
Message-ID: <20110328145141.GA22686@jh-x301>
References: <1301327540-5699-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301327540-5699-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Mar 28, 2011, Luiz Augusto von Dentz wrote:
> Since there is only one pending request and is directly acessible via
> owner pointer there is no need for media_owner_remove to take the
> request as parameter.
> ---
>  audio/transport.c |   23 ++++++++++++-----------
>  1 files changed, 12 insertions(+), 11 deletions(-)

Thanks. All three of your patches have been pushed upstream.

Johan
