Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EB7288C3D
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765480143; cv=pass; b=sSKMq1pqAsjZFADPeiSxEri/US4CTP7Q0KYJvDkJt7v7h7Kipg0DTVhlQ/jJy1XGqDBX9hWVLIdRb4EUlsjG6K8jwwhD4z1CLP5XGEqaq48y1lWi+uOYsludsvtO075ijagO7NL2yNHr2otFxxORHSPj9A1Us186uC3/XyLfM8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765480143; c=relaxed/simple;
	bh=HxZNJ+Bi0cT3HpoUS7hpqkmsFdn5JBkaadL496CImp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DTlzW+gldUAX+B+qC9RxC1unAqkaNKVosgqr5KT8cuHaWK2pHMGJvWNMeRFlNcRbuibkfbFSZmKqQtB3H8lGudFxMrWfUHqjpfc2JjmGQ42sA4UWXaGqjQmLwlt25X7M6kRkz0uQjbF2bJDmcOE2iG5kAeOGOxHx9QmfQxu7DLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=zMnXdM6n; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="zMnXdM6n"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dS2Dz0zWqzyQR;
	Thu, 11 Dec 2025 21:08:50 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765480131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mRIwlA18vvnWdMcj8gBWJw55lKbE3/BiChS/L4N1kP0=;
	b=zMnXdM6nF4iAgv0wNMBST22bs5cULxYWOFIXX8WYx9zgJaf13u8Y4V1T0d93YH4aM9etFM
	C8jLOL6d1bqvkf3NH5DhvUZUr9su87o8rnPa1CZXbVXIo+y9jSSGN37MagG5SJQMHoPRiI
	Fz8th2p3kuj0tPu3hytIvWnYg4OeCxY=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765480131;
	b=TngrmUQCZ/l3cJcHa1GdLLEuggemzvCmL/iHfo5sXKP1ONfGJ4iyg1WtzsEMlsFPcxxz3q
	QzOhBPD6jPFYOq5u03cQUMPl061r04aEWOuDFVThltJmOyn8I+usATBJqpbkHs/uqhxXMK
	bp+zIiB2UmRzT15ay6acItrHw1/IKxU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765480131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mRIwlA18vvnWdMcj8gBWJw55lKbE3/BiChS/L4N1kP0=;
	b=XIj/tvApd1OwwlSf9H8jUim/EONk9oqOqlKsPBEwxnTlIAAoArncEBmHqvN+C5/lujMYPG
	ZiZ239UQyO1rzHX6afMA5WawXPb2UL81I4InAU6qgCuTlWLKNgNcX3Bt2CJKG6LIqxjqo/
	ptDMTeY652Fp7HLdBwPnDmE02IjJoho=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 0/7] mcp: support multiple MCP and implement local GMCS
Date: Thu, 11 Dec 2025 21:08:40 +0200
Message-ID: <cover.1765480081.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4:
- move uinput-util.h to src/shared + adapt accordingly
- improve debug logs in profile

v3:
- add missing #include to fix build in the test environment

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

Tested devices (MCS):
- Creative Zen Hybrid Pro (doesn't even connect without GMCS)
- Samsung Galaxy Buds Pro2
- Creative Aurvana Ace 2

Tested devices (MCP):
- Samsung Galaxy A56

Pauli Virtanen (7):
  shared/mcp: support multiple MCP, and add non-stub MCS server
  test-mcp: add tests for MCP / MCS
  mcp: adapt to new MCP API to support multiple remote MCS services
  shared/uinput-util: extract uinput utility function from AVCTP
  avctp: use uinput utilities from src/shared
  mcp: add local GMCS service that emits uinput media keys
  shared/gatt-client: fix notify_data leak in notify_data_write_ccc

 .gitignore               |    1 +
 Makefile.am              |   10 +-
 lib/bluetooth/uuid.h     |   27 +-
 profiles/audio/avctp.c   |  159 +-
 profiles/audio/mcp.c     |  812 +++++++---
 src/shared/gatt-client.c |    3 +
 src/shared/mcp.c         | 3216 ++++++++++++++++++++++----------------
 src/shared/mcp.h         |  186 ++-
 src/shared/mcs.h         |   51 +-
 src/shared/uinput-util.c |  195 +++
 src/shared/uinput-util.h |   31 +
 unit/test-mcp.c          | 1807 +++++++++++++++++++++
 12 files changed, 4742 insertions(+), 1756 deletions(-)
 create mode 100644 src/shared/uinput-util.c
 create mode 100644 src/shared/uinput-util.h
 create mode 100644 unit/test-mcp.c

-- 
2.51.1

