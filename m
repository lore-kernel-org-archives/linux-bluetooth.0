Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Feb 2012 17:25:03 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/7] New MGMT messages for SMP Long Term Keys
Message-ID: <20120203012503.GA10381@x220>
References: <1328227685-27245-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328227685-27245-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Thu, Feb 02, 2012, Vinicius Costa Gomes wrote:
> Changes from last version:
>  * Updated code acording to review comments;
>  * Added a patch that removes useless casts from MGMT code;
> 
> 
> Cheers,
> 
> Vinicius Costa Gomes (7):
>   Bluetooth: Fix doing some useless casts when receiving MGMT commands
>   Bluetooth: Add new structures for handling SMP Long Term Keys
>   Bluetooth: Use the updated key structures for handling LTKs
>   Bluetooth: Add MGMT handlers for dealing with SMP LTK's
>   Bluetooth: Add support for removing LTK's when pairing is removed
>   Bluetooth: Clean up structures left unused
>   Bluetooth: Add support for notifying userspace of new LTK's
> 
>  include/net/bluetooth/hci.h      |    9 +-
>  include/net/bluetooth/hci_core.h |   35 +++--
>  net/bluetooth/hci_core.c         |  108 +++++++++------
>  net/bluetooth/hci_event.c        |   11 ++-
>  net/bluetooth/mgmt.c             |  296 ++++++++++++++++++++++----------------
>  net/bluetooth/smp.c              |   38 +++--
>  6 files changed, 296 insertions(+), 201 deletions(-)

All seven patches have been pushed to my bluetooth-next tree. I went
ahead and did the minor changes proposed by Marcel myself.

Johan
