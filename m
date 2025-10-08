Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE1E2F4A18
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914057; cv=none; b=o1g7gC3HrSnjri9zLfpeYZTCe3wD44MLhF7Ne9Gm49JVdpCyAwe5o5GEL0qcGqs20ucYWPBDPWj5MhmHlFz58wp+scvkr5tdIw0cxc0KDsyY1LzWwXN/n74K0pUvOrZHtNAQtvWVMHiQIRvaTfe1c9xKMNKPixquZu1VOAWGU5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914057; c=relaxed/simple;
	bh=+ltYsXlcVLhJ3IiDDkcSc6p5PI9u+syE5cx8gSLFCp0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2WNf9MUs+gKal2NZqFoZqHYMlUiBwo5ahcRhvUAzFgCgzlbg2e8IoQDosfClMXPIm0EnfnbtnjRWRxMC9j5vR5VOpRLT35Xts1e5L1Yg664fLs3+XoPjn8BZGEvfJ+VQlBkgN/jCThVtWdfvsg005ZxYKEQacp5KZxq4Qppecw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 6F89E584F3B
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 08:50:52 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97835441F3
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 08:50:44 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/9] tools: Install gatttool if deprecated tools are enabled
Date: Wed,  8 Oct 2025 10:40:52 +0200
Message-ID: <20251008085034.2178394-6-hadess@hadess.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008085034.2178394-1-hadess@hadess.net>
References: <20251008085034.2178394-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=1141909
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=720486
---
 tools/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/meson.build b/tools/meson.build
index 5e73b048c118..3e8f7ad439dd 100644
--- a/tools/meson.build
+++ b/tools/meson.build
@@ -231,6 +231,7 @@ if get_option('tools').enabled()
     executable('gatttool',
       sources: gatttool_sources,
       dependencies: [ libbluetooth_internal_dep, libshared_glib_dep, readline_dep ],
+      install: true
     )
     executable('hciattach',
       sources: [
-- 
2.51.0

