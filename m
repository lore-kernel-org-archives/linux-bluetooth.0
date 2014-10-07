Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Oct 2014 17:53:05 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alfonso Acosta <fons@spotify.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Bluetooth: Include ADV_IND report in Device
 Connected event
Message-ID: <20141007145305.GA10391@t440s.P-661HNU-F1>
References: <1412671452-24854-1-git-send-email-fons@spotify.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412671452-24854-1-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

On Tue, Oct 07, 2014, Alfonso Acosta wrote:
> Rebased and took care of Johan's remarks, including a separate patch
> to remove an redundant check on hci_conn's device class.
> 
> Alfonso Acosta (3):
>   Bluetooth: Refactor arguments of mgmt_device_connected
>   Bluetooth: Include ADV_IND report in Device Connected event
>   Bluetooth: Remove redundant check on hci_conn's device class
> 
>  include/net/bluetooth/hci_core.h |  7 +++---
>  net/bluetooth/hci_event.c        | 46 +++++++++++++++++++++++-----------------
>  net/bluetooth/l2cap_core.c       |  4 +---
>  net/bluetooth/mgmt.c             | 32 ++++++++++++++++++----------
>  4 files changed, 52 insertions(+), 37 deletions(-)

Thanks. All three patches have been applied to the bluetooth-next tree.

One minor change I did was to add a bit more descriptive commit message
to patch 1/3 since one-sentence messages should really only be
acceptable for very trivial and obvious patches.

Johan
