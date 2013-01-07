Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Jan 2013 14:18:45 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/5] lib: Add SDP_IS_TEXT_STR() macro for
 SDP_TEXT_STR* checking
Message-ID: <20130107121845.GA6052@x220>
References: <1357559795-22090-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357559795-22090-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Mon, Jan 07, 2013, Anderson Lizardo wrote:
> This new macro avoids constructs like "if (d->dtd < SDP_TEXT_STR8 ||
> d->dtd > SDP_TEXT_STR32)" which are harder to read.
> ---
>  lib/sdp.h |    2 ++
>  1 file changed, 2 insertions(+)

All patches in this set have been applied. Thanks.

Johan
