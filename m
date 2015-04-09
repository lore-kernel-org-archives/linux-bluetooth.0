Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Apr 2015 10:42:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: btusb: Use proper data structures for
 Intel vendor events
Message-ID: <20150409074238.GA27217@t440s.lan>
References: <1428564919-10398-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428564919-10398-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Apr 09, 2015, Marcel Holtmann wrote:
> The Intel vendors events indicating firmware loading result and the
> bootup of the operational firmware are currently hardcoded byte
> comparisons. So intead of doing that, provide proper data structures
> and actually use them.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btintel.h | 15 +++++++++
>  drivers/bluetooth/btusb.c   | 79 ++++++++++++++++++++++++++++++---------------
>  2 files changed, 68 insertions(+), 26 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
