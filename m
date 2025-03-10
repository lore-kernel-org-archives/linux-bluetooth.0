Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B0A19F103
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607197; cv=none; b=jEp/rhUvvbMskBSNlNQUlGZX/KknLY1b6jKuG4qrdxcPa/d/npBxT5nCpToaAdpNt3vgnIovhrUk+op1HBzzW17Oe9v4REjeltngMXlu2lIKGJcTwplItAyYX9Pc/esPxmYIXBVYeafivN9plpSjoX74B+oo9g0yCncKk4/8/PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607197; c=relaxed/simple;
	bh=kJIG19p9MpZRt+mMf4QjVF8mmuMLisq/cPCCp0ZXJAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V5UFKRQ+vlkOLlpuQoMYIR5c+wvLJo3q2wj4/Ptd/H3rcU7ANiShAiixUusKX+uYypLegpbP5Uf3/0sTjGKkzGyrETd/iSLr/1R4t6WQNHIXLuU8T1zJd0hfXL0qTm6KbyhwWw4DOVxyyj5sAIPk46hQZl/BPiykYsIFREVHPns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from b.2.5.5.5.8.8.9.d.7.e.2.4.c.3.8.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:83c4:2e7d:9885:552b] helo=andrews-2024-laptop.lan)
	by painless-a.thn.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1trams-00EBaY-36;
	Mon, 10 Mar 2025 10:55:11 +0000
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ] Fix typo: s/registery/registry/
Date: Mon, 10 Mar 2025 10:52:18 +0000
Message-ID: <20250310105218.4127627-1-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 obexd/plugins/phonebook-ebook.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/obexd/plugins/phonebook-ebook.c b/obexd/plugins/phonebook-ebook.c
index e509dd29a..d772edca0 100644
--- a/obexd/plugins/phonebook-ebook.c
+++ b/obexd/plugins/phonebook-ebook.c
@@ -630,7 +630,7 @@ int phonebook_init(void)
 	/* Acquire ESource Registry */
 	registry = e_source_registry_new_sync(NULL, &gerr);
 	if (gerr != NULL) {
-		error("Unable to acquire registery: %s\n", gerr->message);
+		error("Unable to acquire registry: %s\n", gerr->message);
 		g_error_free(gerr);
 		return -1;
 	}
-- 
2.47.2

