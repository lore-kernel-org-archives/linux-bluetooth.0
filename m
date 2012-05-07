Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 May 2012 11:30:40 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] gatttool: Add option to specify LE address type
Message-ID: <20120507183040.GA7230@x220.hpllc.com>
References: <1336396142-6439-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336396142-6439-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Mon, May 07, 2012, Andrzej Kaczmarek wrote:
> This patch makes possible to specify LE address type.
> 
> After advertising cache was removed from kernel we should always specify
> address type for LE link when calling bt_io_connect() as otherwise random
> will always be used.
> 
> LE address type can be specified either by 'addr-type' or 't' command line
> parameter or as additional parameter to 'connect' command in interactive mode.
> 
> Possible values are 'public' (default) and 'random'.
> ---
>  attrib/gatttool.c    |    8 ++++++--
>  attrib/gatttool.h    |    7 ++++---
>  attrib/interactive.c |   17 +++++++++++++----
>  attrib/utils.c       |   12 ++++++++++--
>  4 files changed, 33 insertions(+), 11 deletions(-)

Applied. Thanks.

Johan
