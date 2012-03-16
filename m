Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Mar 2012 12:59:39 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 0/2] LE support for MGMT Stop Discovery
Message-ID: <20120316155939.GA22160@x220>
References: <1331841128-1396-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331841128-1396-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Thu, Mar 15, 2012, Andre Guedes wrote:
> From the previous cover letter:
> 
> This small patch series adds LE support for Stop Discovery MGMT command.
> Now, we are able to stop LE discovery procedues (LE-only and interleaved).
> 
> A brief word about patch 1/2: due to discovery state machine, we don't need
> to worry about canceling hdev->le_scan work since it is never pending or
> running when hci_cancel_le_scan is called.
> 
> Andre Guedes (2):
>   Bluetooth: Add hci_cancel_le_scan() to hci_core
>   Bluetooth: LE support for MGMT stop discovery
> 
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_core.c         |   18 ++++++++++++++++++
>  net/bluetooth/hci_event.c        |    6 +++++-
>  net/bluetooth/mgmt.c             |    6 +++++-
>  4 files changed, 29 insertions(+), 2 deletions(-)

Both patches have been applied to my bluetooth-next tree. Thanks.

Johan
