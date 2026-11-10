Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328502;
	b=H0lS6T8/Gx9TQvxXr2D+GI6p0R7H+0iCrv6mghGvcI09c3l6qKaLGih7kOvYFQ6AIIkE
	 8HnZnVhRMDJdzzj5g48hBQ3GO0BEF7JJ815Bk2jAnTcWktHg5MTiv5ZRaSiPaCajpcyqA
	 +rXBdsN21z3J/+jIIxd6+9jdQKI4ynjcsBkZEJqqVRf8k7XhdfXhYmTB8pQsskYtl06j6
	 uefOd1oo1+sM1VVhAmIHXyJ2f/JkmF1GD0umCrkN4a1zJwLoJO223mJR+DFNoT7M+JmiS
	 /eKRwbpX7Bv+obKZGOrwlyjV+Lr4pTbyS/kNjJTrF0DrnlxBI/X46ccImMn7sUVxX7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328502;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mXuBDqXYFekIMnZ/s4W0ulTP+MzS9DTQLSUo8AX/8bM=;
	b=EX/Bmc1hMMEOPK2PMe4UP6SvmJG+oOC5pzkNF8h3RrhTJPTzbXEeBMw40P31uGjUmEVP
	 7WGPtK7DV2BXF/NTZakNsAmGJGHscGhN2VS14Rvzal48aqdsbO09ENmEFmoo1fXAniEaS
	 lj4pIPdQpHSR0zoLQv2/Q/YJ0mA/EjNbi779VcmfpgXe6jPe084HW7mAXzT2iosxHm6m+
	 C35Mgv6CrEZj7Hf7Osd6vnpiYJ6OwpMyR2AcsibSUL4H4saSMB94LIkSfTvw/3hHKOQrO
	 SaknZEvw7FoIK3etE6pA7axu4LcAG1PqpAEHHJ2aKot8GRen6ZRd37zp9tfejltI1ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ylfRhUr5;
	arc=none smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A21606A228
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 16:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73A21606A228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ylfRhUr5
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9999f21f617so595285241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 08:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794328501; x=1794933301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mXuBDqXYFekIMnZ/s4W0ulTP+MzS9DTQLSUo8AX/8bM=;
        b=ylfRhUr5rS3mGZv2u4ydPB8kno/Vidf4HFs7w5RSzkHy8+SxUZzr7w9rwzM2ZPnIsO
         OIRqqeB/a0Wk9uWHaekO6EVeyyuGiWWdb4rrou2GFWOKcdxyJuHdTshLB5yqtRTPj1y+
         A6fWN4Zf7jF2etOFsxdGOgjcWZ7u8jswVDb+QoFmYrGOfKeObnq4k/BCgy1NR7syx9Xn
         0BJRvT9fgaPUZmfiN8Rrd6Iq3L+KPBwoP2xJOl8xHsQo/j3o8bX3ief8L6xWH9wxvEI2
         caRSJg3//kj3O6G7wTkB+KVwGS7IE2sexr4OE/lHHhxUZQfBaRmCO1qoHxH6AYdQR3Hi
         IRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328501; x=1794933301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mXuBDqXYFekIMnZ/s4W0ulTP+MzS9DTQLSUo8AX/8bM=;
        b=unjM1wRkyIG1DgGK1jRfZQM26KFhhLCgpsZ7w7EhL/75dDPF9KenKMHvuj8/1V/Ikk
         bgF3LlLVPNjhtDZPhS4htmBCBaPFFl08pyZhlEVkA8XceqgiZ4VbqOWQmpd25w70tje6
         XFWWh0/UGXo+EiQ2tbnOZ+d/HR/vSfhoBuqPy4J7vTnQRb8ywFNFS2pvkkZvUbvrVekx
         lCoz5LW+39bgmPJAZf3l3wimfHq2vOlpHeb5W4MW7XEMgsDS7soz9ACsUid2yMMti607
         PxZq9VpKJv5nRnl4VX02KF0YqOU9O03r1O9p8SfWzi+tBQMqmWf12SEPGwoqrLsatkuF
         K7vA==
X-Gm-Message-State: APuU4Z+wNynw9cAdMkpVTxT5kPMlUkuLpP1roEpsFr9pSq2sd5Qd4kGr
	2z3L5JEFjqlzc+4RceYpweGhifhz7Dx0zl8wqrrx7flnG6gogbiLNPcRLiQcaA==
X-Gm-Gg: AYBFou3tmmfRhKdfopZbKkBuUpDsKRWtBPNH1Xn9Qhhd7DAzYXPXFNibg904+Wr9ZkH
	aAG3S8gfZ0sCKNp29K6pIh318hMG0xfUBOw4L5L8TMvFZii67H29vARLNdar/i5R0XR6wUp+j/u
	wbyaX1feCZta7cIsZY8aKxvafMW+kYSghGyVbQ63zLF6w1RrHIQIH28sT0VMV7YlhNSFpBCZa02
	L0YPdAQvU5rwo2FH+EX9zgqjgsuTNfyGRy8ijXOiRB/aZty1RQAdS2v27sl3tQq7yeFo1PR5AYn
	PAegIdGscWjmuGNGbVt896ohtRcenkjwAKxWDEXhe9f+TOlTXHsrYY9M0fdlve37xb79If5D5tQ
	jw85U/paDXP1SKaUq8mlx0UWsg716nsu1UmiSHewFeYxZiybhyejOL7n1b3UVETaO77rENyrn4K
	0go9ZNpaVJhDekXSdhFk0alVgGE4fTrGzXJfsDvVka1Eg8gzbiukqU/J2qNIyLro/a0a/Ezu0kP
	xoRMq45PH5U87HDdOjiVApnzWeLMEqnnbSJ9DFXYDvmeK+TP8k/G8qf79j1ps+1YQsLEm9cD7qj
	i9Vk2eQx6bn7PCsqR2PIIw5mSw0fJgntxU07KXC8fe4psdCRaigBDyjH+j3kzI1LZMp9TIl2BO0
	AcoJ617AHxOO6tz+rK2r818R2HKhA+qfs117bibBrMmM8Z51bRteET1cXFqgWskPRTLId7GBwiG
	82QNY=
X-Received: by 2002:a05:6102:3e8d:b0:7d2:d45e:5c9d with SMTP id ada2fe7eead31-7d301b8e8a8mr1081910137.13.1794328501412;
        Tue, 10 Nov 2026 08:35:01 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d3023543casm1989315137.5.2026.11.10.08.34.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:35:00 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v8 03/11] doc/iso-protocol: Document BT_ISO_QOS
Date: Tue, 10 Nov 2026 11:34:43 -0500
Message-ID: <20261110163452.2649366-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110163452.2649366-1-luiz.dentz@gmail.com>
References: <20261110163452.2649366-1-luiz.dentz@gmail.com>
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

