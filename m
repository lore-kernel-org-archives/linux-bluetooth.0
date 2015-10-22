Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [PATCH 0/5] Bluetooth: UPF cleanups & fixes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1445495915-21059-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 22 Oct 2015 09:03:18 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5F7FD516-B6D8-42C1-91E8-22B818F9E664@holtmann.org>
References: <1445495915-21059-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Here's the remaining 5 patches that weren't applied yet. The only change
> is a fix to the SCO rejection reason code which has some special
> limitations (see commit d41c15cf95bd91b9c333).
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (5):
>      Bluetooth: Disable auto-connection parameters when unpairing
>      Bluetooth: Introduce hci_req helper to abort a connection
>      Bluetooth: Take advantage of connection abort helpers
>      Bluetooth: Make hci_disconnect() behave correctly for all states
>      Bluetooth: Fix crash in SMP when unpairing
> 
> net/bluetooth/hci_conn.c    | 90 ++++++------------------------------------
> net/bluetooth/hci_request.c | 93 ++++++++++++++++++++++++++++++++++++++++++++
> net/bluetooth/hci_request.h |  4 ++
> net/bluetooth/mgmt.c        | 49 ++++++++---------------
> net/bluetooth/smp.c         | 26 +++++++++++++
> net/bluetooth/smp.h         |  1 +
> 6 files changed, 151 insertions(+), 112 deletions(-)

patch 1 and 5 have been applied to bluetooth-next tree.

Regards

Marcel

