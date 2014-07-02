Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Jul 2014 09:39:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Add support for hdev->set_bdaddr callback
 handling
Message-ID: <20140702063939.GA26245@t440s.P-661HNU-F1>
References: <1404255228-51661-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404255228-51661-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jul 02, 2014, Marcel Holtmann wrote:
> Some embedded controllers allow the programming of a public address
> and this adds vendor support for supporting OEM confguration of such
> addresses.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  2 ++
>  net/bluetooth/hci_core.c         | 11 +++++++++++
>  2 files changed, 13 insertions(+)

Both patches have been applied to bluetooth-next. Thanks.

Johan
