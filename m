Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414482;
	b=djsGYkDs2l5lI42dO7UckEtliOtB4v+Im0b4UGrqFVCBghYP/2IfKEp7gEVZ0jMsV87y
	 9h+uwxoGurZe0pN5ERzkfTwgAtqz4iAAf8ap3KcgegPSNDff8thmGYN0kYIAWCI43SBEw
	 nZ6Bavw3Hu+ZOnpS3ywf5+loH//KC2s6ujU1ztmnEFzQbMs+AEU6yyD7A+aGqy467yJLN
	 znQCizSLUAnM+j/IDbppYdpGP/qm5wV7FOORLNwKZtqe5bbiu0GSFbixS3/AQTUmXOjJy
	 SwPQQynz6VrtCN0ZK90ytD5bN7KxFu0SAuPlXWhBfFWsjisbutWeQRq03uFxC0GasLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mXuBDqXYFekIMnZ/s4W0ulTP+MzS9DTQLSUo8AX/8bM=;
	b=JijfEpb+ikvN4+HtmjDwsCW8A/E2S/59Tvobe0jKyoBXm9i29tJ9E0ej/7OrAC58XmYo
	 +pHATtmoi0/DKovcCcwdjUlcoIyQrhLJGUYNT7Z3zW9ZzT9VjJmmdjgEyVE/e35vzWRDZ
	 yT6Ebuum5l22yzkFw7OjSJhYiEzehiOmoW54TC3r7XiQF2vvG0Sg7ma27ZbH0bp+SnkRY
	 X65NY+sPL06QPVl0ihi8vIg53GsLBOOEaohX7wYgjpEiTwYPvV32VkJDxmCypStbxOURC
	 zzJ7TCGg/YEOGKAsn7DYX9YaBkm9FOSaW1qhzsD8r/Hs6RNBhcKsnyaNSJibZtnomUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b0rcq63W;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D37606A330
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1D37606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b0rcq63W
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5eaf169fe3dso1032927e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414481; x=1795019281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mXuBDqXYFekIMnZ/s4W0ulTP+MzS9DTQLSUo8AX/8bM=;
        b=b0rcq63W4DaajFofiMwHCGqF5npfmSYJSNOSbBDHxs5JWSqxLyCEuzz3EBw4vV3DU/
         VLFDUpcNE0fA0Pyfz2B9M5ZUnlbiUVRwTaNffxoyz/vX20yaKA3eugoNMSCtPkULElaB
         7p8j08RsWxd+p9whimjAUOwKa8X3mAYm9gANTMfc1Zx+a5iEAbzTd+h9u+jRqN8LUOGE
         7KGLSYMBPJO7d9U5L+DCKQD5aMm0T6QDI4qhWwbVVsio6zVaScqZMRGaE+bMY5W+nlW2
         kFKgBRs3G8aLna3Dtk4tI972qbZmWr864sLKeWuXcvS+ViCaMpgDBHeCH00RzAOVgJvF
         NnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414481; x=1795019281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mXuBDqXYFekIMnZ/s4W0ulTP+MzS9DTQLSUo8AX/8bM=;
        b=hYdOP5OTi4ldhS6ub3LQ+YsxFob6xXviJwBxJR1dSPBjQSTGCg7G7mEkR4LdxAGsI+
         hDWa5tDJ+JI7VNsZJ1Sc9jUHjyWUPZ3kJ7eUQl2aSvWEqJqiagJQDYUcTLgyH4sS3WhP
         SdkzAQNDTv35yqt8k1tDJSPN0WUYVWgAHbCi9M7AYdKUZx8ZxSO9abSwmiYl8rHh8GFA
         1VnAPT3ntSO+la52nGGMBX+rVOsc0T0VxqOdDdDioLE1Ww+vIyhH4EwwSTIlCRQZh0rp
         lWqfiMDhL2Qv6Gj0s2usLYr33jGfX7//5p55YhB3z6gPAj2L/4FgZ8Bv2imOilR7J1TT
         dhJw==
X-Gm-Message-State: APuU4Z+hHbqwcZnvgL8kfZA6gunJ3DP72JDoXfSjFO4vCO07p7iFO5Ai
	jCJMNvriPklCFkmpnUk5CCMcQi9qREGecmoE2/JHkA5faTU1nT6wedRrRyt/bQ==
X-Gm-Gg: AYBFou22UNe7pDtdIX+KItX9Q2SiVzZ0jhIYL6g8X2a4j/T/apq5MzDFuo0PkObL7TZ
	UI+/SVpZiN+Xm2m31CjAePOIzxY68Cuc5gMc5yB7VyczjLG0qHPaGatITvoAKiZMIUcriGDo5Xr
	/faeT2ynKPj1QPcusBtnV+lmvMxMQW2V3zvxSCaJvXUhlMDwxls/yPT/MwG2uasx7UfkExIt+eV
	QW5gr9VgerUDe1C3jCXpnbHZL1SMTHcz2XsRtpAX1Sl+CZ3QCB+yTqbe0bOMJcr7OXNo47ZbLq/
	12Nso5QlKIBFDszOprzsjs/5Ya3RhqGHp1fL3P0BZfshlKOcPebsK7gREcMB5HGMareevhsdLRS
	OUDoWN/GDKkE9qocAq5om6hA0GkB09DAPTCNseMURRMqLH17QIIPs2Kk33mYm0h990s8BPI8Htg
	IYjAmroolWL2+6QvjeyqpTqRWLJigixBf5E/AytmNQXFpX9MojNNTAli3c6Sy5WkIo6r2HESCMA
	+Me9HPjrSqFnUrnmf31Z+GIq2EgkKhkifq92Scfjl/ogf0N7pe8PvwD7t+58VlLPc+jk//xTGN/
	A8/R+C3CprCM44IqLuQTTjIcgLczChRGL111UEOCZ56fOVV+5UT5HNEygMXPjBINojxxhwmJWZZ
	z5G2wk6Fh39Kg4HYG1BGmgo7mJb2ndUicXgXaQx+lbx/H4iDJhedPhSRoT64iYLsDkJ7Rpaw6Sf
	eGgcA6
X-Received: by 2002:a05:6122:130b:b0:5e9:6d96:aa38 with SMTP id 71dfb90a1353d-5ee1c419898mr1128167e0c.9.1794414480766;
        Wed, 11 Nov 2026 08:28:00 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c5ab918sm4007081e0c.7.2026.11.11.08.28.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:28:00 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v9 03/11] doc/iso-protocol: Document BT_ISO_QOS
Date: Wed, 11 Nov 2026 11:27:46 -0500
Message-ID: <20261111162755.3506226-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111162755.3506226-1-luiz.dentz@gmail.com>
References: <20261111162755.3506226-1-luiz.dentz@gmail.com>
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

