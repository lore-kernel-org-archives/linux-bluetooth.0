Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Jul 2014 13:54:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Move HCI socket definitions into its own
 header file
Message-ID: <20140711105413.GA14378@t440s.P-661HNU-F1>
References: <1405047509-46346-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405047509-46346-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jul 11, 2014, Marcel Holtmann wrote:
> All the HCI sockets and ioctl based definitions have been in a global
> header file that also includes all the HCI protocol structures. To
> make this a bit cleaner, move them into its own file.
> 
> This also adjusts fs/compat_ioctl.c to only include this new file
> and not all the protocol structures that are not needed.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  fs/compat_ioctl.c                |   2 +-
>  include/net/bluetooth/hci.h      | 149 ---------------------------------
>  include/net/bluetooth/hci_core.h |   1 +
>  include/net/bluetooth/hci_sock.h | 175 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 177 insertions(+), 150 deletions(-)
>  create mode 100644 include/net/bluetooth/hci_sock.h

Applied to bluetooth-next. Thanks.

Johan
