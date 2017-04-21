Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH V3 0/3] hci_ldisc hci_uart_init_work() fixes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1492708001-30228-1-git-send-email-Dean_Jenkins@mentor.com>
Date: Fri, 21 Apr 2017 18:26:40 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <8BE5CB4A-F3D7-47F7-90D6-2FBE1240A677@holtmann.org>
References: <1492708001-30228-1-git-send-email-Dean_Jenkins@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

> To make things easier for you, I am going to break up my V2 patchset of 16
> patches into smaller patchsets. I think this approach will increase the
> probability of you taking the patches and providing me feedback. Therefore, you
> can concentrate on a few tightly related patches in one go.
> 
> This is patchset V3 which are needed fixes before hci_uart_tty_close() can be
> reorganised to overcome a design flaw related to the proper closure of the
> Data Link protocol layer. In the worst case scenario a kernel crash occurs.
> 
> Previous Discussions
> ====================
> 
> Please refer to the discussion on my patchset V2 that can be found here:
> https://www.spinics.net/lists/linux-bluetooth/msg70183.html
> 
> Please refer to the discussion on my RFC patchset V1 that can be found here:
> https://www.spinics.net/lists/linux-bluetooth/msg70077.html
> 
> 
> Changes between V2 and V3
> =========================
> 
> 1. Only presenting the first 3 patches of the V2 patchset. These changes relate
>   mainly to handling of the failure to register the hdev device for the h5
>   Protocol Data layer protocol.
> 
> 2. The remaining 13 patches will be put into smaller patchsets after this first
>   patchset has been accepted.
> 
> 3. Changed the patchset title from "hci_ldisc hci_uart_tty_close() fixes" to
>   "hci_ldisc hci_uart_init_work() fixes" because this patchset does not modify
>   hci_uart_tty_close().
> 
> 
> Changes between V1 and V2
> =========================
> 
> 1. Implemented some minor code style changes that were suggested by Marcel
> Holtmann.
> 2. Reordered some of the patches to better group together related changes.
> 
> Analysis
> ========
> 
> hci_uart_init_work() is used with the h5 Data Link layer protocol. Static code
> inspection reveals issues. Instead of testing with h5, test code was used to
> show that a kernel crash occurs in HCI LDISC.
> 
> hci_uart_init_work() is used to register the HCI UART device and sets the
> HCI_UART_REGISTERED flag after the h5 protocol has reached the H5_ACTIVE state
> and calls hci_uart_init_ready(). This procedure is armed by setting the
> HCI_UART_INIT_PENDING flag via hci_uart_tty_ioctl() using HCIUARTSETFLAGS.
> 
> During my analysis, it became clear that the hci_uart_init_work() function was
> incomplete. Initially, it caused me confusion in how the design allowed
> HCI_UART_REGISTERED to be set despite hci_register_dev() failing.
> 
> 
> Test code was added to:
> a) set flag HCI_UART_INIT_PENDING - used with h5 to delay hdev registration
> b) call hci_uart_init_ready() - simulates h5 reaching the H5_ACTIVE state
> c) force hci_register_dev() to fail
> 
> This testcase caused a kernel crash because hdev was freed in
> hci_uart_init_work() but the HCI_UART_REGISTERED flag was set. Therefore,
> the HCI_UART_REGISTERED flag is erroneously set on the failure of
> hci_register_dev(). This is fixed in the following patch by adding a missing
> return statement:
> 
>  Bluetooth: hci_ldisc: Add missing return in hci_uart_init_work()
> 
> 
> Analysis of hu->hdev showed that the hdev member of hu could remain present
> despite hdev having been freed. This is potentially dangerous as there is a risk
> of using hu->hdev after hdev was freed. This is fixed in patch:
> 
>  Bluetooth: hci_ldisc: Ensure hu->hdev set to NULL before freeing hdev
> 
> 
> Analysis of the flag HCI_UART_PROTO_READY showed an inconsistency for
> hci_register_dev() failing in hci_uart_init_work(). The oversight is that
> HCI_UART_PROTO_READY must be cleared before the close "proto" function pointer
> is called as per hci_uart_set_proto() and hci_uart_tty_close(). This is fixed
> in patch:
> 
>  Bluetooth: hci_ldisc: Add missing clear HCI_UART_PROTO_READY
> 
> 
> Patch list
> ==========
> 
> The patches were rebased onto the bluetooth-next/master branch commit:
> 6493b63 ieee802154: don't select COMMON_CLK
> 
> Dean Jenkins (3):
>  Bluetooth: hci_ldisc: Add missing return in hci_uart_init_work()
>  Bluetooth: hci_ldisc: Ensure hu->hdev set to NULL before freeing hdev
>  Bluetooth: hci_ldisc: Add missing clear HCI_UART_PROTO_READY
> 
> drivers/bluetooth/hci_ldisc.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

