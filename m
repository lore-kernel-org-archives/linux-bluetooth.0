Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Dec 2010 17:07:54 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix printing D-Bus errors when headset record could
 not be found
Message-ID: <20101227150754.GA17203@jh-x301>
References: <1293452841-7141-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1293452841-7141-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Dec 27, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> When connection is started via headset_config_stream there is no D-Bus
> message to reply to.
> ---
>  audio/headset.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
