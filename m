Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99667165FD9
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332709; cv=none; b=Zc2pFJgPbUNaMtoG4fpnEKYhcyFRQLns6ooDOAWEDZz0DCf51KZ0nGlB5vaqlTP0O5dhSedr9ViTKrdqR6gzcSTVjDcQmAg7IoPZ6/qLGCE3h9OnphQqMFAG2cP2/cqLaqBxRrPtStGZBklyZKGqHpJU2JvOeX00wCxT/c/FL+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332709; c=relaxed/simple;
	bh=M3Ywyy+4fuNjRQVFMj+DtHH2PN8++yYDfen2QT1Gpis=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvnRqi2x203XAT0TAwj8VcCjHnpciepcJCxN3FyNdHHm5/o44HtFFtMHSevixfrRubHaYOJ+Eiwd9BDRLg/ALLguw3XS7E6su15+Y5GRr1U6yi/ISOhUCKwMnPe5KdsSzOVr1ckz9vTM4q8NslfAAeRvFCh/E91IvG0K5a8qPJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 309611BF216
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:18 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 14/14] shared/vcp: Fix copy/paste error
Date: Fri, 10 May 2024 11:11:12 +0200
Message-ID: <20240510091814.3172988-15-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510091814.3172988-1-hadess@hadess.net>
References: <20240510091814.3172988-1-hadess@hadess.net>
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

