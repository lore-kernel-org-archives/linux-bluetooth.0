Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Dec 2010 20:42:12 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix crash due to misplaced parameter in
 emit_device_found() call
Message-ID: <20101228184212.GA18053@jh-x301>
References: <1293555150-9979-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1293555150-9979-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Dec 28, 2010, Anderson Lizardo wrote:
> To avoid related mistakes, dev->uuid_count was shortened to uuid_count
> and kept on the same line.
> ---
> Note that there is a 82-column line on this patch. I chose to put it
> on the same line to avoid a similar mistake in future.
> ---
>  src/adapter.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

The patch has been pushed upstream. Thanks.

Johan
