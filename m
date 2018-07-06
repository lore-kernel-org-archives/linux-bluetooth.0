Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v3 05/18] Bluetooth: Use extended LE Connection if
 supported
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1530876944-17453-6-git-send-email-jaganathx.kanakkassery@intel.com>
Date: Fri, 6 Jul 2018 22:57:24 +0200
Cc: linux-bluetooth@vger.kernel.org,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Message-Id: <B9EAC95F-5A5C-455B-A586-C83E2C219B2F@holtmann.org>
References: <1530876944-17453-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1530876944-17453-6-git-send-email-jaganathx.kanakkassery@intel.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> This implements extended LE craete connection and enhanced
> LE conn complete event if the controller supports.
> 
> For now it is as good as legacy LE connection and event as
> no new features in the extended connection is handled.
> 
> < HCI Command: LE Extended Create Connection (0x08|0x0043) plen 26
>        Filter policy: White list is not used (0x00)
>        Own address type: Public (0x00)
>        Peer address type: Random (0x01)
>        Peer address: DB:7E:2E:1D:85:E8 (Static)
>        Initiating PHYs: 0x01
>        Entry 0: LE 1M
>          Scan interval: 60.000 msec (0x0060)
>          Scan window: 60.000 msec (0x0060)
>          Min connection interval: 50.00 msec (0x0028)
>          Max connection interval: 70.00 msec (0x0038)
>          Connection latency: 0 (0x0000)
>          Supervision timeout: 420 msec (0x002a)
>          Min connection length: 0.000 msec (0x0000)
>          Max connection length: 0.000 msec (0x0000)
>> HCI Event: Command Status (0x0f) plen 4
>      LE Extended Create Connection (0x08|0x0043) ncmd 2
>        Status: Success (0x00)
>> HCI Event: LE Meta Event (0x3e) plen 31
>      LE Enhanced Connection Complete (0x0a)
>        Status: Success (0x00)
>        Handle: 3585
>        Role: Master (0x00)
>        Peer address type: Random (0x01)
>        Peer address: DB:7E:2E:1D:85:E8 (Static)
>        Local resolvable private address: 00:00:00:00:00:00 (Non-Resolvable)
>        Peer resolvable private address: 00:00:00:00:00:00 (Non-Resolvable)
>        Connection interval: 67.50 msec (0x0036)
>        Connection latency: 0 (0x0000)
>        Supervision timeout: 420 msec (0x002a)
>        Master clock accuracy: 0x00
> @ MGMT Event: Device Connected (0x000b) plen 40
>        LE Address: DB:7E:2E:1D:85:E8 (Static)
>        Flags: 0x00000000
>        Data length: 27
>        Name (complete): Designer Mouse
>        Appearance: Mouse (0x03c2)
>        Flags: 0x05
>          LE Limited Discoverable Mode
>          BR/EDR Not Supported
>        16-bit Service UUIDs (complete): 1 entry
>          Human Interface Device (0x1812)
> 
> Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
> ---
> include/net/bluetooth/hci.h      | 36 ++++++++++++++++++++
> include/net/bluetooth/hci_core.h |  2 ++
> net/bluetooth/hci_conn.c         | 72 ++++++++++++++++++++++++++++++----------
> net/bluetooth/hci_core.c         |  6 ++++
> net/bluetooth/hci_event.c        | 47 ++++++++++++++++++++++++++
> 5 files changed, 145 insertions(+), 18 deletions(-)

patches 1-5 have been applied to bluetooth-next tree.

Regards

Marcel

