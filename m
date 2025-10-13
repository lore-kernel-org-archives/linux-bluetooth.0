Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A922F2610
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345282; cv=none; b=L4FGRPc5rthVkGaZTKrEW7XuLqhiHejVHIfmUrEEkRJUnj3nMQZdCV++tt4Smuu6bR5x+yg5JE5B4LvcZ8vIJuitBKHAa5Dv3pfKRK9AuuV8yONInk+tYapNMTjMyMQi/krI36mS7oGZ+5eF9z6h0lHvs0KVUvxNFf4BbF+Qt1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345282; c=relaxed/simple;
	bh=+ltYsXlcVLhJ3IiDDkcSc6p5PI9u+syE5cx8gSLFCp0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIETJma19OhIjAGz1QyzPkEQNc7f0D+ms8eXfSB4+eq9s01ZkLt1F/LftU3J8H00vu9+n5yMbPFjXtadxjiT/rqGclETZb4XY9ILcD1RitVRnb1UyFqtbFl+GYNcaUnWnrUfH+cyadQ97znFsbea5ell+6hAWou1KwWlrJYw064=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 62A7558211E
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 08:33:16 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B46004327B
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 08:33:08 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 5/9] tools: Install gatttool if deprecated tools are enabled
Date: Mon, 13 Oct 2025 10:32:15 +0200
Message-ID: <20251013083259.3152260-6-hadess@hadess.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013083259.3152260-1-hadess@hadess.net>
References: <20251013083259.3152260-1-hadess@hadess.net>
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

