Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Jul 2014 20:27:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Read list of local codecs supported by the
 controller
Message-ID: <20140723172746.GA30463@t440s.P-661HNU-F1>
References: <1406135604-26220-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406135604-26220-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jul 23, 2014, Marcel Holtmann wrote:
> If the Bluetooth controller supports Read Local Supported Codecs
> command, the issue it during initialization so that the list of
> codecs is known.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h | 2 ++
>  net/bluetooth/hci_core.c    | 4 ++++
>  2 files changed, 6 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
