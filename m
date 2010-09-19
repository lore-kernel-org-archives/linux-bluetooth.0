Return-Path: <cyrus@holtmann.org>
Date: Sun, 19 Sep 2010 10:39:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Remove --enable-mcap from configure command line
 options
Message-ID: <20100919073945.GA3254@jh-x301>
References: <1284796712-10934-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1284796712-10934-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Sep 18, 2010, Santiago Carot-Nemesio wrote:
> Only plugins are in charge of switch on MCAP if they require
> it to work.
> ---
>  acinclude.m4 |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)

Thanks. The patch has been pushed upstream.

Johan
