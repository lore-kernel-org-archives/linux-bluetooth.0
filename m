Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-Dc7gGXVRkZsGTyPUh8mg"
Message-Id: <1081523614.13202.23.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Testing patch for 2.4
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 09 Apr 2004 17:13:34 +0200


--=-Dc7gGXVRkZsGTyPUh8mg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Folks,

I did a big rework of the Bluetooth PCMCIA part for 2.6 and as a result
of it the Anycom CF-300 is now supported and the 3Com driver uses the
request_firmware() interface for loading the firmware. This means that
the bluefw loader is no longer needed and these cards may also work on a
PowerPC platform. A hotplug package with firmware.agent script must be
used and BT3CPCC.bin must be under /usr/lib/hotplug/firmware/

Attached is the result of my backport to 2.4

 Documentation/Configure.help    |    3 
 drivers/bluetooth/Makefile.lib  |    3 
 drivers/bluetooth/bluecard_cs.c |   39 +++++++++-
 drivers/bluetooth/bt3c_cs.c     |  147 +++++++++++++++++++++++++---------------
 4 files changed, 128 insertions(+), 64 deletions(-)

I don't have time for 2.4 testing, so I need feedback from people with
the Anycom CF-300 or the 3Com card version 2.0.

Regards

Marcel


--=-Dc7gGXVRkZsGTyPUh8mg
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== Documentation/Configure.help 1.239 vs edited =====
--- 1.239/Documentation/Configure.help	Thu Apr  1 12:19:49 2004
+++ edited/Documentation/Configure.help	Fri Apr  9 17:03:05 2004
@@ -23167,9 +23167,6 @@
      3Com Bluetooth Card (3CRWB6096)
      HP Bluetooth Card
 
-  The HCI BT3C driver uses external firmware loader program provided in
-  the BlueFW package. For more information, see <http://bluez.sf.net>.
-
   Say Y here to compile support for HCI BT3C devices into the
   kernel or say M to compile it as module (bt3c_cs.o).
 
===== drivers/bluetooth/Makefile.lib 1.1 vs edited =====
--- 1.1/drivers/bluetooth/Makefile.lib	Sat Aug 16 10:25:11 2003
+++ edited/drivers/bluetooth/Makefile.lib	Fri Apr  9 16:33:57 2004
@@ -1 +1,2 @@
-obj-$(CONFIG_BLUEZ_HCIBFUSB) += firmware_class.o
+obj-$(CONFIG_BLUEZ_HCIBFUSB)	+= firmware_class.o
+obj-$(CONFIG_BLUEZ_HCIBT3C)	+= firmware_class.o
===== drivers/bluetooth/bluecard_cs.c 1.1 vs edited =====
--- 1.1/drivers/bluetooth/bluecard_cs.c	Sat Aug  3 13:54:07 2002
+++ edited/drivers/bluetooth/bluecard_cs.c	Fri Apr  9 16:55:28 2004
@@ -174,6 +174,9 @@
 	bluecard_info_t *info = (bluecard_info_t *)arg;
 	unsigned int iobase = info->link.io.BasePort1;
 
+	if (!test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state)))
+		return;
+
 	if (test_bit(CARD_HAS_ACTIVITY_LED, &(info->hw_state))) {
 		/* Disable activity LED */
 		outb(0x08 | 0x20, iobase + 0x30);
@@ -188,6 +191,9 @@
 {
 	unsigned int iobase = info->link.io.BasePort1;
 
+	if (!test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state)))
+		return;
+
 	if (test_bit(CARD_HAS_ACTIVITY_LED, &(info->hw_state))) {
 		/* Enable activity LED */
 		outb(0x10 | 0x40, iobase + 0x30);
@@ -627,13 +633,16 @@
 	bluecard_info_t *info = (bluecard_info_t *)(hdev->driver_data);
 	unsigned int iobase = info->link.io.BasePort1;
 
-	bluecard_hci_set_baud_rate(hdev, DEFAULT_BAUD_RATE);
+	if (test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state)))
+		bluecard_hci_set_baud_rate(hdev, DEFAULT_BAUD_RATE);
 
 	if (test_and_set_bit(HCI_RUNNING, &(hdev->flags)))
 		return 0;
 
-	/* Enable LED */
-	outb(0x08 | 0x20, iobase + 0x30);
+	if (test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state))) {
+		/* Enable LED */
+		outb(0x08 | 0x20, iobase + 0x30);
+	}
 
 	return 0;
 }
