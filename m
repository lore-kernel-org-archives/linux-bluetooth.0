Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89D125A2A2
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765018903; cv=pass; b=nsNkHNTFm5VQCb+UubHzYTf7318cS2JmL5AveI4NPcj7VUfOfbk114hXl78Dg67IZ1EEPDLXPDdVXAXMt2A/LBKG94NG+cLtSaW9YuE7jXO9Xw6PG4lQ4o5K+cgHzbjDD7dkGPksqQpvu5G8biglhR1JRFAleQHEbBAapPoTUYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765018903; c=relaxed/simple;
	bh=Fn+ynrvGA8pZNQDKPH3O50Mi8A3cr/Rkkd0aQkadlUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Az8Cp8CHdGwiE0Wm2eSbNhI/+R2FHJZYTEaqtUnJcW9doJvegPVhr+WushDFmBP211Beuy3SJhFd6Ov/09INg4PX0FEyVBPCf+llahkrjC59aBhwKsQumz4r94xcpmuargLPiWUBi/+4JvmlsNqxS86L/pDKy8i2QNs8iBqThEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=k96mstJw; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="k96mstJw"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dNlg12CXSzyYb;
	Sat,  6 Dec 2025 13:01:33 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765018893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+MvEEd6R6/AC33zmIRBqpy31YkB17s7IFtJvzEwc9EU=;
	b=k96mstJwhdcGt3dZ6uaKQ5mikt9b0cv7AOMr/eFvnqzedi2/wQ1MPKLdpsHBpZbrXeyi7V
	17W4HF2Z4NR6PRtT9baHDWwEL3X3GRE4kEvMdh0CK6qp9BRu3dr3Q6NJ4AXANBlRSVL184
	ORwAni3GBowbAAFHbmtxdgLpbj37byA=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765018893;
	b=twpuovoxrDox1uEjgxYIRrKfsOaJWxJQS/WFDDcphRn09sa5cfhAANgYQPF6e1R9VdJGx5
	09hMPZvvgQ03JiVoiK/JaFnx74fU74Upnw9PIMITiylXBF22xq/PewK7HCJZOcb7KcpIhL
	yk9LX1hLWjCotDcjEp0WhIp4pLsAE0E=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765018893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+MvEEd6R6/AC33zmIRBqpy31YkB17s7IFtJvzEwc9EU=;
	b=svYL4yx6ETP406s9u7xJRjDEOc3OslfodPcQe7GGbmhzxdwa82uMAJU0ozKuZCDBC9ddQf
	z1R1UDl0gevY/kz5UovjVJI2XHzKBAx7ko3qdXJz4nyj587aem/fJcbvGVBfncyuSnlZ/B
	/25d5rA30ktSldCElcV/XIecfb8ZwuA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 01/11] lib: move VCS, TMAS, GMAS uuid strings to uuid.h
Date: Sat,  6 Dec 2025 13:01:17 +0200
Message-ID: <c65bf870d8bc9813523302d28eb99b101673285d.1765018766.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765018766.git.pav@iki.fi>
References: <cover.1765018766.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are needed in several places, so move also string version of the
uuid to uuid.h.

The naming in string vs. uint16_t uuid is not systematic in this file.
Retain the _STR suffix to be clearer.
---
 lib/bluetooth/uuid.h | 3 +++
 profiles/audio/bap.c | 4 ----
 profiles/audio/vcp.c | 1 -
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/lib/bluetooth/uuid.h b/lib/bluetooth/uuid.h
index 82e948a23..805366c3d 100644
--- a/lib/bluetooth/uuid.h
+++ b/lib/bluetooth/uuid.h
@@ -178,6 +178,7 @@ extern "C" {
 #define BCAST_AUDIO_SCAN_CP_UUID			0x2bc7
 #define BCAST_RECV_STATE_UUID				0x2bc8
 
+#define VCS_UUID_STR		"00001844-0000-1000-8000-00805f9b34fb"
 #define VCS_UUID					0x1844
 #define VOL_OFFSET_CS_UUID				0x1845
 #define AUDIO_INPUT_CS_UUID				0x1843
@@ -213,10 +214,12 @@ extern "C" {
 #define MEDIA_CONTENT_CONTROL_ID_CHRC_UUID      0x2bba
 
 /* Telephony and Media Audio Service */
+#define TMAS_UUID_STR		"00001855-0000-1000-8000-00805f9b34fb"
 #define TMAS_UUID				0x1855
 #define TMAP_ROLE_CHRC_UUID			0x2b51
 
 /* Gaming Audio Service */
+#define GMAS_UUID_STR		"00001858-0000-1000-8000-00805f9b34fb"
 #define GMAS_UUID				0x1858
 #define GMAP_ROLE_CHRC_UUID			0x2c00
 #define GMAP_UGG_CHRC_UUID			0x2c01
diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 4c7b8fcc8..9cd649c7b 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -67,10 +67,6 @@
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
 #define MEDIA_INTERFACE "org.bluez.Media1"
 
-#define VCS_UUID_STR "00001844-0000-1000-8000-00805f9b34fb"
-#define TMAS_UUID_STR "00001855-0000-1000-8000-00805f9b34fb"
-#define GMAS_UUID_STR "00001858-0000-1000-8000-00805f9b34fb"
-
 struct bap_setup;
 
 typedef void (*bap_setup_ready_func_t)(struct bap_setup *setup, int code,
diff --git a/profiles/audio/vcp.c b/profiles/audio/vcp.c
index fb2aff6ce..277c9bbc3 100644
--- a/profiles/audio/vcp.c
+++ b/profiles/audio/vcp.c
@@ -54,7 +54,6 @@
 #include "vcp.h"
 #include "transport.h"
 
-#define VCS_UUID_STR "00001844-0000-1000-8000-00805f9b34fb"
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
 
 struct vcp_data {
-- 
2.51.1

