Return-Path: <cyrus@holtmann.org>
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/8] btio: Add bluetooth.[ch] helper functions
Date: Thu, 19 Aug 2010 22:21:14 +0800
Message-Id: <1282227676-15381-7-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1282227676-15381-1-git-send-email-zhenhua.zhang@intel.com>
References: <1282227676-15381-1-git-send-email-zhenhua.zhang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

btio/bluetooth.[ch] is a subset of libbluetooth to provide helper APIs
for btio/btio.[ch].
---
 Makefile.am      |    2 +-
 btio/bluetooth.c |   80 ++++++++++++++++++++
 btio/bluetooth.h |  211 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 292 insertions(+), 1 deletions(-)
 create mode 100644 btio/bluetooth.c
 create mode 100644 btio/bluetooth.h

diff --git a/Makefile.am b/Makefile.am
index a89e62b..f77fa27 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -18,7 +18,7 @@ gwobex_sources = gwobex/gw-obex.h gwobex/gw-obex.c \
 			gwobex/obex-xfer.h gwobex/obex-xfer.c \
 			gwobex/utils.h gwobex/utils.c gwobex/log.h
 
-btio_sources = btio/btio.h btio/btio.c
+btio_sources = btio/btio.h btio/btio.c btio/bluetooth.h btio/bluetooth.c
 
 libexec_PROGRAMS =
 
