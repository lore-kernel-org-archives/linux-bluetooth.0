Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Mar 2011 11:11:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix error message when getting SCO connection handle
Message-ID: <20110325091148.GA31700@jh-x301>
References: <1300968593-25442-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300968593-25442-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Mar 24, 2011, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> Error message should indicate the transport correctly which is SCO
> not RFCOMM.
> ---
>  btio/btio.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Both of your patches have been pushed upstream. Thanks.

Johan
