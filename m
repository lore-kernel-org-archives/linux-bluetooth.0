Return-Path: <cyrus@holtmann.org>
Date: Sun, 8 Jan 2012 22:37:12 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	marcel@holtmann.org
Subject: Re: [PATCH] Bluetooth: dtl1: Fix memleak in probe()
Message-ID: <20120108203712.GK16731@x220.P-661HNU-F1>
References: <1325945981-11330-1-git-send-email-dh.herrmann@googlemail.com>
 <1325945981-11330-5-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1325945981-11330-5-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Sat, Jan 07, 2012, David Herrmann wrote:
> We currently leak the driver info structure if dtl1_config fails. If we add a
> kfree() to dtl1_release to fix this, then dtl1_release and dtl1_detach are
> identical so this merges both functions.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  drivers/bluetooth/dtl1_cs.c |   20 +++-----------------
>  1 files changed, 3 insertions(+), 17 deletions(-)

Applied to my bluetooth-next tree. Thanks.

Johan
