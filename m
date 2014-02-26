Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 10/17] Bluetooth: Connection parameters and auto connection
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CACJA=fV7sDAsLrH46MMxa6pPXXrunZbsHL3VOGQ4NhibrXxA8A@mail.gmail.com>
Date: Wed, 26 Feb 2014 11:52:18 -0800
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <9E714163-6C3E-430F-8768-128DA8C1DBEF@holtmann.org>
References: <1393362104-12175-1-git-send-email-andre.guedes@openbossa.org> <1393362104-12175-11-git-send-email-andre.guedes@openbossa.org> <6791ADBE-F061-4979-97B8-CBCB119EA840@holtmann.org> <CACJA=fV7sDAsLrH46MMxa6pPXXrunZbsHL3VOGQ4NhibrXxA8A@mail.gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

>>> This patch modifies hci_conn_params_add() and hci_conn_params_del() so
>>> they also add/delete pending LE connections according to the auto_
>>> connect option. This way, background scan is automatically triggered/
>>> untriggered when connection parameters are added/removed.
>>> 
>>> For instance, when a new connection parameters with HCI_AUTO_CONN_ALWAYS
>>> option is added and we are not connected to the device, we add a pending
>>> LE connection for that device.
>>> 
>>> Likewise, when the connection parameters are updated we add or delete
>>> a pending LE connection according to its new auto_connect option.
>>> 
>>> Finally, when the connection parameter is deleted we also delete the
>>> pending LE connection (if any).
>> 
>> what about disconnecting an existing connection for a device we have in our auto-connect list. I think that should happen as well.
> 
> This kind of logic seems to be more suitable if we implement it in the
> upper layer (mgmt.c). The function that will handle connection
> parameters removal would also terminate the connection in case there
> is a connection for that device.

not 100% convinced here. If the connection has been triggered by an actually connect() socket call, then sure it is there to stay until disconnect by the user.

However in case the connection has been established by the auto-connect handling and we either remove the value or set it back to disabled, then why not also terminate that connection. This might need further thinking. So lets go ahead without doing it right now.

Regards

Marcel

