Return-Path: <cyrus@holtmann.org>
Date: Tue, 2 Oct 2012 12:50:20 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] service: Remove extra memory copying from
 cancel_authorization
Message-ID: <20121002095020.GA8080@x220>
References: <1349170392-16498-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349170392-16498-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Oct 02, 2012, Szymon Janc wrote:
> src is never read before being overwritten few lines below.
> 
> ---
>  plugins/service.c |    5 -----
>  1 file changed, 5 deletions(-)

Both patches have been applied. Thanks.

Johan
