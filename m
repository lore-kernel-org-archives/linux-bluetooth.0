Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Adam Czaplinski <adamc@hcvwireless.com>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-7bqC0MRh253VwCV+4VA8"
Message-Id: <1121741293.4788.96.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] hci bcsp driver bug
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 19 Jul 2005 12:48:13 +1000


--=-7bqC0MRh253VwCV+4VA8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I recently discovered very consistent BUG inside the serial HCI driver
that implements BlueCore BCSP protocol.

I am running BlueZ 2.18 protocol stack (compiled with gcc version
3.3.2)  on the embedded ARM-based CerfBoard target platform from
Intrinsync on the linux-2.6.7-cerfb1 kernel. I am using ttyS3 serial
interface at the 115200 baud rate as the HCI interface to BlueCore
module attached to the BlueZ upper layer stack via:
$ hciattach ttyS3 bcsp 115200

I created successfully PAN-profile bluetooth access point (with ethernet
bridging to local LAN for Internet access) and tested it with the XDA||
pocket PC.

Generally all basic fuctionality seems to be OK i.e. BNEP interface get
created successfully and the access to LAN is working fine. The problem
is triggered when I am trying to increase the traffic via the HCI bcsp
link. Any application on my PocketPc that increases the network traffic
via the BNEP interface (ftp, sip, web browsing... etc) eventually causes
the kernel to Oops at the attempt to dereference a NULL pointer. I
analysed the Oops trace and localised the offending code to be placed
inside the bcsp_complete_rx_pkt() function. Next I added following
debugging code (marked as "ajc:..."), in the hci_bcsp.c:

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
static int cnt = 0; //ajc: DBG
static inline void bcsp_complete_rx_pkt(struct hci_uart *hu)
{
    struct bcsp_struct *bcsp = hu->priv;
    int pass_up;
    unsigned char  **ptr_dbg = &(bcsp->rx_skb->data); //ajc: DBG
                                                                                                                            
    if (bcsp->rx_skb->data[0] & 0x80) {     /* reliable pkt */

		...
                                                                                                                        
         /* If needed, transmit an ack pkt */
         hci_uart_tx_wakeup(hu);
                                                                                                                            
         //ajc: DBG start
         ++cnt;
         if (!bcsp->rx_skb) //ajc: detect NULL pointer
         {
           printk("ajc: !! NULL pointer: 0x%p->(0x%p != 0x%p) cnt=%d\n",
                        bcsp->rx_skb,
                        &(bcsp->rx_skb->data),
                        ptr_dbg,
                        cnt);
               printk("ajc: Next instruction will crush the kernel\n");
            }
            //ajc: DBG end
        }
                                                                                                                          
        bcsp->rxack = (bcsp->rx_skb->data[0] >> 3) & 0x07;
        ...
}
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 

The final result is that the the code line:

bcsp->rxack = (bcsp->rx_skb->data[0] >> 3) & 0x07;

fails because the "bcsp->rx_skb" pointer gets occasionally reseted to
NULL. The full Oops trace from my target platform is included (see
Oops.txt). Unfortunately the complexity of the code, and the limited
linux programming experience from my side stopped me from making any
further progress in solving this problem. Therefore I would deeply
appreciate any comments (or solutions) to help in resolving described
above problem. 

Thanks in advance for your co-operation. 

Best regards,
Adam 

--=-7bqC0MRh253VwCV+4VA8
Content-Disposition: attachment; filename=oops.txt
Content-Type: text/plain; name=oops.txt; charset=utf-8
Content-Transfer-Encoding: 7bit


-sh-2.05b# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:0A:31:01:00:29
          inet addr:192.168.8.108  Bcast:192.168.8.255  Mask:255.255.255.0
          UP BROADCAST RUNNING  MTU:1500  Metric:1
          RX packets:25 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:2950 (2.8 Kb)  TX bytes:1522 (1.4 Kb)
          Interrupt:44 Base address:0x300 DMA chan:8

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

-sh-2.05b# /etc/bluetooth/ajc_dir/startall
Bridge firewalling registered
eth0: Promiscuous mode enabled
device eth0 entered promiscuous mode
pan0: driver changed get_stats after register
pan0: port 1(eth0) entering learning state
pan0: topology change detected, propgating
pan0: port 1(eth0) entering forwarding state
eth0: Promiscuous mode enabled
Bluetooth: Core ver 2.5
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI UART driver ver 2.1
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized
bcsp_recv: Out-of-order packet arrived, got 1 expected 0
Bluetooth: L2CAP ver 2.2
Bluetooth: L2CAP socket layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.0
Bluetooth: BNEP filters: protocol multicast
-sh-2.05b# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:0A:31:01:00:29
          UP BROADCAST RUNNING  MTU:1500  Metric:1
          RX packets:46 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:4912 (4.7 Kb)  TX bytes:1522 (1.4 Kb)
          Interrupt:44 Base address:0x300 DMA chan:8

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

pan0      Link encap:Ethernet  HWaddr 00:0A:31:01:00:29
          inet addr:192.168.8.108  Bcast:192.168.8.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:10 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:754 (754.0 b)  TX bytes:0 (0.0 b)

-sh-2.05b# hciconfig -a
hci0:   Type: UART
        BD Address: 00:02:72:B2:D5:4E ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN AUTH ENCRYPT
        RX bytes:307 acl:0 sco:0 events:15 errors:0
        TX bytes:484 acl:0 sco:0 commands:14 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
