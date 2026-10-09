Received: from tabos.org (krueger-it.net [145.239.1.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1484C8C50
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.1.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553786; cv=none; b=esOcXCowt5ut39rwhF4VtUph6Ri53aOMr70DyUQTYoi/HITpzp4pnpacfXGIynNsSCFulJuRVSMQp89o73nqTtWcwJcJdhghn/pYqjyldI6fDrj4oTEH7mYdrdDmRaLvAN3xFghUu4KhyOzOFA1/AUPfsl12nxiG/48eQyGDtwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553786; c=relaxed/simple;
	bh=KDeNJnALSbMdXsmHWFbfiRC7gw44j+NXwpeiKyX4sLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E27y9IIRxGw0XVpJpn1zx2A8b/zSvyjXF6cnBXd4H1JWgpxln1bJc2skeX5kNy1JUfGUi4Po2MWIxwJdM6z9n/5rGfW8lIOk0lpJ/Tqdh6gtj6AVuWeok/d0P+4+yLKz/gmDrcF9mXgz5Oj0771N7Na+s6+a1302uhjYiwENNh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tabos.org; spf=pass smtp.mailfrom=tabos.org; dkim=pass (2048-bit key) header.d=tabos.org header.i=@tabos.org header.b=GYt/V9eJ; arc=none smtp.client-ip=145.239.1.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tabos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tabos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tabos.org header.i=@tabos.org header.b="GYt/V9eJ"
Received: from c0d1ngstat1on.fritz.box (unknown [94.31.74.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by dserver.krueger-it.net (Postfix) with ESMTPSA id ADFB762E02CD;
	Fri,  9 Oct 2026 15:49:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tabos.org;
	s=default; t=1791553775;
	bh=Bl2d1gPTVaC8dlH+GOhj0OC9TJiuBnXbDdQBXYP/JQg=; h=From:To:Subject;
	b=GYt/V9eJYj7Q4DRRD1xiYD/4T46w92XEOAqnm0m5kNEuFqRTZgxbpxJbllQf7yL/f
	 HrGQf84k/ElXsAXeHHnHXNNEm781r5MiHkOjKmtXUuGlnTW9xMzFwmONgNFj3SHc/D
	 9osigEZ/FkNrkGmA8PVWugomnNioCeadrxIGM5B0o+pV1YpKuQGU6Eck21e8kCBxUp
	 W0KzaKVxb0AM8jsCuntZjBLTPnRmm2mOkJITBS6GSZCuFsmbjxUvFHi02JAU2QPmUd
	 7JitQhtOUQ1ZOsonUokZQgIkRTtwIdYO4BK0QnNz+H7QUfASMk6JlgSgvhL87mCpKd
	 zlF1CjCqh1IIg==
Authentication-Results: dserver.krueger-it.net;
        spf=pass (sender IP is 94.31.74.100) smtp.mailfrom=jan.brummer@tabos.org smtp.helo=c0d1ngstat1on.fritz.box
Received-SPF: pass (dserver.krueger-it.net: connection is authenticated)
From: Jan-Michael <jan.brummer@tabos.org>
To: linux-bluetooth@vger.kernel.org
Cc: jan.brummer@tabos.org
Subject: [PATCH v4 BlueZ 0/1] Add cover art support
Date: Fri,  9 Oct 2026 15:49:23 +0200
Message-ID: <20261009134924.122040-1-jan.brummer@tabos.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260803195620.255866-1-jan.brummer@tabos.org>
References: <20260803195620.255866-1-jan.brummer@tabos.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BlueZ wasn't able to display cover art in car's headunits due to missing
cover art support. Add missing pieces to allow sending cover arts:

 - Add AVRCP BIP Cover Art Responder
 - Advertise Cover Art Support

v2:
Dropped the patch that relaxed the sandbox of the systemd unit.
bluetoothd no longer touches the filesystem at all: instead of
reading the file mpris:artUrl points to, it asks the player for the
image data over D-Bus, and mpris-proxy answers that call
for the players it registers (patch 5). ProtectHome= and the
capability bounding set stay exactly as they are.

v3:
Update based on review comments, e.g. moved to obex

v4:
Fix CheckPatch findings

Tested on a Fairphone 5 and OnePlus 6T with a VW head unit.

Jan-Michael Brummer (1):
  Add cover art support

 Makefile.plugins           |   4 +-
 doc/org.bluez.Media.rst    |  21 ++
 profiles/audio/avrcp-bip.c | 608 +++++++++++++++++++++++++++++++++++++
 profiles/audio/avrcp-bip.h |  46 +++
 profiles/audio/avrcp.c     |  92 +++++-
 profiles/audio/media.c     | 194 ++++++++++++
 src/bluetooth.conf         |   1 +
 tools/mpris-proxy.c        |  81 +++++
 8 files changed, 1041 insertions(+), 6 deletions(-)
 create mode 100644 profiles/audio/avrcp-bip.c
 create mode 100644 profiles/audio/avrcp-bip.h

-- 
2.55.0

