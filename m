Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Nov 2012 16:15:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 2/5] core: Make exit sequence consistent with init
Message-ID: <20121115141538.GA6884@x220>
References: <1352988325-10782-1-git-send-email-luiz.dentz@gmail.com>
 <1352988325-10782-2-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352988325-10782-2-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Nov 15, 2012, Luiz Augusto von Dentz wrote:
> manager_cleanup should be called after plugin_cleanup on exit as
> manager_init is called before plugin_init on the init sequence.
> ---
>  src/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patches 1 and 2 have been applied. For the others I'll wait for some
more feedback (e.g. from Lucas and Marcel).

Johan
