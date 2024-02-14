Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657EA12E72
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 22:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951244; cv=none; b=EQ/Xkngjw8Tfof2WiSHmLj1tKhhgzcy6Runsq3RF9jKtqSm2RVDLOKsLpEnszlv9NPPMgbYyN05UZXrf8MCaHqTUCNY2PTlfIyM8RU+E6Pro1RhxA7J8y2uSSz8/4P6ln0mazkduBQdpcKgWXjKE/dgnredQgPPO1mmYE3BEOyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951244; c=relaxed/simple;
	bh=gXKg/RuVyJZgIkt2kL3hwZJc+5Iwraa1pGHvlCEpevg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sF+KDVhxyfnaE0MeI2933kS4fQbYXwCcZoYqgaopb5+L44ocLwA9xDGCTLPYQgFqo0X/NZhZkrw4f7PwmP699/bvEgNMjS54jnwOkHiZuA0jahGeJ38WDb7gE76O+qdzukM6T8EXrQ7yh9shvJtFlp+bRpNv7bL9CIsObGHPmXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay4-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::224])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id B5FE2C0F14
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 22:50:03 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F895E000B
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 22:49:56 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [[BlueZ PATCH v2] ] mesh-gatt: Fix JSON files missing from dist
Date: Wed, 14 Feb 2024 23:49:12 +0100
Message-ID: <20240214224955.405535-1-hadess@hadess.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Moving EXTRA_DIST into a conditional means that if the dist isn't made
with the deprecated tools enabled, then files will be missing from the
distribution.

Fixes: 1f6553edd8a5 ("build: Deprecate meshctl tool")
---
Changes in v2:
- Fix SHA to have 12 characters, not 13

 Makefile.tools | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 044342e29bc6..4178940bf066 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -378,9 +378,8 @@ tools_meshctl_SOURCES = tools/meshctl.c \
 tools_meshctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
 				lib/libbluetooth-internal.la \
 				$(GLIB_LIBS) $(DBUS_LIBS) -ljson-c -lreadline
-
-EXTRA_DIST += tools/mesh-gatt/local_node.json tools/mesh-gatt/prov_db.json
 endif
+EXTRA_DIST += tools/mesh-gatt/local_node.json tools/mesh-gatt/prov_db.json
 
 bin_PROGRAMS +=  tools/mesh-cfgclient
 
-- 
2.43.0

