Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4585E2AD00
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791751247; cv=pass; b=dPM1PJU9nQKlRNm0m5qkIeb4rsIAypZRrrJD3qyvPo6fq7z8EiLI146TZdU9ukbOkgaVUZ3zg5e/LLv196aJYtZEB6mmp/L2kv7xrz62K8lQGK0KhGZIgZy5WZzV+h71OpiDN2lp4M6kbdjIpYJAI8GTM22bVZCt3Qb6hP0zdlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791751247; c=relaxed/simple;
	bh=KKcDXO4VvDqnONGqfOweaikItQh6s0IPT/NqI+EWF7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgZfwTJeVR8ySIckUxuUqy3DlkvGAE32SJ3J0Va9hHtFna2eSotFFrt9x7Y68uDmGBaUqMzC/D6LRuav4mCac7f1NmaDin5G2fhXfI4JtlXoNkAVCYVhlf+FNDBTydybGuFeQ8SF90uSfv2mw92+LcnMf9E/dnTulk8yZMJmrxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=n8aF/nin; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="n8aF/nin"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4j2stb74mJzyjt;
	Sun, 11 Oct 2026 23:40:39 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1791751240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e4bF1EiErHG3LDspQloRHoRpy0DPKFl9SmId2/ojcog=;
	b=n8aF/ninC7ox7//r5p4Sl9lYxvc8eGN5871vjbibisYl/p9ZhPBqbuknAfw+AGzG5PpqMX
	diqwpmnG6o5HNQ5HfSQjj8Un/vUTouf5C26o3D+FNgG5jhcpytqSKyyQvdpp55fgwO8vZG
	E5v+ONp1pmImWrlINcvbPjyAN7isaxc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1791751240;
	b=A4uDE33rXvSNsm555LxaA/8HkPg+zdFQBTqOxNjcBh+Vc6x7Fs14A+3SMQL1i1UAFfTsxg
	9sGS0DCz0n67FnxhapeZJd/SsMN3sZfZZGNZTMONYjlXR9Mp47FF1t14mwODAStNpTaUk+
	OP17s/gkVR9aKi4eTRKNT4To+7e6zs4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1791751240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e4bF1EiErHG3LDspQloRHoRpy0DPKFl9SmId2/ojcog=;
	b=Trm4/pWOlWgs2sFTogqByhYPq+TfsG0hTUf/PUlTGi41hAgMFHQ6hkz9qFvh/hntEsCC8I
	NFKnF9aEUSXTlaitGtcWGTjRMcul9rOTc6mk5bDl9jtt0IIa6PozSljRXIQ1CATPYowCqm
	0HuVYgJ/bqQgfPBnePfApH2EV4/wIGk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 4/5] doc: iso: document ISO PAST listener readiness
Date: Sun, 11 Oct 2026 23:40:18 +0300
Message-ID: <fc863afc9e2c71d83e2d350ef0ebceffb6b26554.1791750393.git.pav@iki.fi>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791750393.git.pav@iki.fi>
References: <cover.1791750393.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document PAST receiver setup and waiting for POLLOUT before requesting
PAST. Describe the read-only BT_ISO_PAST_POLLOUT capability query and
handling kernels without readiness notifications.

Assisted-by: LLM
---
 doc/iso-protocol.rst | 81 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/doc/iso-protocol.rst b/doc/iso-protocol.rst
index 4d315132f..7e98374c4 100644
--- a/doc/iso-protocol.rst
+++ b/doc/iso-protocol.rst
@@ -145,11 +145,90 @@ Advertising Sync Transfer (PAST):
     /* Rebind already connected socket to PAST address */
     bind(iso_socket, (struct sockaddr *)addr, addr_len);
 
+Receiving PAST: set *PAST enabled* with MGMT *Set Device Flags*.
+
+Bind the ISO socket to that peer and its advertising SID, set receiver
+QoS, then call **listen(2)**. Setup is asynchronous: wait for
+``POLLOUT`` before requesting PAST from the peer. ``POLLIN`` indicates
+a connection ready for **accept(2)** as usual. On error, ``POLLIN`` is
+indicated and **accept(2)** produces a socket in error state.
+``POLLOUT`` is not necessarily indicated on error.
+
+Signaling ``POLLOUT`` on PAST ready is not available in Linux <= 7.3.
+Query **BT_ISO_PAST_POLLOUT** with **getsockopt(2)** to check whether
+this notification is supported before waiting for it.
+
+Example (``qos`` contains the receiver QoS):
+
+.. code-block::
+
+    struct {
+        struct sockaddr_iso iso;
+        struct sockaddr_iso_bc bc;
+    } addr = {
+        .iso.iso_family = AF_BLUETOOTH,
+        .iso.iso_bdaddr_type = BDADDR_LE_PUBLIC,
+        .bc.bc_bdaddr_type = peer_addr_type,
+        .bc.bc_sid = sid,
+        .bc.bc_num_bis = 1,
+        .bc.bc_bis = {1},
+    };
+    struct pollfd pfd = {
+        .fd = iso_socket,
+        .events = POLLIN | POLLOUT,
+    };
+    int past_pollout;
+    socklen_t optlen = sizeof(past_pollout);
+
+    if (getsockopt(iso_socket, SOL_BLUETOOTH, BT_ISO_PAST_POLLOUT,
+                   &past_pollout, &optlen) < 0) {
+        if (errno != ENOPROTOOPT)
+            goto error;
+
+        past_pollout = 0;
+    }
+
+    bacpy(&addr.iso.iso_bdaddr, &local_addr);
+    bacpy(&addr.bc.bc_bdaddr, &peer_addr);
+
+    if (bind(iso_socket, (struct sockaddr *)&addr, sizeof(addr)) < 0)
+        goto error;
+
+    if (setsockopt(iso_socket, SOL_BLUETOOTH, BT_ISO_QOS,
+                   &qos, sizeof(qos)) < 0)
+        goto error;
+
+    if (listen(iso_socket, 5) < 0)
+        goto error;
+
+    if (past_pollout) {
+        if (poll(&pfd, 1, 5000) <= 0)
+            goto error;
+    }
+    if (!past_pollout || (pfd.revents & POLLOUT))
+           notify_bcast_rcv_state(peer);
+
+    sk = accept(iso_socket, ...);
+
 SOCKET OPTIONS (SOL_BLUETOOTH)
 ==============================
 
 The socket options listed below can be set by using **setsockopt(2)** and read
-with **getsockopt(2)** with the socket level set to SOL_BLUETOOTH.
+with **getsockopt(2)** with the socket level set to SOL_BLUETOOTH, unless
+otherwise noted.
+
+BT_ISO_PAST_POLLOUT (since Linux 7.4)
+--------------------------------------
+
+Read-only capability query (option number 23). **getsockopt(2)** returns
+an ``int`` with value **1** when the kernel supports signaling ``POLLOUT``
+on a PAST listen socket after receiver setup completes. It reports
+support for the notification, not the current readiness of the socket;
+use **poll(2)** to wait for readiness.
+
+Kernels without this option return **ENOPROTOOPT**. Applications running
+on those kernels must not wait for the readiness notification.
+**setsockopt(2)** returns **EINVAL** for this option.
 
 BT_SECURITY
 -----------
-- 
2.56.0

