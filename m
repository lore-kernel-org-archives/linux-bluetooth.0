Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Oct 2013 12:56:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Remove unneeded val variable when setting
 SSP
Message-ID: <20131010105606.GA28965@x220.p-661hnu-f1>
References: <1381399691-42391-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381399691-42391-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 10, 2013, Marcel Holtmann wrote:
> The variable val in the set_ssp() function of the management interface
> is not needed. Just use cp->val directly since its input values have
> already been validated.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
