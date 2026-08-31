Received: from tabos.org (krueger-it.net [145.239.1.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B944C50F736
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.1.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188486; cv=none; b=MMP/0rTcB4j5/32z2pSENhpMzQwN9qfCrsI61rC8XQuzrRwFBfsbpJO+8QRX49ePwknazMK0/XtU/11fIcsVupg6DM92RklBZSTIIu+livpnxM63HdsnLkegUdFltewlrEmx3ZbQAQGUn/LFN2bl/S/A2s60f5pQaKoiaiWdY1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188486; c=relaxed/simple;
	bh=mSSnlJ2LqHoovBv6N91Vh1MLgpL+j4RzaubJDgRjCeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgaQ4pUoMPFxzCb6byJurmtGlvOuksQ1kCmIcmuPkaGWnXs/+PK5P/NMwqvj4MuyTN1ozUvOYTjE1YkFAsjdnkRbSqJKRXn7tbnXr0Zcrj7rHLBS9aK5K02PtSPNY9hNsaZyl/C/N5lS0cuhQe0J4D8pZo8PAvue3jcT0sDScg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tabos.org; spf=pass smtp.mailfrom=tabos.org; dkim=pass (2048-bit key) header.d=tabos.org header.i=@tabos.org header.b=kXde5jzg; arc=none smtp.client-ip=145.239.1.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tabos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tabos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tabos.org header.i=@tabos.org header.b="kXde5jzg"
Received: from c0d1ngstat1on.fritz.box (unknown [94.31.74.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by dserver.krueger-it.net (Postfix) with ESMTPSA id 80A8062E0712;
	Mon, 31 Aug 2026 17:01:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tabos.org;
	s=default; t=1788188476;
	bh=HHGysD6/tgazurLgHFLi59WgP0g8Kucm1tWwz/RFwMM=; h=From:To:Subject;
	b=kXde5jzg23E58Wd08wjfB4wt6K2Kx5VI8R3l4FoJJSRgmiSfUm4v1vX/7f7G2thT9
	 wpw16N1goCvMMtq+ucSOrs9YG7ajjzGeDAuOj3jFLhdrYNvehcTiobOkYHYm9BR/UL
	 9yhFfi/jDpBsfanvnC5SoOnQ07Gl72fXr8TSZeQhJvpKWTsmmecFkRIX0ePDFne0UM
	 Sx6sSE+I+6SSVXMHccDCWpppaOk+FAtYGnsQ/Al60G0OfVZJ1O28i76omp2jkqGGN7
	 f8+OMKuivJRbADHYMQ08PiIRZnfKW57OKbWx/iLNjZmS6mwy+qQqqE7Pucz8VmK//a
	 2cdbyswbP0k8g==
Authentication-Results: dserver.krueger-it.net;
        spf=pass (sender IP is 94.31.74.100) smtp.mailfrom=jan.brummer@tabos.org smtp.helo=c0d1ngstat1on.fritz.box
Received-SPF: pass (dserver.krueger-it.net: connection is authenticated)
From: Jan-Michael <jan.brummer@tabos.org>
To: linux-bluetooth@vger.kernel.org
Cc: jan.brummer@tabos.org
Subject: [PATCH v2 BlueZ 0/1] Add cover art support
Date: Mon, 31 Aug 2026 17:00:50 +0200
Message-ID: <20260831150051.80631-1-jan.brummer@tabos.org>
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
 - Update bluetooth service to have at least read only access to home directories (where cover images are located)

v2:
Dropped the patch that relaxed the sandbox of the systemd unit.
bluetoothd no longer touches the filesystem at all: instead of
reading the file mpris:artUrl points to, it asks the player for the
image data over D-Bus, and mpris-proxy answers that call
for the players it registers (patch 5). ProtectHome= and the
capability bounding set stay exactly as they are.

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

