Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v2 0/2] Bluetooth: Add a new mgmt_set_bredr command
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380710594-24555-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 2 Oct 2013 12:49:51 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <ED1977E2-DFDA-4274-9BA3-6EE359058A2A@holtmann.org>
References: <1380710594-24555-1-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Yet another update with error code fixes in both patches based on
> feedback. I also removed the unnecessary val and enabled variables as
> suggested by Andrei Emeltchenko.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (2):
>      Bluetooth: Introduce a new HCI_BREDR_ENABLED flag
>      Bluetooth: Add a new mgmt_set_bredr command
> 
> include/net/bluetooth/hci.h  |   1 +
> include/net/bluetooth/mgmt.h |   2 +
> net/bluetooth/hci_conn.c     |   3 +
> net/bluetooth/hci_core.c     |  21 +++++-
> net/bluetooth/hci_event.c    |   5 ++
> net/bluetooth/mgmt.c         | 144 ++++++++++++++++++++++++++++++++++++++----
> 6 files changed, 163 insertions(+), 13 deletions(-)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

