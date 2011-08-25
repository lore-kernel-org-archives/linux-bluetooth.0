Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Aug 2011 10:03:14 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Antti Julku <antti.julku@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: Add mgmt events for blacklisting
Message-ID: <20110825130314.GC25269@joana>
References: <1314280082-1571-1-git-send-email-antti.julku@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314280082-1571-1-git-send-email-antti.julku@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antti,

* Antti Julku <antti.julku@nokia.com> [2011-08-25 16:48:02 +0300]:

> Add management interface events for blocking/unblocking a device.
> Sender of the block device command gets cmd complete and other
> mgmt sockets get the event. Event is also sent to mgmt sockets when
> blocking is done with ioctl, e.g when blocking a device with
> hciconfig. This makes it possible for bluetoothd to track status
> of blocked devices when a third party block or unblocks a device.
> 
> Event sending is handled in mgmt_device_blocked function which gets
> called from hci_blacklist_add in hci_core.c. A pending command is
> added in mgmt_block_device, so that it can found when sending the
> event - the event is not sent to the socket from which the pending
> command came. Locks were moved out from hci_core.c to hci_sock.c
> and mgmt.c, because locking is needed also for mgmt_pending_add in
> mgmt.c.
> 
> Signed-off-by: Antti Julku <antti.julku@nokia.com>
> ---
>  include/net/bluetooth/hci_core.h |    2 +
>  include/net/bluetooth/mgmt.h     |   10 ++++++
>  net/bluetooth/hci_core.c         |   28 ++++-------------
>  net/bluetooth/hci_sock.c         |   18 ++++++++++-
>  net/bluetooth/mgmt.c             |   62 ++++++++++++++++++++++++++++++++++----
>  5 files changed, 90 insertions(+), 30 deletions(-)

Patch has been applied, thanks.

	Gustavo
