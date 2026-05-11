Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFD52E62AC
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506359; cv=none; b=RX+mMH8iyNKBKXxKYqvLukv9wc5dmG4jUCcQUD6BZVrrARNEwVdcz+VB5cAPjCC3IC/h/bYzAhPMZC2cEAdi7UASCIZON8xzpiRQCeXenhp+j/YNpWIBncFZ8L6fgdawvSjUrhsYrMBlCbWKegHgNzRbc0epndZvNtflUGYVNxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506359; c=relaxed/simple;
	bh=hDOtj5Nf1/urz+vU6PahUXo7HAFlCMAwJn2MgWVuFbc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QcvTmo8TitgO/12MrxBixMvNNCEEPLCi4C0akqfApIZ1aN73RCXmXAO4vXoceb52XCQOyVlrKDfgGwGlNPP9O0oIZmHVyUO1rIyEpG1hHujP+s5nBPLUlPAXeNkOYWUnKBBgXCCzC7PO+5rM/7yT9YjyNah6i4glnj/C4yiiHBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 5C4175813BF
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:21:48 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E23033EC40
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:21:40 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v3 3/6] doc: Recommend using _cleanup_ and friends
Date: Mon, 11 May 2026 15:18:06 +0200
Message-ID: <20260511132131.1283892-4-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511132131.1283892-1-hadess@hadess.net>
References: <20260511132131.1283892-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTFyg4dcWaG5eSKnyQUHRkNw/X4O2fwqTBchSxLtNlc8UZkgYcvmT3qFT99KlQyk19auPdMEZcmgm/Vyr6QiQMZqh5NFE17Zc0wXOtGPQQZRz5XwT9JV83lfqcvUtVp2HNtl2hZC1BgZ9TR7tsTgsJSySwYWZzV5EPUMt6P2DJ1BVLKAGzqYnxDlPqKBHFh4XfMCnpWb3pFBFavNJlLQjO+blTA/peaWNxPspJqGVDx6v0cAbK74vnvh38G7adG+f8OSDFt6Fhdnqo3vTy+0xSBEumrusRanrze1CrRoMShKBmPygTEsg0qM+HlxUOxeeaxDbZ4d+AS9eqXKhVcDycEXawdMY9MPP+ck2Tg6Xn5yoQqQm/vjeg58uTGnHvAJMvSsJoWsPLm0GtcLGqGcphFXp9xJUWXApQI4YibL4URMlT2SeGk9SmlAg1ApvDuvxs3cLQEgXcF796snOijxn0vZjVvLGytq4hcL3hu5wMkEQtspe1oOaU2NMoLWG4n4DVqW7YKE9dI/feXL25MGg/p6W6XJkdGReVG0cW0MPfVD4yf0iQzD/B+OVAmOIIJXmTpt0Fsdf7aBpcwBujb2OC44MVeCAGbbKVAb68GDs++ovIoa2r5Vv4vdNmDL4WUgQU2I7gtiYpYAGmFXYAwmTTLaUOFFaXTUpYH4d44QyGlByA
X-GND-State: clean
X-GND-Score: 0

---
 doc/maintainer-guidelines.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/maintainer-guidelines.rst b/doc/maintainer-guidelines.rst
index 44d3e258db6e..b67c6596f4c1 100644
--- a/doc/maintainer-guidelines.rst
+++ b/doc/maintainer-guidelines.rst
@@ -98,6 +98,9 @@ do this:
 
 The above assumes that a kernel tree resides in ``~/src/linux/``.
 
+Also make sure to use ``_cleanup_free_`` and ``_cleanup_(free_func)`` when
+possible. It makes your code much nicer to read (and shorter), and avoids
+common memory leaks on error paths.
 
 Rule 4: Pay extra attention to adding new files to the tree
 -----------------------------------------------------------
-- 
2.54.0

