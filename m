Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Nov 2013 10:55:41 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Bluetooth: Remove unneeded check in
 hci_disconn_complete_evt()
Message-ID: <20131108085541.GA23164@x220.p-661hnu-f1>
References: <1383856570-30480-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383856570-30480-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Thu, Nov 07, 2013, Andre Guedes wrote:
> According to b644ba336 (patch that introduced HCI_CONN_MGMT_CONNECTED
> flag), the HCI_CONN_MGMT_CONNECTED flag tracks when mgmt has been
> notified about the connection.
> 
> That being said, there is no point in calling mgmt_disconnect_failed()
> conditionally based on this flag. mgmt_disconnect_failed() removes
> pending MGMT_OP_DISCONNECT commands, it doesn't matter if that
> connection was notified or not.
> 
> Moreover, if the Disconnection Complete event has status then we have
> nothing else to do but call mgmt_disconnect_failed() and return.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)

Both patches have now been applied to bluetooth-next. Thanks.

Johan
