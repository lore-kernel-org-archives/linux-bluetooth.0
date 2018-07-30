Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v5 00/16] Bluetooth: Extended Adv, Scan, Connection and
 PHY support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
Date: Mon, 30 Jul 2018 13:58:26 +0200
Cc: linux-bluetooth@vger.kernel.org,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Message-Id: <9B5300EA-EA7B-46E7-A171-84A69F4578AC@holtmann.org>
References: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> Implemented Get, Set PHY Configuration and setting of PHY in
> Advertising. Also implemented extended advertising,
> scanning and connection.
> 
> v2: Fixed kbuild warnings
> v3: Added BREDR packet types in PHY Configurtion commands and events
> v4: Added default phys as variable in hdev and removed same from hci flags
> v5: Applied Marcel's comments
> 
> Jaganath Kanakkassery (16):
>  Bluetooth: Define PHY flags in hdev and set 1M as default
>  Bluetooth: Add defines for BREDR pkt_type and LE PHYs
>  Bluetooth: Implement Get PHY Configuration mgmt command
>  Bluetooth: Implement Set PHY Confguration command
>  Bluetooth: Implement PHY changed event
>  Bluetooth: Set Scan PHYs based on selected PHYs by user
>  Bluetooth: Handle extended ADV PDU types
>  Bluetooth: Use selected PHYs in extended connect
>  Bluetooth: Read no of adv sets during init
>  Bluetooth: Impmlement extended adv enable
>  Bluetooth: Use Set ext adv/scan rsp data if controller supports
>  Bluetooth: Implement disable and removal of adv instance
>  Bluetooth: Use ext adv for directed adv
>  Bluetooth: Implement Set ADV set random address
>  Bluetooth: Handle ADv set terminated event
>  Bluetooth: Implement secondary advertising on different PHYs
> 
> include/net/bluetooth/hci.h      | 118 +++++++++-
> include/net/bluetooth/hci_core.h |  26 ++
> include/net/bluetooth/mgmt.h     |  55 +++++
> net/bluetooth/hci_conn.c         | 151 +++++++++---
> net/bluetooth/hci_core.c         |  72 +++++-
> net/bluetooth/hci_event.c        | 250 ++++++++++++++++++--
> net/bluetooth/hci_request.c      | 498 ++++++++++++++++++++++++++++++++++-----
> net/bluetooth/hci_request.h      |   8 +
> net/bluetooth/mgmt.c             | 405 ++++++++++++++++++++++++++++++-
> 9 files changed, 1451 insertions(+), 132 deletions(-)

all 16 patches have been applied to bluetooth-next tree.

Regards

Marcel

