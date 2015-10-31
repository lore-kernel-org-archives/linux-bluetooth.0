Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [RFC] Fix scan enable/disable kernel issue for opening socket
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD0=r8zhd6g4eNvdLW6K0sQ99qHAkv5dhm42G9fOqoB2OEY6BA@mail.gmail.com>
Date: Sat, 31 Oct 2015 12:56:49 +0900
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <B9062355-3892-4C8B-AEB8-60A5999CDF99@holtmann.org>
References: <CAD0=r8zhd6g4eNvdLW6K0sQ99qHAkv5dhm42G9fOqoB2OEY6BA@mail.gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> Issue (on all kernels, including bluetooth-next and latest 4.3 kernel):
> 1. in bluetoothd pair to two BLE devices using random address
> (AA:BB:CC:DD:EE:FF and FF:EE:DD:CC:BB:AA), that don't use autoconnect.
> 2. Make sure all those devices don't advertise.
> 3. call Device1.Connect() on both devices at same time, with scan
> initially disabled.
> 4. Second request will fail right away, instead of timeout in 45
> seconds (if it doesn't fail repeat, it's a race condition and happens
> once every time, trying with more, i.e. 5 devices at same time gives
> bigger change).
> 
> When calling Device1.Connect() twice, bluetoothd will try to open two
> sockets, each to different random address device.
> 1 Inside kernel, for first socket, scan state is checked,and
> HCI_OP_SET_SCAN_ENABLE is scheduled, but not yet executed.
> 2. Same happens for second socket - current scan state is checked, and
> HCI_OP_SET_SCAN_ENABLE is scheduled.
> 3. Now both HCI_OP_SET_SCAN_ENABLE are executed, second will fail,
> because first one already enabled scan.

I think that is the fundamental problem here. The state machine is bogus. I said this many time before, in general the scanning needs to be disabled first, whitelist re-programmed and then scanning resumed. The fact that an L2CAP connect() for ATT might be triggered at the same time is really not any reason to not have a proper state machine behind this.

> To solve this kind of issues, I want to propose adding inside kernel
> virtual HCI commands, that might be scheduled in hci_request. Virtual
> HCI command will be able to do some very basic check (i.e. check scan
> state) and might cause real HCI command to be issued.
> 
> Commands I'd like to add:
> VIRT_HCI_SCAN_DISABLE_START - check scan state, remember it, and send
> HCI_OP_SET_SCAN_ENABLE(enable=false) if it was enabled
> VIRT_HCI_SCAN_DISABLE_STOP - bring scan state back to state remembered
> in VIRT_HCI_SCAN_DISABLE_START
> Those commands must be both scheduled in hci_request, having only one
> of them in hci_request would be error.
> 
> VIRT_HCI_SCAN_ENABLE - this command will check current scan state, and
> send HCI_OP_SET_SCAN_ENABLE(enable=true) if scan was disabled
> VIRT_HCI_SCAN_DISABLE - this command will check current scan state,
> and send HCI_OP_SET_SCAN_ENABLE(enable=false) if scan was enabled

This approach does not sound right at all. And honestly I do not see a need for adding such a complex overhead. It is like fixing symptoms. What we need to fix is the root cause.

And what I like to see is that we actually have mgmt-tester and l2cap-tester test cases first that expose this issue. Then we can ensure that we never break this behavior anymore.

Regards

Marcel

