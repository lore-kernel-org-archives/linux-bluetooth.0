Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1519384128-2016-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1519384128-2016-1-git-send-email-jaganathx.kanakkassery@intel.com>
From: Jaganath K <jaganath.k.os@gmail.com>
Date: Mon, 5 Mar 2018 13:41:35 +0530
Message-ID: <CAJzH+bobG4osbD4hRr+2S-Rbbw9ncOGCuFL5J8-1-JtJNPq7xw@mail.gmail.com>
Subject: Re: [PATCH 00/11] Ext scan/connect and PHY Configuration
To: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Feb 23, 2018 at 4:38 PM, Jaganath Kanakkassery
<jaganath.k.os@gmail.com> wrote:
> The patch set implements extended scanning and conection and use it
> based on the controller support.
>
> This also implements PHY configuration mgmt commands and events
> to set defualt PHY and PHYs to be used for scan and connect.
>
> One downside of this approch is user cannot force kernel to use
> legacy comands if controller is 5.0.
>
> Jaganath Kanakkassery (11):
>   Bluetooth: Introduce helpers for LE set scan start and complete
>   Bluetooth: Use extended scanning if controller supports
>   Bluetooth: Process extended ADV report event
>   Bluetooth: Introduce helpers for le conn status and complete
>   Bluetooth: Use extended LE Connection if supported
>   Bluetooth: Define PHY flags in hdev and set 1M as default
>   Bluetooth: Implement Get PHY Configuration mgmt command
>   Bluetooth: Implement Set PHY Confguration command
>   Bluetooth: Set Scan PHYs based on selected PHYs by user
>   Bluetooth: Handle extended ADV PDU types
>   Bluetooth: Use selected PHYs in extended connect
>
>  include/net/bluetooth/hci.h      | 110 ++++++++++++
>  include/net/bluetooth/hci_core.h |  15 ++
>  include/net/bluetooth/mgmt.h     |  31 ++++
>  net/bluetooth/hci_conn.c         | 103 +++++++++--
>  net/bluetooth/hci_core.c         |  17 ++
>  net/bluetooth/hci_event.c        | 371 ++++++++++++++++++++++++++++++++-------
>  net/bluetooth/hci_request.c      | 156 +++++++++++-----
>  net/bluetooth/hci_sock.c         |   1 +
>  net/bluetooth/mgmt.c             | 231 ++++++++++++++++++++++++
>  9 files changed, 914 insertions(+), 121 deletions(-)
>
> --

Ping.

Thanks,
Jaganath
