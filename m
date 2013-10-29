Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [RFC v2 13/15] Bluetooth: Add thread-safe version of helpers
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383053160-10175-14-git-send-email-andre.guedes@openbossa.org>
Date: Wed, 30 Oct 2013 00:16:50 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <98043350-0262-4201-88E2-0DD4B6552C39@holtmann.org>
References: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org> <1383053160-10175-14-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds the thread-safe version of helper functions to add
> and remove pending auto connections. These helpers will be used in
> next patches to implementing the Mgmt add/remove connection
> parameters commands.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> include/net/bluetooth/hci_core.h |  4 ++++
> net/bluetooth/hci_core.c         | 20 ++++++++++++++++++++
> 2 files changed, 24 insertions(+)

and here is where I would stop and start with a debugfs interface. So we can start testing this. Going straight for mgmt without seeing how it all works would be a little bit too early for me.

Regards

Marcel

