Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCHv2 1/2] Bluetooth: Clear role switch pending flag
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1415299013-24580-1-git-send-email-kubax.t.pawlak@intel.com>
Date: Thu, 6 Nov 2014 10:41:03 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3987A164-2161-4E21-A33D-13ACD2A14CF2@holtmann.org>
References: <1415299013-24580-1-git-send-email-kubax.t.pawlak@intel.com>
To: Kuba Pawlak <kubax.t.pawlak@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kuba,

> If role switch was rejected by the controller and HCI Event: Command Status
> returned with status "Command Disallowed" (0x0C) the flag
> HCI_CONN_RSWITCH_PEND remains set. No further role switches are
> possible as this flag prevents us from sending any new HCI Switch Role
> requests and the only way to clear it is to receive a valid
> HCI Event Switch Role.
> 
> This patch clears the flag if command was rejected.
> 
> 2013-01-01 00:03:44.209913 < HCI Command: Switch Role (0x02|0x000b) plen 7
>    bdaddr BC:C6:DB:C4:6F:79 role 0x00
>    Role: Master
> 2013-01-01 00:03:44.210867 > HCI Event: Command Status (0x0f) plen 4
>    Switch Role (0x02|0x000b) status 0x0c ncmd 1
>    Error: Command Disallowed
> 
> Signed-off-by: Kuba Pawlak <kubax.t.pawlak@intel.com>
> ---
> net/bluetooth/hci_event.c | 27 +++++++++++++++++++++++++++
> 1 file changed, 27 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

