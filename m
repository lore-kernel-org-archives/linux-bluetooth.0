Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989097;
	b=hjhBTpPXk3nG0zF1TA9AMFhqaE3Mlyvbbv9K1pmO3QPbq7AqYaTrqB7Y/omHDcYgklnq
	 Rz/jiQgKnFo8j5K2BrIOf2Z5NEzHeqjn4K28WPcBvQitZhDSGiIJ19OvmHJsg6RxvFWQN
	 BNN/I89yh6S5VsueYKxQwQwb9jF9ry7DQL+AnwJqYR4qj3fTegNLUboY4ZxVCwaYmMZ7D
	 4MjUw/JOPqPsKAgtiXp1HPGxMcVov/uzeFBn2GdmksBz2FXDxQuaVNOn6kSiDrZc6Jidx
	 IGSyzAnuK8ixCGwhXw6CQ1ZO0ZNvEZan62P1SNodOS9k+CG5mGmFNiwtUY3gNjpRaPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989097;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mXuBDqXYFekIMnZ/s4W0ulTP+MzS9DTQLSUo8AX/8bM=;
	b=2uXPbG4EL33zlxC5xEBLmXJPK6ODCD0KgV7uQrctLep9rQOXazzNckOfQ733v4d4VASu
	 zN9SFU2Vj+Z7l/qWEUTA6DpIEGgZvD8b1dG/l0TJUSCWmbJgc0wsOKETtlly0HAEGZg2W
	 SYB0BHL1SKlsQCiwsDjGeGmTZ1HMUiq78A4LqjiO5clkzI7oVUIPci3NdPo/ewimZDqVl
	 nLEDyOahqjapZ2haRPYuOBcx6UTkKx8jeTL0sFEJnEP9FRj9GGj+5VJvaYiWUVU9+PY0C
	 GBNhCc4N2tAyWf//P/qWlYQ//HKOrnYyEwh5nunJ5OS6gqxDKTFCw011OPyCJ61/P9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pvz8e5DE;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9E5606A331
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 18:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E9E5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pvz8e5DE
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eadf48fb2dso404158e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 10:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793989095; x=1794593895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mXuBDqXYFekIMnZ/s4W0ulTP+MzS9DTQLSUo8AX/8bM=;
        b=Pvz8e5DEF0iaOTioxX+sf4bT+uqxVtIfuwRQifZQh08ycyU6Iv/Qn6oxixVmRzUgxa
         bHZD1M52kYDAJVOI+nTodc/aI6EUx15CYGmjaM2/TFIAa9mgk6SAe83rXzcWaeprzTO2
         9SsoxqCRVNFesVLCYijWCXX1iR6HjG+sghpBzmTd1E6sCibFIGFtDiynhQSD1ARJWJxT
         02I8Pjk3qlB6P3Fgrc5/k+lp1sr1XqQiZhL4h5bVIOr3xXPF8t57ZVj1UerHL0milJL+
         SuXfkTHph6Yk8eguwPzyVvVDkkD/eJT+7e5fzu7vwWO1LKuRBzphFzmr4yMH56H/bbPE
         /I5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989095; x=1794593895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mXuBDqXYFekIMnZ/s4W0ulTP+MzS9DTQLSUo8AX/8bM=;
        b=ySCHsMH36OrG9urq2EzdRMu1Xw8H3cGRGvrb9K9aeMFR4s1AGIYf2IxSHBgw5wfRBL
         eM84iDi4B0RpEtRbR01LQfNwB3S+Bej2z3tgY7eJtas5KwZZ/3r1Dg6BKwwEZRyqORu7
         R0wnitkgts8wxnhEgga9eKFUymbpiw5m0aXVUexqZLRBfD8KxoR0vpGzWLCAyG5t2Qru
         v8R7pTT+eLSsx9hRdUAibesrF9jFZJF4zz7RrDvi+DN1BERCKD5OyTInxWB5T/IrB6WC
         V4LRDigpmt7HUcrZmR8W4Nt1Imsa0i6Tq3rsqWgQ91uGkTouaQruhr3XTMwIL8EsU040
         qntA==
