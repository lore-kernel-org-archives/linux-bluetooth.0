Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 10/17] Bluetooth: Connection parameters and auto connection
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393362104-12175-11-git-send-email-andre.guedes@openbossa.org>
Date: Tue, 25 Feb 2014 22:33:07 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6791ADBE-F061-4979-97B8-CBCB119EA840@holtmann.org>
References: <1393362104-12175-1-git-send-email-andre.guedes@openbossa.org> <1393362104-12175-11-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch modifies hci_conn_params_add() and hci_conn_params_del() so
> they also add/delete pending LE connections according to the auto_
> connect option. This way, background scan is automatically triggered/
> untriggered when connection parameters are added/removed.
> 
> For instance, when a new connection parameters with HCI_AUTO_CONN_ALWAYS
> option is added and we are not connected to the device, we add a pending
> LE connection for that device.
> 
> Likewise, when the connection parameters are updated we add or delete
> a pending LE connection according to its new auto_connect option.
> 
> Finally, when the connection parameter is deleted we also delete the
> pending LE connection (if any).

what about disconnecting an existing connection for a device we have in our auto-connect list. I think that should happen as well.

Regards

Marcel

