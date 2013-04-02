Return-Path: <cyrus@holtmann.org>
Date: Tue, 2 Apr 2013 10:07:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Fix Inquiry command support in HCI request
 framework
Message-ID: <20130402070746.GA5376@x220>
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

I did a bit of testing and these patches seem to work fine. I'm not
really familiar with the smp_mb__after_clear_bit() usage, but I'll
assume you did your homework to ensure it's correct. Other than that the
patches seem fine to me.

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
