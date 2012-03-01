Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Feb 2012 20:05:07 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] mgmtops: Add CANCEL_PAIR_DEVICE command complete
 handling
Message-ID: <20120301020507.GB27177@x220>
References: <1330545435-2770-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330545435-2770-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Feb 29, 2012, Anderson Lizardo wrote:
> This avoids the "Unknown command complete for opcode 26" error.
> ---
>  plugins/mgmtops.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

Applied. Thanks.

Johan
