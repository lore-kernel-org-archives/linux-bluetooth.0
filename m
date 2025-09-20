Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B171B423C
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Sep 2025 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758360058; cv=pass; b=d1uFMm0zASXn2wP384Qeta66idsreZftOjFtD4tQbv6rCxri4T6X/D8FgHQ9Yt9ZHW6bUpVs9Kr75zBFfLzUMxOL/7LJj5OUAByDE/a9bLqbBkKO7MRqFoiuv723hlvvddru1A6hN0G+xFC2VzXCDdyntiZxfUcN9EYML+/m7vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758360058; c=relaxed/simple;
	bh=Zkf6RqbkBC1e5rvSTzSi5olFAxeHtRWkENjsW6etxEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sSlJeu/dqgUlEesHX2bhTCoVKbgX/nYNwkL+sjmdC0Yx8prQUnl0BaWkkdBV051glTL7/ILwpGz1q0pD4YtxKAf07L1nsamYmxWs0jgc3zCAac6iFRhVj7YJJx6F+1ZeEqfPEcm7DxB633HhLTEcy7HXexGIiibWlrN1FglHMh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=M2IbF9M8; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="M2IbF9M8"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cTP4B35SFz49Pxd;
	Sat, 20 Sep 2025 12:20:42 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1758360042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bRT6G0ghESOJ/mCJgWX0L4NB0dINO71tt26qHus3ZGk=;
	b=M2IbF9M8t2RCbbCAMtb/hoDYErtLdWBHjRwk2Be8sEt3NIYyX5vwf4DGnVqvXtuPyOPrJa
	qWb2Qpo/qlqjPHiDZPB+uygr5rMYXxVI4znyyX04byW65b72G6coZUxek14w9zRuV8x3Gb
	te8khr5MWHucSWK1Nz5yNGpdDi49qru34wiD9IL527xlc0aBIRzZEB6rozcsk4H0aS6W6d
	zcahBKyomQroU+t/cj/k7V/a4F6VBlI0oMKJv4UkrJ5oHPQv8fUy2hyFXw+dEN8qJ6vIX6
	JOmH8nBD3krEGyv4qR+OP9ud1yViMl/OsN3DydIxj+sMUyP5qJ1kKr6vNue/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1758360042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bRT6G0ghESOJ/mCJgWX0L4NB0dINO71tt26qHus3ZGk=;
	b=oBpMKkH3aV91aHO/uF/+z9b3Pa1PlLF3dAZdRRPg0+gh8swXb+X91i7weoK+9LTFuvfu7k
	Z9wtYWlcI3EUjpQnkh3rVVXgEKAcCW1yOAl+cZZnmQHOqJz3jkHVyhUNtEY8GAONl2CrTQ
	u6JmPmQsMNbU0wGapojWuo5A2WzfAE4f/RdqM8JCe+qE5bOpNOkcAzAZejIXG2JoIa4nrW
	B7SOuGDv46fgnJLmpyeDCYzgmwPRlm7g8N2IyXecAOcDnnXGwoymY+HIRHEN4txtLD7Exn
	UxwNRpxaGU8AQoenSspCYzXRS0q6zaFuW0TsowjSL3lPr1dKsEtUjRHzaRYRrg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1758360042; a=rsa-sha256;
	cv=none;
	b=kTY41BP0cOIQjV37VMw6gAMZLu3RvXgmJg8f499wiJdqW8O/nFihTMTUf5ufvdj8PWelF3
	vSpVYqM+r/xlBHQ3sOseFrF36zrFdeGaU6uFvWpL/lG6CCjbAdf8/xFzov5eBxYgGZvmRK
	H6H3yaHlgYZTb47zCCxN/ykCzvv+dwCsPzeA6uI2Uv9FgAY66WIvY8nXijQb8LgBaVK+wx
	HF4Wh36mTsUL81xjFkg/jUpnD/dr8ueNK718eUmbK79D+BiWi0J7GPZOWjvPu1zvxk5sUu
	l4cMn2FG6IX7dK5IPUXCKd+2lBvPAHCZTsb45nS4we9WDBZPpoEDsKyg7datfQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] doc: iso: add BT_PKT_SEQNUM documentation
Date: Sat, 20 Sep 2025 12:20:36 +0300
Message-ID: <5ad48176668987b22fb71be24cf4e478d0869dc2.1758360020.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 doc/iso.rst | 76 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 70 insertions(+), 6 deletions(-)

diff --git a/doc/iso.rst b/doc/iso.rst
index d08b60d20..2ad9c73e4 100644
--- a/doc/iso.rst
+++ b/doc/iso.rst
@@ -250,12 +250,76 @@ received packets.  Possible values:
         :header: "pkt_status", "Description"
         :widths: auto
 
-        **0x0**, Valid data. The complete SDU was received correctly.
-        **0x1**, Possibly invalid data. The contents of the ISO_SDU_Fragment
-	, may contain errors or part of the SDU may be missing.
-	, This is reported as "data with possible errors".
-        **0x2**, Part(s) of the SDU were not received correctly.
-	, This is reported as "lost data".
+        **0x0**, "Valid data. The complete SDU was received correctly."
+        **0x1**, "Possibly invalid data. The contents of the ISO_SDU_Fragment,
+        may contain errors or part of the SDU may be missing.
+        This is reported as 'data with possible errors'."
+        **0x2**, "Part(s) of the SDU were not received correctly.
+        This is reported as 'lost data'."
+
+BT_PKT_SEQNUM (since Linux 6.17-rc1)
+------------------------------------
+
+Enable reporting packet ISO sequence number via `BT_SCM_PKT_SEQNUM`
+CMSG on received packets.  Possible values:
+
+.. csv-table::
+    :header: "Value", "Description"
+    :widths: auto
+
+    **0**, Disable (default)
+    **1**, Enable
+
+
+:BT_SCM_PKT_SEQNUM:
+
+    Level ``SOL_BLUETOOTH`` CMSG with data::
+
+        uint16_t pkt_seqnum;
+
+    The values are equal to the "Packet_Sequence_Number" defined in
+    Core Specification v6.1, 5.4.5. HCI ISO Data packets:
+
+    https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-61/out/en/host-controller-interface/host-controller-interface-functional-specification.html#UUID-9b5fb085-278b-5084-ac33-bee2839abe6b
+
+Example (Enable sequence numbers):
+
+.. code-block::
+
+    uint32_t opt = 1;
+    if (setsockopt(fd, SOL_BLUETOOTH, BT_PKT_SEQNUM, &opt, sizeof(opt)) < 0)
+        goto error;
+
+Example (Read packet and its sequence number):
+
+.. code-block::
+
+   char data_buf[256];
+   uint16_t seqnum;
+   union {
+       char buf[CMSG_SPACE(sizeof(uint16_t))];
+       struct cmsghdr align;
+   } control;
+   struct iovec data = {
+       .iov_base = data_buf,
+       .iov_len = sizeof(data_buf),
+   };
+   struct msghdr msg = {
+       .msg_iov = &data,
+       .msg_iovlen = 1,
+       .msg_control = control.buf,
+       .msg_controllen = sizeof(control.buf),
+   };
+   struct scm_timestamping tss;
+
+   res = recvmsg(fd, &msg, 0);
+   if (res < 0)
+       goto error;
+
+   for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+       if (cmsg->cmsg_level == SOL_BLUETOOTH && cmsg->cmsg_type == BT_PKT_SEQNUM)
+           memcpy(&seqnum, CMSG_DATA(cmsg), sizeof(seqnum));
+   }
 
 SOCKET OPTIONS (SOL_SOCKET)
 ===========================
-- 
2.51.0

