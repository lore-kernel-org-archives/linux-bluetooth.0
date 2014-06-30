Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Jun 2014 18:16:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Start background scanning only when
 controller is ready
Message-ID: <20140630151613.GA23879@t440s.P-661HNU-F1>
References: <1404137052-15424-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404137052-15424-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jun 30, 2014, Marcel Holtmann wrote:
> When the controller is not active or in init/setup phase, do not
> try to start or stop background scanning.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
