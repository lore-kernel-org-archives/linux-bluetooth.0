Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 20 Jul 2010 17:30:25 +0800
Message-ID: <AANLkTimYuaveU7To6oLdtDLlxXIky1KU7QHMTD47Mwwh@mail.gmail.com>
Subject: Virtual cable unplug not supported in BlueZ?
From: Liang Bao <tim.bao@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have a question on "Virtual Cable Unplug" in current BlueZ version.

Currently BlueZ doesn't expose a D-Bus method in input/device.c for
virtually unplug cable which is a mandatory requirement to pass
TC_HOS_HCR_BV_03_I. Actually the support in kernel is already there.
Can anyone give some insight to why this is not exposed at the DBUS
API level like Connect/Disconnect/GetProperties? Can I think the
reason behind this design is we only need one of "Disconnect" and
"VirtualUnplug" to allow user to disconnect?

Thanks.

Regards,
Liang Bao
