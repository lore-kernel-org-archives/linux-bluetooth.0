Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Oct 2013 00:21:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Move amp.h header file into net/bluetooth/
Message-ID: <20131010222109.GA4228@x220.p-661hnu-f1>
References: <1381434976-36296-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381434976-36296-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 10, 2013, Marcel Holtmann wrote:
> The amp.h header file is only used internally by the bluetooth.ko
> module and is not a public API. So make it local to the core
> Bluetooth module.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/amp.h | 54 ---------------------------------------------
>  net/bluetooth/a2mp.c        |  3 ++-
>  net/bluetooth/amp.c         |  3 ++-
>  net/bluetooth/amp.h         | 54 +++++++++++++++++++++++++++++++++++++++++++++
>  net/bluetooth/hci_event.c   |  3 ++-
>  net/bluetooth/l2cap_core.c  |  3 ++-
>  6 files changed, 62 insertions(+), 58 deletions(-)
>  delete mode 100644 include/net/bluetooth/amp.h
>  create mode 100644 net/bluetooth/amp.h

All three patches in this set have been applied to bluetooth-next.

Johan
