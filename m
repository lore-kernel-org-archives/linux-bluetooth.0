Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 17 Jul 2009 16:13:53 -0300
Message-ID: <5d223510907171213n3fad15a5vd25dfd43e29c38fa@mail.gmail.com>
Subject: Corrupted skbs on ARM
From: Rafael Seste <rseste@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

We have been stuck with a problem regarding bluetooth audio
transmission in ARM processors for a long time. Our ARM machine runs
Linux (2.6.30 kernel) and has a Bluetooth USB adapter (Bluez 4.42).
When it plays or receives audio, some packets are right, but a good
deal of them have wrong handles and lengths.

When the same Bluetooth adapter is used in an x86 system, with the
same kernel version, the audio works perfectly, the handles are normal
(constant for one connection) and the lengths are 48 bytes for all
audio packets.

Using hcidump and printks in hci_core.c to see these packets, we found
that hci_rx_task() already receives corrupted skbs when it calls
skb_dequeue(&hdev->rx_q). Not having any experience with the Linux
Kernel, we don't know what enqueues skbs in that queue, nor in what
direction the calls are coming from - from to OS to the physical
device or from a device interrupt to an OS callback.

Has anyone else experienced this problem and found a solution? Also,
since we are backtracking the error, knowing where the skbs in rx_q
come from is essential. Could anyone point us where these skbs are
inserted in the queue?

Thank you in advance for the help.

-- 
Rafael S. Seste
