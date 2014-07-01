Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC v3 4/4] Bluetooth: Introduce "New Connection Parameter" Event
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404249011-23645-4-git-send-email-andre.guedes@openbossa.org>
Date: Tue, 1 Jul 2014 23:45:40 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <831A7F81-23CA-403B-A17E-29C20676B2CE@holtmann.org>
References: <1404249011-23645-1-git-send-email-andre.guedes@openbossa.org> <1404249011-23645-4-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch introduces a new Mgmt event called "New Connection Parameter".
> This event indicates to userspace the connection parameters values the
> remote device requested.
> 
> The user may store these values and load them into kernel. This way, next
> time a connection is established to that device, the kernel will use those
> parameters values instead of the default ones.
> 
> This event is sent when the remote device requests new connection
> parameters through connection parameter update procedure. This event is
> not sent for slave connections.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> include/net/bluetooth/hci_core.h |  3 +++
> include/net/bluetooth/mgmt.h     | 10 ++++++++++
> net/bluetooth/hci_event.c        |  4 ++++
> net/bluetooth/l2cap_core.c       |  6 +++++-
> net/bluetooth/mgmt.c             | 19 +++++++++++++++++++
> 5 files changed, 41 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

