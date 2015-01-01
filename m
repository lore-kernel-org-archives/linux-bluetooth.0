Return-Path: <cyrus@holtmann.org>
Date: Thu, 1 Jan 2015 10:59:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Bluetooth: Introduce force_bredr_smp debugfs option
 for testing
Message-ID: <20150101085901.GA13261@t440s.P-661HNU-F1>
References: <1420065799-28781-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1420065799-28781-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Dec 31, 2014, Marcel Holtmann wrote:
> Testing cross-transport pairing that starts on BR/EDR is only valid when
> using a controller with BR/EDR Secure Connections. Devices will indicate
> this by providing BR/EDR SMP fixed channel over L2CAP. To allow testing
> of this feature on Bluetooth 4.0 controller or controllers without the
> BR/EDR Secure Connections features, introduce a force_bredr_smp debugfs
> option that allows faking the required AES connection.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h |  1 +
>  net/bluetooth/l2cap_core.c  |  2 +-
>  net/bluetooth/smp.c         | 78 ++++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 76 insertions(+), 5 deletions(-)

All four patches in this set have been applied to bluetooth-next.
Thanks.

Johan
