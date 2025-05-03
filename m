Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A2218DF80
	for <linux-bluetooth@vger.kernel.org>; Sat,  3 May 2025 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746257085; cv=pass; b=SbcCz/Ao4fWqv0ZEepVCX7iKpQM9rkfSuHuyn9UNiCbDVhwvq1FUtG2RkhrWeERc7u/WYynfD2NoO3D2skoP1N+cOL23Qo30miktSPrCosbhUdTsaEt1dDPdPI7g64oeXpSdqvppRT8CSlT+YPrYc9kK4Rz+ZwWlG5lfKSooAnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746257085; c=relaxed/simple;
	bh=dIpfl3zNfmZtt/FRv6L0MgCHDe1QECDRO8pUET8WU+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Og9l1IDaVGg8UM+H7bWltE2drXK7Z2CnzRZIiB6r0Y+xmEVrHXN5wJgRIX3EBnF1P6Dc8Xk/YH76Tto4P7Sb16SOPpKRA6FLZrfBX4YQ1dnwfIcJ6ZbH3baE2N2cmyBb/Fh8NtLLJeg/Ct4aaFVI9dWqagBE1UkzgXm+9OhAv+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=jYnc1U0Z; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="jYnc1U0Z"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZqK6j1khqz49Q3S;
	Sat,  3 May 2025 10:24:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1746257069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y/7K+XrQ1Odsyha4r3GbQ4usH+9AiNSK0okW5tO97sI=;
	b=jYnc1U0ZaVlvr6qXXuqZoAp3r5K2VwxXP4VYLyuX0NHdGXBzjL+2q3rqqFLsi12S8WLfwv
	BqkXAqqq9h0lXsPekTkj6keNC/GCoyWkDvpvL1V1bP50GALOytLbSmv434uDgygp90hOC6
	FZMAzBCWJ2My0Pon+bgEvocXQhSCfRfbkIxmZDEETs9icbJHyCTqtS+y807Zd+/UCQyicu
	P8mWLpi+mjchb4IjpsVjvwtAYwCYA3lCAbVrbUWQRrvZMGmfTbCameHCgbY/hvl9ZyDJRV
	b8/594lD3Vdw6snLlCWuj1uU8LLw+NCu6kGMHZjYiuW944j6eM1rxaJO6u/Ncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1746257069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y/7K+XrQ1Odsyha4r3GbQ4usH+9AiNSK0okW5tO97sI=;
	b=mX1PFbFWvY3AbAJzLXhdmdGlVk3Q303mRLnSUtphI6ZFp9Z8quLo+LkBDtX9BZPUj0a0On
	RWy32hJMddkwTcsUmOxATnQotESoeOH0S8nFKcW43c6C5s5I9siQYf8HgUmJ1NvAu+9inH
	oC635RhzcvmBSUXY7YcmDUENsBwCucUwfhylxe9M6iZk4iEMyBg8JmQHDBMKVwXBEUKLfc
	lmOR6MtxZgjcEX29a3VsQtGQw+iu7OxqKLyVXPOiDg33Pkr1qxYVWseM5C6cDYoREPi5GI
	xZI0BUAUCf4782mYLO8UghPZhUhPwt2WHMmHKThWEIwsCfHQPeRpfWv0BimgkQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1746257069; a=rsa-sha256;
	cv=none;
	b=bVAUxp2t1ea2UDNmCuRRHmJlSZpRL2An2br+E/wMBb3nXoKKcFK+cfnIy2ucgHQhj5kv23
	9f/BNcj9Gbg87wnpM+jfyuAj8IJCRnCx4tr163ljVPKpQHmkTNTOs4h2/QeVzBrsLF1dsT
	CNCdaMvOISfrhsi8BfofIcjgpEq0VDLSTkByoKuaaaDb+EWH6A2Ab0zR612RHcGSKP32CK
	rnrvhukk06ZYCCN4dvZzsUGBu9XIoLhneFcnUeSO68wvsVLCZX6omCt1bX1pa32tEw/oSa
	UbUW3z6nXfo0nGP0z+uz68KITNRBqA4Te7oWUgEt2juB6XiD3JfGxxh9dth8uw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 1/2] org.bluez.Media: add SupportedFeatures
Date: Sat,  3 May 2025 10:24:25 +0300
Message-ID: <6df15922fc4f602c9b10baf640e07859c4d3e958.1746256909.git.pav@iki.fi>
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
    v4 & v3:
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

