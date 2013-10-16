Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Oct 2013 10:32:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/6] Bluetooth: Rename create_ad into create_adv_data
Message-ID: <20131016073239.GA24410@x220.p-661hnu-f1>
References: <1381907811-33872-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381907811-33872-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 16, 2013, Marcel Holtmann wrote:
> Rename the create_ad function into create_adv_data to make it clear
> that it is used to create the advertising data. This is important
> since later on a function adding the scan response data will be
> added.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

All six patches have been applied to bluetooth-next. Thanks.

Johan
