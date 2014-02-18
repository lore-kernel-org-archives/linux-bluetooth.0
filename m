Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [RFC v10 09/10] Bluetooth: Auto connection and power on
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1392754534-12747-9-git-send-email-andre.guedes@openbossa.org>
Date: Tue, 18 Feb 2014 12:55:12 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <66746AF2-08CF-4E22-95D0-1ADB649BBED8@holtmann.org>
References: <1392754534-12747-1-git-send-email-andre.guedes@openbossa.org> <1392754534-12747-9-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> When hdev is closed (e.g. Mgmt power off command, RFKILL or controller
> is reset), the ongoing active connections are silently dropped by the
> controller (no Disconnection Complete Event is sent to host). For that
> reason, the devices that require HCI_AUTO_CONN_ALWAYS are not added to
> hdev->pend_le_conns list and they won't auto connect.
> 
> So to fix this issue, during hdev closing, we remove all pending LE
> connections. After adapter is powered on, we add a pending LE connection
> for each HCI_AUTO_CONN_ALWAYS address.
> 
> This way, the auto connection mechanism works propely after a power
> off and power on sequence as well as RFKILL block/unblock.

and when background scan is running, you might want to make sure to disable LE scan first before doing the actual power down. I just crashed my controller.

Regards

Marcel

