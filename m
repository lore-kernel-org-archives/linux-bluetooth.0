Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F36E334C1C
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Mar 2026 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772378984; cv=none; b=HAkfixsorxq9W2vadx8lARTRmzKgraTea3s9iRdDgmqFR/2kuFx6fT2nj2xZb33mwv/4RKTxYxWODVGHfGGGXMG+dvBPEtUoyrKE3/cbXfX82se1IpGAUXneDNDJFUZ5ljPRF67SnGllk4dO3wC0tsz/TNzBk0CQtai1PMGNBB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772378984; c=relaxed/simple;
	bh=OdijiEzr5Fq04lnfKxvxr7o68v7M2Webq8jf1n13Mj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KlvEw8gy1Potb2aH8q83TnfZBoWZxZB6vmOxeCNJtbyYCpuAgVcO7Nr9G1CoSq+JQPcFNkKrQyy5jM81ybj7EqIgCeD82J/TWM3oKmKTajsIX+84tgrFnc0h3vea9zobXb474n+H5ueRMCgHJPDA42YmOCTLLjzjlK4X7h03ZR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=HRcx9ukX; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="HRcx9ukX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1772378979; x=1772983779; i=martinbts@gmx.net;
	bh=ISH6Q+BNTdKKWxxjg/HHIlKH92fFGT/NSPVfBH5fI9c=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HRcx9ukXQgOOvJjWyesiUStjZ2GylGkXzs6h7ZN49zNGeatW3fPTZ3Ougo5apdch
	 vTM/4VteRxFe3w3j6QTLAOxujE2bJTLFXuKERXr3tdwTVQ1bUjb07h3ZrKK/4clEv
	 xUCLSkohHrOqorPjWuMqYL9PwSmQXqZax87gOQsp7BBHYxcIGeqVSr5LJmR+BeSO3
	 NXsiooB2eJ+qS+HRwuis5aW/vQihi82cZmNCwZc4w19Ft/6WL+DPZ76trevYXVPB/
	 2kg5+OrWLLcsRd0UWwpvP2RBHrF5NZJCdqApq9AqhU0gYdNk68a4orcAH1LuNgb9U
	 q4Rf2PYQJ0Z60r8YQQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXp5Q-1wAxna3r36-00Juh5; Sun, 01
 Mar 2026 16:29:39 +0100
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: Martin BTS <martinbts@gmx.net>
Subject: [PATCH BlueZ 5/5] plugins/switch2: Add Nintendo Switch 2 Controller plugin
Date: Sun,  1 Mar 2026 16:29:30 +0100
Message-ID: <20260301152930.221472-6-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260301152930.221472-1-martinbts@gmx.net>
References: <20260301152930.221472-1-martinbts@gmx.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4m704ox9zgskhl3WS659aloTTN/uodkrlBpZMEvZGlQxqIB6eSJ
 AiD8rfIimTHMXaEMEHUzEfcljRe/0uioeKxkjMFn/YbjIVLljqgxXHW9nuL9NpBUt+dr53T
 PXnlDPpN04g9gNp+PY6tafhs8kg3hJ6IErzo/bCts/w8rfr5ajotwBEEPCP+r5N3aRFifI2
 r0l6R4nBgKSliALpu360A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/3JE9BCog08=;YfAOVqvVTKDrYB3DhtNLe1mB992
 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

Add a BLE plugin for the Nintendo Switch 2 controllers.

Currently this is only developed, tried and tested with the Nintendo
Switch 2 Pro Controller (ProCon2).

