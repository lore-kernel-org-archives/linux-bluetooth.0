Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Nov 2010 22:01:51 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Fix not deinitializing telephony driver when there
 is no adapter powered
Message-ID: <20101125200151.GA30633@jh-x301>
References: <1290698551-8706-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290698551-8706-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Nov 25, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> This changes hook telephony driver de/initialization to powered state so
> telephony drivers can now free their resources when there is no adapter
> active in the system.
> ---
>  audio/manager.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 files changed, 54 insertions(+), 5 deletions(-)

All three patches (v2 of 3/3) have been pushed upstream. Thanks.

Johan