diff --git a/btio/bluetooth.c b/btio/bluetooth.c
new file mode 100644
index 0000000..f56be3b
--- /dev/null
+++ b/btio/bluetooth.c
@@ -0,0 +1,80 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <sys/ioctl.h>
+
+#include <glib.h>
+
+#include "bluetooth.h"
+
+int devid2ba(int dev_id, bdaddr_t *bdaddr)
+{
+	struct hci_dev_info di;
+	int dd, err, ret;
+
+	memset(&di, 0, sizeof(di));
+
+	dd = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
+	if (dd < 0)
+		return dd;
+
+	memset(&di, 0, sizeof(struct hci_dev_info));
+
+	di.dev_id = dev_id;
+	ret = ioctl(dd, HCIGETDEVINFO, (void *) &di);
+
+	err = errno;
+	close(dd);
+	errno = err;
+
+	if (ret)
+		return -1;
+
+	if (!di.flags & (1 << HCI_UP)) {
+		errno = ENETDOWN;
+		return -1;
+	}
+
+	bacpy(bdaddr, &di.bdaddr);
+
+	return 0;
+}
+
+void baswap(bdaddr_t *dst, const bdaddr_t *src)
+{
+	register unsigned char *d = (unsigned char *) dst;
+	register const unsigned char *s = (const unsigned char *) src;
+	register int i;
+
+	for (i = 0; i < 6; i++)
+		d[i] = s[5-i];
+}
+
+int ba2str(const bdaddr_t *ba, char *str)
+{
+	uint8_t b[6];
+
+	baswap((bdaddr_t *) b, ba);
+	return sprintf(str, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
+		b[0], b[1], b[2], b[3], b[4], b[5]);
+}
+
+int str2ba(const char *str, bdaddr_t *ba)
+{
+	uint8_t b[6];
+	const char *ptr = str;
+	int i;
+
+	for (i = 0; i < 6; i++) {
+		b[i] = (uint8_t) strtol(ptr, NULL, 16);
+		if (i != 5 && !(ptr = strchr(ptr, ':')))
+			ptr = ":00:00:00:00:00";
+		ptr++;
+	}
+
+	baswap(ba, (bdaddr_t *) b);
+
+	return 0;
+}
diff --git a/btio/bluetooth.h b/btio/bluetooth.h
new file mode 100644
index 0000000..4a0f357
--- /dev/null
+++ b/btio/bluetooth.h
@@ -0,0 +1,211 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2009-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2009-2010  Nokia Corporation
+ *  Copyright (C) 2010  Intel Corporation
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+#ifndef BLUETOOTH_H
+#define BLUETOOTH_H
+
+#include <stdint.h>
+#include <string.h>
+#include <endian.h>
+#include <byteswap.h>
+#include <sys/socket.h>
+
+#include <glib.h>
+
+#define BTPROTO_L2CAP		0
+#define BTPROTO_HCI		1
+#define BTPROTO_RFCOMM		3
+
+#define SOL_HCI		0
+#define SOL_L2CAP	6
+#define SOL_RFCOMM	18
+
+#ifndef SOL_BLUETOOTH
+#define SOL_BLUETOOTH	274
+#endif
+
+#define BT_SECURITY	4
+struct bt_security {
+	uint8_t level;
+};
+#define BT_SECURITY_SDP		0
+#define BT_SECURITY_LOW		1
+#define BT_SECURITY_MEDIUM	2
+#define BT_SECURITY_HIGH	3
+
+#define BT_DEFER_SETUP	7
+
+/* Byte order conversions */
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+#define htobs(d)  (d)
+#define htobl(d)  (d)
+#define btohs(d)  (d)
+#define btohl(d)  (d)
+#elif __BYTE_ORDER == __BIG_ENDIAN
+#define htobs(d)  bswap_16(d)
+#define htobl(d)  bswap_32(d)
+#define btohs(d)  bswap_16(d)
+#define btohl(d)  bswap_32(d)
+#else
+#error "Unknown byte order"
+#endif
+
+/* BD Address */
+typedef struct {
+	uint8_t b[6];
+} __attribute__((packed)) bdaddr_t;
+
+/* Copy, swap, convert BD Address */
+static inline int bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2)
+{
+	return memcmp(ba1, ba2, sizeof(bdaddr_t));
+}
+
+static inline void bacpy(bdaddr_t *dst, const bdaddr_t *src)
+{
+	memcpy(dst, src, sizeof(bdaddr_t));
+}
+
+/* RFCOMM socket address */
+struct sockaddr_rc {
+	sa_family_t	rc_family;
+	bdaddr_t	rc_bdaddr;
+	uint8_t		rc_channel;
+};
+
+/* RFCOMM socket options */
+#define RFCOMM_CONNINFO	0x02
+struct rfcomm_conninfo {
+	uint16_t	hci_handle;
+	uint8_t		dev_class[3];
+};
+
+#define RFCOMM_LM	0x03
+#define RFCOMM_LM_MASTER	0x0001
+#define RFCOMM_LM_AUTH		0x0002
+#define RFCOMM_LM_ENCRYPT	0x0004
+#define RFCOMM_LM_TRUSTED	0x0008
+#define RFCOMM_LM_RELIABLE	0x0010
+#define RFCOMM_LM_SECURE	0x0020
+
+/* L2CAP socket address */
+struct sockaddr_l2 {
+	sa_family_t	l2_family;
+	unsigned short	l2_psm;
+	bdaddr_t	l2_bdaddr;
+	unsigned short	l2_cid;
+};
+
+/* L2CAP socket options */
+#define L2CAP_OPTIONS	0x01
+struct l2cap_options {
+	uint16_t	omtu;
+	uint16_t	imtu;
+	uint16_t	flush_to;
+	uint8_t		mode;
+	uint8_t		fcs;
+};
+
+#define L2CAP_CONNINFO	0x02
+struct l2cap_conninfo {
+	uint16_t	hci_handle;
+	uint8_t		dev_class[3];
+};
+
+#define L2CAP_LM	0x03
+#define L2CAP_LM_MASTER		0x0001
+#define L2CAP_LM_AUTH		0x0002
+#define L2CAP_LM_ENCRYPT	0x0004
+#define L2CAP_LM_TRUSTED	0x0008
+#define L2CAP_LM_RELIABLE	0x0010
+#define L2CAP_LM_SECURE		0x0020
+
+#define L2CAP_MODE_BASIC	0x00
+#define L2CAP_MODE_RETRANS	0x01
+#define L2CAP_MODE_FLOWCTL	0x02
+#define L2CAP_MODE_ERTM		0x03
+#define L2CAP_MODE_STREAMING	0x04
+
+/* hci.h */
+
+/* HCI device flags */
+enum {
+	HCI_UP,
+	HCI_INIT,
+	HCI_RUNNING,
+
+	HCI_PSCAN,
+	HCI_ISCAN,
+	HCI_AUTH,
+	HCI_ENCRYPT,
+	HCI_INQUIRY,
+
+	HCI_RAW,
+};
+
+#define HCIGETDEVINFO	_IOR('H', 211, int)
+
+/* Ioctl requests structures */
+struct hci_dev_stats {
+	uint32_t err_rx;
+	uint32_t err_tx;
+	uint32_t cmd_tx;
+	uint32_t evt_rx;
+	uint32_t acl_tx;
+	uint32_t acl_rx;
+	uint32_t sco_tx;
+	uint32_t sco_rx;
+	uint32_t byte_rx;
+	uint32_t byte_tx;
+};
+
+struct hci_dev_info {
+	uint16_t dev_id;
+	char     name[8];
+
+	bdaddr_t bdaddr;
+
+	uint32_t flags;
+	uint8_t  type;
+
+	uint8_t  features[8];
+
+	uint32_t pkt_type;
+	uint32_t link_policy;
+	uint32_t link_mode;
+
+	uint16_t acl_mtu;
+	uint16_t acl_pkts;
+	uint16_t sco_mtu;
+	uint16_t sco_pkts;
+
+	struct   hci_dev_stats stat;
+};
+
+int devid2ba(int dev_id, bdaddr_t *bdaddr);
+void baswap(bdaddr_t *dst, const bdaddr_t *src);
+int ba2str(const bdaddr_t *ba, char *str);
+int str2ba(const char *str, bdaddr_t *ba);
+
+#endif
-- 
1.7.0.4

