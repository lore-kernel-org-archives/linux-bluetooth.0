Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Subject: Thoughts about new hciattach
Message-Id: <ECBBC064-4E80-4B2F-9B4F-2BC43329A36A@holtmann.org>
Date: Wed, 2 Jul 2014 15:34:38 +0200
To: Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello everyone,

the hciattach source has been bitrotting for a while and is by far the most ugly code there is in the whole tree. There is a long history on this code and it is what it is, but maybe with newer kernels this can be all simplified. One major problem is that that all the initialization code (patching, config etc.) needs a working HCI transport. That is simple enough for H:4, but H:5 or BCSP it is way more complicated.

Since we added HCI_CHANNEL_USER support in Linux 3.13 and I just finished some fixes for the whole HCI_QUIRK_RAW_DEVICE for Linux 3.17, I think we can just easily combine this now. So here is what I think how an init procedure for btattach (the new hciattach) should look like.

	 1) open serial port
	 2) set initial baud rate
	 3) attach N_HCI line discipline
	 3) call HCIUARTSETFLAGS with HCI_UART_RAW_DEVICE
	 4) call HCIUARTSETPROTO with H:4, H:5, BCSP etc.
	 5) call HCIUARTGETDEVICE to get dev_id
	 6) open HCI_CHANNEL_USER for dev_id

	--> run vendor HCI commands (src/shared/hci.h can be of help)

	 7) close HCI_CHANNEL_USER for dev_id
	 8) remove N_HCI line discipline
	 9) set new baud rate
	10) attach H_HCI line discipline
	11) call HCIUARTSETFLAGS without HCI_UART_RAW_DEVICE
	12) call HCIUARTSETPROTO with H:4, H:5, BCSP etc.

	--> normal operation (bluetoothd in action)

	13) remove N_HCI line discipline
	14) close serial port

The neat trick here is that raw devices will not be announced over management interface, but they can be used from the user channel interface. However in both cases the actual transport protocol is run by the kernel and thus does not need to be duplicated. Especially for H:5 and BCSP this should make things a lot simpler.

So this is just an idea. I have not tried how well the TTY layer behaves and if setting the line discipline, removing it and setting it again actually works as expected.

Regards

Marcel

