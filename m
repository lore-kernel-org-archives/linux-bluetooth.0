Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 25 Oct 2015 21:41:28 -0700
Message-ID: <CAD0=r8zhd6g4eNvdLW6K0sQ99qHAkv5dhm42G9fOqoB2OEY6BA@mail.gmail.com>
Subject: [RFC] Fix scan enable/disable kernel issue for opening socket
From: Jakub Pawlowski <jpawlowski@google.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Issue (on all kernels, including bluetooth-next and latest 4.3 kernel):
1. in bluetoothd pair to two BLE devices using random address
(AA:BB:CC:DD:EE:FF and FF:EE:DD:CC:BB:AA), that don't use autoconnect.
2. Make sure all those devices don't advertise.
3. call Device1.Connect() on both devices at same time, with scan
initially disabled.
4. Second request will fail right away, instead of timeout in 45
seconds (if it doesn't fail repeat, it's a race condition and happens
once every time, trying with more, i.e. 5 devices at same time gives
bigger change).

When calling Device1.Connect() twice, bluetoothd will try to open two
sockets, each to different random address device.
1 Inside kernel, for first socket, scan state is checked,and
HCI_OP_SET_SCAN_ENABLE is scheduled, but not yet executed.
2. Same happens for second socket - current scan state is checked, and
HCI_OP_SET_SCAN_ENABLE is scheduled.
3. Now both HCI_OP_SET_SCAN_ENABLE are executed, second will fail,
because first one already enabled scan.


To solve this kind of issues, I want to propose adding inside kernel
virtual HCI commands, that might be scheduled in hci_request. Virtual
HCI command will be able to do some very basic check (i.e. check scan
state) and might cause real HCI command to be issued.

Commands I'd like to add:
VIRT_HCI_SCAN_DISABLE_START - check scan state, remember it, and send
HCI_OP_SET_SCAN_ENABLE(enable=false) if it was enabled
VIRT_HCI_SCAN_DISABLE_STOP - bring scan state back to state remembered
in VIRT_HCI_SCAN_DISABLE_START
Those commands must be both scheduled in hci_request, having only one
of them in hci_request would be error.

VIRT_HCI_SCAN_ENABLE - this command will check current scan state, and
send HCI_OP_SET_SCAN_ENABLE(enable=true) if scan was disabled
VIRT_HCI_SCAN_DISABLE - this command will check current scan state,
and send HCI_OP_SET_SCAN_ENABLE(enable=false) if scan was enabled
