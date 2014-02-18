Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [RFC v9 01/10] Bluetooth: Create hci_req_add_le_scan_disable helper
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1392746101-5981-1-git-send-email-andre.guedes@openbossa.org>
Date: Tue, 18 Feb 2014 11:50:11 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C2424B4D-6165-4D37-870A-0A2E1A061D96@holtmann.org>
References: <1392746101-5981-1-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch moves stop LE scanning duplicate code to one single
> place and reuses it. This will avoid more duplicate code in
> upcoming patches.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/hci_core.c         | 14 ++++++++++----
> net/bluetooth/mgmt.c             |  6 +-----
> 3 files changed, 12 insertions(+), 9 deletions(-)

can you please rebase this against bluetooth-next. Unfortunately you are conflicting with Johan’s work for resolving private addresses.

Regards

Marcel

