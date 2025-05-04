Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFD725771
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 May 2025 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746374539; cv=pass; b=DzvnA9fyAr3eZeRBlLacUckci7juC2rNW9u19bK08pyxch8Kvhb9WKuRXsxYLUL4KC2Tgp3lZyWgmpiWsIhUAVGzvmjuL7OdS6KmWMp5gLnnKUOzx8rbWtY1CDZK+hB6tskDeWfNV2ies0D18WpmvFbeyqljkPbhfVRdmx8ESSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746374539; c=relaxed/simple;
	bh=mT0gdvBJeiu47wyrF8Nbef7AIzSwgfEQZO9pcf0k4Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qvTJIOqf+YSdmahA54pHGglIhHzKtW0uQFmbSZggZWaPh9Pe/ZcpCVtGs585BP8ESr3Cgt0rS+mAYf3Ey65OLmuvSbmyf5NbQ+8igawn+pxjxVgn/EzpOiuNjRvohhsuiBgCqjUJmb9rlrMsNDTM1smOsi+bpPI3QgYAdklDB0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=toRbJeF4; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="toRbJeF4"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Zr8YY43WVzyNC;
	Sun,  4 May 2025 19:02:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1746374529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M5ATRzSEdlEHRHON0Vd/Laqho58L9AH19ahm2wENUhM=;
	b=toRbJeF40gAO4VG3b6QouYEh9giv3qrRhm/lY2orS8rdw4ezSnAEA4ZLggqM+M5I+LdaiF
	3HbSXUsikQSbxEOwiZra2GKrZKt7RR/eXJV3hdvg+2uzIXqMqooBJuLPXndrDu4K6qr/vu
	XbK/3KMBwnkjATgYx3I6YVfMu4TAW7w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1746374529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M5ATRzSEdlEHRHON0Vd/Laqho58L9AH19ahm2wENUhM=;
	b=JSteS2rK8UDarrXIFn7cKvWS5lfSicwAoGj05f/2Z68/2nZr84sGRziRsBqAywd3DjMqZx
	6nKv44JTyiJqBVrYBxHv28JjR1CwaIy8x10DZ2g6k51wHfWSa1ml1SXGsc8gF74kByLyqa
	Fg5Kx5sCbdmdz++VTvT3aLxgIdK603g=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1746374529; a=rsa-sha256; cv=none;
	b=EMWMgdQpOUrsZKVL5Jh/IILgZ4N8vqz/7xIVUSUktMzNqySwhH+T6PqFRwFM22IFWi4+5C
	q1OitGER+pS4w4b0wh8MNgOjWvrkd/Kcot8rvhMGPZ6Oi9RiPLfw229CWyPshkvSGwU+mu
	L76r0TciT1sp++mD2JCVfb1N+vfSn1E=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ v2 01/11] org.bluez.MediaEndpoint: removing BAP streams with ClearConfiguration
Date: Sun,  4 May 2025 19:01:53 +0300
Message-ID: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow user to remove specific streams by calling
ClearConfiguration(transport_path) on the endpoint.  If the path is the
endpoint path instead, clear all streams associated with the endpoint.
---

Notes:
    Whole patch series:
    
    Pipewire side: https://gitlab.freedesktop.org/pvir/pipewire/-/commits/bap-codec-switch-select
    
    Tested with
    - Sony Linkbuds S: switching between AC 6(ii), 7(ii), 8(ii), 11(ii)
    - Earfun Air Pro 3: switching between AC 6(i), 11(i)
    
    TODO:
    - Enabling/Disabling while Reconfigure/ClearConfiguration is in progress
      should be handled better.
      Stream QoS should be delayed until CIG is no longer busy.

 doc/org.bluez.MediaEndpoint.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpoint.rst
index f2b830ab0..b81106f0b 100644
--- a/doc/org.bluez.MediaEndpoint.rst
+++ b/doc/org.bluez.MediaEndpoint.rst
@@ -109,6 +109,12 @@ void ClearConfiguration(object transport)
 
 	Clear transport configuration.
 
+	**Server role:** [ISO only]
+
+	Close the stream associated with the given transport. If the
+	path given is the path of this endpoint, all its streams are
+	closed.
+
 void Release()
 ``````````````
 
-- 
2.49.0

