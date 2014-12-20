Return-Path: <cyrus@holtmann.org>
Date: Sat, 20 Dec 2014 17:54:28 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Bluetooth: Add skeleton functions for debugfs
 creation
Message-ID: <20141220155428.GA12555@t440s.P-661HNU-F1>
References: <1419087916-8968-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419087916-8968-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Dec 20, 2014, Marcel Holtmann wrote:
> The debugfs file creation has been part of the core initialization
> handling of controllers. With the introduction of Bluetooth 4.2 core
> specification, the number of debugfs files is increasing even further.
> 
> To avoid cluttering the core controller handling, create a separate
> file hci_debugfs.c to centralize all debugfs file creation. For now
> leave the current files in the core, but in the future all debugfs
> file creation will be moved.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/Makefile      |  2 +-
>  net/bluetooth/hci_core.c    |  7 +++++++
>  net/bluetooth/hci_debugfs.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  net/bluetooth/hci_debugfs.h | 25 +++++++++++++++++++++++++
>  4 files changed, 74 insertions(+), 1 deletion(-)
>  create mode 100644 net/bluetooth/hci_debugfs.c
>  create mode 100644 net/bluetooth/hci_debugfs.h

All four patches in this set have been applied to bluetooth-next.
Thanks.

Johan
