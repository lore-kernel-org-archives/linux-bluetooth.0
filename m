Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCHv2 2/2] Bluetooth: Sort switch cases by opcode's numeric value
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1415299013-24580-2-git-send-email-kubax.t.pawlak@intel.com>
Date: Thu, 6 Nov 2014 10:41:06 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C387FD38-547E-48E0-AA8B-14A8321E982D@holtmann.org>
References: <1415299013-24580-1-git-send-email-kubax.t.pawlak@intel.com> <1415299013-24580-2-git-send-email-kubax.t.pawlak@intel.com>
To: Kuba Pawlak <kubax.t.pawlak@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kuba,

> Opcodes in switch/case in hci_cmd_status_evt are not sorted
> by value. This patch restores proper ordering.
> 
> Signed-off-by: Kuba Pawlak <kubax.t.pawlak@intel.com>
> ---
> net/bluetooth/hci_event.c | 24 ++++++++++++------------
> 1 file changed, 12 insertions(+), 12 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

