Return-Path: <cyrus@holtmann.org>
Date: Sat, 1 Feb 2014 18:01:06 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Remove check for valid LTK authenticated
 parameter
Message-ID: <20140202020106.GD5133@x220.p-661hnu-f1>
References: <1391222538-34065-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391222538-34065-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jan 31, 2014, Marcel Holtmann wrote:
> The LTK authenticated parameter is the key type of the LTK and similar
> to link keys there is no need to check the currently supported values.
> 
> For possible future improvements, the kernel will only use key types
> it knows about and just ignore all the other ones.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 2 --
>  1 file changed, 2 deletions(-)

All three patches in this set have been applied to bluetooth-next. Thanks.

Johan