@@ -649,8 +658,10 @@
 
 	bluecard_hci_flush(hdev);
 
-	/* Disable LED */
-	outb(0x00, iobase + 0x30);
+	if (test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state))) {
+		/* Disable LED */
+		outb(0x00, iobase + 0x30);
+	}
 
 	return 0;
 }
@@ -756,6 +767,24 @@
 	outb(0xff, iobase + REG_INTERRUPT);
 	info->ctrl_reg |= REG_CONTROL_INTERRUPT;
 	outb(info->ctrl_reg, iobase + REG_CONTROL);
+
+	if ((id & 0x0f) == 0x03) {
+		/* Disable RTS */
+		info->ctrl_reg |= REG_CONTROL_RTS;
+		outb(info->ctrl_reg, iobase + REG_CONTROL);
+
+		/* Set baud rate */
+		info->ctrl_reg |= 0x03;
+		outb(info->ctrl_reg, iobase + REG_CONTROL);
+
+		/* Enable RTS */
+		info->ctrl_reg &= ~REG_CONTROL_RTS;
+		outb(info->ctrl_reg, iobase + REG_CONTROL);
+
+		set_bit(XMIT_BUF_ONE_READY, &(info->tx_state));
+		set_bit(XMIT_BUF_TWO_READY, &(info->tx_state));
+		set_bit(XMIT_SENDING_READY, &(info->tx_state));
+	}
 
 	/* Start the RX buffers */
 	outb(REG_COMMAND_RX_BUF_ONE, iobase + REG_COMMAND);
===== drivers/bluetooth/bt3c_cs.c 1.1 vs edited =====
--- 1.1/drivers/bluetooth/bt3c_cs.c	Sat Aug  3 13:54:07 2002
+++ edited/drivers/bluetooth/bt3c_cs.c	Fri Apr  9 17:09:00 2004
@@ -24,8 +24,6 @@
 #include <linux/config.h>
 #include <linux/module.h>
 
-#define __KERNEL_SYSCALLS__
-
 #include <linux/kernel.h>
 #include <linux/kmod.h>
 #include <linux/init.h>
@@ -48,6 +46,8 @@
 #include <asm/bitops.h>
 #include <asm/io.h>
 
+#include <linux/firmware.h>
+
 #include <pcmcia/version.h>
 #include <pcmcia/cs_types.h>
 #include <pcmcia/cs.h>
@@ -485,78 +485,101 @@
 
 
 
