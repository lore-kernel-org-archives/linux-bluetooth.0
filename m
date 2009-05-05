Return-Path: <cyrus@holtmann.org>
Subject: Re: [regression] connecting a bluetooth mouse triggers multiple
 BUGs  and warnings
From: Marcel Holtmann <marcel@holtmann.org>
To: Davide Pesavento <davidepesa@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2da21fe50905041506m2d9fc879l715e34f1a2027046@mail.gmail.com>
References: <2da21fe50905031022o73481d88tdaecb88491cfcfd2@mail.gmail.com>
	 <1241381725.2785.0.camel@localhost.localdomain>
	 <2da21fe50905041506m2d9fc879l715e34f1a2027046@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-CfQ+Hh6TH9oun2EoKW0O"
Date: Mon, 04 May 2009 18:56:03 -0700
Message-Id: <1241488563.3319.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-CfQ+Hh6TH9oun2EoKW0O
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Davide,

> the NULL pointer dereference and the warnings are indeed fixed in
> bluetooth-testing, and the mouse works. Thanks!
> However the following issue remains:
> 
> [  110.012125] BUG: sleeping function called from invalid context at
> mm/slub.c:1595
> [  110.012135] in_atomic(): 1, irqs_disabled(): 0, pid: 0, name:
> swapper
> [  110.012141] 2 locks held by swapper/0:
> [  110.012145]  #0:  (hci_task_lock){++.-.+}, at: [<ffffffffa01f822f>]
> hci_rx_task+0x2f/0x2d0 [bluetooth]
> [  110.012173]  #1:  (&hdev->lock){+.-.+.}, at: [<ffffffffa01fb9e2>]
> hci_event_packet+0x72/0x25c0 [bluetooth]
> [  110.012198] Pid: 0, comm: swapper Tainted: G        W
> 2.6.30-rc4-g953cdaa #1
> [  110.012203] Call Trace:
> [  110.012207]  <IRQ>  [<ffffffff8023eabd>] __might_sleep+0x14d/0x170
> [  110.012228]  [<ffffffff802cfbe1>] __kmalloc+0x111/0x170
> [  110.012239]  [<ffffffff803c2094>] kvasprintf+0x64/0xb0
> [  110.012248]  [<ffffffff803b7a5b>] kobject_set_name_vargs+0x3b/0xa0
> [  110.012257]  [<ffffffff80465326>] dev_set_name+0x76/0xa0
> [  110.012273]  [<ffffffffa01fb9e2>] ? hci_event_packet+0x72/0x25c0
> [bluetooth]
> [  110.012289]  [<ffffffffa01ffc1d>] hci_conn_add_sysfs+0x3d/0x70
> [bluetooth]
> [  110.012303]  [<ffffffffa01fba2c>] hci_event_packet+0xbc/0x25c0
> [bluetooth]
> [  110.012312]  [<ffffffff80516eb0>] ? sock_def_readable+0x80/0xa0
> [  110.012328]  [<ffffffffa01fee0c>] ? hci_send_to_sock+0xfc/0x1c0
> [bluetooth]
> [  110.012343]  [<ffffffff80516eb0>] ? sock_def_readable+0x80/0xa0
> [  110.012347]  [<ffffffff805e88c5>] ? _read_unlock+0x75/0x80
> [  110.012354]  [<ffffffffa01fee0c>] ? hci_send_to_sock+0xfc/0x1c0
> [bluetooth]
> [  110.012360]  [<ffffffffa01f8403>] hci_rx_task+0x203/0x2d0
> [bluetooth]
> [  110.012365]  [<ffffffff80250ab5>] tasklet_action+0xb5/0x160
> [  110.012369]  [<ffffffff8025116c>] __do_softirq+0x9c/0x150
> [  110.012372]  [<ffffffff805e850f>] ? _spin_unlock+0x3f/0x80
> [  110.012376]  [<ffffffff8020cbbc>] call_softirq+0x1c/0x30
> [  110.012380]  [<ffffffff8020f01d>] do_softirq+0x8d/0xe0
> [  110.012383]  [<ffffffff80250df5>] irq_exit+0xc5/0xe0
> [  110.012386]  [<ffffffff8020e71d>] do_IRQ+0x9d/0x120
> [  110.012389]  [<ffffffff8020c3d3>] ret_from_intr+0x0/0xf
> [  110.012391]  <EOI>  [<ffffffff80431832>] ? acpi_idle_enter_bm+0x264/0x2a6
> [  110.012399]  [<ffffffff80431828>] ? acpi_idle_enter_bm+0x25a/0x2a6
> [  110.012403]  [<ffffffff804f50d5>] ? cpuidle_idle_call+0xc5/0x130
> [  110.012407]  [<ffffffff8020a4b4>] ? cpu_idle+0xc4/0x130
> [  110.012411]  [<ffffffff805d2268>] ? rest_init+0x88/0xb0
> [  110.012416]  [<ffffffff807e2fbd>] ? start_kernel+0x3b5/0x412
> [  110.012420]  [<ffffffff807e2281>] ? x86_64_start_reservations+0x91/0xb5
> [  110.012424]  [<ffffffff807e2394>] ? x86_64_start_kernel+0xef/0x11b
> [  110.320835] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> [  110.349150] input: Mighty Mouse as
> /devices/pci0000:00/0000:00:1d.3/usb5/5-1/5-1:1.0/bluetooth/hci0/hci0:46/input10
> [  110.351343] apple 0005:05AC:030C.0004: input: BLUETOOTH HID v2.00
> Mouse [Mighty Mouse] on 00:17:F2:AB:8D:45

try the attached patch. It should fix this.

Regards

Marcel


--=-CfQ+Hh6TH9oun2EoKW0O
Content-Disposition: attachment; filename="patch"
Content-Type: text/x-patch; name="patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 582d887..a05d45e 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -88,10 +88,13 @@ static struct device_type bt_link = {
 static void add_conn(struct work_struct *work)
 {
 	struct hci_conn *conn = container_of(work, struct hci_conn, work_add);
+	struct hci_dev *hdev = conn->hdev;
 
 	/* ensure previous del is complete */
 	flush_work(&conn->work_del);
 
+	dev_set_name(&conn->dev, "%s:%d", hdev->name, conn->handle);
+
 	if (device_add(&conn->dev) < 0) {
 		BT_ERR("Failed to register connection device");
 		return;
@@ -154,12 +157,8 @@ void hci_conn_init_sysfs(struct hci_conn *conn)
 
 void hci_conn_add_sysfs(struct hci_conn *conn)
 {
-	struct hci_dev *hdev = conn->hdev;
-
 	BT_DBG("conn %p", conn);
 
-	dev_set_name(&conn->dev, "%s:%d", hdev->name, conn->handle);
-
 	queue_work(bt_workq, &conn->work_add);
 }
 

--=-CfQ+Hh6TH9oun2EoKW0O--

