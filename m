Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Jul 2014 08:52:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add support for controller configuration info
 command
Message-ID: <20140704055237.GA5208@t440s.P-661HNU-F1>
References: <1404427616-34654-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404427616-34654-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jul 04, 2014, Marcel Holtmann wrote:
> The Read Controller Configuration Information command allows retrieving
> details about possible configurations option. The supported options are
> returned and also the missing options (if any).
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/mgmt.h | 11 +++++++++++
>  net/bluetooth/mgmt.c         | 28 ++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
