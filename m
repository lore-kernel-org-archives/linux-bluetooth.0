Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 May 2012 10:43:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] GATT: Avoid unneeded discover transaction
Message-ID: <20120530074328.GF6539@x220>
References: <1338299726-25822-1-git-send-email-claudio.takahasi@openbossa.org>
 <1338299726-25822-2-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338299726-25822-2-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, May 29, 2012, Claudio Takahasi wrote:
> This patch fix unneeded discover characteristics transaction when the
> last characteristic declaration contains the handle number equals to the
> end handle of the primary service.
> ---
>  attrib/gatt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
