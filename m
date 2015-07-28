Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 28 Jul 2015 17:01:53 +0200
Message-ID: <CANzaTi4UOpyNbUw=8-HTd+oM6_soOgf25hPW_FgruH_jCUYGMw@mail.gmail.com>
Subject: Advertising api - local name missing
From: dogan yazar <doganyazar@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Advertising api does not have a field to set shortened or complete
local name. Daemon sets the local name (bluetoothd[828]:
src/adapter.c:local_name_changed_callback() Current alias: foo)
but when I run test/example-advertisement the local name is not sent
in the advertisement.
Is this a deliberate design choice, or a bug or just a low priority
feature to be implemented later?

Thanks
Dogan
