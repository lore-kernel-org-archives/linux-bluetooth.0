Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Oct 2013 09:34:45 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Set default own address type only during
 controller setup
Message-ID: <20131030073445.GA1710@x220.p-661hnu-f1>
References: <1383074811-6623-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383074811-6623-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 29, 2013, Marcel Holtmann wrote:
> The default own address type is currently set at every power on of
> a controller. This overwrites the value set via debugfs. To avoid
> this issue, set the default own address type only during controller
> setup.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
