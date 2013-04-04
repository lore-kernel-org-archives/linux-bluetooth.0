Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Apr 2013 11:26:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Fix Inquiry command support in HCI request
 framework
Message-ID: <20130404082613.GC2340@x220>
References: <1364425497-30944-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364425497-30944-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Wed, Mar 27, 2013, Andre Guedes wrote:
> This v2 implements the following comments about the previous patch set:
>  - Consider commands (which don't send Command Complete Event) as completed
>    based on Command Status Event.
>  - Remove hci_req_cmd_status function.
> 
> Thus, for those HCI commands which don't send Command Complete Event, the HCI
> request framework considers they have completed when the Command Status Event
> is received. 
> 
> Regards,
> 
> Andre
> 
> Andre Guedes (3):
>   Bluetooth: Fix HCI request framework
>   Bluetooth: Fix hci_inquiry
>   Bluetooth: Remove hci_req_cmd_status
> 
>  include/net/bluetooth/hci_core.h |  1 -
>  net/bluetooth/hci_core.c         | 39 +++++++++++++--------------------------
>  net/bluetooth/hci_event.c        | 11 ++++++-----
>  3 files changed, 19 insertions(+), 32 deletions(-)

All patches in this set have now been pushed to the bluetooth-next
tree. Thanks.

Johan
