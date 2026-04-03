Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0603822A9
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206602; cv=none; b=fZeL0IT7OAU2rRe1MpUg2m5GVJhMLzAGhnrbRUUsso4WayWAWjDzkbembke8JD7EB2yxLwcoaLmbp0z8WucQ1e+J71eSNxw/3uSD/45qrshxmoZogVphDixdtlqEnBTYfKQ9vw+2q03tNn2iwc1ZO9UHgsAcpkL4MPOJOsAckHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206602; c=relaxed/simple;
	bh=DZHIGClj2O8InNQL1yS7xTls3FkyEayb8X8Xkfc8P48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohSo0tylR5xZTyGsZ6RgFaEjoFoVThwBosXONw0inQtazQsj0+ip0slhgPmCxubPqkH1gw0JqYsziGlW8k7V9G7eONaL+75Zj7eqJ9C5cxvxGg6NSNpz5sc98r0hs5y17CZBrvhsphKB6TQevScMckBtvjc3/qaxMF23HH1XWMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=ODaCyhMN; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="ODaCyhMN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1775206596; x=1775811396; i=martinbts@gmx.net;
	bh=ALC1KQBjHrbnN4wINEiHCeG6NABsIOqunMkYfYNmU0U=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ODaCyhMNP7QMyzbcuU/jyDfrIby79iBHvgHYU4LcvQ7HhxO3dWF9rdylG19b7K/G
	 9jiRkWhGHmLcyvN/ILXgNoZbRkXZQ0hIFY6ZObPOEtCRVnr8Q5S69R8RYUlaJ+Rwg
	 MqjjKcS0sfTzzDxlkZdD7PEPX7mOmpkyEJRfAIBgphn7SRF3eP8ZlGSh7sL6YTzmJ
	 pnQAAZhz9GR5+kDiTLFQurdii5akxn/g6kkvkPDqddpcoqkkUhHyWK2aPt46mXnlh
	 U1UzJIhpphZQSEkI4jCFKAuG7xbcWX0yd0fS6QRsKm+0X0g897Ai6g4swe77tckH7
	 LcpGEkB8A0tWvBDNXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEUz4-1wJ6410Wyo-00CVNO; Fri, 03
 Apr 2026 10:56:35 +0200
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net,
	luiz.dentz@gmail.com,
	vi@endrift.com,
	Martin BTS <martinbts@gmx.net>
