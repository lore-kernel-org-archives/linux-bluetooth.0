Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F1425FA1D
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745233527; cv=pass; b=R+R55K8KrrCx56JA9Dng4WQ6fbwtM+BS2SqN373u9TIyy1Yg9ZWb+Nd2Of3Pr2OBcMcPLCMxSvKtF0tModGwKxUP9wH1GjoQDM4VdpfMjRat7tkZ10pw9VmgdQ7u3zk2hVe9+WSub4DOBOLOAFeSHrE/tbNiotJnyH9j20UNtjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745233527; c=relaxed/simple;
	bh=i1CS/0qEe8EA7gnJ1f4taCyLAzKw4Gc1vdfQP1glISk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kblmqIa5PwmcQLLPXWRSszDZAqXrzGbXAP4KDVkjbEnflysfJwJotrLOLO/oz+qSZZcaCuxpBdsiEHSjpdwPX8wCfQxMSyRNiBHi4/1fpyeqhX4IgMFJ5yM7b12S8GIAonu+BbTPCyMa77cejpGQXfMyTx5pF3l4VMxEB88e560=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=hFR1XUmb; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=A47YMYaJ; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="hFR1XUmb";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="A47YMYaJ"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4Zh2b06k21z49Q5l
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 14:05:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1745233516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TnNvl7Tqo0FcWKW1uYS/pZx6za1f0Zj7zLNY4494PLc=;
	b=hFR1XUmb7SROSEP3PXHA+EPfh7z4dOd2Q3yTfwiRwei1HBDXWZt0Y+uuGMAgLe1473GFkq
	6yUz1aIyIuXnebtloBn8Us/S2+z+6xo1nwxziJTOZ5P94ncm8Q1esxJiZzYnNk7HSJP+ro
	c0vADnG0LlLJGfx74nP5W94zuLu4ZCPEbuvZ6jAwawLO1cd06m8Z+Q7e8SOzE5RRr4hA0/
	3CHWHIIqGMLL6ULyNZob2tXe6adIiIjYRMfzUHRFE/7a9l8D5VKuf15UQRSTjJ0YJ1Vug0
	cDOPEx+YwLmja/miuQpK5gxUs4BNcyQlVyNyilQFRXvidBEk8NslKNM3oUmWsw==
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Zh2Zr3hRZzyR8;
	Mon, 21 Apr 2025 14:05:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1745233508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TnNvl7Tqo0FcWKW1uYS/pZx6za1f0Zj7zLNY4494PLc=;
	b=A47YMYaJHedXerIG0tEVfD/dr27GVPb8xAxH9i8kyDUde5WjIYsSnCRjG8cjnmN4JNBYRF
	OB5SCpKyjm3aq0hFaYHHUuxKqhHSRtKjddG9MSfjNflaxdKRWPk3WFwalBih1M5r7+O0uc
	B4+TF/QycilYh4A9qKZUp6fvJQt0nzw=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1745233508; a=rsa-sha256; cv=none;
	b=VIEluk5fePiMu+1M5FYfC2Q0TNYwHUe3x1zGdIu76ARIqIUSYsfuKW/BfqbFVgpQyg6oec
	lYNT8l/z8aZwfEJY9D68tuXVJBYIIrtP2GgKNX4shaEL9MgtcLcjoVYD8cd2OLHcrZBIxc
	1VtGv+GlaB68PTmhOnx31OlwaKfiB1M=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1745233508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TnNvl7Tqo0FcWKW1uYS/pZx6za1f0Zj7zLNY4494PLc=;
	b=ZbRIhIqzNVv1W8MiNaaovnK+TtNuJAxYjkBPRP5BQx8qpQu6qBo2WE/bWq4y06RxN3Fkqt
	MjtJeRkGKQwJJWQMGqAuO+jiJYpT246GDTw4FCo+1FuYmeUh2N/ZO33pFy9v2sjtnRBtAt
	T4N6yTlgMiB0vuMiPaI+iufe+OEflO8=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] org.bluez.Media: add SupportedFeatures
Date: Mon, 21 Apr 2025 14:04:33 +0300
Message-ID: <fb302ed17cf2a4331d7ca57529cdbdde80376d82.1745233468.git.pav@iki.fi>
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
 doc/org.bluez.Media.rst | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/doc/org.bluez.Media.rst b/doc/org.bluez.Media.rst
index ecd982652..d41329ccb 100644
--- a/doc/org.bluez.Media.rst
+++ b/doc/org.bluez.Media.rst
@@ -7,7 +7,7 @@ BlueZ D-Bus Media API documentation
 -----------------------------------
 
 :Version: BlueZ
-:Date: September 2023
+:Date: April 2025
 :Manual section: 5
 :Manual group: Linux System Administration
 
@@ -131,3 +131,14 @@ array{string} SupportedUUIDs [readonly]
 
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
+		Media applications are allowed to enable kernel TX
+		timestamping for acquired fds.
-- 
2.49.0

