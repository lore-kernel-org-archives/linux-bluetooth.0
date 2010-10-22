Return-Path: <cyrus@holtmann.org>
From: Anderson Briglia <anderson.briglia@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] SMP initial draft
Date: Fri, 22 Oct 2010 19:56:54 -0400
Message-Id: <1287791820-22693-1-git-send-email-anderson.briglia@openbossa.org>
In-Reply-To: <linux-bluetooth@vger.kernel.org>
References: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This RFC is about Security Manager Protocol (SMP).
Basically this patchset implements the initial negotiation over L2CAP and LE
connections between a Master and a Slave. TK and STK keys are not being generated
and/or exchanged yet, do not expect real encryption/decryption by now.
Actually, our next tasks are related to integrate current implementation and
Criptographic Toolbox ah, c1 and s1 functions for TK and STK key generation for
Just Works SMP pairing method.

To test this RFC you need to have the Ville Tervo[1] kernel tree with LE connection
patches. Of course you need LE devices and bluez git tree (master branch). Just run
the bluetoothd and try to list the primary services using gatttool over an LE channel.
eg.: gatttool --primary --le -i hci0 -b 00:17:E7:DD:08:FF

Comments are welcome.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/vtervo/bluetooth-le-2.6.git

[PATCH 1/6] Bluetooth: Add SMP command structures
[PATCH 2/6] Bluetooth: fix receiving L2CAP packets over LE
[PATCH 3/6] Bluetooth: Implement the first SMP commands
[PATCH 4/6] Bluetooth: Start SMP procedure
[PATCH 5/6] Bluetooth: Fix initiated LE connections
[PATCH 6/6] Bluetooth: simple SMP pairing negotiation
