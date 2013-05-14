Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 13 May 2013 20:53:38 -0400
Message-ID: <CALSoeMev+OKwwPddVfh5kgEJESv0iTArysGHkJXiRwWe1FvL8A@mail.gmail.com>
Subject: BlueZ dbus API - device address type
From: Sandeep Mistry <sandeep.mistry@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Is there a way to determine the Bluetooth address type of a device via
the dbus API?

I would like to know if a device has an LE public (BDADDR_LE_PUBLIC)
or LE static (BDADDR_LE_RANDOM) type, so I can issue the correct
connect command to gatttool.

Thanks,
Sandeep
