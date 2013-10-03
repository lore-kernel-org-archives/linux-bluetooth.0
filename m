Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <B5036FD2-37E8-491E-B35E-16F1F2625A3E@holtmann.org>
References: <1380668636-30654-1-git-send-email-andre.guedes@openbossa.org>
 <1380668636-30654-8-git-send-email-andre.guedes@openbossa.org> <B5036FD2-37E8-491E-B35E-16F1F2625A3E@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
Date: Thu, 3 Oct 2013 11:06:22 -0300
Message-ID: <CACJA=fXKWh_zFO+rPpJpmNxGq5k5XL0g7WnKzeyLg4=1XDbLig@mail.gmail.com>
Subject: Re: [PATCH 7/7] Bluetooth: Locking in hci_le_conn_complete_evt
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 2, 2013 at 2:23 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Andre,
>
> > This patch moves hci_dev_lock and hci_dev_unlock calls to where they
> > are really required, reducing the critical region in hci_le_conn_
> > complete_evt function. hdev->lock is required only in hci_conn_del
> > and hci_conn_add call to protect concurrent add and remove operations
> > in hci_conn_hash list.
>
> is this statement actually true? Because we have done this for so many HCI event, that I highly doubt that your statement tis correct. And if it is correct, you need to fix all other users first.

Well, if we take a look at each function called inside
le_conn_complete_evt(), we'll find:
* hci_conn_hash_lookup_state which traverses hdev->conn_hash
(protected by RCU). So it doesn't require hdev->lock.
* mgmt_connect_failed which accesses hdev->id. hdev->id is written
only at hci_register_dev(). So it doesn't require hdev->lock.
* hci_proto_connect_cfm: it handles connection layer stuff, So it
doesn't require hdev->lock.
* mgmt_device_connected which access hdev->name. hdev->name is written
only at hci_register_dev(). So it doesn't require hdev->lock.
* hci_conn_add_sysfs which access only hdev->name. So it doesn't
require hdev->lock.
* hci_conn_del which removes a element from hdev->conn_hash. Since
hdev->conn_hash is protected by RCU, we have to guarantee updaters
mutual exclusion. So it requires hdev->lock.
* hci_conn_add which adds a new element to hdev->conn_hash. Since we
have to guarantee updaters mutual exclusion, it requires hdev->lock.

That being said, I'm not sure the same applies for all others HCI
handlers. We have to analyze each handler to make sure we can safely
move the locking.

Regards,

Andre
