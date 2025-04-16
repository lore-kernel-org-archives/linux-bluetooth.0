Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFF7207E0C
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744816860; cv=none; b=mx+4iGL3CIIefYmfloAQ9d0C+eZxdeRPIsjlaA++bEqG7saPzkHJjQH5WG9AUeR53J0FaOqWBTx+1m+/ITABOBuNfAzAntGO/tqWZQdSIo25uTu1/cfkMtanYh73pQNZGyrSlBMn/FUtgFmgPAOgYIlozl+W4npmcZcsFVArX5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744816860; c=relaxed/simple;
	bh=YQxOUOpeV9tJiG97008Roqt8pbysN4XAeflRUzNH5hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUSA9PcJKMsY0IxluavG6H/xwpGRIHbimXJ3QPi6iyLHspx+gpMiJH4BJQpzmNNDtQGFE0MMRs+zfF2+zCPG+brwFLQjHrhyUQsEhI/vqbj3GHh2v/wVMpxlavW2MuuRDyRLJJ05lAcNAjPZ7AExh3pajiUOjAnNOGBX2c8s0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from a.d.7.c.3.f.6.7.e.2.2.8.b.5.4.d.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:d45b:822e:76f3:c7da] helo=andrews-2024-laptop.lan)
	by painless-a.thn.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u54ZK-009SGS-1v;
	Wed, 16 Apr 2025 16:20:54 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ 1/2] build: add bluez.tmpfiles
Date: Wed, 16 Apr 2025 16:19:35 +0100
Message-ID: <20250416152039.971257-2-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416152039.971257-1-kernel.org@pileofstuff.org>
References: <20250416152039.971257-1-kernel.org@pileofstuff.org>
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

