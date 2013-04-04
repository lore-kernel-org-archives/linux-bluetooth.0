Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v2 3/4] Bluetooth: Add support for custom event terminated commands
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1365062347-860-4-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 4 Apr 2013 08:29:07 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C5164C8E-61F4-48EE-810E-69B449D0DDA3@holtmann.org>
References: <1365062347-860-1-git-send-email-johan.hedberg@gmail.com> <1365062347-860-4-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds support for having commands within HCI requests that do
> not result in a command complete but some other event. This is at least
> needed for some vendor specific commands to be issued in the
> hdev->setup() procecure, but might also be useful for other commands.
> 
> The way that the support is implemented is by extending the skb control
> buffer to have a field to indicate that the command is expected to
> terminate with a special event. After sending the command each received
> event can then be compared against this field through hdev->sent_cmd.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/bluetooth.h |    1 +
> include/net/bluetooth/hci_core.h  |    2 ++
> net/bluetooth/hci_core.c          |   10 +++++++++-
> net/bluetooth/hci_event.c         |   11 ++++++++++-
> 4 files changed, 22 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

