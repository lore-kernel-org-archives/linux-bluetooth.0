Received: from tabos.org (krueger-it.net [145.239.1.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB32B51D51E
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Sep 2026 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.1.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788809663; cv=none; b=ZXMw3R7rv1z3X8d1v8lYyhieQMIXrNZry9Y8TBdGH1NNlHrkDR4rE42lK+t2P5/NVpGi+n9EqSLjXD1FLyRZuI6BJmesil54702F3BXYrKADxgSf1Gfcs38wn+c7HXF5zg4WK42GNPo/0HrgU2DVfowjniCd2V5mjOhvbFD4bsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788809663; c=relaxed/simple;
	bh=yrQcZIr14OaE+VsXM+1Ar6/2w1jOQia7nFAknWhrdG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8UszU7HEPLlXCdkxzAuhy2pI9SFktTytQMmbRbLBZz1DijdcDMWWqaLZwzfx7lyzqq0GVMnS15mvRsluaWpoqB6kjMoMrZnpQZoCmutUZ1lleiYpvBK6O5jWszy2a7ZpaV5HnTzhGUDmfp80y/SjulzW4M01tfi25xddIo8mpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tabos.org; spf=pass smtp.mailfrom=tabos.org; dkim=pass (2048-bit key) header.d=tabos.org header.i=@tabos.org header.b=hpRv6l1y; arc=none smtp.client-ip=145.239.1.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tabos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tabos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tabos.org header.i=@tabos.org header.b="hpRv6l1y"
Received: from c0d1ngstat1on.fritz.box (unknown [94.31.74.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by dserver.krueger-it.net (Postfix) with ESMTPSA id 53E8D62E04CB;
	Mon,  7 Sep 2026 21:34:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tabos.org;
	s=default; t=1788809652;
	bh=Leh8rWYAfqNTaT9gwJ2/irthiWfV4YDVesAt+x5jwRo=; h=From:To:Subject;
	b=hpRv6l1yxbOIlon+P+Te0fLu0QJvZqf7IQJeD0baR8PYrVvq1wcElpV84e6AMtDRv
	 1twPuNPisYVFduRLg8y08P8sQD4fgfm6Pj5VPtx+OapB2WFGprXyWRAzXLcRX0z5C5
	 m/6GLbIIYK8duPDnfWfEpNa+WOfF07iDmfFtoIg+7dVfh8YHlMZxCqfHSRfb3W89L9
	 pEVEPhtj1kct7j0pYbZdJngxyedQiwEWdeLWM0qomNgvtQaMxi2Y43lG9RPD3RWUc1
	 mJ1TDAWrQACoylBZhGGnas/zuR2ajIkXxKfcHtT1pCm5A2kkZ3SFsrYjwAJ1YwZxXG
	 FpCLfyAc9GASw==
Authentication-Results: dserver.krueger-it.net;
        spf=pass (sender IP is 94.31.74.100) smtp.mailfrom=jan.brummer@tabos.org smtp.helo=c0d1ngstat1on.fritz.box
Received-SPF: pass (dserver.krueger-it.net: connection is authenticated)
From: Jan-Michael <jan.brummer@tabos.org>
To: linux-bluetooth@vger.kernel.org
Cc: jan.brummer@tabos.org
Subject: [PATCH v3 BlueZ 0/1] Add cover art support
Date: Mon,  7 Sep 2026 21:34:03 +0200
Message-ID: <20260907193404.124504-1-jan.brummer@tabos.org>
X-Mailer: git-send-email 2.55.0
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

