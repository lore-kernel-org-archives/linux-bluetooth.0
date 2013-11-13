Return-Path: <cyrus@holtmann.org>
From: "Oprisenescu, CatalinX" <catalinx.oprisenescu@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Trandafir, IonutX" <ionutx.trandafir@intel.com>
Subject: bluetoothd failure after a "malloc retun NULL" injection
Date: Wed, 13 Nov 2013 14:05:02 +0000
Message-ID: <6522C4F948C6F5419BA5943E1E79DD2A8ABB96@IRSMSX104.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Following is a issue encountered and handled using bluez-5.10 on a 32bit Tizen 2.0 IVI based distribution.

If malloc returns a random NULL bluetoothd exits with core dumped.
In this case we do the following:
      -start bluetoothd,
      -at a random malloc call from any library (*lib*.so*), a random NULL will be returned by bluetoothd with a ld_preloaded library.

~# LD_PRELOAD=/root/lib_wrapper.so /usr/libexec/bluetooth/bluetoothd -E

Analizyng the dump, it points directly to a DBUS_ERROR_NO_MEMORY which, after handling, keeps bluetoothd from dumping and allowing it to return the fatal error occurred as exit status, thus failing gracefully.

A fix proposal, handling the use-case is attached.


Regards,
Calin Oprisenescu.

--------------------------------------------------------------
Intel Shannon Limited
Registered in Ireland
Registered Office: Collinstown Industrial Park, Leixlip, County Kildare
Registered Number: 308263
Business address: Dromore House, East Park, Shannon, Co. Clare

This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). Any review or distribution by others is strictly prohibited. If you are not the intended recipient, please contact the sender and delete all copies.