bcsp_timed_event: Timeout, retransmitting 1 pkts
        Name: '_BlueZ (familiar)'
        Class: 0x020100
        Service Classes: Networking
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.... here I connected my PocketPc PAN client
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 

-sh-2.05b# device bnep0 entered promiscuous mode
bnep0: driver changed get_stats after register
pan0: port 2(bnep0) entering learning state
pan0: topology change detected, propgating
pan0: port 2(bnep0) entering forwarding state

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.... now I started browsing the web on PocketPC via BNEP interface
and felt over after following a coule of web page links.
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

-sh-2.05b#
ajc: !! NULL pointer: 0x00000000->(0x000000a0 != 0xc38e19c0) cnt=1135
ajc: Next instruction will crush the kernel
Unable to handle kernel NULL pointer dereference at virtual address 000000a0
pgd = c0004000
[000000a0] *pgd=00000000
Internal error: Oops: 7 [#1]
Modules linked in: bnep l2cap hci_uart bluetooth bridge unix
CPU: 0
PC is at bcsp_recv+0x51c/0x848 [hci_uart]
LR is at 0x1
pc : [<bf01dd18>]    lr : [<00000001>]    Not tainted
sp : c01e7e58  ip : 60000093  fp : c01e7e98
r10: 00000004  r9 : c397571c  r8 : c398531c
r7 : c38e0138  r6 : c38e0138  r5 : 00000000  r4 : c38e19c0
r3 : 00000000  r2 : 00000000  r1 : 000016f0  r0 : c38e0138
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment kernel
Control: 397F  Table: A3CBC000  DAC: 0000001D
Process swapper (pid: 0, stack limit = 0xc01e60fc)
Stack: (0xc01e7e58 to 0xc01e8000)
7e40:                                                       0000046f 00000001
7e60: c3891778 00000000 c3891778 00c0dba4 c397571c c3985000 00000010 60000013
7e80: 00000010 c01e7f68 c022d898 c01e7eb4 c01e7e9c bf01c610 bf01d808 c3985710
7ea0: c3985310 00000000 c01e7ed8 c01e7eb8 c00f7004 bf01c5d0 c022db7c 00000000
7ec0: c022dc14 00000000 00000000 c01e7f0c c01e7edc c0100374 c00f6f68 0000000e
7ee0: 00000000 c397591c 00000000 00000000 0000000e c01e7f68 ffffffff a0019d64
7f00: c01e7f30 c01e7f10 c0020d0c c0100310 c021fd18 0000000e c01e7f68 c0021944
7f20: 60000013 c01e7f4c c01e7f34 c0020f70 c0020cc4 c01e6000 c01e7f68 00200000
7f40: c01e7f64 c01e7f50 c00210f0 c0020f14 c01e7f9c f2d00000 c01e7fbc c01e7f68
7f60: c001fec0 c00210b4 00000001 c0221be8 f2e00000 60000013 c00218fc c01e6000
7f80: c01e91a4 c0220f1c c01e8f08 69052d06 a0019d64 c01e7fbc c01e7fc0 c01e7fb0
7fa0: c0021938 c0021944 60000013 ffffffff c01e7fd8 c01e7fc0 c0021998 c0021908
7fc0: c025a4b8 c021f5b8 c0229c08 c01e7ffc c01e7fdc c000863c c0021958 c0008350
7fe0: c0221338 c025a4b8 c025a4b8 c0220f28 00000000 c01e8000 c0008080 c00084c8
Backtrace:
[<bf01d7fc>] (bcsp_recv+0x0/0x848 [hci_uart]) from [<bf01c610>] (hci_uart_tty_re
ceive+0x4c/0x9c [hci_uart])
[<bf01c5c4>] (hci_uart_tty_receive+0x0/0x9c [hci_uart]) from [<c00f7004>] (flush
_to_ldisc+0xa8/0xac)
 r6 = 00000000  r5 = C3985310  r4 = C3985710
[<c00f6f5c>] (flush_to_ldisc+0x0/0xac) from [<c0100374>] (serial8250_interrupt+0
x70/0xd8)
 r8 = 00000000  r7 = 00000000  r6 = C022DC14  r5 = 00000000
 r4 = C022DB7C
[<c0100304>] (serial8250_interrupt+0x0/0xd8) from [<c0020d0c>] (__do_irq+0x54/0x
84)
[<c0020cb8>] (__do_irq+0x0/0x84) from [<c0020f70>] (do_level_IRQ+0x68/0xc0)
 r8 = 60000013  r7 = C0021944  r6 = C01E7F68  r5 = 0000000E
 r4 = C021FD18
[<c0020f08>] (do_level_IRQ+0x0/0xc0) from [<c00210f0>] (asm_do_IRQ+0x48/0xa4)
 r6 = 00200000  r5 = C01E7F68  r4 = C01E6000
[<c00210a8>] (asm_do_IRQ+0x0/0xa4) from [<c001fec0>] (__irq_svc+0x20/0x60)
 r5 = F2D00000  r4 = C01E7F9C
[<c00218fc>] (default_idle+0x0/0x50) from [<c0021998>] (cpu_idle+0x4c/0x78)
[<c002194c>] (cpu_idle+0x0/0x78) from [<c000863c>] (start_kernel+0x180/0x1c0)
 r6 = C0229C08  r5 = C021F5B8  r4 = C025A4B8
[<c00084bc>] (start_kernel+0x0/0x1c0) from [<c0008080>] (__mmap_switched+0x0/0x2
c)
Code: e59f0314 eb406774 e5973028 e1a00007 (e59330a0)
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

--=-7bqC0MRh253VwCV+4VA8--



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
