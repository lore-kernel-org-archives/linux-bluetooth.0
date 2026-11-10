Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349519;
	b=y85vO81liQNohV3euzlHGmQlAExn/dk41FXxbNUZRHvwGizlNQ55fELFyAT5/eVWfj2U
	 Z4arye4YZrB2/1/fb9VJIwdQuTyRmtWoS2ricrU36vrcadDOFBHeOyRrXxTd3v5mv4Q2J
	 OqUzV9Fovr9H3ic4pPegsgT7dy4CYYjON1+HqOEDUwpgzJ9ZhwD3seqlLF/BSpKYCrmSN
	 rP92kfp31cjYENV7F5wsNI7EVHpdZSCzKEDoWnMGpSG7c5Qia5OSs56OEY0fqNxxJ1NaC
	 oeGhZ61a2fsakxuEw8QtBE6lKYdm//QZY9h2m3h9G3g5NjqFmkfbKqQKkws9bDT4z4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mXuBDqXYFekIMnZ/s4W0ulTP+MzS9DTQLSUo8AX/8bM=;
	b=R7p6JL+Bk8Sb2oL4LJlGLctcQKge1Gj0NLpyO5jT5NAjkAeEWAOGFqb+Yt0cR30t+fmT
	 qtr3HIrmcFRj8aksNieci4xtML2IawiZfFI3XJrhBkJTo6tWfzg1UrCDqwv4fxiKJGbQ/
	 qjKZ+rfcaxJr1E3UhVwwL3n068l/nzNtNrFvWwX2ULrOTaNUKF1pT2VwPk4jSdIwSN7eD
	 67fPJrOo6Gavm1N3gDGsNB5t1duyVTRhs/Oyq4x2KkA+OVaAe9ABuhq8DV9xBahweljYK
	 PuJQyHJFPceVt/gY0vNNROtKXLO0RNwhs28hVC1CWiVxXmr8TOg4icH4no4Xf5WmbOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sfCcIiS8;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCF4606A32D
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACCF4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sfCcIiS8
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7cc603a168fso1022819137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349517; x=1794954317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mXuBDqXYFekIMnZ/s4W0ulTP+MzS9DTQLSUo8AX/8bM=;
        b=sfCcIiS8Tz3rrzncmFehH/LI3k4sNx8Ie71XaH2zoYfBfyl+Jl/XkYc+oJJaUuR02e
         fLengwwcUmik6YUDR82xOLqKNmoQVOmyRylX91Qgy03ek06KkwSaGslg2I+qt7jVJGzS
         vsqvUSbDTjSDGG/GCBN3jvDbBWpND9SeCdL1pozP114ygwsi46j9fP/HfAKpyWwmP9E9
         QvHGZ4ntPNEyBwDflfDDv/ad5l5btTo2OhRF9kzPK/XU1yl5P9VHOzbaL3OyIDYHhe6y
         0tB+apw5dWtwy2XWQZhnMcPzH0BFoBvzTj2dtGwqEcYnXif8pnrAm9IiBV2WRLwDUN7l
         wiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349517; x=1794954317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mXuBDqXYFekIMnZ/s4W0ulTP+MzS9DTQLSUo8AX/8bM=;
        b=h5uAyBnH2gGJdScF3ja5prkQftYnGRC3JTJP0+tqF0HoqIcHGQ3rdzQ5CBklb4oyvt
         swT1f1ZT/LPxLTPQDM0kbYsxNCvJSdqTFr4DxTJ+ZgnkNW2DKWS7ZJ03pKRcTzXervnQ
         jWrE+J9T4F2yEJ54VV2tqc8Ek8CGZDxI4MccCazymnP+eKoabJcUAMC1chKU/cvWbIbK
         E67tXAaJre4To1lR5xCYqskPyJ/H1SaCgYmW3VBbBzasDFroKOy7X/R3Uq+651xepmFP
         8t5bLriLwH1/dzLqHhIWNUj/weCz/yVoAfULepnzz8EuImoM1PFgNXafqdAoOXTp+0z9
         zN9w==
X-Gm-Message-State: APuU4Z8q2S+hRy6AmAahvYkdjQPs2L9sV9lheDMbj2wRUwnD9Rq5EiKD
	ZliIToqkZ2c55cYLeNAxFp0m/3+Cu3Pn7+USbH1aMWoBsOORNlWyV76vQX3NEA==
X-Gm-Gg: AYBFou21Ew82xtBRtiHspE6ClqeoyFkSb2GUlCLj772z1nGZ89Us1BagMZK9OVajqC6
	yJWvZkLaBWG+ctrS6lV1pQOfR+ztXWVkSQ6S3g0mBmaVTMcA7LGVwGmTIxz95eDFTlACpvv+KXe
	t49OlCZwzaitAkLCoj/KnN941kKaD/c6I9UjFTrRmd/0NkdM5CGLIKaVI0B18lyI5JIk2ua75Ex
	/cGRA94tRJqNFJH66NU6YyBJADwvygw8TToOodQ8lGg6ASQ9bqkmN9MMu9iELNHvNbYCA7AliVC
	qCZiTPamQCYa0hr7Tp16WnAXmXvSLnhmrI1gZaWjLSdlATe92DkPQdYD+3xG0BDY+UqEbZYxw9x
	Y8xfInZ9bkuE00LEuaCd8ftjSWcbp1MkYXTKxWY7g+yXKGuQPq3uaDqy4HhBZ2bnZIePc1RAaGf
	l/0n+vIDxX6kKLcWUp0SU8zVNmYh5+66bwmS1DkgGx67rTa/K09Odz5GiGuBXN2924/qhqqY8mW
	9CJr/oyZ+VYIyd2PfDcpbW6XwJMY6n34PNMyPWW7jc2V6pqQDIyRzUg6rP6u/Ue3zydiTrLOnmT
	PUav4KqxUFA3X9FcvDOisJVVxSIncgDb882as9s3FtkePWCSKMQFPnQp8oxPPbWuTrFDyN0YVRp
	tWMqCv/bufO6mv6Pq1Eh7u37U0EGiNTMPhOmSGPbD1XN9uSfko/yVGhzlkM1coUxIxwJ5QGsxpB
	b4a74=
X-Received: by 2002:a05:6102:f8b:b0:7cc:26e4:1943 with SMTP id ada2fe7eead31-7d5061ab85fmr131820137.28.1794349517412;
        Tue, 10 Nov 2026 14:25:17 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d30223977dsm2609190137.1.2026.11.10.14.25.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:25:16 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v8 03/11] doc/iso-protocol: Document BT_ISO_QOS
Date: Tue, 10 Nov 2026 17:25:02 -0500
Message-ID: <20261110222511.3011494-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110222511.3011494-1-luiz.dentz@gmail.com>
References: <20261110222511.3011494-1-luiz.dentz@gmail.com>
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

