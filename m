Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240961;
	b=VVprUNR0CD708yklBTCj2e9Iwecs2SylpaS1hhI3ET1qDIB/Fj8J7EDCL1P+m8LVed4N
	 cWJcNeUTakDuPLvfumfzxOZAy70FS3HpW5Zk1U+dZQ7hv0NMFLAOM17dC7hlVA3RKSgUI
	 oEK5dDE91A1FYnGuiMCNOKf/b4ba6A+TLKS+47VHsko4w07IeUsVMrC2HRQsrOneAIYit
	 AihDIHtPQgwUyCPA8VNdtEUrN5yRjI3FuE+Cxt93bwjeEonPOINpXmthLzwrtTpGlCywM
	 +WbZLPYBX9B68OnloXwvgKPjBpPTIkaxxiXsUQma94yWYxfsRzTprtqPpfLeeqEVuhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mXuBDqXYFekIMnZ/s4W0ulTP+MzS9DTQLSUo8AX/8bM=;
	b=w/ozRvJcZilzMETLOHq4tsupcKCjmV9T9h92R3O4xhzVqgezWVpNkt9L36ddTjKsqYTy
	 VOVvcWfhlg3bCVuO69oNnYH+8LHHvJa6TFJsDclp1WzGKh8MjpQd1gg8+o1J77rdNlTo9
	 DM/wSkbv5O1mwTsdCumQflB2LAFLlaBHvCpdNlFY0OckP/VfaP/QFibES7/Tp5Xm4I8uq
	 BNzwCq6IGP9vjUMp60ME8wl4hWoSLs5PSJdrT8vePnRvoi02gRBJLcmenXKPGn3aypUO0
	 VtyYKDWXhvNTf2XEdmSBUm2z1+92G8tKxSwHurjpMt8l4CBSy8jIIE+ZytUw8OqjJwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VgbetET0;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8270A606A333
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 16:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8270A606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VgbetET0
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7d2db1b9bf2so319654137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 08:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794240960; x=1794845760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mXuBDqXYFekIMnZ/s4W0ulTP+MzS9DTQLSUo8AX/8bM=;
        b=VgbetET0MLpiKHGdQayUzYilrbtKlK32YUNgUkVch2MNjfOOu+LLPaxZtSz8j+mfiG
         YU9OkbATdxaS64EJLoprdtT7RjOWzQFtaYtCJ6YCF4tC8UIiTczCBAwzF0IjZTPnLgsL
         MpKYdzGfJDs0DLMBcnJ5O525hJTpYQFI7s2QjFRxgfHpxyuT2IzgeD/hSV7zChh2dBkY
         E2Fkme7gvcBWrX4EKv8taqw1FpcsEUnXK3mu7HXeCQ372fWO7ymHbhDDz4xPQKaJLom0
         clzR0qZOhFZgXq/cHzHtKCbApAOBHtiClr3J6T3aug7b4GGB1aPPM/E1ocC+9GcKUjGi
         aprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794240960; x=1794845760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mXuBDqXYFekIMnZ/s4W0ulTP+MzS9DTQLSUo8AX/8bM=;
        b=s88AJGgMw/8SmoGXJBKbZt8w4wrdD6/PDPQEgoN4H2OW+QNr3Peic4LK2/bH36VNQK
         F2uVPdcII5YmUGPTJlaLGUn3H+z1UPJLtMOkWrpwWQmPaGRUtDJacAX8Q0GoIBc/MuD8
         NMER7XpKCjdU6mykYocsnU5oPtQ1fdEfGLC3RhijX3g2dXh/hemzipgOGqAGOK/ywxbD
         zVHtLWdNP85Ebop2mj2l4OynAbiYy7HvzXueSI1XJqhGDzZf3y/plj+Wbv+uDr+z1lha
         sv5Md1Upye45+F9tIPEmrVIXM14pWoEpBtic3y9I79jVKJL3r6+KkiIof0mopmD41mnk
         hTQQ==
X-Gm-Message-State: APuU4Z+S/49Ic3o0s53dCl3pND0qnYsaZXF1s4HrUur5FxXh7kVHQweJ
	ppE1Q93FjaesXw3hShoamUQAC2rGdW05D6fk9WNImajRvWJqQRRjiXBbSXS8fA==
X-Gm-Gg: AYBFou2R++qpUGGuXlyLzlHog33ZsB9d+6i/OVCDKymns3zXf8fhFTzZSZ7XTbET4Y1
	Yi3tRJrV+0IK7ST8GHzlr5SZRoP2JRh4dyVLCCdzL9K+x/6YRoot+zOWi9SSsyyHYagD6EDP4Gy
	nnQyHijnkL41hY+pXyf9QFwxpxg6+3OaA+KZu08RrlwrCqYgOvZ+mHiMtP0txeVJ7qjhrSolkQJ
	19O/oLVyWBMgh1C7TBEj3aF6CtWnR95SbgSX6TIW+rTMlHaCp3uy2G2Vwxt8YtuugMmwJv1K9h3
	jixIak4LuuYixvkxOKq/BEQZmN4oDptRFxGf4uSan7JfBJ/ZtNmTU5c7HxKDRXRJxGV7JNvgG5r
	IVb1+nvLH8J67a6aOZU/aQjwrcNHTsD+rT6puiD44AJ7S+dpPe4Lmcp99hWKJHjSdz+2g4+ZW0y
	mRpynxJv+qD0Fcz2lIj0OZuu4nhrUVe+RaHnH55Z5L3BDnY5sKHb/EkiQhmWIR/7kI8PgMy7mZB
	xyo15UtI+OYAcAnHja1hoeSXeWbGwtKWminuLKghUS6jx/LHR50p93TvupoJCcXj/f87xSmWFIM
	M4tRZoiqHoPsQL/gXT6MuS7WfU8era1/8h9d7AacJ6FQxaPUJeLt3v88Rtp2i/bFopWyHd7hgCi
	4xcVqMA5uci60XPNy9k8m3hMwwxB9RZ9zS/OiIX1MISe3tdiJbyTC7x2PhTT/mvazGiJ4nzIqvC
	SpXBQ=
X-Received: by 2002:a05:6102:689c:b0:7c1:bc57:c7f5 with SMTP id ada2fe7eead31-7d2daf180c1mr1172470137.12.1794240959632;
        Mon, 09 Nov 2026 08:15:59 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ece66b77a7sm4562733e0c.17.2026.11.09.08.15.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:15:59 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v7 03/11] doc/iso-protocol: Document BT_ISO_QOS
Date: Mon,  9 Nov 2026 11:15:43 -0500
Message-ID: <20261109161553.1506041-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109161553.1506041-1-luiz.dentz@gmail.com>
References: <20261109161553.1506041-1-luiz.dentz@gmail.com>
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

