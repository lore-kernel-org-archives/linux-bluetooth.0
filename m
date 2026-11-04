Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793830861;
	b=AoFLIOig/gHAnmjtncqatr37BJ8I3bw8vzxH/PVx3NBwxh/aSGOfnqjcolkHokWNHCWE
	 jtmbWbJGZlqWxTjXU6HZOZHEGuHgJxnhcUF1BNsmbuMWOIHWgv07VTVskdKtja8ZXCmkB
	 UxpF7uCL8xoyvWyFXN6sMAba0GILAzrTEVCW1ShRj/29mGVDvGZeEv9+QU4IgOY27jcRy
	 tJ/H2R9yjtns+6QtDZ+sW97hWZcwWzrVZnU08TA0FOnKUU1s2XAwLBL3XDA6OiXhlDKfU
	 JPIcuhKaE/hLNMH2ccR4/sU1RJVFaQBCkCwOWLpg2v5VdMHprhcU8KhPZuNIhoaboTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830861;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SCcj5h5zLSe0dyOrnKtAgt4MbiV2gg3mZaAQUlgNZY0=;
	b=MudzsmQXOK9cUhZxazDygi7MOVbTYvEzbwGCS+gkepNPAvtcqb+3dlrLbnXI4TV4zRZI
	 KVKyL2s5Xpp/yDDProikjYf4AJME02U4PSJIb8DWJT6HpQQ+PxhMme/pY0fXyzxZJdo5q
	 aFgff24jxoSSQrwNL7vckkobBivxMujEvMv21vw4TH/pL3Jw6e3i7MLUNU0uqm8KJQ7Xt
	 Rbwg5RbkvJ0GiAreil8bAcM9k+8FGzqItA1VWH/U9xBDrgCIl7eafwk4xMbDBK13xj7Hl
	 gBMV7orlFnTraO7XFJI9wnfM4HjSmEE4JICX77KfV29GDc9OCwN//eAtKSfrhkHTEXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="L/mzX5wd";
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3B0606D80E
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 22:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC3B0606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L/mzX5wd
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5ec690faf85so397582e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 14:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793830860; x=1794435660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SCcj5h5zLSe0dyOrnKtAgt4MbiV2gg3mZaAQUlgNZY0=;
        b=L/mzX5wdQn3zVHCYNV278AXCcC8rjTwORSnobmsq0D4efYtpK0XXbTIeIG0lQmmNmd
         3QiHeSPm8SNw9aBnzHAS1699Vl7faKWDckss5wZYv2WOf3VBUERbFZQAf21/8AoDj6gZ
         MzxJOzEZa0OEmq6aIv63lcdSZb7EIGkIVHgr9R80l7yy/VisJdMEF2oKMasOJLzURKei
         oTFDjlGUqmBmKM6xlNrlMZ5nkcvr6NF2Vm9G82kBT0K34uDeAEuXeaP7vUsWtJS330A8
         z2v9KEJ0Vg7uPhoBdizY9AvWsE1VZLzWEUKnwC7WZ5SHmoM2PbiPl7F1TpTMQJH0K5G2
         8+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830860; x=1794435660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SCcj5h5zLSe0dyOrnKtAgt4MbiV2gg3mZaAQUlgNZY0=;
        b=ak5lbOwt7aOHHzvWe9Y5z3m4CD4tsmxpif9ThM19tweDokHsjlz1XaeahUsiW6OQYJ
         dzsTHjDtyKNJdDHaASjGmvSy3gjTqKTpkpQp/iex6QI7g3KwO4Nkqf8mvViu1RcKQpyT
         tqZnY5rT7CwCQuiZ73TgY/zMRaphbrwFNhW9rEWTP3NzwYDxCqUxdJ+b7bFEWfkqstP0
         Grx9DoPDZRRi+bpxtSrGwwnHPcKrLU6KzQyKlUAIxgzjhJ0BKHEMa7Lyg0QAL390ucQj
         F7dRVYybMGgcihFD7it18zrHtHP4B415TaYkQkNB2e0C6MpsWoPK319bqDrZ/njhN83A
         qUKA==
X-Gm-Message-State: APuU4Z8KRoD/exEqQyBOPpohFb4Nzvbt3QAfxO7TJvrv5GKdBKAe3btF
	vpqE/N/oTsnLBYKn2W6RZFaz8aZNKmBmjUfaMzeFtGTgxxtQNdnmChGT567Knw==
X-Gm-Gg: AYBFou1f0HNVTdD9PZhpEr7H7/98VCMqhMDI60X9VIKA32Lftngw+SIF2KIIYWc54Zv
	GgiJ8Q7s2kYiQBJtXzjY9qBaB9wU5/kIo59Pn51wcUUtmvi6zWFjhXtmX9GkxRvaIvwitJLBc78
	KKSV+L9qO/hPEGtSL/m2Fku149zfeeOfMA6iDWeP+ZL4/FdhVc6TECjtU02QeehKr8LSCzdXz8L
	wVqls7PjCnwu5DbgmK8dyAS7TOYVY9dK2fN2lMKE8kaK6KhhMijYjGDES7+l1wGQuI59yKwJvgT
	4Lck7PYhLsIwhqhnUOBHrg5eFHobtJYKkFGqbUqOTgTiJ9tLc1+YRKy6NKlU9USRp+pmNps6wsJ
	QVOzLSusVo6UDfUpkw764UzOq4mP69AZCU9xz+gV++2N1pJYVSK0iLVrsRiwZ7xOL9vPKuYLwwF
	2/4tBxRQaKnUhhQh8IJ/nROhxaOZW9Ka6ITdjUHKDmyL8WNpT4ILRsOUultik51O/5/Wzw+bN8T
	9XZjVNFxDQXJ6QWC6TeGG0pF8ZXcz7teTNexZOHo6MKgdKWILIDAudO9uSXQxJierMSphdMP+f/
	uNUncisvAql295C0dIdCxKLfDYZN9Thuy6qhXf37jmeXryOM9VC9KygmKObNQ61bxo6oFqac3Ch
	USjnvxbZ2FKi1MgbHu3TyXx2zVyw8c2oYQTOtk0xuusPg9isTH2HAP4HqpkZapsVXy6wlkToLHG
	DIZ3c=
X-Received: by 2002:a05:6122:e1b2:b0:5ea:91d2:32f8 with SMTP id 71dfb90a1353d-5ec68817bdamr7126177e0c.8.1793830859468;
        Wed, 04 Nov 2026 14:20:59 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca89b6568sm2852206e0c.1.2026.11.04.14.20.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:20:59 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 02/10] doc/iso-protocol: Document BT_ISO_QOS
Date: Wed,  4 Nov 2026 17:20:46 -0500
Message-ID: <20261104222055.1207928-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104222055.1207928-1-luiz.dentz@gmail.com>
References: <20261104222055.1207928-1-luiz.dentz@gmail.com>
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
 doc/iso-protocol.rst | 205 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 205 insertions(+)

diff --git a/doc/iso-protocol.rst b/doc/iso-protocol.rst
index 4d315132f911..8d87b6c3a35a 100644
--- a/doc/iso-protocol.rst
+++ b/doc/iso-protocol.rst
@@ -241,6 +241,211 @@ Example:
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
+``type`` doesn't match how the socket is used. **getsockopt(2)** returns
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

