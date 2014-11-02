Return-Path: <cyrus@holtmann.org>
Date: Sun, 2 Nov 2014 10:05:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Add hci_reset_dev() for driver triggerd
 stack reset
Message-ID: <20141102080509.GE20526@t440s.P-661HNU-F1>
References: <1414912539-1010-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414912539-1010-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Nov 02, 2014, Marcel Holtmann wrote:
> Some Bluetooth drivers require to reset the upper stack. To avoid having
> all drivers send HCI Hardware Error events, provide a generic function
> to wrap the reset functionality.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)

Both patches in this set have been applied to bluetooth-next. Thanks.

Johan
