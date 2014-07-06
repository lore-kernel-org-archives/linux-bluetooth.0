Return-Path: <cyrus@holtmann.org>
Date: Sun, 6 Jul 2014 17:12:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix memory leaking when hdev->send returns an
 error
Message-ID: <20140706141218.GA9808@t440s.P-661HNU-F1>
References: <1404653775-2386-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404653775-2386-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jul 06, 2014, Marcel Holtmann wrote:
> The drivers are allowed to just return an error from hdev->send callback
> and in that case the driver does not own the SKB. Which means that the
> caller has to free the SKB.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
