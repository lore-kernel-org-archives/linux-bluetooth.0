Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Oct 2015 09:51:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Send index information updates to monitor
 channel
Message-ID: <20151008065107.GA25309@t440s.lan>
References: <1444224733-20368-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444224733-20368-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 07, 2015, Marcel Holtmann wrote:
> The Bluetooth public device address might change during controller setup
> and it makes it a lot simpler for monitoring tools if they just get told
> what the new address is. In addition include the manufacturer / company
> information of the controller. That allows for easy vendor specific HCI
> command and event handling.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_mon.h |  7 +++++++
>  net/bluetooth/hci_sock.c        | 25 ++++++++++++++++++++++++-
>  2 files changed, 31 insertions(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
