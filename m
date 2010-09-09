Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Sep 2010 13:38:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Zhenhua Zhang <zhenhua.zhang@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/4] btio: Remove unused bt_io_set function
Message-ID: <20100909101901.GA16324@jh-x301>
References: <1284025283-3773-1-git-send-email-zhenhua.zhang@intel.com>
 <1284025283-3773-4-git-send-email-zhenhua.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1284025283-3773-4-git-send-email-zhenhua.zhang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Sep 09, 2010, Zhenhua Zhang wrote:
> It is not used by either obex or bluez.
> ---
>  btio/btio.c |   33 ---------------------------------
>  btio/btio.h |    3 ---
>  2 files changed, 0 insertions(+), 36 deletions(-)

I don't think removing this feature is a good idea. Even though there
aren't any current users of bt_io_set doesn't mean that there wont be in
the future. I remember e.g. discussions regarding AMP about applications
needing the ability to request a switch from BR/EDR to WLAN for an
active connection. This could e.g. be accomplished through a setsockopt
call. Other uses for setsockopt while a connection is open, or even
changing settings for an existing server socket might exist too.

Johan
