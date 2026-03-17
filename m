Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BDE387346
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 20:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773779230; cv=none; b=kfHtih86nYOMJiw6hgIcqh684rxilgNNhAC05ZqczBV/zpDFHlXzHsLOMcG8amT/4G1SOIcX7ueaRkwFrgqs7HQwSfCTpu3e8pHTQfbeuU6PwzGHv59/TGPsgtq4OblNiNuhOSM7lnbkV6H39Xydyh+1rIJNmrlKCp4yxUVmL4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773779230; c=relaxed/simple;
	bh=gh1CM9pGGVAa3MMAOf7XZsI/ooV+dJjLrr0BN3yBFoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=feByKme4hwiUSEecmb/0NWrd2G3fT0xBK5w5SHFLTHTTqrmREdx3XC/VvBVOXya37QOF9to4hZu1/0WdG8AmX74ko0fyrEPolHrM1zP3Cp8B0L5tQ94NMTAMhjhKpNOCRXXl5iWWwWAf0oNTire9agf+tvADe8ZQEFWStKmiC1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=Wf1L0yZv; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="Wf1L0yZv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773779226; x=1774384026; i=martinbts@gmx.net;
	bh=uVG3KF7xthIITbK4NXuPjT6zxExsfs4CawuYHKpQXp4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Wf1L0yZvHBiEuwAk+EwcBxWeoBnTB/cEqnyPgwWEK8bQvKxdwPFyOzWrRjWLfwzI
	 Ckz2cH0wcMjJkXylEidO4sO7Y0YyIqf6IR12ugVTI56ZwRRqcYUYvWDXBaI6PKvGP
	 TmEkW9VYQTaYmDhZqdqiS5ajbFqNCH2hJDMLJe9yRKSDRWzimLw22zORFGK2vnOkh
	 emd82nOa665orDF4QuEo1D+aH1GqiyG49e1MrZZ2Z+84YSlGVL8/T/8MCPfXz6PQi
	 rJeZ3cEpPYwZ8NhF+DdJ/Lf1KHDFUV4NMAWpEXMOT22CN4LOYZlXdRvEki+y5+8V0
	 4MGA0DM57iVKQxRqFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeU4y-1vUMiU0dvQ-00nbWu; Tue, 17
 Mar 2026 21:27:06 +0100
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net,
	luiz.dentz@gmail.com,
	vi@endrift.com,
	Martin BTS <martinbts@gmx.net>
Subject: [PATCH BlueZ v3 5/6] plugins/gatt-uhid: Add generic GATT-to-UHID bridge
Date: Tue, 17 Mar 2026 21:26:31 +0100
Message-ID: <20260317202637.158997-6-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317202637.158997-1-martinbts@gmx.net>
References: <20260317202637.158997-1-martinbts@gmx.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KRs+Vi6zZVtEuM5KkSJ2RNZnlXToLtfYkY+lI5QX7uXwk5wVraZ
 0nW1YN3x+4CURqsYoIrHB1ZG9IJRYLRLd0rD4eu2CzkWItrvSV0qLAQj4X1QDuuNNNhP9aw
 hLAW2uuC+0N8YDPOrhIXK31mlEVc+geqdZIFW4gzvBZTy1soFvAr/drZXIdHnc5MDmAW/et
 1zOR5TwwRQ7+XIgoNqyhw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MJTvPMmQ47M=;Ufd7GW0bdQcG6ZIAenwUCzWBNjN
 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
 9w

Add a reusable bridge that creates a /dev/uhid device backed by BLE
GATT characteristics. It forwards GATT notifications as HID input
reports (UHID_INPUT2) and HID output reports (UHID_OUTPUT) back as
GATT write-without-response commands.

Report format (both directions):
  byte 0:    HID report ID (0x01)
  byte 1-2:  GATT handle, little-endian
  byte 3+:   payload

The bridge has no device-specific knowledge. It subscribes to all
notify-capable GATT characteristics passed by the caller and generates
a vendor-defined HID descriptor at runtime. A kernel HID driver matched
by vendor/product ID provides all protocol handling.

