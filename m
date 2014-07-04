Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Jul 2014 21:13:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add support for Set External Configuration
 management command
Message-ID: <20140704181348.GB17855@t440s.P-661HNU-F1>
References: <1404490315-30656-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404490315-30656-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jul 04, 2014, Marcel Holtmann wrote:
> The Set External Configuration management command allows for switching
> between configured and unconfigured start if HCI_QURIK_EXTERNAL_CONFIG
> is set by the transport driver.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h  |  1 +
>  include/net/bluetooth/mgmt.h |  6 ++++
>  net/bluetooth/mgmt.c         | 77 ++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 82 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
