Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C282BD5A8
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769601256; cv=none; b=cwWhcasAIEL6+ri6+zYrOCRA7oaKfCpOw2093I0yRA21UarPjv04KsGoQzK9HnPWDCX1h8i/GmeuF0NyvRdkbS3t1/tc6eRLA0smpzmqZJLQ/Zm5ZMbGS7f2TeQRddoJNG/YLOCYBcW+AAiV24oF4+8n6u63U7a0mlwcKFulq7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769601256; c=relaxed/simple;
	bh=yYBoK23s7NVHXPErSKzxTgz1dfC/INCWCUkLU2t+q0I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D3KDanxhKql4kSz49CI16ho7v+8McOArEKn8+ESG/wFflyoz+SFo+HpBFa52RQuZB0ILpOrfjZ7o41/Lc+04MRUo407m9t8/anzEQ81ukwW5paIPsyfEdYZNK4MnyBPqmHHxJAeoyXXLInwPg6DNwF7oRiyUJvEpMiWN8Z74YwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pLbfF6//; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pLbfF6//"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1769601245;
	bh=yYBoK23s7NVHXPErSKzxTgz1dfC/INCWCUkLU2t+q0I=;
	h=From:To:Subject:Date:From;
	b=pLbfF6//MGlSISsEfQomSwwefpCtkpqP84EhChomiDf/9CbSDEpoOFQUV039LQrFr
	 WNJ6BWIYbOdcSAg5+vcD3bMw5INHt1Bh+DsmuZMgvVkt2Z8rVp87mAK2zwdL5Jyk7E
	 ydtzImjZtlorPcLzSxtljKfrQ190abXVejKHz3WdZWwjd4T8hhAjAJFCdKpLb6RhVf
	 p+8g+YhKvpjptQhO8BaR84hCqCKsu/j4qnS7GFCcJ95sznoXuBjUsX4MSG1pnrLmNf
	 iQkFqIN9Ev1ERql6JcesVH9A3dA0j6/rss88F7zsKawGE8n6QVcdF/WE0A6YX7GtUT
	 l8X5lpPz+pE9Q==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-Af44-1001-C806-A574-25Cc-A244.rev.sfr.net [IPv6:2a02:8428:af44:1001:c806:a574:25cc:a244])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8377B17E138B
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 12:54:05 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] doc/qualification: Fix typos
Date: Wed, 28 Jan 2026 12:53:59 +0100
Message-ID: <20260128115359.222251-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This fix the errors and warnings found during HTML generation.
---
 doc/qualification/avrcp-pics.rst |  2 +-
 doc/qualification/gap-pics.rst   | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/doc/qualification/avrcp-pics.rst b/doc/qualification/avrcp-pics.rst
index ee7acd6f2..802ea3775 100644
--- a/doc/qualification/avrcp-pics.rst
+++ b/doc/qualification/avrcp-pics.rst
@@ -17,7 +17,7 @@ Prerequisite: AVRCP 1/1 "Controller"
 +==================+==========+==============================================+
 | TSPC_AVRCP_2b_4  |          | AVRCP v1.5 (C.1)                             |
 +------------------+----------+----------------------------------------------+
-| TSPC_AVRCP_2b_5  | x        | AVRCP v1.6	(C.1, C.2)                       |
+| TSPC_AVRCP_2b_5  | x        | AVRCP v1.6 (C.1, C.2)                        |
 +------------------+----------+----------------------------------------------+
 
 - C.1: Mandatory to support one and only one.
diff --git a/doc/qualification/gap-pics.rst b/doc/qualification/gap-pics.rst
index aef0b3cbd..f5b63a00a 100644
--- a/doc/qualification/gap-pics.rst
+++ b/doc/qualification/gap-pics.rst
@@ -1069,7 +1069,7 @@ AND NOT (SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS" OR SUM ICS
 +------------------+----------+----------------------------------------------+
 | TSPC_GAP_27a_3   |          | Periodic Advertising Synchronization         |
 |                  |          | Establishment procedure over an LE connection|
-|                  |          |  with listening for periodic advertising     |
+|                  |          | with listening for periodic advertising      |
 |                  |          | (C.3)                                        |
 +------------------+----------+----------------------------------------------+
 
@@ -1548,7 +1548,7 @@ Prerequisite: GAP 5/4 "Central (LE)" OR GAP 38/4 "Central (BR/EDR/LE)"
   not defined.
 
 BR/EDR/LE Capability Statement
-=======================
+==============================
 **Table 38: BR/EDR/LE Roles**
 
 Prerequisite: GAP 0/3 "BR/EDR/LE"
@@ -1568,7 +1568,7 @@ Prerequisite: GAP 0/3 "BR/EDR/LE"
 - C.1: Mandatory to support at least one.
 
 BR/EDR/LE Capability Statement
-=======================
+==============================
 **Table 41: Central BR/EDR/LE Security Aspects**
 
 Prerequisite: GAP 38/4 "Central (BR/EDR/LE)"
@@ -1587,7 +1587,7 @@ Prerequisite: GAP 38/4 "Central (BR/EDR/LE)"
 - O: Optional
 
 BR/EDR/LE Capability Statement
-=======================
+==============================
 **Table 44: Central Simultaneous BR/EDR and LE Transports**
 
 Prerequisite: GAP 38/4 "Central (BR/EDR/LE)"
@@ -1605,7 +1605,7 @@ Prerequisite: GAP 38/4 "Central (BR/EDR/LE)"
 - O: Optional
 
 BR/EDR/LE Capability Statement
-=======================
+==============================
 **Table 43: Peripheral BR/EDR/LE Security Aspects**
 
 Prerequisite: GAP 38/3 "Peripheral (BR/EDR/LE)"
@@ -1624,7 +1624,7 @@ Prerequisite: GAP 38/3 "Peripheral (BR/EDR/LE)"
 - O: Optional
 
 BR/EDR/LE Capability Statement
-=======================
+==============================
 **Table 45: Peripheral Simultaneous BR/EDR and LE Transports**
 
 Prerequisite: GAP 38/3 "Peripheral (BR/EDR/LE)"
-- 
2.43.0

