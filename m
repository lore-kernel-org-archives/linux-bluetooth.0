Return-Path: <cyrus@holtmann.org>
Message-ID: <4D69EE46.9050401@lundman.net>
Date: Sun, 27 Feb 2011 15:25:10 +0900
From: lundman <lundman@lundman.net>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Linux 2.6.28-10 Oops in hci_send_to_sock
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Linux-2.6.28 CE41xx kernel, sodaville board.

I turned on more debugging, and added a print for each SK and peppered 
the logic a little:

[code]
void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
{
[snip]

         BT_DBG("filter");

         /* Apply filter */
         flt = &hci_pi(sk)->filter;

  [snip]

         BT_DBG("type");

         if (bt_cb(skb)->pkt_type == HCI_EVENT_PKT) {
             register int evt = (*(__u8 *)skb->data & HCI_FLT_EVENT_BITS);

             if (!hci_test_bit(evt, &flt->event_mask))
                 continue;

             if (flt->opcode &&
                 ((evt == HCI_EV_CMD_COMPLETE &&
                   flt->opcode !=                  get_unaligned((__le16 
*)(skb->data + 3))) ||
                  (evt == HCI_EV_CMD_STATUS &&
                   flt->opcode !=
                   get_unaligned((__le16 *)(skb->data + 4)))))
                 continue;
         }

         BT_DBG("clone");


[/code]


When I start bluetoothd, the panic looks like:


[code]
hci_send_to_sock: hdev 00000000 len 8
usbcore: registered new interface driver btusb
hci_sock_create: sock cbd6dd80
hci_sock_bind: sock cbd6dd80 sk cab87c00
hci_sock_sendmsg: sock cbd6dd80 sk cab87c00
hci_sock_release: sock cbd6dd80 sk cab87c00
hci_sock_create: sock cbd6dd80
hci_sock_setsockopt: sk cab87e00, opt 2
hci_sock_bind: sock cbd6dd80 sk cab87e00
hci_sock_ioctl: cmd 800448d2 arg b7f37208
hci_sock_create: sock cbdb9000
hci_sock_bind: sock cbdb9000 sk ca2cd400
hci_dev_get: 0
hci_sock_setsockopt: sk ca2cd400, opt 2
hci_sock_ioctl: cmd 400448e2 arg bff12038
hci_dev_get: 0
hci_sock_ioctl: cmd 400448c9 arg 0
hci_dev_get: 0
hci_dev_open: hci0 cc308c00
btusb_open: hci0
btusb_submit_intr_urb: hci0
__hci_request: hci0 start
btusb_intr_complete: hci0 urb ca3bec80 status 0 count 6
hci_rx_task: hci0
hci_send_to_sock: hdev cc308c00 len 6
hci_send_to_sock: skb ca2cd400
hci_send_to_sock: filter
hci_send_to_sock: type
BUG: unable to handle kernel NULL pointer dereference at 00000008
IP: [<cf108fc8>] hci_send_to_sock+0x83/0x153 [bluetooth]
*pdpt = 000000000a3d6001 *pde = 0000000000000000
Oops: 0000 [#1] PREEMPT
last sysfs file: /sys/class/vc/vcsa1/dev
Modules linked in: btusb bluetooth fusion pvrsrvkm alsa_shim 
snd_usb_audio snd_x

Pid: 1783, comm: bluetoothd Not tainted (2.6.28 #1)
EIP: 0060:[<cf108fc8>] EFLAGS: 00010246 CPU: 0
EIP is at hci_send_to_sock+0x83/0x153 [bluetooth]
EAX: 00000008 EBX: ca2cd400 ECX: 00000004 EDX: ffffffff
ESI: ca2cd408 EDI: 00000102 EBP: cc2a1480 ESP: ca3cbd4c
  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
Process bluetoothd (pid: 1783, ti=ca3ca000 task=ca0e6e60 task.ti=ca3ca000)
Call Trace:
  [<cf103ef1>] hci_rx_task+0x54/0x286 [bluetooth]
  [<c011ee03>] tasklet_action+0x34/0x69
  [<c011ec7e>] __do_softirq+0x53/0xe7
  [<cfb2b989>] SystemISRWrapper+0xe/0x24 [pvrsrvkm]
  [<c013a8dc>] handle_IRQ_event+0x25/0x4a
  [<c011ed39>] do_softirq+0x27/0x29
  [<c011ef52>] irq_exit+0x32/0x34
  [<c0104ed8>] do_IRQ+0x4c/0x94
  [<c0298eef>] serial8250_console_putchar+0x0/0x1d
  [<c01039bf>] common_interrupt+0x23/0x28
  [<c011b494>] vprintk+0x1d3/0x300
  [<c011b525>] vprintk+0x264/0x300
  [<c013fe13>] filemap_fault+0x119/0x466
  [<c011b5dc>] printk+0x1b/0x1f
  [<cf102fba>] __hci_request+0x48/0xfb [bluetooth]
  [<cf1034e8>] hci_init_req+0x0/0x158 [bluetooth]
  [<c01179c5>] default_wake_function+0x0/0x8
  [<cf103902>] hci_dev_open+0x9a/0x197 [bluetooth]
  [<c035c98f>] sock_ioctl+0xb0/0x1fc
  [<c035c8df>] sock_ioctl+0x0/0x1fc
  [<c016d5f6>] vfs_ioctl+0x1f/0x6d
  [<c016d7a7>] do_vfs_ioctl+0x52/0x471
  [<c0111f41>] do_page_fault+0x1b2/0x881
  [<c0111d8f>] do_page_fault+0x0/0x881
  [<c043a1c2>] error_code+0x6a/0x70
  [<c016dbfa>] sys_ioctl+0x34/0x50
  [<c0102e71>] sysenter_do_call+0x12/0x25
  [<c0430000>] pci_scan_bridge+0x40/0x3c7
[/code]


Somewhere between 'type' and 'clone', anyone want to throw me a bone?;)

Lund

