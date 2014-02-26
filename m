Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6791ADBE-F061-4979-97B8-CBCB119EA840@holtmann.org>
References: <1393362104-12175-1-git-send-email-andre.guedes@openbossa.org>
 <1393362104-12175-11-git-send-email-andre.guedes@openbossa.org> <6791ADBE-F061-4979-97B8-CBCB119EA840@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
Date: Wed, 26 Feb 2014 16:34:42 -0300
Message-ID: <CACJA=fV7sDAsLrH46MMxa6pPXXrunZbsHL3VOGQ4NhibrXxA8A@mail.gmail.com>
Subject: Re: [PATCH 10/17] Bluetooth: Connection parameters and auto connection
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Feb 26, 2014 at 3:33 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andre,
>
>> This patch modifies hci_conn_params_add() and hci_conn_params_del() so
>> they also add/delete pending LE connections according to the auto_
>> connect option. This way, background scan is automatically triggered/
>> untriggered when connection parameters are added/removed.
>>
>> For instance, when a new connection parameters with HCI_AUTO_CONN_ALWAYS
>> option is added and we are not connected to the device, we add a pending
>> LE connection for that device.
>>
>> Likewise, when the connection parameters are updated we add or delete
>> a pending LE connection according to its new auto_connect option.
>>
>> Finally, when the connection parameter is deleted we also delete the
>> pending LE connection (if any).
>
> what about disconnecting an existing connection for a device we have in our auto-connect list. I think that should happen as well.

This kind of logic seems to be more suitable if we implement it in the
upper layer (mgmt.c). The function that will handle connection
parameters removal would also terminate the connection in case there
is a connection for that device.

BR,

Andre
