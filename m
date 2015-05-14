Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCHv2] Bluetooth: Fix remote name event return directly.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1431484395-29634-1-git-send-email-wesley.kuo@intel.com>
Date: Thu, 14 May 2015 10:36:11 +0200
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@intel.com>
Message-Id: <4736BC31-BBA7-441D-87FC-E3A1CBB12484@holtmann.org>
References: <1431484395-29634-1-git-send-email-wesley.kuo@intel.com>
To: wesley.kuo@intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wesley,

> This patch fixes hci_remote_name_evt dose not resolve name during
> discovery status is RESOLVING. Before simultaneous dual mode scan enabled,
> hci_check_pending_name will set discovery status to STOPPED eventually.
> 
> Signed-off-by: Wesley Kuo <wesley.kuo@intel.com>
> ---
> net/bluetooth/hci_core.c |    6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)

patch has been applied to bluetooth tree.

Regards

Marcel

