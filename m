Return-Path: <cyrus@holtmann.org>
From: "Xu, Martin" <martin.xu@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Liu, Bing Wei" <bing.wei.liu@intel.com>
Date: Tue, 5 May 2009 16:06:23 +0800
Subject: kernel carsh using Bluez on Netbook platform  
Message-ID: <9F0C1DB20AFA954FA1DA05309350433D5F913D92@pdsmsx503.ccr.corp.intel.com>
References: <ef67228d0905031346q740aa88es5203a64a151de2e@mail.gmail.com>
 <1241399835.2899.0.camel@localhost.localdomain>
 <9F0C1DB20AFA954FA1DA05309350433D5F913D45@pdsmsx503.ccr.corp.intel.com>
In-Reply-To: <9F0C1DB20AFA954FA1DA05309350433D5F913D45@pdsmsx503.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi:
On netbook platform( Eeepc 901; "Aspire One + Omiz Bluetooth dongle"), when using bluez, such as paring, l2ping and rfcomm, kernel crashes easily.
I am using kernel 2.6.29. 

I caught below crash messag:
BUG: spinlock bad magic on CPU#0, swapper/0
Bug: unable to handle kernel paging request at 00646733
IP:[<c0508736>] spin_bug+0x5a/0x87
*pdpt = 0000000000a1b001 *pde = 0000000000000000
Oops: 0000 [#1] PREEMPT smp
last sysfs file:
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.0/bluetooth/hci0/hci0/hci0:42/type
...
EIP is at spin_bug+0x5a/0x87
...
Call Trace:
[c......]? _raw_spin_lock+0x1e/ox11c
[c......]? spin_unlock_irqrestore+0x22/0x25
[c......]?_spin_lock_irqsave+0x17/0x1c
[c......]skb_dequeue+0-x2a/0x94
[c......]skb_queue_purge+0x14/0x1b
[c......]hci_conn_del+0x10e/0x115
[c......]hci_event_packet+0x620/0x29b7
[c......]enqueue_task_fair+0xxxx/0xxxx
[c......]_spin_unlock_irqresotre+0xxxx/0xxxx
[c......]try_to_wake_up+0xxxx/0xxxx
[c......]default_wake_function+0xxxx/0xxxx
[c......]pollwake+0xxxx/0xxxx
[c......]default_wake_function+0xxxx/0xxxx
[c......]wake_up_common+0xxxx/0xxxx
[c......]spin_unlock_irqrestore+0xxxx/0xxxx
[c......]__wake_up_sync+0xxxx/0xxxx
[c......]_read_unlock+0xxxx/0xxxx
[c......]sock_def_readable+0xxxx/0xxxx
[c......]sock_queue_rcv_skb+0xxxx/0xxxx
[c......]_read_unlock+0xxxx/0xxxx
[c......]hci_send_to_socket+0xxxx/0xxxx
[c......]hci_rx_task+0xxxx/0xxxx
[c......]tasklet_action+0xxxx/0xxxx
[c......]__do_softirq+0xxxx/0xxxx
[c......]do_softirq+0xxxx/0xxxx
[c......]irq_exit+0xxxx/0xxxx
[c......]do_IRQ+0xxxx/0xxxx
[c......]connmon_interrupt+0xxxx/0xxxx
[c......]acpi_idle_enter_bm+0xxxx/0xxxx
[c......]cpuidle_dile_call+0xxxx/0xxxx
[c......]cpu_idle+0xxxx/0xxxx
[c......]rest_init+0xxxx/0xxxx

Also see moblin bug: 
https://bugzilla.moblin.org/show_bug.cgi?id=1919
Executing l2ping from netbook caused the system hang

https://bugzilla.moblin.org/show_bug.cgi?id=2006
The user can't use bluetooth function sometimes

https://bugzilla.moblin.org/show_bug.cgi?id=1543
A issue in rfcomm connection