Input forwarding is gated on CCCD subscription completion: the bridge
suppresses UHID_INPUT2 writes until all GATT notification registrations
are confirmed, ensuring the kernel driver's output path is fully
operational before it receives any input events.
=2D--
 plugins/gatt-uhid.c | 350 ++++++++++++++++++++++++++++++++++++++++++++
 plugins/gatt-uhid.h |  56 +++++++
 2 files changed, 406 insertions(+)
 create mode 100644 plugins/gatt-uhid.c
 create mode 100644 plugins/gatt-uhid.h

diff --git a/plugins/gatt-uhid.c b/plugins/gatt-uhid.c
new file mode 100644
index 000000000..2f81812fe
=2D-- /dev/null
+++ b/plugins/gatt-uhid.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Generic GATT-to-UHID bridge
+ *  Bridges a BLE GATT service to the kernel HID subsystem via /dev/uhid.
+ *
+ *  Report format (both directions):
+ *    byte 0:    HID report ID (0x01)
+ *    byte 1-2:  GATT handle, little-endian
+ *    byte 3+:   payload
+ *
+ *  Input:  bridge prepends [report_id][handle_lo][handle_hi] to the raw
+ *          GATT notification payload.
+ *  Output: bridge reads [report_id][handle_lo][handle_hi] from the HID
+ *          output report and writes the remaining payload to that GATT
+ *          handle via write-without-response.
+ *
+ *  The HID report descriptor uses a vendor-defined usage page with a
+ *  single input and output report, each sized for the 2-byte handle
+ *  prefix plus the maximum payload.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#include <linux/uhid.h>
+
+#include <glib.h>
+
+#include "src/log.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-client.h"
+#include "src/shared/util.h"
+
+#include "plugins/gatt-uhid.h"
+
+#define GATT_UHID_REPORT_ID	0x01
+
+/* Handle prefix overhead added to every report */
+#define GATT_UHID_HANDLE_SIZE	2
+
+/*
+ * The struct representing a GATT_UHID-Bridge.
+ */
+struct gatt_uhid {
+	struct bt_gatt_client *client;
+
+	int fd; /* /dev/uhid file descriptor */
+	guint watch_id; /* GLib I/O watch for UHID_OUTPUT */
+
+	unsigned int *notify_ids; /* registered GATT notify IDs */
+	unsigned int notify_count;
+
+	unsigned int cccd_pending; /* CCCDs not yet confirmed */
+};
+
+
+/*
+ * A prototypical HID report descriptor.
+ *
+ * One input and one output report, each sized for the 2-byte handle
+ * prefix plus the maximum payload.  The two Report Count fields
+ * (marked 0x00, 0x00) are patched at runtime.
+ */
+static const uint8_t hid_desc_template[] =3D {
+	0x06, 0x00, 0xff, /* Usage Page; Vendor Defined; no hid-generic */
+	0x09, 0x01, /* Usage; we are a vendor */
+	0xa1, 0x01, /* Collection; <hid_descriptor> */
+
+	/* Input report */
+	0x85, GATT_UHID_REPORT_ID,
+	0x09, 0x01,		/* Usage */
+	0x15, 0x00,		/* Logical Minimum (0) */
+	0x26, 0xff, 0x00,	/* Logical Maximum (255) */
+	0x75, 0x08,		/* Report Size (8) */
+	0x96, 0x00, 0x00,	/* Put max input size here! */
+	0x81, 0x02,		/* Input (Data, Variable, Absolute) */
+
+	/* Output report */
+	0x85, GATT_UHID_REPORT_ID,
+	0x09, 0x02,		/* Usage */
+	0x75, 0x08,		/* Report Size (8) */
+	0x96, 0x00, 0x00,	/* Put max output size here! */
+	0x91, 0x02,		/* Output (Data, Variable, Absolute) */
+
+	0xc0,			/* End Collection; </hid_descriptor> */
+};
+
+/* Offsets used to put device max sizes into hid_desc_template */
+#define HID_DESC_MAX_INPUT_OFFSET 19
+#define HID_DESC_MAX_OUTPUT_OFFSET 30
+
+static size_t build_hid_descriptor(uint8_t *buf, uint16_t input_size,
+							uint16_t output_size)
+{
+	uint16_t in_total =3D GATT_UHID_HANDLE_SIZE + input_size;
+	uint16_t out_total =3D GATT_UHID_HANDLE_SIZE + output_size;
+
+	memcpy(buf, hid_desc_template, sizeof(hid_desc_template));
+
+	/* little endian! */
+	buf[HID_DESC_MAX_INPUT_OFFSET] =3D in_total & 0xff;
+	buf[HID_DESC_MAX_INPUT_OFFSET + 1] =3D (in_total >> 8) & 0xff;
+
+	buf[HID_DESC_MAX_OUTPUT_OFFSET] =3D out_total & 0xff;
+	buf[HID_DESC_MAX_OUTPUT_OFFSET + 1] =3D (out_total >> 8) & 0xff;
+
+	return sizeof(hid_desc_template);
+}
+
+/* Create device using params from device specific plugin */
+static int uhid_create(const struct gatt_uhid_params *params)
+{
+	struct uhid_event ev =3D {};
+	uint8_t hid_desc[128];
+	size_t hid_desc_len;
+	int fd;
+
+	fd =3D open("/dev/uhid", O_RDWR | O_CLOEXEC);
+	if (fd < 0) {
+		error("gatt-uhid: open /dev/uhid: %s", strerror(errno));
+		return -1;
+	}
+
+	hid_desc_len =3D build_hid_descriptor(hid_desc,
+					params->input_size,
+					params->output_size);
+
+	ev.type =3D UHID_CREATE2;
+	ev.u.create2.bus =3D BUS_BLUETOOTH;
+	ev.u.create2.vendor =3D params->vendor;
+	ev.u.create2.product =3D params->product;
+	ev.u.create2.version =3D params->version;
+	ev.u.create2.country =3D 0;
+	ev.u.create2.rd_size =3D hid_desc_len;
+	strncpy((char *) ev.u.create2.name, params->name, 127);
+	memcpy(ev.u.create2.rd_data, hid_desc, hid_desc_len);
+
+	if (write(fd, &ev, sizeof(ev)) < 0) {
+		error("gatt-uhid: UHID_CREATE2: %s", strerror(errno));
+		close(fd);
+		return -1;
+	}
+
+	DBG("gatt-uhid: uhid device created (%s)", params->name);
+	return fd;
+}
+
+/*
+ * From HID to BLE device
+ *
+ * UHID_OUTPUT data from the kernel HID driver:
+ *   byte 0-1:  GATT handle, little-endian
+ *   byte 2+:   payload to write
+ */
+static gboolean uhid_output_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct gatt_uhid *bridge =3D user_data;
+	struct uhid_event ev;
+	uint16_t handle;
+	ssize_t n;
+
+	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
+		DBG("gatt-uhid: output_cb error/hup/nval cond=3D0x%x",
+								(int) cond);
+		bridge->watch_id =3D 0;
+		return FALSE;
+	}
+
+	n =3D read(bridge->fd, &ev, sizeof(ev)); /* fetch the event */
+	if (n < 0 || (size_t) n < sizeof(ev)) {
+		DBG("gatt-uhid: output_cb read returned %zd", n);
+		return TRUE;
+	}
+
+	DBG("gatt-uhid: output_cb event type=3D%u size=3D%u",
+					ev.type, ev.u.output.size);
+
+	if (ev.type !=3D UHID_OUTPUT) {
+		DBG("gatt-uhid: output_cb ignoring event type %u", ev.type);
+		return TRUE;
+	}
+
+	if (!bridge->client) {
+		DBG("gatt-uhid: output_cb no client");
+		return TRUE;
+	}
+
+	/* Need at least the 2-byte handle prefix */
+	if (ev.u.output.size < GATT_UHID_HANDLE_SIZE) {
+		DBG("gatt-uhid: output_cb too short: %u", ev.u.output.size);
+		return TRUE;
+	}
+
+	handle =3D ev.u.output.data[0] | ((uint16_t) ev.u.output.data[1] << 8);
+
+	if (!handle) {
+		DBG("gatt-uhid: output_cb handle is zero");
+		return TRUE;
+	}
+
+	bt_gatt_client_write_without_response(bridge->client,
+				handle, false,
+				ev.u.output.data + GATT_UHID_HANDLE_SIZE,
+				ev.u.output.size - GATT_UHID_HANDLE_SIZE);
+	return TRUE;
+}
+
+
+/*
+ * From BLE device to HID
+ *
+ * Input report format to kernel HID driver:
+ *   byte 0:    report ID (0x01)
+ *   byte 1-2:  GATT handle, little-endian
+ *   byte 3+:   raw notification payload
+ */
+static void notify_cb(uint16_t value_handle, const uint8_t *value,
+			uint16_t length, void *user_data)
+{
+	struct gatt_uhid *bridge =3D user_data;
+	struct uhid_event ev =3D {};
+
+	if (length =3D=3D 0 || bridge->fd < 0)
+		return;
+
+	/* Don't forward until all CCCDs are confirmed, so we don't have
+	 * to deal with **some** available handles. */
+	if (bridge->cccd_pending)
+		return;
+
+	ev.type =3D UHID_INPUT2;
+	ev.u.input2.size =3D 1 + GATT_UHID_HANDLE_SIZE + length;
+	ev.u.input2.data[0] =3D GATT_UHID_REPORT_ID;
+	ev.u.input2.data[1] =3D value_handle & 0xff;
+	ev.u.input2.data[2] =3D (value_handle >> 8) & 0xff;
+	memcpy(&ev.u.input2.data[3], value, length);
+
+	if (write(bridge->fd, &ev, sizeof(ev)) < 0)
+		error("gatt-uhid: uhid write: %s", strerror(errno));
+}
+
+/* We can react to every single subscription on_registered */
+static void notify_registered_cb(uint16_t att_ecode, void *user_data)
+{
+	struct gatt_uhid *bridge =3D user_data;
+
+	if (att_ecode) {
+		error("gatt-uhid: notify registration failed: 0x%04x",
+								att_ecode);
+	}
+
+	if (bridge->cccd_pending > 0)
+		bridge->cccd_pending--;
+
+	if (bridge->cccd_pending =3D=3D 0)
+		DBG("gatt-uhid: all %u CCCDs confirmed, forwarding input",
+						bridge->notify_count);
+}
+
+/*
+ * Public API
+ */
+
+struct gatt_uhid *gatt_uhid_new(struct bt_gatt_client *client,
+				const struct gatt_uhid_params *params)
+{
+	struct gatt_uhid *bridge;
+	GIOChannel *io;
+	unsigned int c;
+
+	if (!client || !params || !params->notify_count)
+		return NULL;
+
+	/* Create bridge */
+	bridge =3D g_new0(struct gatt_uhid, 1);
+	bridge->client =3D client;
+	bridge->notify_count =3D params->notify_count;
+	bridge->notify_ids =3D g_new0(unsigned int, params->notify_count);
+
+	bridge->fd =3D uhid_create(params); /* Create hid device */
+	if (bridge->fd < 0) {
+		g_free(bridge->notify_ids);
+		g_free(bridge);
+		return NULL;
+	}
+
+	/* Watch for UHID_OUTPUT events (commands from kernel HID driver) */
+	io =3D g_io_channel_unix_new(bridge->fd);
+	g_io_channel_set_encoding(io, NULL, NULL);
+	g_io_channel_set_buffered(io, FALSE);
+	bridge->watch_id =3D g_io_add_watch(io, G_IO_IN | G_IO_ERR | G_IO_HUP,
+							uhid_output_cb, bridge);
+	g_io_channel_unref(io);
+
+	/* Subscribe to all GATT notification handles. */
+	bridge->cccd_pending =3D params->notify_count;
+	for (c =3D 0; c < params->notify_count; c++) {
+		bridge->notify_ids[c] =3D bt_gatt_client_register_notify(
+					client,
+					params->notify_handles[c],
+					notify_registered_cb,
+					notify_cb,
+					bridge, NULL);
+		if (!bridge->notify_ids[c])
+			error("gatt-uhid: failed to register notify "
+				"for handle 0x%04x", params->notify_handles[c]);
+	}
+
+	return bridge;
+}
+
+void gatt_uhid_free(struct gatt_uhid *bridge)
+{
+	struct uhid_event ev =3D {};
+	unsigned int c;
+
+	if (!bridge)
+		return;
+
+	for (c =3D 0; c < bridge->notify_count; c++) {
+		if (bridge->notify_ids[c] && bridge->client)
+			bt_gatt_client_unregister_notify(bridge->client,
+						bridge->notify_ids[c]);
+	}
+
+	if (bridge->watch_id)
+		g_source_remove(bridge->watch_id);
+
+	if (bridge->fd >=3D 0) {
+		ev.type =3D UHID_DESTROY;
+		if (write(bridge->fd, &ev, sizeof(ev)) < 0)
+			error("gatt-uhid: UHID_DESTROY: %s", strerror(errno));
+		close(bridge->fd);
+	}
+
+	g_free(bridge->notify_ids);
+	g_free(bridge);
+}
diff --git a/plugins/gatt-uhid.h b/plugins/gatt-uhid.h
new file mode 100644
index 000000000..6b5e65f3b
=2D-- /dev/null
+++ b/plugins/gatt-uhid.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Generic GATT-to-UHID bridge
+ *  Bridges a BLE GATT service to the kernel HID subsystem via /dev/uhid.
+ *
+ *  GATT notifications are forwarded as HID input reports; ble->bluez->uh=
id
+ *  HID output reports are forwarded back as GATT writes; hid->bluez->ble
+ *
+ *  The bridge is device-agnostic =E2=80=94 all protocol knowledge lives =
in the
+ *  kernel HID driver that claims the uhid device by vendor/product ID.
+ *
+ *  This lets the kernel driver identify which characteristic produced
+ *  each input report, and target specific handles for output writes.
+ */
+
+#include <stdint.h>
+#include <stdbool.h>
+
+struct gatt_uhid;
+struct bt_gatt_client;
+
+/*
+ * Device specific plugins provide a gatt_uhid_params to
+ * configure the bridge.
+ *
+ * All GATT handles are value handles (not CCCD handles).
+ */
+struct gatt_uhid_params {
+	const char *name; /* Shown device name */
+	uint16_t vendor;  /* Vendor ID like USB VID. Use this to match */
+	uint16_t product; /* Product ID like USB PID. Use this to match */
+	uint16_t version;
+
+	uint16_t *notify_handles;  /* array of notification value handles */
+	unsigned int notify_count; /* number of entries in notify_handles */
+
+	/* Max payload sizes (excluding report ID and 2-byte handle prefix).*/
+	uint16_t input_size;  /* size of a notification from BLE */
+	uint16_t output_size; /* size of an output from HID */
+};
+
+/*
+ * Create a GATT-UHID bridge.  Opens /dev/uhid, creates the device,
+ * and subscribes to the specified GATT notification handles.
+ * Returns NULL on failure.
+ */
+struct gatt_uhid *gatt_uhid_new(struct bt_gatt_client *client,
+				const struct gatt_uhid_params *params);
+
+/*
+ * Destroy the bridge =E2=80=94 unsubscribes GATT notifications, sends
+ * UHID_DESTROY, and frees resources.
+ */
+void gatt_uhid_free(struct gatt_uhid *bridge);
=2D-=20
2.47.3

