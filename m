Return-Path: <cyrus@holtmann.org>
Message-ID: <250863.34433.qm@web94911.mail.in2.yahoo.com>
Date: Tue, 6 Jul 2010 17:36:47 +0530 (IST)
From: Pavan Savoy <pavan_savoy@ti.com>
Reply-To: pavan_savoy@ti.com
Subject: using hci0 interface without DEVUP
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>, kobile@ti.com,
  pavan savoy <pavan_savoy@yahoo.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,=0A=0AIn certain cases, as in using VS commads to communicate with diffe=
rent cores on the combo chips (say, BT, FM, GPS) - we would have to use the=
 hci0 interface without it being UP.=0A=0AAs in the hci0 interface still ne=
eds to be invisible (via dbus/bluetoothd) to the system but to be available=
 to be use.=0A=0AIs there a way we can do this while registering with the h=
ci ?=0Asay a flag in the struct hci_dev to be by default during registratio=
n HCI_DEV_DOWN to be default state ?=0A=0A
