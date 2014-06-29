Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Jun 2014 20:53:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Add support for Add/Remove Device
 management commands
Message-ID: <20140629175319.GA19150@t440s.P-661HNU-F1>
References: <1404063843-48945-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404063843-48945-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jun 29, 2014, Marcel Holtmann wrote:
> This allows adding or removing devices from the background scanning
> list the kernel maintains. Device flagged for auto-connection will
> be automatically connected if they are found.
> 
> The passive scanning required for auto-connection will be started
> and stopped on demand.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/mgmt.h | 13 ++++++
>  net/bluetooth/mgmt.c         | 99 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 111 insertions(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
