Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 1/2] Bluetooth: Convert auto accept timer to use delayed work
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381936300-18629-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 16 Oct 2013 18:13:01 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4C1E43C6-CCE5-4AD4-85BE-98EFB238E206@holtmann.org>
References: <1381936300-18629-1-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Since the entire Bluetooth subsystem runs in workqueues these days there
> is no need to use a timer for deferring work.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  2 +-
> net/bluetooth/hci_conn.c         | 14 ++++++--------
> net/bluetooth/hci_event.c        |  3 ++-
> 3 files changed, 9 insertions(+), 10 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