The controller uses a vendor-specific GATT service for all HID
communication.  The plugin discovers the service, binds its
characteristics, and runs an ACK-driven initialization state machine
that sends 13 configuration commands one at a time (each waiting for
the controller's ACK notification before proceeding).

The controller requires BT_SECURITY_LOW =E2=80=94 any SMP pairing attempt
causes it to respond with "Pairing Not Supported" and drop the link.

After initialization completes, input notifications are forwarded to
userspace via a uhid device that presents a standard gamepad HID
report descriptor.  A back channel allows the host to send commands
back to the controller (e.g. rumble, LED control).
=2D--
 Makefile.plugins  |    3 +
 plugins/switch2.c | 1069 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 1072 insertions(+)
 create mode 100644 plugins/switch2.c

diff --git a/Makefile.plugins b/Makefile.plugins
index c9efadb45..4882d6808 100644
=2D-- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+builtin_modules +=3D switch2
+builtin_sources +=3D plugins/switch2.c
+
 builtin_modules +=3D hostname
 builtin_sources +=3D plugins/hostname.c
=20
diff --git a/plugins/switch2.c b/plugins/switch2.c
new file mode 100644
index 000000000..ba7fbf63e
=2D-- /dev/null
+++ b/plugins/switch2.c
@@ -0,0 +1,1069 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Nintendo Switch 2 controller BLE plugin
+ *
+ *  Handles the proprietary 0x91 GATT protocol used by Nintendo Switch 2
+ *  controllers (Pro Controller 2, Joy-Con 2 L/R) over BLE.  The GATT
+ *  service UUID is shared by all three variants; the init sequence, HID
+ *  descriptor, and input handling are currently ProCon2-only.  JoyCon
+ *  connections are accepted but not initialised (no uhid device is
+ *  created).
+ *
+ *  Protocol references:
+ *    - joycon2cpp (TheFrano) =E2=80=94 minimal Windows BLE implementatio=
n
+ *    - hid-switch2-dkms (Senko-p / Valve / Vicki Pfau) =E2=80=94 NS2_REP=
ORT_PRO format
+ *    - ble_test.py =E2=80=94 working Linux BLE proof of concept (this pr=
oject)
+ *
+ *  GATT service: ab7de9be-89fe-49ad-828f-118f09df7fd0  (handles 0x0008=
=E2=80=930x002a)
+ *
+ *  Key characteristic roles (confirmed by LED test and input capture):
+ *    Command  0x0014  649d4ac9-8eb7-4e6c-af44-1ea54fe5f005  write-no-res=
p
+ *    ACK      0x001a  c765a961-????-????-????-????????????  notify
+ *    Input    0x000e  7492866c-ec3e-4619-8258-32755ffcc0f8  notify  (63 =
bytes @ ~80Hz)
+ *
+ *  The ACK characteristic UUID (c765a961-...) was not fully captured; it=
 is
+ *  identified at runtime as the first notify-only characteristic followi=
ng the
+ *  command characteristic in the service attribute list.
+ *
+ *  Init sequence ordering (critical):
+ *    1. Subscribe ACK CCCD (0x001b)
+ *    2. Send all 13 init commands to 0x0014
+ *    3. Subscribe input CCCDs (0x000f, 0x000b, 0x001f, 0x0023, 0x0027)
+ *    If input CCCDs are enabled before init, the ~80 report/sec notifica=
tion
+ *    flood drowns the ACK responses and init commands are silently dropp=
ed.
+ *
+ *  MTU: BlueZ's bt_gatt_client negotiates MTU during connection setup.
+ *  Input reports are 63 bytes; default ATT MTU (23) is insufficient.
+ *  Verified MTU 512 works (controller offers 512).
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
+#include "bluetooth/bluetooth.h"
+#include "bluetooth/uuid.h"
+
+#include "src/adapter.h"
+#include "src/device.h"
+#include "src/profile.h"
+#include "src/service.h"
+#include "src/plugin.h"
+#include "src/log.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-client.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/queue.h"
+#include "src/shared/util.h"
+
+/* ------------------------------------------------------------------ */
+/* UUIDs                                                                *=
/
+/* ------------------------------------------------------------------ */
+
+/* Proprietary service 2 =E2=80=94 handles 0x0008=E2=80=930x002a */
+#define SWITCH2_SERVICE_UUID \
+	"ab7de9be-89fe-49ad-828f-118f09df7fd0"
+
+/* Command channel =E2=80=94 write-no-response, handle 0x0014 */
+#define SWITCH2_CMD_UUID \
+	"649d4ac9-8eb7-4e6c-af44-1ea54fe5f005"
+
+/* Primary input channel =E2=80=94 notify, handle 0x000e, 63-byte reports=
 @ ~80Hz
+ * (macOS project uses ...f9 =E2=80=94 one-byte variant, likely a firmwar=
e difference) */
+#define SWITCH2_INPUT_UUID \
+	"7492866c-ec3e-4619-8258-32755ffcc0f8"
+
+/* ACK channel UUID (c765a961-...) is not fully documented; discovered at
+ * runtime =E2=80=94 see find_chars_in_service(). */
+
+/* ------------------------------------------------------------------ */
+/* Product IDs (from hid-switch2's hid-ids.h)                          */
+/* ------------------------------------------------------------------ */
+
+#define NS2_VID            0x057e
+#define NS2_PID_JOYCON_R   0x2066
+#define NS2_PID_JOYCON_L   0x2067
+#define NS2_PID_PROCON     0x2069
+
+enum switch2_ctlr_type {
+	NS2_CTLR_TYPE_JOYCON_L,
+	NS2_CTLR_TYPE_JOYCON_R,
+	NS2_CTLR_TYPE_PROCON,
+};
+
+struct switch2_ctlr_info {
+	uint16_t                pid;
+	enum switch2_ctlr_type  type;
+	const char             *alias;
+};
+
+static const struct switch2_ctlr_info ctlr_table[] =3D {
+	{ NS2_PID_PROCON,   NS2_CTLR_TYPE_PROCON,   "Nintendo Pro Controller 2" =
},
+	{ NS2_PID_JOYCON_L, NS2_CTLR_TYPE_JOYCON_L, "Nintendo Joy-Con 2 (L)" },
+	{ NS2_PID_JOYCON_R, NS2_CTLR_TYPE_JOYCON_R, "Nintendo Joy-Con 2 (R)" },
+};
+
+/* ------------------------------------------------------------------ */
+/* HID report descriptor for the uhid device                           */
+/* ------------------------------------------------------------------ */
+/*
+ * Describes NS2_REPORT_PRO (ID=3D0x09).  hid-core.c calls raw_event() wi=
th
+ * the original buffer including the report-ID byte, so raw_data[0]=3D0x0=
9.
+ * The 63-byte payload (report-ID excluded) maps to raw_data[1..] as
+ * expected by hid-switch2's switch2_event():
+ *
+ *   raw_data[0]     0x09 (report ID =E2=80=94 present in raw_event buffe=
r)
+ *   raw_data[1-2]   seq, status(0x20)  =E2=80=94 vendor, not parsed
+ *   raw_data[3]     btnsR  B A Y X R ZR + RS       =E2=80=94 8 buttons
+ *   raw_data[4]     btnsL  Dn Rt Lt Up L ZL - LS   =E2=80=94 8 buttons
+ *   raw_data[5]     btns3  Home Cap GripR GripL Camera + 3-bit pad =E2=
=80=94 5 buttons
+ *   raw_data[6-8]   left stick  (2=C3=9712-bit, Switch packing)
+ *   raw_data[9-11]  right stick (2=C3=9712-bit, Switch packing)
+ *   raw_data[12-63] IMU + constants (52 bytes, not parsed by HID)
+ *
+ * Bit count: 2=C3=978 + 8 + 8 + 5+3 + 2=C3=9712 + 2=C3=9712 + 52=C3=978 =
=3D 504 bits =3D 63 bytes =E2=9C=93
+ *
+ * The BLE report is 63 bytes with no report ID.  The plugin prepends rep=
ort
+ * ID 0x09 =E2=86=92 64 bytes total for uhid.
+ */
+static const uint8_t switch2_hid_desc[] =3D {
+	0x05, 0x01,              /* Usage Page (Generic Desktop)        */
+	0x09, 0x05,              /* Usage (Gamepad)                     */
+	0xa1, 0x01,              /* Collection (Application)            */
+	0x85, 0x09,              /*   Report ID (9)  =E2=80=94 NS2_REPORT_PRO  *=
/
+
+	/* raw_data[1-2]: seq, status =E2=80=94 2 bytes vendor constant (no pad)=
 */
+	0x06, 0x00, 0xff,        /*   Usage Page (Vendor Defined)       */
+	0x09, 0x20,              /*   Usage (0x20)                      */
+	0x15, 0x00,              /*   Logical Minimum (0)               */
+	0x26, 0xff, 0x00,        /*   Logical Maximum (255)             */
+	0x75, 0x08,              /*   Report Size (8)                   */
+	0x95, 0x02,              /*   Report Count (2)                  */
+	0x81, 0x03,              /*   Input (Const, Variable, Absolute) */
+
+	/* raw_data[3]: btnsR =E2=80=94 B(0) A(1) Y(2) X(3) R(4) ZR(5) +(6) RS(7=
) */
+	0x05, 0x09,              /*   Usage Page (Button)               */
+	0x19, 0x01,              /*   Usage Minimum (1)                 */
+	0x29, 0x08,              /*   Usage Maximum (8)                 */
+	0x15, 0x00,              /*   Logical Minimum (0)               */
+	0x25, 0x01,              /*   Logical Maximum (1)               */
+	0x75, 0x01,              /*   Report Size (1)                   */
+	0x95, 0x08,              /*   Report Count (8)                  */
+	0x81, 0x02,              /*   Input (Data, Variable, Absolute)  */
+
+	/* raw_data[4]: btnsL =E2=80=94 Dn(0) Rt(1) Lt(2) Up(3) L(4) ZL(5) -(6) =
LS(7) */
+	0x19, 0x09,              /*   Usage Minimum (9)                 */
+	0x29, 0x10,              /*   Usage Maximum (16)                */
+	0x75, 0x01,              /*   Report Size (1)                   */
+	0x95, 0x08,              /*   Report Count (8)                  */
+	0x81, 0x02,              /*   Input (Data, Variable, Absolute)  */
+
+	/* raw_data[5]: btns3 =E2=80=94 Home(0) Cap(1) GripR(2) GripL(3) Camera(=
4) + 3-bit pad */
+	0x19, 0x11,              /*   Usage Minimum (17)                */
+	0x29, 0x15,              /*   Usage Maximum (21)                */
+	0x75, 0x01,              /*   Report Size (1)                   */
+	0x95, 0x05,              /*   Report Count (5)                  */
+	0x81, 0x02,              /*   Input (Data, Variable, Absolute)  */
+	0x95, 0x03,              /*   Report Count (3) =E2=80=94 padding        =
*/
+	0x81, 0x03,              /*   Input (Const, Variable, Absolute) */
+
+	/* raw_data[6-8]: left stick =E2=80=94 X then Y, each 12-bit LE */
+	0x05, 0x01,              /*   Usage Page (Generic Desktop)      */
+	0x09, 0x30,              /*   Usage (X)                         */
+	0x09, 0x31,              /*   Usage (Y)                         */
+	0x15, 0x00,              /*   Logical Minimum (0)               */
+	0x26, 0xff, 0x0f,        /*   Logical Maximum (4095)            */
+	0x75, 0x0c,              /*   Report Size (12)                  */
+	0x95, 0x02,              /*   Report Count (2)                  */
+	0x81, 0x02,              /*   Input (Data, Variable, Absolute)  */
+
+	/* raw_data[9-11]: right stick =E2=80=94 Rx then Ry, each 12-bit LE */
+	0x09, 0x33,              /*   Usage (Rx)                        */
+	0x09, 0x34,              /*   Usage (Ry)                        */
+	0x75, 0x0c,              /*   Report Size (12)                  */
+	0x95, 0x02,              /*   Report Count (2)                  */
+	0x81, 0x02,              /*   Input (Data, Variable, Absolute)  */
+
+	/* raw_data[12-63]: IMU + constants =E2=80=94 52 bytes, not parsed by HI=
D */
+	0x06, 0x00, 0xff,        /*   Usage Page (Vendor Defined)       */
+	0x09, 0x21,              /*   Usage (0x21)                      */
+	0x15, 0x00,              /*   Logical Minimum (0)               */
+	0x26, 0xff, 0x00,        /*   Logical Maximum (255)             */
+	0x75, 0x08,              /*   Report Size (8)                   */
+	0x95, 0x34,              /*   Report Count (52)                 */
+	0x81, 0x03,              /*   Input (Const, Variable, Absolute) */
+
+	/*
+	 * Output report =E2=80=94 used by hid-switch2's BLE transport path.
+	 * switch2-ble.c calls hid_hw_output_report() with a pre-formatted
+	 * 0x91 frame (command or haptic); the kernel uhid driver delivers
+	 * it here as a UHID_OUTPUT event, which uhid_output_cb() picks up
+	 * and forwards to GATT 0x0014.
+	 * hid-generic has no output handler and ignores this report.
+	 */
+	0x85, 0x01,              /*   Report ID (1)                     */
+	0x06, 0x00, 0xff,        /*   Usage Page (Vendor Defined)       */
+	0x09, 0x23,              /*   Usage (0x23)                      */
+	0x75, 0x08,              /*   Report Size (8)                   */
+	0x95, 0x40,              /*   Report Count (64)                 */
+	0x91, 0x02,              /*   Output (Data, Variable, Absolute) */
+
+	0xc0,                    /* End Collection                      */
+};
+
+/* ------------------------------------------------------------------ */
+/* Stick calibration types                                             */
+/* ------------------------------------------------------------------ */
+
+struct stick_axis_calib {
+	uint16_t neutral;
+	uint16_t positive;   /* excursion from neutral toward max */
+	uint16_t negative;   /* excursion from neutral toward min */
+};
+
+struct stick_calib {
+	struct stick_axis_calib x;
+	struct stick_axis_calib y;
+};
+
+/* ------------------------------------------------------------------ */
+/* Init command byte arrays                                             *=
/
+/* Header format: [CMD][0x91][TRANSPORT=3D0x01 BT][SUBCMD][0x00]        *=
/
+/*                [PAYLOAD_LEN][0x00][0x00][...PAYLOAD]                */
+/* ------------------------------------------------------------------ */
+
+/* 1. INIT =E2=80=94 starts HID output (analogous to Switch1 SET_REPORT_M=
ODE) */
+static const uint8_t CMD_INIT[] =3D {
+	0x03, 0x91, 0x01, 0x0d, 0x00, 0x08, 0x00, 0x00,
+	0x01, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
+};
+/* 2. Unknown 0x07/0x01 */
+static const uint8_t CMD_07[] =3D {
+	0x07, 0x91, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00
+};
+/* 3. Unknown 0x16/0x01 */
+static const uint8_t CMD_16[] =3D {
+	0x16, 0x91, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00
+};
+/* 4. Unknown 0x15/0x03 */
+static const uint8_t CMD_15_03[] =3D {
+	0x15, 0x91, 0x01, 0x03, 0x00, 0x01, 0x00, 0x00, 0x00
+};
+/* 5. FEATSEL SET_MASK =E2=80=94 0x2F =3D buttons|analog|imu|bit3|rumble =
*/
+static const uint8_t CMD_FEATSEL_SET_MASK[] =3D {
+	0x0c, 0x91, 0x01, 0x02, 0x00, 0x04, 0x00, 0x00,
+	0x2f, 0x00, 0x00, 0x00
+};
+/* 6. Device info request 0x11/0x03 */
+static const uint8_t CMD_11[] =3D {
+	0x11, 0x91, 0x01, 0x03, 0x00, 0x00, 0x00, 0x00
+};
+/* 7. VIBRATE config 0x0A/0x08 */
+static const uint8_t CMD_VIBRATE_CFG[] =3D {
+	0x0a, 0x91, 0x01, 0x08, 0x00, 0x14, 0x00, 0x00,
+	0x01,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0x35, 0x00, 0x46,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+/* 8. FEATSEL ENABLE =E2=80=94 0x2F */
+static const uint8_t CMD_FEATSEL_ENABLE[] =3D {
+	0x0c, 0x91, 0x01, 0x04, 0x00, 0x04, 0x00, 0x00,
+	0x2f, 0x00, 0x00, 0x00
+};
+/* 9. SELECT_REPORT =E2=80=94 0x09 =3D NS2_REPORT_PRO (full sticks + IMU =
+ buttons) */
+static const uint8_t CMD_SELECT_REPORT[] =3D {
+	0x03, 0x91, 0x01, 0x0a, 0x00, 0x04, 0x00, 0x00,
+	0x09, 0x00, 0x00, 0x00
+};
+/* 10. FW_INFO_GET */
+static const uint8_t CMD_FW_INFO_GET[] =3D {
+	0x10, 0x91, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00
+};
+/* 11. Unknown 0x01/0x0C */
+static const uint8_t CMD_01_0C[] =3D {
+	0x01, 0x91, 0x01, 0x0c, 0x00, 0x00, 0x00, 0x00
+};
+/* 12. SET_PLAYER_LED =E2=80=94 player 1 (LED value 0x01) */
+static const uint8_t CMD_SET_PLAYER_LED[] =3D {
+	0x09, 0x91, 0x01, 0x07, 0x00, 0x08, 0x00, 0x00,
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+/*
+ * 14-15. Factory stick calibration SPI reads.
+ * Command: NS2_CMD_FLASH(0x02) / NS2_SUBCMD_FLASH_READ(0x04)
+ * Payload: [size=3D9][0x7e][0x00][0x00][addr_le32]
+ * ACK data at value[16..24]: 9 bytes of packed 12-bit calibration values=
.
+ * Addresses from hid-switch2's NS2_FLASH_ADDR_FACTORY_*_CALIB defines.
+ */
+/* Factory primary calibration =E2=80=94 left stick @ 0x000130a8, 9 bytes=
 */
+static const uint8_t CMD_CALIB_LEFT[] =3D {
+	0x02, 0x91, 0x01, 0x04, 0x00, 0x08, 0x00, 0x00,
+	0x09, 0x7e, 0x00, 0x00, 0xa8, 0x30, 0x01, 0x00
+};
+/* Factory secondary calibration =E2=80=94 right stick @ 0x000130e8, 9 by=
tes */
+static const uint8_t CMD_CALIB_RIGHT[] =3D {
+	0x02, 0x91, 0x01, 0x04, 0x00, 0x08, 0x00, 0x00,
+	0x09, 0x7e, 0x00, 0x00, 0xe8, 0x30, 0x01, 0x00
+};
+
+struct init_cmd {
+	const char    *name;
+	const uint8_t *data;
+	uint16_t       len;
+};
+
+#define INIT_CMD(name, arr) { name, arr, sizeof(arr) }
+
+static const struct init_cmd init_sequence[] =3D {
+	INIT_CMD("INIT",             CMD_INIT),           /* [0]  */
+	INIT_CMD("CMD_07",           CMD_07),             /* [1]  */
+	INIT_CMD("CMD_16",           CMD_16),             /* [2]  */
+	INIT_CMD("CMD_15_03",        CMD_15_03),          /* [3]  */
+	INIT_CMD("FEATSEL_SET_MASK", CMD_FEATSEL_SET_MASK), /* [4] */
+	INIT_CMD("CMD_11",           CMD_11),             /* [5]  */
+	INIT_CMD("VIBRATE_CFG",      CMD_VIBRATE_CFG),   /* [6]  */
+	INIT_CMD("FEATSEL_ENABLE",   CMD_FEATSEL_ENABLE), /* [7]  */
+	INIT_CMD("SELECT_REPORT",    CMD_SELECT_REPORT), /* [8]  */
+	INIT_CMD("FW_INFO_GET",      CMD_FW_INFO_GET),   /* [9]  */
+	INIT_CMD("CMD_01_0C",        CMD_01_0C),          /* [10] */
+	INIT_CMD("SET_PLAYER_LED",   CMD_SET_PLAYER_LED), /* [11] */
+	INIT_CMD("CALIB_LEFT",       CMD_CALIB_LEFT),    /* [12] */
+	INIT_CMD("CALIB_RIGHT",      CMD_CALIB_RIGHT),   /* [13] */
+};
+
+/* Input CCCDs enabled AFTER init (value handles, not CCCD handles) */
+static const uint16_t post_init_notify_handles[] =3D {
+	0x000e,  /* primary input (NS2_REPORT_PRO, 63 bytes) */
+	0x000a,  /* secondary input (joycon2cpp-style) */
+	0x001e,  /* unknown notify */
+	0x0022,  /* unknown notify */
+	0x0026,  /* unknown notify */
+};
+
+/* ------------------------------------------------------------------ */
+/* Per-connection state                                                 *=
/
+/* ------------------------------------------------------------------ */
+
+struct switch2_device {
+	struct btd_device    *device;
+	struct btd_service   *service;   /* stored for async connecting_complete=
 */
+	struct bt_gatt_client *client;
+
+	uint16_t  cmd_handle;    /* write-no-resp target  */
+	uint16_t  ack_handle;    /* first notify-only char after cmd */
+	uint16_t  input_handle;  /* primary 63-byte input char */
+
+	unsigned int  ack_notify_id;
+	unsigned int  input_notify_ids[G_N_ELEMENTS(post_init_notify_handles)];
+
+	/* Init state machine: send one command at a time, wait for ACK between =
*/
+	unsigned int  init_idx;   /* index of command most recently sent */
+	bool          init_done;  /* true after all init commands have been ACK'=
d */
+
+	/* uhid device =E2=80=94 kernel HID subsystem sees the controller as a g=
amepad */
+	int           uhid_fd;
+	guint         uhid_watch_id;   /* GLib I/O watch for UHID_OUTPUT events =
*/
+
+	/* Factory stick calibration, read from SPI flash during init */
+	struct stick_calib  stick_calib[2];  /* [0]=3Dleft, [1]=3Dright */
+	bool                calib_valid;
+
+	/* Controller variant */
+	enum switch2_ctlr_type          ctlr_type;
+	const struct switch2_ctlr_info *info;
+};
+
+static struct queue *devices =3D NULL;
+
+/* ------------------------------------------------------------------ */
+/* GATT database walk =E2=80=94 find our three characteristics           =
       */
+/* ------------------------------------------------------------------ */
+
+struct char_walk_state {
+	bt_uuid_t  cmd_uuid;
+	bt_uuid_t  input_uuid;
+
+	uint16_t   cmd_handle;
+	uint16_t   ack_handle;   /* first notify-only char seen after cmd */
+	uint16_t   input_handle;
+
+	bool       past_cmd;     /* have we passed the cmd characteristic? */
+};
+
+static void inspect_characteristic(struct gatt_db_attribute *attr,
+							void *user_data)
+{
+	struct char_walk_state *state =3D user_data;
+	uint16_t handle, value_handle;
+	uint8_t properties;
+	bt_uuid_t uuid;
+
+	if (!gatt_db_attribute_get_char_data(attr, &handle, &value_handle,
+						&properties, NULL, &uuid))
+		return;
+
+	/* Command channel: match by UUID */
+	if (bt_uuid_cmp(&uuid, &state->cmd_uuid) =3D=3D 0) {
+		state->cmd_handle =3D value_handle;
+		state->past_cmd   =3D true;
+		return;
+	}
+
+	/* Input channel: match by UUID */
+	if (bt_uuid_cmp(&uuid, &state->input_uuid) =3D=3D 0) {
+		state->input_handle =3D value_handle;
+		return;
+	}
+
+	/* ACK channel: first Notify-only char after the command channel.
+	 * The full UUID (c765a961-...) was not captured; this is the only
+	 * Notify-only characteristic in the service after handle 0x0014. */
+	if (state->past_cmd && !state->ack_handle) {
+		/* Notify bit set, Read bit clear =E2=80=94 pure notify, not read+notif=
y */
+		if ((properties & 0x10) && !(properties & 0x02))
+			state->ack_handle =3D value_handle;
+	}
+}
+
+static void find_chars_in_service(struct gatt_db_attribute *service,
+							void *user_data)
+{
+	gatt_db_service_foreach_char(service, inspect_characteristic, user_data)=
;
+}
+
+/* ------------------------------------------------------------------ */
+/* uhid device                                                          *=
/
+/* ------------------------------------------------------------------ */
+
+static int uhid_create(const struct switch2_ctlr_info *ctlr)
+{
+	struct uhid_event ev =3D {};
+	int fd;
+
+	fd =3D open("/dev/uhid", O_RDWR | O_CLOEXEC);
+	if (fd < 0) {
+		error("switch2: open /dev/uhid: %s", strerror(errno));
+		return -1;
+	}
+
+	ev.type =3D UHID_CREATE2;
+	strncpy((char *)ev.u.create2.name, ctlr->alias, 127);
+	ev.u.create2.bus     =3D BUS_BLUETOOTH;
+	ev.u.create2.vendor  =3D NS2_VID;
+	ev.u.create2.product =3D ctlr->pid;
+	ev.u.create2.version =3D 0x0001;
+	ev.u.create2.country =3D 0;
+	ev.u.create2.rd_size =3D sizeof(switch2_hid_desc);
+	memcpy(ev.u.create2.rd_data, switch2_hid_desc,
+					sizeof(switch2_hid_desc));
+
+	if (write(fd, &ev, sizeof(ev)) < 0) {
+		error("switch2: UHID_CREATE2: %s", strerror(errno));
+		close(fd);
+		return -1;
+	}
+
+	info("switch2: uhid device created");
+	return fd;
+}
+
+/* ------------------------------------------------------------------ */
+/* Stick calibration helpers                                            *=
/
+/* ------------------------------------------------------------------ */
+
+/*
+ * Parse 9 bytes of factory stick calibration data into a stick_calib.
+ * Layout: 6 =C3=97 12-bit LE values packed into 9 bytes:
+ *   [0-2]  x.neutral (12-bit), y.neutral (12-bit)
+ *   [3-5]  x.positive (12-bit), y.positive (12-bit)
+ *   [6-8]  x.negative (12-bit), y.negative (12-bit)
+ * Matches hid-switch2's switch2_parse_stick_calibration().
+ * Returns false if the data is all-0xFF (uncalibrated flash).
+ */
+static bool parse_stick_calib(struct stick_calib *out, const uint8_t *dat=
a)
+{
+	static const uint8_t uncal[9] =3D {
+		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
+	};
+	if (memcmp(data, uncal, 9) =3D=3D 0)
+		return false;
+
+	out->x.neutral  =3D data[0] | ((data[1] & 0x0f) << 8);
+	out->y.neutral  =3D (data[1] >> 4) | (data[2] << 4);
+	out->x.positive =3D data[3] | ((data[4] & 0x0f) << 8);
+	out->y.positive =3D (data[4] >> 4) | (data[5] << 4);
+	out->x.negative =3D data[6] | ((data[7] & 0x0f) << 8);
+	out->y.negative =3D (data[7] >> 4) | (data[8] << 4);
+
+	/* Guard against zero excursion (avoid divide-by-zero) */
+	if (!out->x.positive) out->x.positive =3D 1;
+	if (!out->x.negative) out->x.negative =3D 1;
+	if (!out->y.positive) out->y.positive =3D 1;
+	if (!out->y.negative) out->y.negative =3D 1;
+
+	return out->x.neutral !=3D 0;
+}
+
+/*
+ * Apply axis calibration: map a raw 12-bit value to a normalized 12-bit
+ * value centred at 2048 with symmetric excursion =C2=B12047.  When sent =
to
+ * hid-switch2's BLE path (zero calib =E2=86=92 fallback), the formula
+ * (value =E2=88=92 2048) =C3=97 16 produces the correct =C2=B132752 outp=
ut range.
+ */
+static uint16_t apply_axis_calib(const struct stick_axis_calib *c,
+				  uint16_t raw)
+{
+	int delta     =3D (int)raw - (int)c->neutral;
+	int excursion =3D delta > 0 ? (int)c->positive : (int)c->negative;
+	int norm      =3D delta * 2047 / excursion;
+
+	if (norm < -2047) norm =3D -2047;
+	if (norm >  2047) norm =3D  2047;
+	return (uint16_t)(2048 + norm);
+}
+
+/*
+ * Pack two 12-bit stick axis values (x, y) back into the Switch 3-byte
+ * little-endian format used in HID reports.
+ */
+static void pack_stick(uint8_t *dst, uint16_t x, uint16_t y)
+{
+	dst[0] =3D  x & 0xff;
+	dst[1] =3D ((x >> 8) & 0x0f) | ((y & 0x0f) << 4);
+	dst[2] =3D  (y >> 4) & 0xff;
+}
+
+/* ------------------------------------------------------------------ */
+/* uhid output callback =E2=80=94 forwards UHID_OUTPUT to GATT 0x0014    =
      */
+/* ------------------------------------------------------------------ */
+
+/*
+ * Called by GLib whenever the uhid fd becomes readable.  hid-switch2's
+ * BLE transport (switch2-ble.c) calls hid_hw_output_report() to send
+ * pre-formatted 0x91 frames; the kernel uhid driver queues them as
+ * UHID_OUTPUT events that we read here and write to GATT 0x0014.
+ */
+static gboolean uhid_output_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct switch2_device *dev =3D user_data;
+	struct uhid_event ev;
+	ssize_t n;
+
+	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
+		dev->uhid_watch_id =3D 0;
+		return FALSE;
+	}
+
+	n =3D read(dev->uhid_fd, &ev, sizeof(ev));
+	if (n < 0 || (size_t)n < sizeof(ev))
+		return TRUE;
+
+	if (ev.type !=3D UHID_OUTPUT)
+		return TRUE;
+
+	if (!dev->client || !dev->cmd_handle || !dev->init_done)
+		return TRUE;
+
+	bt_gatt_client_write_without_response(dev->client,
+					dev->cmd_handle, false,
+					ev.u.output.data, ev.u.output.size);
+	return TRUE;
+}
+
+/* ------------------------------------------------------------------ */
+/* Notification callbacks                                               *=
/
+/* ------------------------------------------------------------------ */
+
+/* Forward declarations needed by ack_notify_cb */
+static void input_registered_cb(uint16_t att_ecode, void *user_data);
+static void input_notify_cb(uint16_t value_handle, const uint8_t *value,
+			uint16_t length, void *user_data);
+
+static void ack_registered_cb(uint16_t att_ecode, void *user_data)
+{
+	struct switch2_device *dev =3D user_data;
+	const struct init_cmd *cmd;
+
+	if (att_ecode) {
+		error("switch2: ACK notify registration failed: 0x%04x",
+								att_ecode);
+		btd_service_connecting_complete(dev->service, -EIO);
+		return;
+	}
+
+	/* JoyCon variants share the GATT service but the init sequence and
+	 * HID descriptor are ProCon2-specific.  Accept the connection
+	 * without starting init or creating a uhid device. */
+	if (dev->ctlr_type !=3D NS2_CTLR_TYPE_PROCON) {
+		info("switch2: %s connected (no init sequence for this type)",
+						dev->info->alias);
+		btd_service_connecting_complete(dev->service, 0);
+		return;
+	}
+
+	DBG("switch2: ACK notify registered, starting init sequence");
+
+	/* Send first init command; the rest are sent one-by-one from
+	 * ack_notify_cb as each ACK notification is received. */
+	cmd =3D &init_sequence[0];
+	if (!bt_gatt_client_write_without_response(dev->client,
+				dev->cmd_handle, false, cmd->data, cmd->len)) {
+		error("switch2: failed to send %s", cmd->name);
+		btd_service_connecting_complete(dev->service, -EIO);
+		return;
+	}
+	DBG("switch2: sent %s (1/%zu)", cmd->name,
+					G_N_ELEMENTS(init_sequence));
+}
+
+static void ack_notify_cb(uint16_t value_handle, const uint8_t *value,
+				uint16_t length, void *user_data)
+{
+	struct switch2_device *dev =3D user_data;
+	const struct init_cmd *cmd;
+	unsigned int i;
+
+	/* ACK format: [CMD][STATUS: 01=3Dok 00=3Dfail][00][ARG][10][78][00][00]=
[data...] */
+	if (length < 2)
+		return;
+
+	DBG("switch2: ACK cmd=3D0x%02x status=3D%s", value[0],
+					value[1] =3D=3D 0x01 ? "ok" : "FAIL");
+
+	/* After init is done, ACK notifications are from normal operations. */
+	if (dev->init_done)
+		return;
+
+	/*
+	 * Parse calibration data from SPI flash read ACKs.
+	 * The calibration commands are the last two in init_sequence ([13] and
+	 * [14]).  dev->init_idx is the index of the command just ACK'd.
+	 * Flash read ACK payload layout (after the 8-byte ACK header):
+	 *   value[8]     read_size (9)
+	 *   value[9]     0x7e
+	 *   value[10-11] padding
+	 *   value[12-15] address LE32 (echoed)
+	 *   value[16-24] 9 bytes of calibration data
+	 */
+	if (value[0] =3D=3D 0x02 && value[1] =3D=3D 0x01 && length >=3D 25) {
+		unsigned int calib_left_idx  =3D G_N_ELEMENTS(init_sequence) - 2;
+		unsigned int calib_right_idx =3D G_N_ELEMENTS(init_sequence) - 1;
+		bool ok;
+
+		if (dev->init_idx =3D=3D calib_left_idx) {
+			ok =3D parse_stick_calib(&dev->stick_calib[0], &value[16]);
+			if (ok)
+				DBG("switch2: left stick calibration parsed "
+				     "(x_n=3D%u x_p=3D%u x_neg=3D%u)",
+				     dev->stick_calib[0].x.neutral,
+				     dev->stick_calib[0].x.positive,
+				     dev->stick_calib[0].x.negative);
+			else
+				DBG("switch2: left stick calibration not present");
+		} else if (dev->init_idx =3D=3D calib_right_idx) {
+			ok =3D parse_stick_calib(&dev->stick_calib[1], &value[16]);
+			if (ok) {
+				DBG("switch2: right stick calibration parsed "
+				     "(x_n=3D%u x_p=3D%u x_neg=3D%u)",
+				     dev->stick_calib[1].x.neutral,
+				     dev->stick_calib[1].x.positive,
+				     dev->stick_calib[1].x.negative);
+				/* Both reads attempted; mark valid if at least
+				 * left stick parsed (right may be uncalibrated
+				 * on some units =E2=80=94 left is always present). */
+				dev->calib_valid =3D
+					dev->stick_calib[0].x.neutral !=3D 0;
+			} else {
+				DBG("switch2: right stick calibration not present");
+				dev->calib_valid =3D
+					dev->stick_calib[0].x.neutral !=3D 0;
+			}
+		}
+	}
+
+	/* Advance to the next init command. */
+	dev->init_idx++;
+
+	if (dev->init_idx < G_N_ELEMENTS(init_sequence)) {
+		cmd =3D &init_sequence[dev->init_idx];
+		if (!bt_gatt_client_write_without_response(dev->client,
+					dev->cmd_handle, false,
+					cmd->data, cmd->len)) {
+			error("switch2: failed to send %s", cmd->name);
+		} else {
+			DBG("switch2: sent %s (%u/%zu)", cmd->name,
+				dev->init_idx + 1,
+				G_N_ELEMENTS(init_sequence));
+		}
+		return;
+	}
+
+	/* All init commands have been ACK'd.  Create the uhid gamepad device,
+	 * register a watch for UHID_OUTPUT (rumble/LED from hid-switch2),
+	 * then subscribe to input CCCDs. */
+	dev->init_done =3D true;
+	dev->uhid_fd =3D uhid_create(dev->info);
+	if (dev->uhid_fd >=3D 0) {
+		GIOChannel *io =3D g_io_channel_unix_new(dev->uhid_fd);
+		dev->uhid_watch_id =3D g_io_add_watch(io,
+					G_IO_IN | G_IO_ERR | G_IO_HUP,
+					uhid_output_cb, dev);
+		g_io_channel_unref(io);
+	}
+	DBG("switch2: init complete, subscribing input CCCDs");
+
+	for (i =3D 0; i < G_N_ELEMENTS(post_init_notify_handles); i++) {
+		dev->input_notify_ids[i] =3D bt_gatt_client_register_notify(
+					dev->client,
+					post_init_notify_handles[i],
+					input_registered_cb,
+					post_init_notify_handles[i] =3D=3D dev->input_handle
+						? input_notify_cb : NULL,
+					dev, NULL);
+	}
+
+	btd_service_connecting_complete(dev->service, 0);
+}
+
+static void input_registered_cb(uint16_t att_ecode, void *user_data)
+{
+	if (att_ecode)
+		error("switch2: input notify registration failed: 0x%04x",
+								att_ecode);
+	else
+		DBG("switch2: input notify registered");
+}
+
+static void input_notify_cb(uint16_t value_handle, const uint8_t *value,
+				uint16_t length, void *user_data)
+{
+	struct switch2_device *dev =3D user_data;
+	struct uhid_event ev =3D {};
+	uint8_t *d;
+
+	/* Defence-in-depth: input CCCDs are only subscribed for ProCon2,
+	 * but guard against unexpected notifications for other types. */
+	if (dev->ctlr_type !=3D NS2_CTLR_TYPE_PROCON)
+		return;
+
+	/*
+	 * BLE report format (63 bytes, no HID report ID prefix):
+	 *   [0]    sequence counter
+	 *   [1]    status (always 0x20)
+	 *   [2]    btnsR: B(0) A(1) Y(2) X(3) R(4) ZR(5) +(6) RS(7)
+	 *   [3]    btnsL: Dn(0) Rt(1) Lt(2) Up(3) L(4) ZL(5) -(6) LS(7)
+	 *   [4]    btns3: Home(0) Cap(1) GripR(2) GripL(3) Camera(4) ...
+	 *   [5-7]  left stick  (12-bit packing)
+	 *   [8-10] right stick (12-bit packing)
+	 *   [11-62] IMU + constants
+	 *
+	 * uhid report (64 bytes =3D report_id + 63-byte payload):
+	 *   d[0]   =3D 0x09  (report ID =3D NS2_REPORT_PRO)
+	 *   d[1]   =3D value[0]  (seq)          -> raw_data[1]
+	 *   d[2]   =3D value[1]  (status 0x20)  -> raw_data[2]
+	 *   d[3..] =3D value[2..]               -> raw_data[3..]
+	 *
+	 * hid-core.c calls hdrv->raw_event(hid, report, data, size) with
+	 * the original buffer =E2=80=94 the report-ID is at raw_data[0].  The
+	 * report-ID stripping (cdata++) happens afterwards inside
+	 * hid_report_raw_event() for the HID core's own field parser only.
+	 * hid-switch2 therefore sees raw_data[0]=3D0x09, raw_data[3]=3DbtnsR,
+	 * raw_data[4]=3DbtnsL, raw_data[6..8]=3Dleft stick, etc.  No pad byte.
+	 *
+	 * The HID descriptor exposes 5 bits of btns3 (Home Cap GripR GripL
+	 * Camera =E2=86=92 buttons 17=E2=80=9321) rather than 2, so GripR/GripL=
/Camera are
+	 * not silently consumed as padding.  Y axes are inverted below.
+	 */
+	if (length < 11 || dev->uhid_fd < 0)
+		return;
+
+	ev.type =3D UHID_INPUT2;
+	ev.u.input2.size =3D 64;
+	d =3D ev.u.input2.data;
+
+	d[0] =3D 0x09;		/* report ID =3D NS2_REPORT_PRO   -> raw_data[0] */
+	d[1] =3D value[0];	/* seq                          -> raw_data[1] */
+	d[2] =3D value[1];	/* status 0x20                  -> raw_data[2] */
+	memcpy(&d[3], &value[2], MIN(length - 2, 61));
+
+	/*
+	 * Decode sticks, apply factory calibration if available, invert Y.
+	 * Sticks sit at d[6..8] (left) and d[9..11] (right) =3D raw_data[6..11]=
.
+	 *
+	 * Nintendo's Y axis is high=3Dup; HID convention is high=3Ddown.
+	 * Invert unconditionally so the axis direction is correct regardless
+	 * of whether factory calibration data was read from SPI flash.
+	 */
+	{
+		uint16_t lx =3D d[6] | ((d[7] & 0x0f) << 8);
+		uint16_t ly =3D (d[7] >> 4) | (d[8] << 4);
+		uint16_t rx =3D d[9] | ((d[10] & 0x0f) << 8);
+		uint16_t ry =3D (d[10] >> 4) | (d[11] << 4);
+
+		if (dev->calib_valid) {
+			lx =3D apply_axis_calib(&dev->stick_calib[0].x, lx);
+			ly =3D apply_axis_calib(&dev->stick_calib[0].y, ly);
+			rx =3D apply_axis_calib(&dev->stick_calib[1].x, rx);
+			ry =3D apply_axis_calib(&dev->stick_calib[1].y, ry);
+		}
+
+		/* Invert Y: Nintendo high=3Dup, HID expects high=3Ddown */
+		ly =3D 4095 - ly;
+		ry =3D 4095 - ry;
+
+		pack_stick(&d[6], lx, ly);
+		pack_stick(&d[9], rx, ry);
+	}
+
+	if (write(dev->uhid_fd, &ev, sizeof(ev)) < 0)
+		error("switch2: uhid write: %s", strerror(errno));
+}
+
+/* ------------------------------------------------------------------ */
+/* btd_profile callbacks                                                *=
/
+/* ------------------------------------------------------------------ */
+
+static int switch2_probe(struct btd_service *service)
+{
+	struct btd_device *device =3D btd_service_get_device(service);
+	struct switch2_device *dev;
+	char gap_name[248];
+	unsigned int i;
+
+	info("switch2: probe %s", device_get_path(device));
+
+	dev =3D g_new0(struct switch2_device, 1);
+	dev->device  =3D btd_device_ref(device);
+	dev->uhid_fd =3D -1;
+
+	/* Detect controller type from GAP Device Name.  The ProCon2
+	 * advertises "Pro Controller 2", JoyCon L "Joy-Con (L) 2",
+	 * JoyCon R "Joy-Con (R) 2".  Default to ProCon2 (the only
+	 * tested variant) if no match. */
+	device_get_name(device, gap_name, sizeof(gap_name));
+	dev->info =3D &ctlr_table[0]; /* default: ProCon2 */
+	dev->ctlr_type =3D NS2_CTLR_TYPE_PROCON;
+
+	for (i =3D 0; i < G_N_ELEMENTS(ctlr_table); i++) {
+		if (ctlr_table[i].type =3D=3D NS2_CTLR_TYPE_JOYCON_L &&
+				strstr(gap_name, "Joy-Con") &&
+				strstr(gap_name, "(L)")) {
+			dev->info =3D &ctlr_table[i];
+			dev->ctlr_type =3D ctlr_table[i].type;
+			break;
+		}
+		if (ctlr_table[i].type =3D=3D NS2_CTLR_TYPE_JOYCON_R &&
+				strstr(gap_name, "Joy-Con") &&
+				strstr(gap_name, "(R)")) {
+			dev->info =3D &ctlr_table[i];
+			dev->ctlr_type =3D ctlr_table[i].type;
+			break;
+		}
+	}
+
+	info("switch2: detected %s (GAP name \"%s\")", dev->info->alias,
+								gap_name);
+
+	/* Override the controller's GAP Device Name with a human-readable
+	 * alias.  The alias is stored in the device info file and takes
+	 * priority over the GAP name on every reconnect. */
+	btd_device_set_alias(device, dev->info->alias);
+
+	if (!devices)
+		devices =3D queue_new();
+
+	queue_push_tail(devices, dev);
+	btd_service_set_user_data(service, dev);
+
+	return 0;
+}
+
+static void switch2_remove(struct btd_service *service)
+{
+	struct switch2_device *dev =3D btd_service_get_user_data(service);
+
+	info("switch2: remove %s", device_get_path(dev->device));
+
+	queue_remove(devices, dev);
+	if (queue_isempty(devices)) {
+		queue_destroy(devices, NULL);
+		devices =3D NULL;
+	}
+
+	btd_device_unref(dev->device);
+	g_free(dev);
+}
+
+static int switch2_accept(struct btd_service *service)
+{
+	struct switch2_device *dev =3D btd_service_get_user_data(service);
+	struct btd_device *device  =3D btd_service_get_device(service);
+	struct gatt_db *db;
+	struct char_walk_state state;
+	bt_uuid_t service_uuid;
+
+	info("switch2: accept %s", device_get_path(device));
+
+	dev->client   =3D btd_device_get_gatt_client(device);
+	dev->service  =3D service;
+	dev->init_idx =3D 0;
+	dev->init_done =3D false;
+	if (!dev->client) {
+		error("switch2: no GATT client");
+		return -EINVAL;
+	}
+
+	/* NS2 controllers only accept SMP AuthReq=3D0x00 (no bonding, no MITM,
+	 * no SC).  Any security elevation attempt causes them to reply with
+	 * SMP Pairing Not Supported (0x05) and drop the link.  Keep the
+	 * bearer at BT_SECURITY_LOW so bt_gatt_client never sends a Pairing
+	 * Request. */
+	bt_gatt_client_set_security(dev->client, BT_SECURITY_LOW);
+
+	/* Request minimum BLE connection interval for low-latency gaming input.
+	 * Intervals in 1.25ms units: 6 =3D 7.5ms (spec minimum).
+	 * Latency 0: controller must respond every interval (no skipping).
+	 * Timeout in 10ms units: 200 =3D 2s supervision timeout.
+	 * BlueZ forwards this via MGMT LOAD_CONN_PARAM =E2=86=92 kernel sends
+	 * HCI_LE_CONNECTION_UPDATE on the active connection. */
+	btd_device_set_conn_param(device, 6, 6, 0, 200);
+
+	DBG("switch2: GATT client MTU =3D %u", bt_gatt_client_get_mtu(dev->clien=
t));
+
+	/* Walk the GATT database to locate our three characteristics */
+	memset(&state, 0, sizeof(state));
+	bt_string_to_uuid(&state.cmd_uuid,   SWITCH2_CMD_UUID);
+	bt_string_to_uuid(&state.input_uuid, SWITCH2_INPUT_UUID);
+
+	db =3D btd_device_get_gatt_db(device);
+	bt_string_to_uuid(&service_uuid, SWITCH2_SERVICE_UUID);
+	gatt_db_foreach_service(db, &service_uuid,
+					find_chars_in_service, &state);
+
+	dev->cmd_handle   =3D state.cmd_handle;
+	dev->ack_handle   =3D state.ack_handle;
+	dev->input_handle =3D state.input_handle;
+
+	if (!dev->cmd_handle || !dev->ack_handle || !dev->input_handle) {
+		error("switch2: characteristic discovery failed "
+			"(cmd=3D0x%04x ack=3D0x%04x input=3D0x%04x)",
+			dev->cmd_handle, dev->ack_handle, dev->input_handle);
+		return -ENOENT;
+	}
+
+	DBG("switch2: cmd=3D0x%04x ack=3D0x%04x input=3D0x%04x MTU=3D%u",
+		dev->cmd_handle, dev->ack_handle, dev->input_handle,
+		bt_gatt_client_get_mtu(dev->client));
+
+	/* Subscribe to ACK notifications.  The init sequence starts in
+	 * ack_registered_cb once the CCCD Write Request is acknowledged by the
+	 * controller =E2=80=94 ensuring the ACK channel is live before any comm=
and
+	 * is sent.  btd_service_connecting_complete() is called from
+	 * ack_notify_cb after the last init command is ACK'd and the input
+	 * CCCDs have been registered. */
+	dev->ack_notify_id =3D bt_gatt_client_register_notify(dev->client,
+					dev->ack_handle,
+					ack_registered_cb,
+					ack_notify_cb,
+					dev, NULL);
+	if (!dev->ack_notify_id) {
+		error("switch2: failed to register ACK notify");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int switch2_disconnect(struct btd_service *service)
+{
+	struct switch2_device *dev =3D btd_service_get_user_data(service);
+	unsigned int i;
+
+	info("switch2: disconnect %s", device_get_path(dev->device));
+
+	/* If connect is still in progress (init not done), fail it now. */
+	if (dev->service && !dev->init_done)
+		btd_service_connecting_complete(dev->service, -ECONNRESET);
+
+	for (i =3D 0; i < G_N_ELEMENTS(post_init_notify_handles); i++) {
+		if (dev->input_notify_ids[i]) {
+			bt_gatt_client_unregister_notify(dev->client,
+						dev->input_notify_ids[i]);
+			dev->input_notify_ids[i] =3D 0;
+		}
+	}
+
+	if (dev->ack_notify_id) {
+		bt_gatt_client_unregister_notify(dev->client,
+						dev->ack_notify_id);
+		dev->ack_notify_id =3D 0;
+	}
+
+	if (dev->uhid_watch_id) {
+		g_source_remove(dev->uhid_watch_id);
+		dev->uhid_watch_id =3D 0;
+	}
+
+	if (dev->uhid_fd >=3D 0) {
+		struct uhid_event ev =3D { .type =3D UHID_DESTROY };
+		if (write(dev->uhid_fd, &ev, sizeof(ev)) < 0)
+			error("switch2: UHID_DESTROY: %s", strerror(errno));
+		close(dev->uhid_fd);
+		dev->uhid_fd =3D -1;
+	}
+
+	dev->client       =3D NULL;
+	dev->cmd_handle   =3D 0;
+	dev->ack_handle   =3D 0;
+	dev->input_handle =3D 0;
+
+	btd_service_disconnecting_complete(service, 0);
+
+	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* Profile and plugin registration                                      *=
/
+/* ------------------------------------------------------------------ */
+
+static struct btd_profile switch2_profile =3D {
+	.name         =3D "switch2",
+	.bearer       =3D BTD_PROFILE_BEARER_LE,
+	.remote_uuid  =3D SWITCH2_SERVICE_UUID,
+	.device_probe  =3D switch2_probe,
+	.device_remove =3D switch2_remove,
+	.accept        =3D switch2_accept,
+	.disconnect    =3D switch2_disconnect,
+	.auto_connect  =3D true,
+};
+
+static int switch2_init(void)
+{
+	info("switch2: plugin init");
+	return btd_profile_register(&switch2_profile);
+}
+
+static void switch2_exit(void)
+{
+	info("switch2: plugin exit");
+	btd_profile_unregister(&switch2_profile);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(switch2, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAU=
LT,
+						switch2_init, switch2_exit)
=2D-=20
2.47.3

