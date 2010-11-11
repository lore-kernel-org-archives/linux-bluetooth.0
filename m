Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 12:36:45 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Remove a2dp setup callbacks after they return
Message-ID: <20101111103645.GL4132@jh-x301>
References: <1289468425-11997-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289468425-11997-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Nov 11, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> Since the callback won't be ever called again it make no sense to keep
> them, also this cause a2dp_cancel to assume there are still some pending
> callbacks to be processed and do not abort when it should.
> ---
>  audio/a2dp.c |   55 +++++++++++++++++++++++++++++++++++--------------------
>  1 files changed, 35 insertions(+), 20 deletions(-)

Both patches have been pushed upstream. Thanks.

Johan
