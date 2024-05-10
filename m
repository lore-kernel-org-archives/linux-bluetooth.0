Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC7917084D
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343258; cv=none; b=LIyho4TM/d50Ax+vMpC9yNMXNS971L6ks/8/+rmaTfvINPbO3tZXR3tx0KthFNnfCUbjARyliaxcZ58dmNzpeS4eeO9hZAHcuSJRi17wKoOHB64mZQYpA7aQ/YYB/GeBK/sPnpiF3FB9//mgBgpy5/2DgRe6O8CMfH2V09XzpWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343258; c=relaxed/simple;
	bh=M3Ywyy+4fuNjRQVFMj+DtHH2PN8++yYDfen2QT1Gpis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmSr6Iq7Q4VlqDAV4H7KdaEy2pO1jEcW6KCvSes8+g1CVQb/QA+Gi3Z8NZhJXOLwhLdgcU0TtlH4FLZGu+Lo82SeJubBjqnxqKwbSbwuMHDnH8m/5ONLqprFNHJunjpf2N+BeIaB1HQYkF+IfRFGJpwWFoCDtLSthF2BQlXPKuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id ED21360013;
	Fri, 10 May 2024 12:13:59 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 14/20] shared/vcp: Fix copy/paste error
Date: Fri, 10 May 2024 14:10:24 +0200
Message-ID: <20240510121355.3241456-15-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510121355.3241456-1-hadess@hadess.net>
References: <20240510121355.3241456-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: COPY_PASTE_ERROR (CWE-398): [#def97] [important]
bluez-5.75/src/shared/vcp.c:2610:16: original: "aics->gain_stting_prop" looks like the original copy.
bluez-5.75/src/shared/vcp.c:2625:16: copy_paste_error: "gain_stting_prop" in "aics->gain_stting_prop" looks like a copy-paste error.
bluez-5.75/src/shared/vcp.c:2625:16: remediation: Should it say "aud_ip_type" instead?
2623|
2624|			aics = vcp_get_aics(vcp);
2625|->			if (!aics || aics->gain_stting_prop)
2626|				return;
2627|
---
 src/shared/vcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 7ba54e64adc0..b7e17e448b74 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -2622,7 +2622,7 @@ static void foreach_aics_char(struct gatt_db_attribute *attr, void *user_data)
 			value_handle);
 
 		aics = vcp_get_aics(vcp);
-		if (!aics || aics->gain_stting_prop)
+		if (!aics || aics->aud_ip_type)
 			return;
 
 		aics->aud_ip_type = attr;
-- 
2.44.0

