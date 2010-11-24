Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Nov 2010 07:42:11 +0200
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Subject: Re: [RFC 00/20] Simple SMP Just Works implementation
Message-ID: <20101124054211.GI874@null>
References: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,


On Tue, Nov 23, 2010 at 12:06:16PM -0300, ext Vinicius Costa Gomes wrote:
> Hi,
> 
> This is an implementation of the Just Works SMP procedure, on top of the work
> done by Ville (included in this series to give some context). The SMP stuff
> starts at 11/20.
> 
> The most important thing about this series is the discussion that (I hope)
> it will cause.
> 
> Some things that I would like to point (in no order):
> 
> - the SMP function names follow the spec nomeclature, would it be better to
>   use more meaningful names?
> 
> - the crypto transform is allocated during the adapter registration, is this
>   the best place to do this?
> 
> - renaming l2cap.c to l2cap_core.c was the only way we could find to keep the
>   SMP implementation separated from the "core" l2cap.

Gustavo do you have something against this change?

> 
> I think this is enough to start a discussion.
> 
> So, as the Human Torch would say: Flame on! :-)

I'll try to find time to do some testing soon.



> 
> Anderson Briglia (3):
>   Bluetooth: Start SMP procedure
>   Bluetooth: simple SMP pairing negotiation
>   Bluetooth: LE SMP Cryptoolbox functions
> 
> Ville Tervo (10):
>   Bluetooth: Add low energy commands and events
>   Bluetooth: Add LE connect support
>   Bluetooth: Use LE buffers for LE traffic
>   Bluetooth: Add LE connection support to L2CAP
>   Bluetooth: Add server socket support for LE connection
>   Bluetooth: Do not send disconn comand over LE links
>   Bluetooth: Treat LE and ACL links separately on timeout
>   Bluetooth: Fix locking balance in l2cap_le_conn_ready
>   Bluetooth: Add server socket support for LE connection
>   Bluetooth: Add SMP command structures
> 
> Vinicius Costa Gomes (7):
>   Bluetooth: Fix initiated LE connections
>   Bluetooth: fix receiving L2CAP packets over LE
>   Bluetooth: Implement the first SMP commands
>   Bluetooth: Add support for using the crypto subsystem
>   Bluetooth: Add support for SMP confirmation checks
>   Bluetooth: Add support for LE Start Encryption
>   Bluetooth: Add support for resuming socket when SMP is finished
> 
>  include/net/bluetooth/hci.h             |   86 ++++++
>  include/net/bluetooth/hci_core.h        |   37 +++-
>  include/net/bluetooth/l2cap.h           |   10 +
>  include/net/bluetooth/smp.h             |   80 ++++++
>  net/bluetooth/Makefile                  |    1 +
>  net/bluetooth/hci_conn.c                |  104 +++++++-
>  net/bluetooth/hci_core.c                |   94 ++++++-
>  net/bluetooth/hci_event.c               |  206 ++++++++++++++-
>  net/bluetooth/{l2cap.c => l2cap_core.c} |  237 +++++++++++++---
>  net/bluetooth/smp.c                     |  465 +++++++++++++++++++++++++++++++
>  10 files changed, 1264 insertions(+), 56 deletions(-)
>  create mode 100644 include/net/bluetooth/smp.h
>  rename net/bluetooth/{l2cap.c => l2cap_core.c} (96%)
>  create mode 100644 net/bluetooth/smp.c
> 
> -- 
> 1.7.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
