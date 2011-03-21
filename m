Return-Path: <cyrus@holtmann.org>
Message-ID: <4D870E6F.4050502@Atheros.com>
Date: Mon, 21 Mar 2011 14:08:07 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: accessing Link key within the Bluetooth module
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am working on a Bluetooth AMP manager module (linked to l2cap module) 
that require access to the Link key of the connected(paired) device.

I am trying to use the hci_find_link_key() call with the BDADDR of the 
remote device as parameter without success. It looks like the list 
"hci_dev.link_keys" is not getting populated in the first place.

Note: The device is already paired with the local device, so the link 
key should be available( I do see the link_key_notify_evt getting called).

is there any way to access the link key of a paired device inside the 
Bluetooth module?

Regards
Suraj
