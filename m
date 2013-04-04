Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v2 4/4] Bluetooth: Add __hci_cmd_sync_ev function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1365062347-860-5-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 4 Apr 2013 08:30:00 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <590BE43B-4902-4050-B22E-D3CC86108208@holtmann.org>
References: <1365062347-860-1-git-send-email-johan.hedberg@gmail.com> <1365062347-860-5-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds a __hci_cmd_sync_ev function, analogous to
> __hci_cmd_sync except that it also takes an event parameter to indicate
> that the command completes with a special event instead of command
> complete. Internally this new function takes advantage of the
> hci_req_add_ev function introduced in the previous patch.
> 
> The primary expected user of this new function are the setup routines of
> HCI drivers which may want to send custom commands and return only when
> they have completed.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |    2 ++
> net/bluetooth/hci_core.c         |   22 +++++++++++++++++-----
> 2 files changed, 19 insertions(+), 5 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