X-Gm-Message-State: APuU4Z8jXbQyiRRQZcbFBd/Fkyod+N6+TicCx0utAseU4nAsHvQiYY5t
	nhiorlJBC5mKgPX8+DIOJhX8Q6IUMSCSaBoi6gMyY+d2Pmt19iMd+cVN6SbO1g==
X-Gm-Gg: AYBFou3l/GGsEyDRCobvUj/B/vfXQB9kkKj29oY1DeFqMKOIKzoHIAwn1/pRXVvcLx2
	ARsIG2z4vQ4gkPpRV3L/oBpQcbk7W5RTDblzqN7sXv4W0icTGSrIGALiUkqT3Kw1bMXox+EkpJ+
	jcmVgo1NorFZcjRHxjJJa7GoDBGApfJCgp0EbZuX3qesVckz4n7efoHxc2jgkneotnem6k/u44V
	zmi3zZdnMsEQy/QWPcSK57khFa/rHAuq8rQ2wn2zQcQ/rPD2jMnjEA5gEQdaarvWiS3dKlFq3Fv
	ppGjloVBhC5HSoJFW/8e/i/UdCP6FONdoFiClkpGvEvZv3ndxfWfUKcEw7P5enKNmgzXEf/Q9+a
	afNXFva4nxovMsznm3Bn7noqWnBm4bSvahfnxKEL75wlkBBdu3UQCMrHZLOpBSv4CaTqDbfpt5h
	Lbe/2C3gXMZtcJ9GauLN4ZPSd4uTiA4CSSEMNb7UOakJI1bBWQTGd9rJzbruqV+j8grlxvzRpTn
	4Jj3Oc2P4eopl+TDRNaIgax8YPv7Fgk5P+3hWfM5D/SzaInuS+KiMxHllHrbbtuVNrN2B4VC/ML
	R8RBHV+1Xosd9dIQjzv1JUNvQXWypwNej8386O43X+mbPukhcB3BgHdvc2g8lrlDHoQh0/HEmZK
	ZEAfdds7lQY7fuTVhAXUpEL6tenuLlvJqbSUYJmIBYjvWMZ6U07BlDqW6WdhcGc50yw+N0+jhwy
	KAcKjN9pQIA68S4TV9V6yhfwrs
X-Received: by 2002:a05:6122:e169:b0:5ea:e197:43ee with SMTP id 71dfb90a1353d-5ecc441d997mr1659117e0c.19.1793989095232;
        Fri, 06 Nov 2026 10:18:15 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc6517dc0sm1922904e0c.17.2026.11.06.10.18.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:18:14 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 03/11] doc/iso-protocol: Document BT_ISO_QOS
Date: Fri,  6 Nov 2026 13:18:00 -0500
Message-ID: <20261106181809.3134862-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106181809.3134862-1-luiz.dentz@gmail.com>
References: <20261106181809.3134862-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Document BT_ISO_QOS with struct bt_iso_qos_ext, its version and type
fields and why they exist, the PHY values and the HDT rates, with
examples for unicast and broadcast with the LE HDT PHY and reading the
QoS in use.
---
 doc/iso-protocol.rst | 207 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 207 insertions(+)

diff --git a/doc/iso-protocol.rst b/doc/iso-protocol.rst
index 4d315132f911..8d8aebc3af2f 100644
--- a/doc/iso-protocol.rst
+++ b/doc/iso-protocol.rst
@@ -241,6 +241,213 @@ Example:
         }
     }
 
