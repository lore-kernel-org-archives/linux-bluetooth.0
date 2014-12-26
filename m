Return-Path: <cyrus@holtmann.org>
Date: Fri, 26 Dec 2014 20:35:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Bluetooth: Introduce HCI_QUIRK_BROKEN_LOCAL_COMMANDS
 constant
Message-ID: <20141226183531.GA30720@t440s.P-661HNU-F1>
References: <1419565354-49553-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419565354-49553-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Dec 26, 2014, Marcel Holtmann wrote:
> Some controllers advertise support for Bluetooth 1.2 specification,
> but they do not support the HCI Read Local Supported Commands command.
> 
> If that is the case, then the driver can quirk the behavior and force
> the core to skip this command. This will allow removing vendor specific
> checks out of the core.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)

All four patches in this set have been applied to bluetooth-next.
Thanks.

Johan
