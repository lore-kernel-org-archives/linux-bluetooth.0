Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Oct 2013 13:53:05 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Restrict disabling of HS when controller is
 powered off
Message-ID: <20131002105305.GA26248@x220.p-661hnu-f1>
References: <1380698822-25791-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380698822-25791-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 02, 2013, Marcel Holtmann wrote:
> Disabling the high speed setting when the controller is powered on has
> too many side effects that are not taken care of. And in general it
> is not an useful operation anyway. So just make such a command fail
> with a rejection error message.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
