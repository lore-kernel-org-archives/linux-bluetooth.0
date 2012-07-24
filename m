Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jul 2012 11:49:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: Re: [PATCH BlueZ] btio: Rescue lost errorneous numbers
Message-ID: <20120724094922.GB9576@x220.ice.intel.com>
References: <1343054163-19119-1-git-send-email-claudio.takahasi@openbossa.org>
 <1343054163-19119-2-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343054163-19119-2-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Mon, Jul 23, 2012, Claudio Takahasi wrote:
> From: Paulo Alcantara <paulo.alcantara@openbossa.org>
> 
> The BT_IO_ERROR_* flags are not used for anything else and we just
> loosing errorneous numbers set in the sockets that might be more
> useful for handling specific errors.
> 
> A use case would be disconnect errors that should not allow BlueZ to
> enable auto connections since the connection would never be possible in
> some cases.
> 
> This patch removes BT_IO_ERROR_* flags and use the errors set in the
> sockets instead. Now, the errors passed in connect/disconnect callbacks
> should contain proper error numbers passed to them.
> ---
>  btio/btio.c |   78 ++++++++++++++++++++++++++++++++++++----------------------
>  btio/btio.h |    7 -----
>  2 files changed, 48 insertions(+), 37 deletions(-)

Applied. Thanks.

Johan
