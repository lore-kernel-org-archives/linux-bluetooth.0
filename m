Return-Path: <johan.hedberg@gmail.com>
Date: Wed, 4 Nov 2015 09:27:16 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Make LE only events conditional on
 supported commands
Message-ID: <20151104072716.GA28987@t440s>
References: <1446617843-8404-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446617843-8404-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Nov 04, 2015, Marcel Holtmann wrote:
> For the LE only controllers, there are events that should not be enabled
> if the corresponding command is not supported.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
