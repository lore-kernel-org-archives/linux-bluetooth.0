Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Jan 2014 11:08:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v5 00/14] LE auto connection and connection parameters
Message-ID: <20140122090834.GC9532@x220.p-661hnu-f1>
References: <1387540675-2466-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387540675-2466-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Fri, Dec 20, 2013, Andre Guedes wrote:
> This patch set is pretty much the same of previous one, except it implements
> a different approach to handle discovery and LE connection (as discussed on
> "[RFC v4 05/12] Bluetooth: Stop scanning on LE connection").
> 
> Regards,
> 
> Andre
> 
> 
> Andre Guedes (14):
>   Bluetooth: Save connection interval parameters in hci_conn
>   Bluetooth: Group list_head fields from strcut hci_dev together
>   Bluetooth: Introduce connection parameters list
>   Bluetooth: Use connection parameters if any
>   Bluetooth: Introduce fail_conn_attempt() helper
>   Bluetooth: Stop scanning on LE connection
>   Bluetooth: Remove unused function
>   Bluetooth: Introduce hdev->pend_le_conn list
>   Bluetooth: Introduce LE auto connection infrastructure
>   Bluetooth: Re-enable background scan in case of error
>   Bluetooth: Temporarily stop background scanning on discovery
>   Bluetooth: Auto connection and power on
>   Bleutooth: Add support for auto connect options
>   Bluetooth: Add le_auto_conn file on debugfs
> 
>  include/net/bluetooth/hci.h      |   1 +
>  include/net/bluetooth/hci_core.h |  43 +++++-
>  net/bluetooth/hci_conn.c         | 111 +++++++++++---
>  net/bluetooth/hci_core.c         | 318 +++++++++++++++++++++++++++++++++++++++
>  net/bluetooth/hci_event.c        |  60 ++++++++
>  net/bluetooth/mgmt.c             |  25 ++-
>  6 files changed, 530 insertions(+), 28 deletions(-)

Besides the couple of minor things I just pointed out I didn't find
anything else obviously wrong with this patch set. It might be worth to
send a rebased non-RFC version of it (with the changes I suggested if
you agree with them) so we get this moving forward.

Johan
.
