Return-Path: <cyrus@holtmann.org>
Message-ID: <4D689640.8030906@lundman.net>
Date: Sat, 26 Feb 2011 14:57:20 +0900
From: lundman <lundman@lundman.net>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Linux 2.6.28-10 Oops in hci_send_to_sock
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


I apologies to bring up such an old kernel, but with embedded devices, I 
do not have the ability to change kernel. I am trying to start 
bluetooth, but I get a kernel panic. I have one device attached.

# insmod bluetooth.ko
# insmod l2cap.ko
# insmod btusb.ko
# insmod sco.ko
# insmod uinput.ko
# ./bluetoothd -d -n

[snip]

bluetoothd[1786]: src/main.c:main() Entering main loop
bluetoothd[1786]: plugins/hciops.c:init_known_adapters()
bluetoothd[1786]: HCI dev 0 registered
bluetoothd[1786]: plugins/hciops.c:device_devreg_setup() hci0
bluetoothd[1786]: plugins/hciops.c:init_device() hci0
bluetoothd[1786]: Listening for HCI events on hci0
bluetoothd[1786]: plugins/hciops.c:init_device() child 1789 forked


# BUG: unable to handle kernel NULL pointer dereference at 00000008
IP: [<cf107ca2>] hci_send_to_sock+0x70/0x12c [bluetooth]
*pdpt = 000000000a197001 *pde = 0000000000000000
Oops: 0000 [#1] PREEMPT
last sysfs file: /sys/class/misc/uinput/dev
Modules linked in: uinput sco btusb l2cap bluetooth fusion pvrsrvkm 
alsa_shim sx

Pid: 0, comm: swapper Not tainted (2.6.28 #1)
EIP: 0060:[<cf107ca2>] EFLAGS: 00010246 CPU: 0
EIP is at hci_send_to_sock+0x70/0x12c [bluetooth]
EAX: 00000001 EBX: 00000000 ECX: 00000204 EDX: ca1eb600
ESI: cc3cbf74 EDI: 00000008 EBP: cc3cbe00 ESP: c056fef8
  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
Process swapper (pid: 0, ti=c056e000 task=c0531380 task.ti=c056e000)
Stack:
  ca1eb600 ca3a6400 cc3cbe08 00000000 ca1eb600 ca3a6400 0000000a cf103299
  cc011380 00000001 00000040 cc011490 0000012c 00000000 00000000 00000014
  00000102 0000000a c011ee03 00000001 c011ec7e cfb49f40 cfb2b989 00000004
Call Trace:
  [<cf103299>] hci_rx_task+0x2a/0x209 [bluetooth]
  [<c011ee03>] tasklet_action+0x34/0x69
  [<c011ec7e>] __do_softirq+0x53/0xe7
  [<cfb2b989>] SystemISRWrapper+0xe/0x24 [pvrsrvkm]
  [<c013a8dc>] handle_IRQ_event+0x25/0x4a
  [<c011ed39>] do_softirq+0x27/0x29
  [<c011ef52>] irq_exit+0x32/0x34
  [<c0104ed8>] do_IRQ+0x4c/0x94
  [<c01039bf>] common_interrupt+0x23/0x28
  [<c0108a16>] mwait_idle+0x2d/0x32
  [<c0101b0c>] cpu_idle+0x1e/0x63
Code: 74 01 00 00 89 ca 83 e2 1f 80 f9 ff 0f 45 c2 0f a3 06 19 c0 85 c0 
74 7f 8
EIP: [<cf107ca2>] hci_send_to_sock+0x70/0x12c [bluetooth] SS:ESP 
0068:c056fef8
Kernel panic - not syncing: Fatal exception in interrupt




I was hoping I could jog someones memory, and maybe get references to 
some existing patches maybe, that I can apply to the kernel module by hand?

Thanks for any reply,

Lund