Subject: [PATCH BlueZ v3 5/6] plugins/gatt-uhid: Add generic GATT-to-UHID bridge
Date: Fri,  3 Apr 2026 10:55:52 +0200
Message-ID: <20260403085555.23871-6-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403085555.23871-1-martinbts@gmx.net>
References: <20260403085555.23871-1-martinbts@gmx.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L/YKraXOvsXEnXQaVneefpA43bBqJsp1D716GsmWFCitPvowOi0
 YkxVNOEUYEtJvxm6/A3QMUT8lRL0cf9/D0cPWBqwfklP3gSYPnEwkmJ3dBkZJIY5TAX7X0l
 cLtZAn5afzuBdVlqSLMk/UCSLoSA++Mij4UY3ln25l6Z2QkvsmYgbU5RXpBFeKiPEUBLEkr
 jqsNv11rSodPqaNQiDRYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GxuixQs1MRw=;wXJAGYEEV8hQY60nnOeGk4RCm6l
 ARu5ezvillh2YfsgsVLnm+rl35J9Pxb4uW4s/EJxGDJtn2SBfeODw//LSBYyTgLUm+W6Xn7Se
 JkOaVkWzfJqUh93xVSz4rip5CCe1lHz7J4Uox8Y/la/h7REMG1CQ7/1GB8+TOYV9N2XFvyblN
 zBUOImCJ2MG1DsrcflPwh3neeLVms4W9Bm2D8b+oRsxKH+Dv3FYy5Jx+k46Zgn+5kzgTLeX3j
 vshyA1SJRNgWJmNN3WHU/tRBqpiQ/MCX7PQSaJ9xp2aRknGCmcqhbvQjcz3BAzmztT+v+2Ih5
 O62eMcx7gbJO4dD6mZZSImKt2e4e/Ba/X15AItRQWy7keM9zTUFwuSpk3hECbEAgVRXybcCE2
 NClaeKCnK4/dOOyuF28gzuPG8SxoOi79z/LdULe/eFVMEP7OKS4VDZI09s2NZo9nkTDFBnxdL
 YZ58XOqMuduGee3Y5GjjE9MOmSyNLHNW/d4Li5yTGLMzadQHBCAL7Y3Rs5iqHHadADgncnERG
 ym74vwle/FsvlTJ1iAwDm74q10ZjUSBtAZ0siNgqyOHg3uOBLRS0z1iK7GG1wfpy07ySXcDOd
 f+06X5cNvC6RziGUm18EXqYtVyxMcCXUjT6acD3up3Svlw7MtWr4EqSc79ew4lOFlINomjSB/
 LFut2w1CR4eSmxiU8Dbojt01wpitIber/gxEXGMcqOLT+gJ8HyBAv6s8kTsfUpcgsEOTuEd28
 C6acUjtANWvk7w0RKyyeMiMMhwecZ+QIrBMi4gSK/qMQpBqMkjyzIm8nuM1kzENf4GrG1g2l0
 5SThWxxXY+kUyoEy6c3KWI98a0P2hmWVv38jXblTCbDlG2HOGBiWrihJuY9JQk14cPQBQv3gW
 9UCIk3yeTv2E2O44Ubc6yi2ju8+FnVUJBSFKsclxaMXiTo/J1GM++9+oKF6SoNPOAiHpoD6kD
 KGf394ubjPhGnSrCJhf8lwH/A6e8PWVkDi3hjmM4sJsrcIUbazmYhxRHsgBr41TidoF322yY/
 mhnkhe0+2Y9kefXRgCvjopopV0PZ5CaEk4py736mTxbRPCN8JE1kP3I5AGBUctQJkJTmG41+L
 xtkSGD89i0RoU4TrtYC8WtILXzcJ15qQSuN+WGCrx63DueG84CbgFZ5lx7nPR11bP4ZZ2FiVf
 roGsgevpkLoHkQLhNVcCnSVgocDGMZ30N59t/aFYfyUREZGPwR6Zb6/DC+19f67RlCibqbTXG
 WR38nHQv2mAMTuopQOPSWB8AO7zG2xniR1ldROrapjT7OiwjsOjNWx3wFtVRCfmTu5sfBF8qf
 hbqIvYISpRvzcCH/OoufUBKoVCAWwAJoYepILqyrdguYFLneC6C5pQCv8QDgl9qMakCqGr6U4
 +lXPPRdooSxTX0zi1EWpEdiYMkmIBTDgSrH41cS3imEL5wuE7Lt9Ql7yJCLlAuBXwd+S162JF
 UBBJOeSCYZIYk6tPczvDboY+3gF1TVysxGT/qI06lfmJ9x23WG5KX/Vz0G6lBY3fPuTTsGv/M
 iWkffwKC5Kfnh9cZFQYD23gPW0MTg7KFusdUA+WFKIo2MV6AAqDR7lS4FD6vFdF8/tL6+b1iw
 7vpJWAOuHpE1jNSdTwTvGN1t9uKpBxQo3pt4MVjU1AdBzBe/Y8Nw0ut1QvGcm3EWUegpNk+yD
 cEV/ny/N0nHpwN1ZQKawLIQGcJrIaSOqljSE1FjDRCppILJbhMlff4JvmeZD9MydSgkmR/E6j
 3igOE1elMlQx0wbIJ6O4U8Sf+XUkPXpZ32lLV1amGdWFUxIObx6Ikc3Bk9DrXpW/TmEx1xztZ
 fuqken5BHWUHrfYYQeJornlLbhNzR/Yo5QHxc1QRnoqa8lJYdGa2pO+zSl7xNpmJvfY8TVaCx
 OtJ0fcKIGHfuSWaYEIR8I41u1sD44nr06Jv5UsyqOSSb+MFU5A0HmF35iRZOhjjChpbRxmIuX
 6L5SzD6USN666+Bhqm22yhTP17eZ4p8RpGoOfEcFwg5oOUF7eSz9LZaAHaVKyCwh2Gu432GAM
 7jktIB//AN2KApkkyCPrBCqs+eJ1jyZp48mHjJT0Y6m4fghuvqMG2LetJe9GzdibsmivtTt5r
 24gohkGpuxdAmS+O5O8cdxMfKpWnc/+d0oCOdxYgsSIVOC8nvU/T9BR0MXmw79TGo1MiZBqWK
 yVoxKGAWiT4TNU6gYzoRdgxQV/s6mEAYO0Bi68rMZd8svuh2WpGQmyXQ3C1sQYQeqB5qlu4cs
 fcxtut5HHu8RQwQCA5fER+oY7y9cjqUQI1sKzMx/OccS4jCwLwMfOukMm88uniD+z7rPNhZlE
 ouKME7K9ZTk7rFRrZ0gIAYzS405JxxfH8VnkCLdjgWePIORD+duZCiEvyYKK8iPnX/LQKZHFv
 E5bkhcJBUyZuWuRUfHQ1FdjYHaDAKTUObP0QztB5G7kxivIM+Zs+XmfCB5NWxNC0RbyUIggOJ
 b02P42PHUGv6iX7D0RliQqCNDcrOseRH07iJvlxtfKdFf9KZVPOlyIo0aXh5TpT9S1bMNJTK9
 KIiMiaT45Yvh0MtXRzOlSOxa8apEuKxzveAA8UWCoxaUb8hxxeypJOf73bgqPMJHDdDdwtOVf
 Vnis3wu/FRD+XVL5UH8Bu4h1mxawT6n/2Y4Ul0nGCWZ9+zqgOBrUYlN3FYY2ElMudz42Q6i/R
 tyqeF6+VWX/8q5MDqQGX7Yd6fYtj5tvnitt/aRJNOJNTbIn1eWnpUWdNutjkR3ucgr32w9XT5
 Qq3c4NdFguo49lthgA9hb4ZrChAtGtH3Ox1SB/wAUi0W+f0/1ZnyypABK/woeSYDbu5+oyKmd
 MNGLjF4/OZze9+zeOteavWaisxQapqjf+sNg31pCTvoEfDUm4NTQae6gW+iKcrZzTbm81xW81
 msUCkFb74u7cURNWlzinc221PsmbhfrXH4ydgSC3b5D9W9XSaUoDWIkTSJLTnk3wXUCSlcYdJ
 8qa9dsSBEnGp3z+tXBckFs6Rv7fBQiKcLg3I1pW35WlkXXYPI34VUUEgZvnUjmeF62mjdSbCP
 0SJVl/k/+Js9Cbgdy5dsWfj6JK+v74GzCzGRzIx4RG10SNtHwoDorB8CgGJVeNdTQucc/7cGH
 VSp3At5EQA49Zvh74RSdASWiml3wKVti0mytFVfrL56EYozbqOfUQWH/HHvioz6q6DS8Usvlk
 xYRYrZQ15faNGpGmkG97XPq9f2QIVn7/Ga6AqImlguuHURPlf9Zxe4Wa0BUHcyHiX06gpWBvi
 Ox3Dd/7NUikCn/6SIvnRfWLZcp0AFZZwrJu1sCdc72ya04zdQrGCu2nxC0lKXxvj6ymJMP3RJ
 z946lsefvkm4FiybO6uqYhRp+RIXEdig2cI5y06msccezuOTHQpf4j6HTnqK0h87pG2gPLksR
 ydqq0Ue3CIQEppnzWRCxtrLTRzklP5ug3nSFMa5jlWtg3g3NCJDbP9vCZ2GEOZREFwAq2gTFG
 wtAEdVqY07qoyfoxVoZa705/8D4b7sgDyCpzYLtsjVu+tFs5apgq0kkG543Xr6LZC28ghwH/4
 N77ppNUohqjWmZ0UigCT793uJ4/7nv9yCPLKV84gsWacmri8esbKtsi2V/3evTlR/34kGq9lc
 2Ze/6t0RlExKKmEhDTeSqkpVQTitHvZs7gxo43NjSvXnBqdmRThbT/Q5pZi5kKWGma/Qhjcsx
 VlDma+dyrK1TcgmKmHSFTcUW2NEqR0gSy9+8BolqrI30FMOP5FpfPKQS/izd7QZqLfEGSc/mP
 OJja20mrfxsuX+UgQiv9bfqqbVwb1Kk5tJQ3U6Z4oHKfMoXCezWy4g6kiv3zpABxMV2XBu97F
 L1li2ETMiGhrZJRap+fzUbHg6SNqoLMETUgRKTJbjh5jfNV9EELY8ISD/9iBfpCZd2In0vZVT
 ZdJqUW6gbxS3sqNxPThnRy0sscYeF0ynen+9lFyujT++xD92lqW6aninmnYQSa+tj+5L+PoIT
 oq/Aadt7eWCzoNcwwfYKvRKzcTEjdvs7BWH6iCX0Cm3D2rLzB9W6lp1GasUZx6emFDt36g3Pv
 FjfKbimt1aypFL6FX6wGRJpO9vTOcYRyZpUe9iVRFQwbH2UiF+YvxIeBN1cdNaBcCdQQJVHj1
 nrMekw6SwIdad+nP7HzlndPUUXwP8d+2iwqvq+YEPGtzlBZ98MuDszVBqpxylxOnugBB3LaKJ
 sCirnfvzBSNbfbu3szYBMJkkJBthsj1TPFVbC8KCbf/9UcS8aNQxZx64I1i3zegv9gVeoYnmJ
 0BUgsrKIH6cO7WlS56SNm+rLL+1Y340HzmG/6CR9STqxnGoJrdvwCQN25DFFvp33e7GIaAw4E
 J8AlRV7pAIf+IO7zxT1vAYJ9BRBCVwiLEKnHZrMO1Fq0iWM58s+x8kjrFtQCin/3e5q1tTb3t
 guztHUErlU4gQLUvLV9b7RTX9shLEFwKbw5YgRAAyYnJ4ifatt2PzAVCfhv12o4RdhGSgR3B5
 JtWCOgfz/grbXmQlMU6jYKCGGsa69CwTKfcu3KHWMF475nSvStoSTFhGmioM0nwllO/k4H9dF
 9nH1dHqUMOBta6PYeSVCqojZ/hvyFL8VUka+pyDuIElbdkBzwmbhLd5M9UmaXm1+7rn18kupe
 q9f1cJxcd59fYDZ9sagtEmaF1OjABsam+Av/zmHmqE/5V1zyaUbN2OQu9753oWnSCoDQOhExX
 j20pg7zsDjSPF6doS7xo42SAsB/jEwnz5VHt4PjVOkAPojdSPfrJnRZHD/QHPhMZSDSb4ci28
 cecYkgLBxEq7TV1Ko2HTp39dvgrlmbM9/F97cu+25HUTYhFbhYCaz7uAiXOks9C3SJjXKge38
 BaZ9s5QNYLjWaWvanPx5HRMnzzSJyvfcFysMJ/9UejFutAe0iAbEbXvbSkZqd44+uVEyimwNP
 FjklndX87YrEcnCtCPmxxC768ukd4CWweK7D664W5x/6FR2JzBUvKcEG/XoU+hWP/OjPPM4sb
 cMiDfxgAg3viABIKejZf1gZ0ABNdb0X1J0UHz/wsbElz/Y6GMJqxriNnBo6CXBzEAMtYVNwFa
 OvuWPoKof0ZaW/RejkEhK5sp2+JJBTzRiVYaxufxLy/icijDvzElktQR9luzqnpJbPpoyPhEA
 GNZk5escuB1vO4POBW5Z+54fjNP8TFK/Rp4UAsXfLE9PBSwoiOZdxT4NS9IIZtqAek3cItJih
 QRPg3uN0wkssGA8rHiu8WdoLGb/wh2DvMCCDVaXGMz9KZlmFQwk0s992maYIBIn1FEQTyvgMC
 sYSdKxq9quCgMBecrP0KLPQkog2BDmctiSVA+V/5dRvNUBU0xX/6PIpOM115mm0jisfMZXIEt
 H1MKLonPmEsyj5ZxmbR3UNDl+dJe7LDCicpC7cXIMIea4s2YJcSchnTfMWaak0ZLI7KHrDB/f
 QmDCOzLyAX+bTEzdRmC84/2RKHiU7UGr+8SynMLLnATto=

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
 plugins/gatt-uhid.c      | 350 +++++++++++++++++++++++++++++++++++++++
 plugins/gatt-uhid.h      |  56 +++++++
 src/shared/gatt-client.h |   1 +
 3 files changed, 407 insertions(+)
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
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index d9655e6f0..93fdada44 100644
=2D-- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -15,6 +15,7 @@
 #define BT_GATT_UUID_SIZE 16
=20
 struct bt_gatt_client;
+struct gatt_db;
=20
 struct bt_gatt_client *bt_gatt_client_new(struct gatt_db *db,
 							struct bt_att *att,
=2D-=20
2.47.3

