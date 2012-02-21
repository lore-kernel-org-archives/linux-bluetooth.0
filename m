Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Feb 2012 14:21:36 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Only keep controller up after init if
 powered on
Message-ID: <20120221122136.GA31177@x220>
References: <1329822865-12312-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329822865-12312-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Feb 21, 2012, Marcel Holtmann wrote:
> When a new controller gets added to the system, it needs to be brought
> up briefly to read basic information like features, BD_ADDR etc. and
> after a timeout it will be brought back down.
> 
> The only command that should overwrite this timeout is the set power
> command from the management interface. Just reading the controller
> list or information is not a good reason to keep the controller up.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c |   23 ++++++++++++++---------
>  1 files changed, 14 insertions(+), 9 deletions(-)

Applied to my bluetooth-next tree. Thanks.

Johan
