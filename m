Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18F72BEFF1
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 22:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765925676; cv=pass; b=NwAWHyMRMG6eAnDJq6EqHPNcVPF5W6xtJBWOA8+LErsLoV/AsCWtv1plI/GIr4UZ1CNtW4UmqKJeluvzMFVMske6Lfib+A2d/f0czYCIZPwounvvJsSpfSt01JuW9tdRRven0CGsweh8NJmN7a9RuKZbmHGxsPrm6tQ7hkgAHL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765925676; c=relaxed/simple;
	bh=oHaAVXYs050rrC38AB/KGLm4nJ+adAJzrHke63ldEgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e2feF7bJtZqv53AAIZur3/3v1aD5MDKf89T5rC2o5iDIpLrc+L+2JmQh6uP9xmhf5n/3jzSFOsapKSPokqPoE98sozSzDXK3h7qicDnb3OFKaIu+BHNBm+mSTypl0f5rcW+cHgjYvu5ebItAt7aUc8xNH7WUWJI4W4Lcm5kzpd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=vDqqJstv; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="vDqqJstv"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dWC134ZY6zyVK;
	Wed, 17 Dec 2025 00:54:31 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765925671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=duHC5uaHnzVvJG5nkVbaQJzgZqkEKsyH69keCSAQJDY=;
	b=vDqqJstv7tJXxmQKk8+Fln8iZlM7tCZ2HBnVqgwN9iYlbDVPFDhMG20wNF4sMg0ZcAvK3J
	tEE3Usl+o5Eq3qYxPZmlY5xGzyM46DN86sUSMVUhzWAfYngC75A5BiGfj3F9WKzrxaaLI3
	PhLJsiMvwktDVzjD7ZiQRoDMFrT9ybU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765925671;
	b=UKqnDAZmWpX+96ZjQRcsOCOc3HzwwH4JnVVpjqAFZyE+AGDrOeZ21GuurGAU5pTeFwzFnC
	oqGiX7Bwylx9wAnMw0kkG2iVcWr97Q1n9G5IGxO2ZnGn7usy8SPUV7TKrcRDyWqYINoj6a
	QO8xsGL+2Xm3riFl2IZ6IeaO+Qt7Ugs=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765925671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=duHC5uaHnzVvJG5nkVbaQJzgZqkEKsyH69keCSAQJDY=;
	b=cHjVjKavU+U2MIIiHmjINFsxc683DPYjMYpR6ouTD73PwUgA5L6uA2LfczJyruLsgoWfsW
	B8S2pyEYhirHZWQAoioQujT1WwM0sxKES52exeBmgw2gtcg6cgLXv2khzVGkdGFY7Z54uJ
	Ze19cvFh7HJ3V7QhkJpKOIzoae6DJYU=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 0/3] mcp: expose org.bluez.MediaPlayer information via GMCS
Date: Wed, 17 Dec 2025 00:54:26 +0200
Message-ID: <cover.1765925485.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Select one of the local org.bluez.MediaPlayer instances as the "active"
player, and expose its playback controls via GMCS.

To do this, decouple media.c player API from AVRCP by adding a similar
API for org.bluez.MediaPlayer --> remote as used for the remote -->
org.bluez.MediaPlayer direction. Use it for both AVRCP and MCS.

In theory we could also expose each org.bluez.MediaPlayer in separate
MCS instances. This is not implemented here; it would need to be done so
that we don't consume ATT handles when players come and go.

Pauli Virtanen (3):
  media: decouple local org.bluez.MediaPlayer from AVRCP
  mcp: expose org.bluez.MediaPlayer information via GMCS
  tools/mpris-proxy: allow selecting which adapter to use

 Makefile.plugins              |   3 +-
 profiles/audio/avrcp-player.c | 291 +++++++++++++++++++
 profiles/audio/avrcp.c        |   4 +
 profiles/audio/avrcp.h        |   3 +
 profiles/audio/mcp.c          | 506 +++++++++++++++++++++++++++++-----
 profiles/audio/media.c        | 501 ++++++++++++++++++---------------
 profiles/audio/media.h        |  45 +++
 tools/mpris-proxy.c           |   8 +-
 8 files changed, 1074 insertions(+), 287 deletions(-)
 create mode 100644 profiles/audio/avrcp-player.c

-- 
2.51.1

