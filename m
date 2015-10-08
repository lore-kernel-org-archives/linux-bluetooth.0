Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Oct 2015 15:34:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix basic debugfs entries for unconfigured
 controllers
Message-ID: <20151008123421.GA12431@t440s.lan>
References: <1444300542-96764-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444300542-96764-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 08, 2015, Marcel Holtmann wrote:
> When the controller is unconfigured (for example it does not have a
> valid Bluetooth address), then the basic debugfs entries for dut_mode
> and vendor_diag are not creates. Ensure they are created in __hci_init
> and also __hci_unconf_init functions. One of them is called during setup
> stage of a new controller.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
