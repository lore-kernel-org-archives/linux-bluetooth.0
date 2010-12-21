Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Dec 2010 00:20:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Configure HFP/HSP endpoints if headset interface is
 already connected
Message-ID: <20101221222042.GA17957@jh-x301>
References: <1292946195-25355-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292946195-25355-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Dec 21, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> HFP/HSP can be connected when registering an endpoint which is different
> than on a2dp where the sep cannot be configured already since it wasn't
> available before.
> ---
>  audio/media.c |   13 +++++++++++--
>  1 files changed, 11 insertions(+), 2 deletions(-)

The patch has been pushed upstream. Thanks.

Johan
