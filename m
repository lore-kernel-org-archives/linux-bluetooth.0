Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Oct 2013 18:48:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add HCI command structure for writing current
 IAC LAP
Message-ID: <20131015154837.GB25463@x220.p-661hnu-f1>
References: <1381851255-34399-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381851255-34399-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 15, 2013, Marcel Holtmann wrote:
> This patch just adds the HCI command structure for configuring the
> current IAC LAP setting. The length of the command is variable and
> supports more than two IAC. However since there is only general
> discoverable and limited discoverable modes, this can be limited
> to two possible IACs.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
