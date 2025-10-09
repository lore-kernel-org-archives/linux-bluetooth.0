Received: from relay0.mail.gandi.net (relay0.mail.gandi.net [217.70.178.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59422C21C9
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 10:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760006176; cv=none; b=igTl6h/+VrSwm3N3G/lTSYf/RWsIx4v1mhNoICy3hohDlLCP89sRGsxdCnUHyB37yYp+k5CyMk7gSpfjm/8c1XbmqZUsaAfcRa2D4sJ44pfQAIVnJP0tuJNujQKUMlJz1YJewZD9NpC6cIMpkea9ibq1s9rSRfqPBuHaRHCKouo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760006176; c=relaxed/simple;
	bh=+ltYsXlcVLhJ3IiDDkcSc6p5PI9u+syE5cx8gSLFCp0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=maG0tOc13eDvZL3/YEIyeveyMNc7HMsOoiCYBpsTdhFoBup342gMXerYB86bqmmDZp26oZCK+x3Tt3GumSFsTjxUxTpNMnSS/p9ArZiFYzI6hn47RQFfnVVCI0FZDXR7UJ0J59a9E4TcefudUqxExuxlfCPF63sVlq03FNtSgTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 372FB434CE
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 10:36:05 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 05/10] tools: Install gatttool if deprecated tools are enabled
Date: Thu,  9 Oct 2025 12:33:28 +0200
Message-ID: <20251009103554.2417973-6-hadess@hadess.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009103554.2417973-1-hadess@hadess.net>
References: <20251009103554.2417973-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

