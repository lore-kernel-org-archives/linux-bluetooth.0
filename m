Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 20 Apr 2011 19:20:57 -0300
Message-ID: <BANLkTinpSJeozeWCcYCBeQ=sxKU5SJSrSQ@mail.gmail.com>
Subject: Read RSSI through Management Interface?
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>, Johan Hedberg <johan.hedberg@nokia.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys,

we need to read the RSSI of LE and basic rate connections to implement
the Proximity profile. RSSI included in the advertising packets can't
be used for Proximity, it requires an "active" connection.

Here are some suggestions:

1. Add a new command to mgmt interface to add a given address into a
RSSI "monitoring list".
   When the connection is established the kernel will automatically
track the RSSI of the connection on regular intervals sending
HCI_Read_RSSI. Read RSSI value can be reported through a new event in
the management interface

Forgetting SMP, we can keep the hciops compatibility implementing the
same logic inside the hciops plugin.

2. Add a new command to mgmt interface to actively read the RSSI of a
given connection/address

Approach (1) seems to be more feasible: address multiple address
asynchronously. In my opinion, approach(2) will not be transparent
enough to our use cases.

Any other idea?

Cheers,
Claudio.
