Return-Path: <cyrus@holtmann.org>
Date: Wed, 21 Oct 2015 07:35:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4] Bluetooth: btintel: Enable extra Intel vendor events
Message-ID: <20151021043540.GD12268@t440s.P-661HNU-F1>
References: <1445388319-43632-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445388319-43632-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 21, 2015, Marcel Holtmann wrote:
> The Intel Bluetooth controllers can emit extra vendor specific events in
> error conditions or for debugging purposes. To make the life easier for
> engineers, enable them by default. When the vendor_diag options has been
> enabled, then additional debug events are also enabled.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btintel.c | 62 ++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btintel.h | 12 +++++++++
>  drivers/bluetooth/btusb.c   | 27 ++++++++++++++------
>  3 files changed, 92 insertions(+), 9 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
