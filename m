Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A995522A
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745771141; cv=pass; b=FJwSLIPMVdrpPwYMns8sco8sUsE+U70KQGVpiZoz0vagPvEb0ve6xrv61F6oFu6xFzfIhoSQz9Om/CWFiDtM2lCzjQJFRC7S2133BMSS+Eh8kr8VFu98PSJP8kX5kFTAhaxgT3v4EpQZ7hZ9Yd2udE+HDKfDQGFNJNsQVCwix/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745771141; c=relaxed/simple;
	bh=rV41norhLiG+J8T+84wDMBsRNlfVTZzzRFBhjW5ptcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JrRoVcksKl+1WSR3tuo40DHZiPUKySmu77yujQM9yOMH/31Jof76f7pWg0mIRnEBruGYTHDysv1jtCXMR+3mMkTOG3IZ+lzItV0uIN4RwPsLbWAlVksAexUEv9DHtkU9EFC4v96sZd1ZzXnuOaaqTr/yn+Vu+/62nyGtGLZSNCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=AYhtlMPQ; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="AYhtlMPQ"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ZlsPp3d62zyQD;
	Sun, 27 Apr 2025 19:25:34 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1745771135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SIuncC0CIYOMaivsZTAXrPQaejvomTI8jmDi02vU19o=;
	b=AYhtlMPQgxjCHZST8kASjlkbGTxqHHU9uGfgsQgnkZRyMgoaq01hTSesk1CuYI09hDo2eB
	qkkFbPT3cOim+xd6UfwS5uFndIcDRzzttsRzevR3Je6J5cQcvwEx5oQ/5OCZgiESTPD8SF
	5T68AMm72A6AFPHHltlj9KKGg1yuPBg=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1745771135; a=rsa-sha256; cv=none;
	b=G0zUMeLvlArRY+yf50MoPYpiCkhPXDytms8RkgXGvSwpp2EFXfOJ4Rg99+XVNLzWdU6os9
	9v4ensfg/sIZt+R/QdApUA3L4EnIToDxNPcoAa/nWYR8KTekXyeGXnZbm7oAw3zlTTfZaO
	arqPBgppKnCpx4ew6TRqfKksE3BqQGw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1745771135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SIuncC0CIYOMaivsZTAXrPQaejvomTI8jmDi02vU19o=;
	b=SJ4Vc7XFYbpHg28M66zsSSO8X7Hodny+QqsFWPVhJNUb+QnEjaR8XpDt2TitTY1MV3Mxby
	Jpu2/6bytRx7YbM9jWBspmxXaWQttiHnQqUD4OOLV/MhFzjlA3dLdHXPONU83FBU0rSRtN
	xCki+ZfFru+l5CXe8xxnGKXRqavWLb0=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 1/2] org.bluez.Media: add SupportedFeatures
Date: Sun, 27 Apr 2025 19:25:29 +0300
Message-ID: <c304d0b98ed0ce4504549e43a99adcfcaca77521.1745771127.git.pav@iki.fi>
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
    v3:
    - no change
    
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

