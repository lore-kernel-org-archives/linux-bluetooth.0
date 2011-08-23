Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Dmitry Shipilov <dmitry.shipilov@gmail.com>
Date: Tue, 23 Aug 2011 21:17:26 +0100
Message-ID: <CAFpRq5k1425=uttf1f-a3996qWmMyEh-AJhXL4SeGXW_QYC25A@mail.gmail.com>
Subject: L2CAP socket binding fails with gatttool over LE
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello!

I was trying to use gatttool from the latest BlueZ 4.96 over LE link,
but it immediately fails with error message:

$ sudo gatttool --adapter=hci0 --device=<BD addr> --primary
l2cap_bind: Invalid argument (22)

There are no commands sent over HCI (according to hcidump) and nothing
is logged in /var/log/syslog as well (bluetoothd is running with -d
option).

I can use HCI LE commands (e.g. lecc) and successfully connect to the
remote LE slave (according to hcidump) and LE is enabled in main.conf.

If I try to use gatttool over regular BT (by specifying psm), gatttool
initiates the connection (but eventually fails since I'm trying to
connect to the single mode LE device on the other end).

It looks like I'm missing something fundamental. Other posts suggest
that gatttool is working over LE - is that correct?

Any help would be much appreciated. Thanks in advance!

With best regards, Dmitry...
[e-mail: dmitry.shipilov@gmail.com]