+BT_ISO_QOS
+----------
+
+Isochronous channel QoS, used by **connect(2)** and **listen(2)** to set up a
+CIS (unicast) or BIS (broadcast). It is read back with **getsockopt(2)**, which
+reports the parameters in use once the channel is connected. Two forms are
+accepted, told apart by the option length:
+
+- ``struct bt_iso_qos``: the original form, kept for existing applications.
+- ``struct bt_iso_qos_ext``: the extended form, required
+  for the fields added after the original one, such as the HDT rates.
+
+.. code-block::
+
+    struct bt_iso_io_qos_ext {
+        uint32_t interval;
+        uint16_t latency;
+        uint16_t sdu;
+        uint8_t  phys;
+        uint8_t  rtn;
+        uint16_t rates;     /* Version 1 */
+    };
+
+    struct bt_iso_ucast_qos_ext {
+        uint8_t  cig;
+        uint8_t  cis;
+        uint8_t  sca;
+        uint8_t  packing;
+        uint8_t  framing;
+        struct bt_iso_io_qos_ext in;
+        struct bt_iso_io_qos_ext out;
+    };
+
+    struct bt_iso_bcast_qos_ext {
+        uint8_t  big;
+        uint8_t  bis;
+        uint8_t  sync_factor;
+        uint8_t  packing;
+        uint8_t  framing;
+        struct bt_iso_io_qos_ext in;
+        struct bt_iso_io_qos_ext out;
+        uint8_t  encryption;
+        uint8_t  bcode[16];
+        uint8_t  options;
+        uint16_t skip;
+        uint16_t sync_timeout;
+        uint8_t  sync_cte_type;
+        uint8_t  mse;
+        uint16_t timeout;
+    };
+
+    struct bt_iso_qos_ext {
+        uint16_t version;
+        uint16_t type;
+        union {         /* Shall be the last member */
+            struct bt_iso_ucast_qos_ext ucast;
+            struct bt_iso_bcast_qos_ext bcast;
+        };
+    };
+
+``struct bt_iso_qos`` has the same fields without ``version``, ``type`` and
+``rates``.
+
+The extended form is meant to grow, by extending it rather than adding new
+socket options or structs, which is what its first two fields are for:
+
+- ``version`` tells which fields are valid. Later versions add fields, while
+  applications built for an earlier version keep working with the fields
+  they know.
+- ``type`` tells which member of the union is in use. The QoS is usually set
+  before **bind(2)** or **connect(2)**, when the socket can't tell unicast
+  from broadcast, so with ``type`` ``ucast`` and ``bcast`` can each grow on
+  their own, by adding fields at their end, without the kernel having to
+  guess which one it was given. That is also why the union is the last
+  member.
+
+version:
+
+.. csv-table::
+    :header: "Value", "Description"
+    :widths: auto
+
+    **BT_ISO_QOS_VERSION_1 (0x0001)**, Adds ``rates`` to each direction
+
+type:
+
+.. csv-table::
+    :header: "Value", "Description"
+    :widths: auto
+
+    **BT_ISO_QOS_ANY (0x0000)**, "Set by **connect(2)** or **listen(2)**,
+    possible with version 1 fields since the unicast ones are a prefix of the
+    broadcast ones"
+    **BT_ISO_QOS_UCAST (0x0001)**, Unicast (CIS) uses ``ucast``
+    **BT_ISO_QOS_BCAST (0x0002)**, Broadcast (BIS) uses ``bcast``
+
+**setsockopt(2)** fails with ``EINVAL`` for an unknown ``version`` or
+``type``, and **connect(2)** or **listen(2)** fail with ``EINVAL`` if
+``type`` doesn't match how the socket is used. A socket that already has a
+connection, such as an accepted one with ``BT_DEFER_SETUP`` or a PA sync,
+knows its type, so there **setsockopt(2)** fails instead. **getsockopt(2)** returns
+``struct bt_iso_qos`` if the buffer is shorter than ``struct bt_iso_qos_ext``,
+otherwise ``struct bt_iso_qos_ext`` with the version and, once known, the type
+in use.
+
+phys, in each direction:
+
+.. csv-table::
+    :header: "Value", "Description"
+    :widths: auto
+
+    **BT_ISO_PHY_1M (0x01)**, LE 1M
+    **BT_ISO_PHY_2M (0x02)**, LE 2M
+    **BT_ISO_PHY_CODED (0x04)**, LE Coded
+    **BT_ISO_PHY_HDT (0x10)**, "LE HDT, if supported by the controller, using
+    ``rates``"
+
+rates, in each direction, used with ``BT_ISO_PHY_HDT``; 0 selects every rate
+the controller supports:
+
+.. csv-table::
+    :header: "Value", "Description"
+    :widths: auto
+
+    **BT_ISO_HDT_RATE_2M (0x0001)**, HDT 2M
+    **BT_ISO_HDT_RATE_3M (0x0002)**, HDT 3M
+    **BT_ISO_HDT_RATE_4M (0x0004)**, HDT 4M
+    **BT_ISO_HDT_RATE_6M (0x0008)**, "HDT 6M, if supported in that direction"
+    **BT_ISO_HDT_RATE_7_5M (0x0010)**, "HDT 7.5M, if supported in that
+    direction"
+
+Example (Unicast with the LE HDT PHY):
+
+.. code-block::
+
+    struct bt_iso_qos_ext qos;
+
+    memset(&qos, 0, sizeof(qos));
+    qos.version = BT_ISO_QOS_VERSION_1;
+    qos.type = BT_ISO_QOS_UCAST;
+    qos.ucast.cig = BT_ISO_QOS_CIG_UNSET;
+    qos.ucast.cis = BT_ISO_QOS_CIS_UNSET;
+
+    qos.ucast.out.interval = 10000;
+    qos.ucast.out.latency = 10;
+    qos.ucast.out.sdu = 40;
+    qos.ucast.out.phys = BT_ISO_PHY_HDT;
+    qos.ucast.out.rtn = 2;
+    qos.ucast.out.rates = BT_ISO_HDT_RATE_4M | BT_ISO_HDT_RATE_6M;
+
+    /* The input direction uses the same settings */
+    qos.ucast.in = qos.ucast.out;
+
+    err = setsockopt(iso_socket, SOL_BLUETOOTH, BT_ISO_QOS, &qos,
+                     sizeof(qos));
+    if (err == -1) {
+        perror("setsockopt");
+        return err;
+    }
+
+    /* connect(2) sets up the CIS */
+
+Example (Broadcast with the LE HDT PHY at any supported rate):
+
+.. code-block::
+
+    struct bt_iso_qos_ext qos;
+
+    memset(&qos, 0, sizeof(qos));
+    qos.version = BT_ISO_QOS_VERSION_1;
+    qos.type = BT_ISO_QOS_BCAST;
+    qos.bcast.big = BT_ISO_QOS_BIG_UNSET;
+    qos.bcast.bis = BT_ISO_QOS_BIS_UNSET;
+    qos.bcast.sync_factor = 0x01;
+    qos.bcast.sync_timeout = BT_ISO_SYNC_TIMEOUT;
+    qos.bcast.timeout = BT_ISO_SYNC_TIMEOUT;
+
+    qos.bcast.out.interval = 10000;
+    qos.bcast.out.latency = 10;
+    qos.bcast.out.sdu = 40;
+    qos.bcast.out.phys = BT_ISO_PHY_HDT;
+    qos.bcast.out.rtn = 2;
+    qos.bcast.out.rates = 0; /* Every rate the controller supports */
+
+    err = setsockopt(iso_socket, SOL_BLUETOOTH, BT_ISO_QOS, &qos,
+                     sizeof(qos));
+
+Example (Read the QoS in use, including the rates selected):
+
+.. code-block::
+
+    struct bt_iso_qos_ext qos;
+    socklen_t len = sizeof(qos);
+
+    err = getsockopt(iso_socket, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len);
+    if (err == -1) {
+        perror("getsockopt");
+        return err;
+    }
+
+    if (len < sizeof(qos)) {
+        /* Older kernel, only struct bt_iso_qos was returned */
+    } else if (qos.type == BT_ISO_QOS_UCAST &&
+               qos.ucast.out.phys == BT_ISO_PHY_HDT) {
+        printf("Output HDT rates 0x%4.4x\n", qos.ucast.out.rates);
+    }
+
 BT_PKT_STATUS
 -------------
 
-- 
2.56.0

