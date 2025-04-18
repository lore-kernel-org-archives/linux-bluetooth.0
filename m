Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BB913790B
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Apr 2025 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990299; cv=none; b=msQkSrjUasAAgr/wlWYTDCc8ymz9w5isAFZexYwwd36Xl8JBQBvTOXlhMwzwcXysE1A085lfMcHbRC+JXld3YUjnW7uXHMw8a7+ur3PTa3IuEfedIqL5p75073DG3Wm64g/8qmdma/AMqORrUPDnJK05Aj+3oAYj7tcy52wYuqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990299; c=relaxed/simple;
	bh=YQxOUOpeV9tJiG97008Roqt8pbysN4XAeflRUzNH5hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zp/GbN3jdzpUBP1C09Iny3+Y/RSqufoJTbER7FOd7m/BTl/QZGR9C/kPtBQpndEhGKniNAbK8z5X6+DuTGlGEkKquw1UxP2SyPWSOg0U8Qo4LMGjYb4wr8JoBNO6hqOH1gh8COYnIAtDja21FIldY7voqdH5eq7fxr5KlXi/EDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from 7.5.f.b.8.d.6.0.d.e.a.0.1.8.a.f.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:fa81:aed:6d8:bf57] helo=andrews-2024-laptop.lan)
	by painless-a.thn.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u5ngj-000vF1-1s;
	Fri, 18 Apr 2025 16:31:33 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ v2 1/2] build: add bluez.tmpfiles
Date: Fri, 18 Apr 2025 16:30:51 +0100
Message-ID: <20250418153115.1714964-2-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418153115.1714964-1-kernel.org@pileofstuff.org>
References: <20250418153115.1714964-1-kernel.org@pileofstuff.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Systemd tmpfiles ensure the status of particular files.
Add a file that bluez can use in future.

Distributors should install the new "tools/bluez.tmpfiles" file, e.g. by
moving it to `debian/bluez.tmpfile` or using Fedora's `%{_tmpfilesdir}`
variable.

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
---
 .gitignore              | 1 +
 configure.ac            | 1 +
 tools/bluez.tmpfiles.in | 0
 3 files changed, 2 insertions(+)
 create mode 100644 tools/bluez.tmpfiles.in

diff --git a/.gitignore b/.gitignore
index 108c3b820..e4431443f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -157,6 +157,7 @@ obexd/src/obex.service
 obexd/src/org.bluez.obex.service
 tools/obex-client-tool
 tools/obex-server-tool
+tools/bluez.tmpfiles
 unit/test-gobex
 unit/test-gobex-apparam
 unit/test-gobex-header
diff --git a/configure.ac b/configure.ac
index 1e089aaa7..4ebd513d6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -530,5 +530,6 @@ AC_CONFIG_FILES(
 	src/bluetooth.service
 	tools/bluetooth-logger.service
 	tools/mpris-proxy.service
+	tools/bluez.tmpfiles
 )
 AC_OUTPUT
diff --git a/tools/bluez.tmpfiles.in b/tools/bluez.tmpfiles.in
new file mode 100644
index 000000000..e69de29bb
-- 
2.49.0

