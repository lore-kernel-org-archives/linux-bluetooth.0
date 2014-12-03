Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 00/49] Bluetooth: LE Secure Connections support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 3 Dec 2014 15:56:49 +0000
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7A80F19C-B469-4BE1-90E3-6D274EFC4D4D@holtmann.org>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> First of all, appologies to all for this huge patch set. It's work from
> the past 6 months or so that wasn't releasable until the 4.2
> specification goes public. That happened just some moments ago:
> 
> http://www.bluetooth.com/SiteCollectionDocuments/4-2/bluetooth4-2.aspx
> 
> I'm sending the patches to the mailing list mainly for reference since
> Marcel will probably directly merge them from my tree. Any issues/fixes
> etc should be done on top of them.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (49):
>      Bluetooth: Add basic SMP defines for LE Secure Connections
>      Bluetooth: Make auth_req mask dependent on SC enabled or not
>      Bluetooth: Add SMP flag for SC and set it when necessary.
>      Bluetooth: Update SMP security level to/from auth_req for SC
>      Bluetooth: Add mgmt support for LE Secure Connections LTK types
>      Bluetooth: Set the correct security level for SC LTKs
>      Bluetooth: Use custom macro for testing BR/EDR SC enabled
>      Bluetooth: Add mgmt_set_secure_conn support for any LE adapter
>      Bluetooth: Update LTK lookup to correctly deal with SC LTKs
>      Bluetooth: Remove unused hci_find_ltk function
>      Bluetooth: Rename hci_find_ltk_by_addr to hci_find_ltk
>      Bluetooth: Set link key generation bit if necessary for LE SC
>      Bluetooth: Add basic support for AES-CMAC
>      Bluetooth: Add ECC library for LE Secure Connections
>      Bluetooth: Add basic support for sending our LE SC public key
>      Bluetooth: Add handler function for receiving LE SC public key
>      Bluetooth: Add support for sending LE SC Confirm value
>      Bluetooth: Add LE SC support for responding to Pairing Confirm PDU
>      Bluetooth: Add support for LE SC numeric comparison
>      Bluetooth: Add support for handling LE SC user response
>      Bluetooth: Add support for LE SC DHKey check PDU
>      Bluetooth: Add support for LE SC key generation
>      Bluetooth: Track authentication method in SMP context
>      Bluetooth: Add selection of the SC authentication method
>      Bluetooth: Detect SMP SC debug keys
>      Bluetooth: Add check for accidentally generating a debug key
>      Bluetooth: Set correct LTK type and authentication for SC
>      Bluetooth: Add support for SC just-works pairing
>      Bluetooth: Fix BR/EDR Link Key type when derived through LE SC
>      Bluetooth: Add passkey entry support for LE SC
>      Bluetooth: Fix DHKey Check sending order for slave role
>      Bluetooth: Add dummy handler for LE SC keypress notification
>      Bluetooth: Use debug keys for SMP when HCI_USE_DEBUG_KEYS is set
>      Bluetooth: Add hci_conn flag for new link key generation
>      Bluetooth: Add debugfs switch for forcing SMP over BR/EDR
>      Bluetooth: Add skeleton for BR/EDR SMP channel
>      Bluetooth: Add full SMP BR/EDR support
>      Bluetooth: Add SC-only mode support for SMP
>      Bluetooth: Unify remote OOB data functions
>      Bluetooth: Store address type with OOB data
>      Bluetooth: Add support for adding remote OOB data for LE
>      Bluetooth: Set SMP OOB flag if OOB data is available
>      Bluetooth: Add basic LE SC OOB support for remote OOB data
>      Bluetooth: Introduce SMP_DBG macro for low-level debuging
>      Bluetooth: Fix missing const declarations in SMP functions
>      Bluetooth: Organize SMP crypto functions to logical sections
>      Bluetooth: Fix SMP debug key handling
>      Bluetooth: Fix minor coding style issue in smp.c
>      Bluetooth: Fix false-positive "uninitialized" compiler warning
> 
> include/net/bluetooth/hci.h      |    1 +
> include/net/bluetooth/hci_core.h |   23 +-
> include/net/bluetooth/l2cap.h    |    2 +
> include/net/bluetooth/mgmt.h     |    3 +
> net/bluetooth/Kconfig            |    1 +
> net/bluetooth/Makefile           |    2 +-
> net/bluetooth/ecc.c              |  816 ++++++++++++++++++++
> net/bluetooth/ecc.h              |   54 ++
> net/bluetooth/hci_core.c         |  155 ++--
> net/bluetooth/hci_event.c        |   23 +-
> net/bluetooth/l2cap_core.c       |    4 +
> net/bluetooth/mgmt.c             |   75 +-
> net/bluetooth/smp.c              | 1543 +++++++++++++++++++++++++++++++++----
> net/bluetooth/smp.h              |   51 +-
> 14 files changed, 2509 insertions(+), 244 deletions(-)

all 49 patches have been applied to bluetooth-next tree.

Regards

Marcel

