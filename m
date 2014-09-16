Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Sep 2014 06:42:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: btusb: Split fragement receiption into
 separate functions
Message-ID: <20140916034206.GB21934@t440s.P-661HNU-F1>
References: <1410838413-16122-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410838413-16122-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Sep 16, 2014, Marcel Holtmann wrote:
> The actual packet reassembly should be done inside the driver. To allow
> this to happen cleany in future patches, split the fragement receiption
> into its own functions.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
