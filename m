Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427632;
	b=DyYZJTYgQPa6EZUia6+BAxkxTsQ1HucOnV5oEpWibEEGbbE/HrWUxYn0WLWa8FUrIG1y
	 j9wgI6rmhi5gsaaxm00/F8P6Uzvd5a2USIcuR3DPDbZtflCu4HQVZ8IF2hxG1A3w1Ul/K
	 /mFza6/N8yn1jd9Q4WTuanWdzyDlL7uaKqL9n6i1gdmE0uuLK1WiseZWtWhhER7rdECg5
	 naJ+lrttC5jAH572pAxcPu4+Y9lgYb04rc74QdGD4BGxA7k0DWVA3khLDl5ogOmVpVrYq
	 VE/RXcj9zReKPjlOUR7wE/b9nGRuUAfGpJ0GNexxhUlKnhDFiQ3WGgbHgrCZ3P5Ks4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mXuBDqXYFekIMnZ/s4W0ulTP+MzS9DTQLSUo8AX/8bM=;
	b=0K/JIJJQi4pxwAOMyHTpgqiKvzWPrk6dTM8Ocp3XviGTlIueS8H/jSOTRbc7uD1YcrGM
	 bRYeuJDCcy9/hODvC9OwDBZt17/fymPiA6IdEeqdRGIwssxzuyZ8g98NdI9W+tLXgZih/
	 jja5f5DllDdi0x4EFzDuXK84FARjWwUpcXrysxzA/z6cpJoPnstXrFjeYDLiYwp1PLH/P
	 5dOQ7bbxPtTFT6pvH/4WPln68fL9SqDBwj/ijaioAnIQ5IGqwGHx4obZpiDU64mrZVkaA
	 +Rpn0mEjj1kglzpsgn1FB0LQh3R8nazxY2Q4JtwYMh/JIGWyFczTlWOfbPmE7r7sVbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="iT9h/wJg";
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B5F606A332
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36B5F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iT9h/wJg
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7cc0ccc2fddso1167952137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794427631; x=1795032431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mXuBDqXYFekIMnZ/s4W0ulTP+MzS9DTQLSUo8AX/8bM=;
        b=iT9h/wJg4OXpn5p2ibNxbUwOww2HcFkZBjTS99RklBx82T9UevwqRlO5xsw56ftLsk
         QKRvi4uC3I9cmSNrBUXMt6vHSmp6+0lHsGj04gxPWTOuYIreSVkgNiZD+2uU2OlHzb93
         bLkSQdRZO2JILkssbrrovAnQwBEkTfi0WT/8MMICceGqXPsYskD6Jx/thBeCN7P1gJnz
         U3A8elKNT31IJnsbkKjElp4s6gzwyX718LDh1BMcDao65Jhr3F8sDNifMZmSUj/gjw+s
         FTITXEbOAuuiIiF+ir8vP9d4NeHVoWtiX2OX4VOjQFeo9M340FXWY6kVubknRzdN5HNv
         cq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794427631; x=1795032431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mXuBDqXYFekIMnZ/s4W0ulTP+MzS9DTQLSUo8AX/8bM=;
        b=FTPndP+qx4tqz+Kf9ZYn+bJM7Uc67KJgDdwcd1CFqoiaD3rfrihrGXn96YcEVkpHvJ
         1BNsqHlthG66zeKVQ4z0xto+SAT3yNOD5cvwHGZO+ojGUGzH0msK1JkRDIfKFt+c7cqr
         S5oIyunHFMJo7tdwsqm1nFFeGc95U2cv05UjHuvZFXwz+1kEPd6J+/CX5oXKoBIQETRv
         U6Gur1caasA+doq42410iS14uKHqJ0JlLlWENvcmyQGNuNp6gn46iScFj7h/y0M/B0TK
         M9yCakVpzcuUVyzFGgUkPbl0wX+c6uQU2fUz4plQIhGYhJuFSdITmPaYd/q2h1agnOMM
         EBWw==
X-Gm-Message-State: APuU4Z/P5YQbmM8AJp2E56TeapMbcETKyM18Qct8yr6hrCm88aGkl6mi
	8cFHKtn5EUAi7fvUSekLhTZAjcdw8ImOIH2KZ17NJ7nAH5CsuTYVIMESuytzfQ==
X-Gm-Gg: AYBFou13vOz20SLh1EOv9ljF4oi9aWesBdwmKaBZfuf3PtaqCE09by6pmSytCd9DzYI
	Yrf4x73MEMZcSq6R1RdqDzWPzB39t2X8scJIeKitsmcXYiKSGuR6W4Wv7n/nnXuDn6nsz4vY3iw
	FufWEYwdgb4ESzin//f1DBSNrbYaK/T07L7mO8RmzXBlc9CvNg+OwYH8o9fiCY0lP099B2UVVSA
	a8A4G2nOLC29kmtMOxuxEnutjp4If/eKtcnT9ah9RvhruFp+MCNfeDBPV+rak7YsUNBi7nKVk/2
	57aASYfAZE9GAS5XATVB5PsHktTuKVnEU+CA07cAnK5k9fYAnGu58VoFTYtK5r8Vd7gLlopJuQJ
	SYs4RKuqNkUr7X27mCO5vIyXFKb65Pz8JVZHatU/xXp8M6o/Ezwzuozr+M4QekJohGjJ6TlHmyv
	3Sls+7+JEAGTbDdcVmpiP72VDlsKhI69eTfExspMfNmQDcz7yiu+ZpDmlTb0PrtEdW9lXgshW8b
	BAib6U5BEkFjKAbKgydRzbL1LW+w1RRK2aiil97ku9Nm1rQO5XtB58mXsNF1aaWrmXfCWO71PvL
	4aUQn8H41Ym9nvXwl0Gyo6b8OYhUEOgQQabPerAOdNDzkqzHtTLp8sNCwCG5+mIiz0h7F7V8DIy
	cIpH7anuYJ4irEkE/qE0OYiR3f/sCQhfuYjryYgsDErGYlV1WQpepklRLhsQCAFr2ympum4fPwm
	Hw7kx708h7DiIO5XPLY8FI9JD5
X-Received: by 2002:a05:6102:f9c:b0:7d2:d45e:5c9d with SMTP id ada2fe7eead31-7d4fb257b3cmr1315630137.13.1794427631022;
        Wed, 11 Nov 2026 12:07:11 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d30209ff97sm4954449137.0.2026.11.11.12.07.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:07:10 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v10 03/11] doc/iso-protocol: Document BT_ISO_QOS
Date: Wed, 11 Nov 2026 15:06:56 -0500
Message-ID: <20261111200705.3802779-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111200705.3802779-1-luiz.dentz@gmail.com>
References: <20261111200705.3802779-1-luiz.dentz@gmail.com>
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