-/* ======================== User mode firmware loader ======================== */
+/* ======================== Card services HCI interaction ======================== */
 
 
-#define FW_LOADER  "/sbin/bluefw"
-static int errno;
+static int bt3c_load_firmware(bt3c_info_t *info, unsigned char *firmware, int count)
+{
+	char *ptr = (char *) firmware;
+	char b[9];
+	unsigned int iobase, size, addr, fcs, tmp;
+	int i, err = 0;
 
+	iobase = info->link.io.BasePort1;
 
-static int bt3c_fw_loader_exec(void *dev)
-{
-	char *argv[] = { FW_LOADER, "pccard", dev, NULL };
-	char *envp[] = { "HOME=/", "TERM=linux", "PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
-	int err;
+	/* Reset */
 
-	err = exec_usermodehelper(FW_LOADER, argv, envp);
-	if (err)
-		printk(KERN_WARNING "bt3c_cs: Failed to exec \"%s pccard %s\".\n", FW_LOADER, (char *)dev);
+	bt3c_io_write(iobase, 0x8040, 0x0404);
+	bt3c_io_write(iobase, 0x8040, 0x0400);
 
-	return err;
-}
+	udelay(1);
 
+	bt3c_io_write(iobase, 0x8040, 0x0404);
 
-static int bt3c_firmware_load(bt3c_info_t *info)
-{
-	sigset_t tmpsig;
-	char dev[16];
-	pid_t pid;
-	int result;
-
-	/* Check if root fs is mounted */
-	if (!current->fs->root) {
-		printk(KERN_WARNING "bt3c_cs: Root filesystem is not mounted.\n");
-		return -EPERM;
-	}
+	udelay(17);
 
-	sprintf(dev, "%04x", info->link.io.BasePort1);
+	/* Load */
 
-	pid = kernel_thread(bt3c_fw_loader_exec, (void *)dev, 0);
-	if (pid < 0) {
-		printk(KERN_WARNING "bt3c_cs: Forking of kernel thread failed (errno=%d).\n", -pid);
-		return pid;
-	}
+	while (count) {
+		if (ptr[0] != 'S') {
+			printk(KERN_WARNING "bt3c_cs: Bad address in firmware.\n");
+			err = -EFAULT;
+			goto error;
+		}
+
+		memset(b, 0, sizeof(b));
+		memcpy(b, ptr + 2, 2);
+		size = simple_strtol(b, NULL, 16);
+
+		memset(b, 0, sizeof(b));
+		memcpy(b, ptr + 4, 8);
+		addr = simple_strtol(b, NULL, 16);
+
+		memset(b, 0, sizeof(b));
+		memcpy(b, ptr + (size * 2) + 2, 2);
+		fcs = simple_strtol(b, NULL, 16);
+
+		memset(b, 0, sizeof(b));
+		for (tmp = 0, i = 0; i < size; i++) {
+			memcpy(b, ptr + (i * 2) + 2, 2);
+			tmp += simple_strtol(b, NULL, 16);
+		}
 
-	/* Block signals, everything but SIGKILL/SIGSTOP */
-	spin_lock_irq(&current->sigmask_lock);
-	tmpsig = current->blocked;
-	siginitsetinv(&current->blocked, sigmask(SIGKILL) | sigmask(SIGSTOP));
-	recalc_sigpending(current);
-	spin_unlock_irq(&current->sigmask_lock);
-
-	result = waitpid(pid, NULL, __WCLONE);
-
-	/* Allow signals again */
-	spin_lock_irq(&current->sigmask_lock);
-	current->blocked = tmpsig;
-	recalc_sigpending(current);
-	spin_unlock_irq(&current->sigmask_lock);
-
-	if (result != pid) {
-		printk(KERN_WARNING "bt3c_cs: Waiting for pid %d failed (errno=%d).\n", pid, -result);
-		return -result;
+		if (((tmp + fcs) & 0xff) != 0xff) {
+			printk(KERN_WARNING "bt3c_cs: Checksum error in firmware.\n");
+			err = -EILSEQ;
+			goto error;
+		}
+
+		if (ptr[1] == '3') {
+			bt3c_address(iobase, addr);
+
+			memset(b, 0, sizeof(b));
+			for (i = 0; i < (size - 4) / 2; i++) {
+				memcpy(b, ptr + (i * 4) + 12, 4);
+				tmp = simple_strtol(b, NULL, 16);
+				bt3c_put(iobase, tmp);
+			}
+		}
+
+		ptr   += (size * 2) + 6;
+		count -= (size * 2) + 6;
 	}
 
-	return 0;
-}
+	udelay(17);
 
+	/* Boot */
 
+	bt3c_address(iobase, 0x3000);
+	outb(inb(iobase + CONTROL) | 0x40, iobase + CONTROL);
 
-/* ======================== Card services HCI interaction ======================== */
+error:
+	udelay(17);
+
+	/* Clear */
+
+	bt3c_io_write(iobase, 0x7006, 0x0000);
+	bt3c_io_write(iobase, 0x7005, 0x0000);
+	bt3c_io_write(iobase, 0x7001, 0x0000);
+
+	return err;
+}
 
 
 int bt3c_open(bt3c_info_t *info)
 {
+	const struct firmware *firmware;
+	char device[16];
 	struct hci_dev *hdev;
 	int err;
 
@@ -570,8 +593,22 @@
 
 	/* Load firmware */
 
-	if ((err = bt3c_firmware_load(info)) < 0)
+	snprintf(device, sizeof(device), "bt3c%4.4x", info->link.io.BasePort1);
+
+	err = request_firmware(&firmware, "BT3CPCC.bin", device);
+	if (err < 0) {
+		printk(KERN_WARNING "bt3c_cs: Firmware request failed.\n");
 		return err;
+	}
+
+	err = bt3c_load_firmware(info, firmware->data, firmware->size);
+
+	release_firmware(firmware);
+
+	if (err < 0) {
+		printk(KERN_WARNING "bt3c_cs: Firmware loading failed.\n");
+		return err;
+	}
 
 	/* Timeout before it is safe to send the first HCI packet */
 

--=-Dc7gGXVRkZsGTyPUh8mg--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
