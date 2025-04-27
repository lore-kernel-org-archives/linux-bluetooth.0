Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5231CE555
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745762651; cv=pass; b=KSmbJwZBHZZe6FS4vF99YEoNs3Sv07Pj0yTcBuearD8+/vesR9MAoqMifdXF5FSIPQ70jGPZ7sWNsclTGuVSYT2o8OtZcMdeAM6kbdVVTA4V4u5h4u07qUpY/btu3t3KMUk+Cw5g6qWIkQ09rDKJl5RVAl9QN+Uv7alNCN46ZLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745762651; c=relaxed/simple;
	bh=aHBbuLVhT9qECBBNC6u8yY1JkGVL9SOaB3FxKWj0ELA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aRNvcF158qBX9Jxuyk9YATo84E4Z9N885DMQ3twz//dDbqCekBizHdNP31GrwlFrp4NXNRXBs19Vbll2hNv9n+NdzhQZxH8ginhQzlCfFFaJZzDG+6DHpMfbZQ2pC+GZrchXYo3WX8i7PRwguHPubGAfW9vubiqOphifHRhvBxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=rRdQFfIM; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="rRdQFfIM"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZlpGT1r6rz49QK4;
	Sun, 27 Apr 2025 17:04:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1745762642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zfMA/smy0v+RqNoDkN6ZjdtXA+CZF+3tf8QwpkhPzAQ=;
	b=rRdQFfIMJFZtRG7fY3faLFVZqh5jcKKV2NinmVksIsRcVjih4Xfo8n4x7O86CjTQUjk1M6
	pDUzIC4mTHg37h9KjjrBnVtXUONVDQDbhej+tuynBJ0FXDG7M/dH/Jsvh8t2nyMrR/GldG
	JrB7cY8pGmZoEHO7Uz1rPnOflrzsojJSXo4tZZfC5BQdQrCk1/5HAHfyZwibZuCjqANxPq
	wDEo0R///WG8i3s81F9tglWSAXWacbvZyOw3kLdJTtCDxAj85EkAyujx1Axg4Y/+hkt/gO
	OQhHBkIhuClf6R6zOcFHJ8azePdiH+yGteYHaqrpzEj8lDq+TM7VxutiFRPkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1745762642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zfMA/smy0v+RqNoDkN6ZjdtXA+CZF+3tf8QwpkhPzAQ=;
	b=AzJyneOu8hRUDjVeKk+9cRCCF9TmK+6/sWfA4vUCWmrlXb54w1FojIgNYXanpWQqN5PCW/
	yyhgiCNJRsAYCPJQvJf1H8dnPb2jGAPDZ4dI82wJuHOkgOllboXwQDyuyYB7HxJGmXP3xU
	VD42WmLAADl+ZIEUrNu/H/MQmhnFt3yBIbkmf7L3bHjJNC/9590GODTWsa2XgS2RwyhDVA
	V7cNWwVgjzopWGxur2hPUwCgPmlT2HYfjv+YBT4Y/AqX7w/ze/pEetUaJd0U++LFMe8E0l
	LUTxPhTAsFzMJVhmOB9yjb7dsvjLxaiFqOs31AtKQMWGHvMHABkBcLbcICUMVg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1745762642; a=rsa-sha256;
	cv=none;
	b=e73/7QhESJ3MRy4ANntl5aiam5zSZVnC/hmThLib/qD8DjDov6xgbSrirysHk8o4LgWKPl
	YmRRgDswOnMV4D2fMZdR8q6Yz0aXVph2wGnw4CjSUm9BYM8yeMhrMw+bY2cUCbEmD1t1EC
	Zxhug5dCLO2vlZlm4zkSvpaZ0ztVDGuJiEgAlJW6dM97JHLowcRKMmSOe2m9R9VPaAfzch
	J8PdVVq8tMJ5zRo9LrHJ0njLdi3/7bS7r7TeTSaJL0EiDa1vvZntqqGpZrk6ExljPUM/hn
	CzY6RodplPj9h0r/NL+vRQWzi7D1wK6BE9vlL1GlzKMigl81LnaxpW+9aAqrGA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 1/2] org.bluez.Media: add SupportedFeatures
Date: Sun, 27 Apr 2025 17:03:54 +0300
Message-ID: <c304d0b98ed0ce4504549e43a99adcfcaca77521.1745762308.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SupportedFeatures property for feature information that applications
cannot find otherwise.

Add feature tx-timestamping. Applications cannot enable it on old BlueZ
versions without that feature, as it requires special handling on BlueZ
side.
---

Notes:
    v2:
    - mention user application can check tstamp types itself

 doc/org.bluez.Media.rst | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/doc/org.bluez.Media.rst b/doc/org.bluez.Media.rst
index ecd982652..ef13a56a9 100644
--- a/doc/org.bluez.Media.rst
+++ b/doc/org.bluez.Media.rst
@@ -7,7 +7,7 @@ BlueZ D-Bus Media API documentation
 -----------------------------------
 
 :Version: BlueZ
-:Date: September 2023
+:Date: April 2025
 :Manual section: 5
 :Manual group: Linux System Administration
 
@@ -131,3 +131,16 @@ array{string} SupportedUUIDs [readonly]
 
 	List of 128-bit UUIDs that represents the supported Endpoint
 	registration.
+
+array{string} SupportedFeatures [readonly]
+``````````````````````````````````````````
+
+	List of strings that represent supported special features.
+	Possible values:
+
+	:"tx-timestamping":
+
+		Bluetooth TX timestamping in media stream sockets is
+		supported by BlueZ and kernel.  Applications may check
+		kernel support for specific timestamp types via
+		SIOCETHTOOL.
-- 
2.49.0

