Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH v2 0/2] Bluetooth: Add support for Start Limited Discovery
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1451992772-4971-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 5 Jan 2016 08:05:07 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <AA8A134E-4957-4A48-8030-49CBDD2F8FF0@holtmann.org>
References: <1451992772-4971-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> These two patches implement support for the Start Limited Discovery mgmt
> command (that's been specified a long time ago but no-one picked up the
> task to implement it so far).
> 
> Johan
> 
> ---
> Johan Hedberg (2):
>      Bluetooth: Change eir_has_data_type() to more generic eir_get_data()
>      Bluetooth: Add support for Start Limited Discovery command
> 
> include/net/bluetooth/hci_core.h | 31 +++++++++++++++-------
> include/net/bluetooth/mgmt.h     |  2 ++
> net/bluetooth/hci_event.c        |  6 ++---
> net/bluetooth/hci_request.c	  | 11 +++++---
> net/bluetooth/mgmt.c             | 56 ++++++++++++++++++++++++++++++++-------
> 5 files changed, 80 insertions(+), 26 deletions(-)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

