Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 May 2012 23:09:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ido Yariv <ido@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] attrib-server: Allow zero length attribute update
Message-ID: <20120528200914.GA474@x220.P-661HNU-F1>
References: <1338229985-27293-1-git-send-email-ido@wizery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338229985-27293-1-git-send-email-ido@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ido,

On Mon, May 28, 2012, Ido Yariv wrote:
> attrib_db_update always fails when g_try_realloc returns NULL, not
> taking into account that the length passed to g_try_realloc could be
> zero. In this case, g_try_realloc frees the currently allocated memory
> and returns NULL.
> As a result, not only will attrib_db_update fail needlessly, a
> use-after-free could occur as the attribute's length will still hold the
> length of the freed buffer.
> 
> Fix this by only returning an error if the length is non-zero.
> ---
>  src/attrib-server.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
