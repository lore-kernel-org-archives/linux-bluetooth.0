Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4C72FFF95
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765381461; cv=pass; b=rnoGi/xaBua1pLH09dX0+IdWUYUOOJQ8nnyg/wm5nq5E7u2C17NE1FbZt+2OVz2hN+YdpTYcsbDa3/D/DN3dnvHuXSoPrMvPIp+6SSgxnR3ZRBwz8T3YGNTZzy0KSyX5MygFbcdGaTwaP7e0N3Zr/df19OoWkM3WSVjx5Hzx938=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765381461; c=relaxed/simple;
	bh=r/hxrmM9JOVdjZ7DHhTaxITI3laPV2MpcYkRG+Hmvg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pIv4teYfYJVry9NoOqyYUMcAjaSr4GXzbwUkoocWdfIIMnIepCcVeD5xwRakMPjNnexT6CN0rD9qGXhm0L4FjI22PyfFEdEyvF1cRo5a+RczGhtOil6l2+q2llglv0LmAj3gPa8FQRPZFM5OwZddSmmRLepC3MBO40qX4F+d174=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=FmKR2VL7; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="FmKR2VL7"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dRKlM58qMzyQH;
	Wed, 10 Dec 2025 17:44:15 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765381456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AIPIT/1wbwtO9LH4oZDyBZHX+ywHJxG3s0LqUSQqGUM=;
	b=FmKR2VL7z3rf19zfHDeVGsEO0qiCDLId1SG57plrFg72WLow+0UD63dk+vLxJz9GziiPjx
	VBktjYHjz3dxzPWAaSPlqDCLdMoDWJETFa1om6roB7ad7iDA7t7c3cFi9YebaH9u+7v8TX
	QIJm68mqvsMqcsoVPVrrg0qzturfNDU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765381456;
	b=bbA/lVPFKt61/DrFiBxRjqauzT6IHbZl4eBW0S32KvLtHl8FzSQb26QIdCGNmsMggRPPmL
	iuUFy8/UsqyVkfVSjZucHp2FAR02MisW+umpuPRuzC0+7LKAoVRG34uKEP8rizJ+yOG3sQ
	5jCtT6yRec0hIl423pjPrcyHscKUpok=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765381456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AIPIT/1wbwtO9LH4oZDyBZHX+ywHJxG3s0LqUSQqGUM=;
	b=U9Kdr3fymDVwLngHyVShv3nc3XKGVuvMz/OaJV31zdB6ITeZNRyened3EHB9bIXzhgcN7c
	3ppNjGOCXvsgWEnAyJc9cZJmxEhzbbW1tZLMbW+NYHrhB9fTfDo1Bzm/sfuMiS4206unbn
	46HQvt4GG5olD4sW2L+WdJtow8b5r7c=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2.. 0/7] mcp: support multiple MCP and implement local GMCS
Date: Wed, 10 Dec 2025 17:44:05 +0200
Message-ID: <cover.1765381438.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- fix compilation issues
- remove unnecessary code in get_media_cp_op_supported

***

For Media Control Client, add support for multiple GMCS / MCS services
on the server. Revise the API accordingly.

For Media Control Server, make it a non-stub implementation (OTS still
missing), and add an API the profile can use.

Add tests.

This changes the design of the previous MCP code, so it's mostly a
rewrite.

The shared/mcp: commit doesn't fix the API in profiles/audio, that's
done in the later mcp: commit, as it's a rewrite of the API.

TODO (for later): OTP/OTS parts -- requires design for OTP/OTS
implementation first

TODO (for later): MPRIS integration to GMCS server -- this needs some
redesign in media.c as it's hardcoded to AVRCP there.

Pauli Virtanen (7):
  shared/mcp: support multiple MCP, and add non-stub MCS server
  test-mcp: add tests for MCP / MCS
  mcp: adapt to new MCP API to support multiple remote MCS services
  avctp: move uinput utilities to uinput-util.c
  uinput-util: fix compiler complaint about strncpy usage
  mcp: add local GMCS service that emits uinput media keys
  shared/gatt-client: fix notify_data leak in notify_data_write_ccc

 .gitignore                   |    1 +
 Makefile.am                  |    6 +
 Makefile.plugins             |    4 +-
 lib/bluetooth/uuid.h         |   27 +-
 profiles/audio/avctp.c       |  119 +-
 profiles/audio/mcp.c         |  802 ++++++---
 profiles/audio/uinput-util.c |  146 ++
 profiles/audio/uinput-util.h |   23 +
 src/shared/gatt-client.c     |    3 +
 src/shared/mcp.c             | 3216 ++++++++++++++++++++--------------
 src/shared/mcp.h             |  186 +-
 src/shared/mcs.h             |   51 +-
 unit/test-mcp.c              | 1807 +++++++++++++++++++
 13 files changed, 4650 insertions(+), 1741 deletions(-)
 create mode 100644 profiles/audio/uinput-util.c
 create mode 100644 profiles/audio/uinput-util.h
 create mode 100644 unit/test-mcp.c

-- 
2.51.1

