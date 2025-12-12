Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CD93B8D47
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 20:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765572362; cv=pass; b=ArkZWtHwN/0Er2keVUOOjA551HT4v0NDxPJ73MAJnYR41mE65yZujaucp6vd1tXBS9MgljVVNLj/nyjKBgKliLlSC9Cg8VyYlnHsgrwAxkJDTnkWM5F64V5AxyqgytQsNsn9TddWe2RKaAhCFMb5Zm+TCOVKcfO+92avgooj3qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765572362; c=relaxed/simple;
	bh=qZmvJ1CVHurhtCO8L4LG98uXb5aRKBD6UmE9H3lwLSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d9bFr5Rg34o82yYfDGBTJK0KNcOLF332le6eqo8515PIw2eQ+HvyAUH/NJR8cowjAK7pCn3X2RXMtREo4rEwMonBzwlyfluIi7VAC/RxtaYuRs1yhV6pNVJypYBSePOeePLjEM92LOYFp+hves513Sw34HB2w7E2lc2Gq9KjSAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=SXp+BdCJ; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="SXp+BdCJ"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dShLY273qzyVp;
	Fri, 12 Dec 2025 22:45:57 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765572357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=meSJeJlXqu672Pes/I0+NbFwW+G6hKM53s0LhqheVGE=;
	b=SXp+BdCJXfgE/9P00opORGxWtnfrgiM9gVMWKInInNLk2aeRbQwwmjN0QsI9gaLYk9w3Mt
	chTL8fFV/20Jcr9JX9xv5IdOUNP+jTyMJ5v7QwLZH8q3HV3bzJWLRGQL24VVexNMbTBmKw
	FUhw03Cvt0KnirbBf3EVJXLlsuS0bgs=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765572357;
	b=xcZn9m66QDMDAMw8tUc2DKiMOQmRpRy/9DKLxrXsw9rCZSlGgVwX9qbLxcy1smy7zfnza/
	MK0VYBzRVyKU6Y2d5pEIqs7+q7sadYzNcjf6CLWnG9hEX0wOaZ9dgtdLHOR/yMzn1jPrES
	ixYvKdZKIp0mKhXLBZy6InfZ8tAiSTs=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765572357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=meSJeJlXqu672Pes/I0+NbFwW+G6hKM53s0LhqheVGE=;
	b=hQAFs+6Tf3a9Ge2lmihhzSHi0OL10/VIsr2L18JrQYR7CGB1NOz1OYJMzfwkuDDwIPzoGX
	ypGIeD3NMzdRH4YqeaI7psfZG8k/qvTXGbfcyKX6iX2125uPMg8YhqtLG3yJ09v/0TEtou
	m4ipKP5JzzMtZgCnc9ZDoKXhWH/7Rik=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v7 0/9] mcp: support multiple MCP and implement local GMCS
Date: Fri, 12 Dec 2025 22:45:45 +0200
Message-ID: <cover.1765572338.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v7:
- fix -Werror=unused-result

v6:
- use only rewritten bt_uinput to be able to change license
- make all patches buildable, combining commits
- in that, split out mcp: add support for Repeat & Shuffle
- fixup: re-read of values on track change if remote doesn't notify
- fixup: make sure other values are read only after CCID

v5:
- fix -D_FORTIFY_SOURCE false positive vs. strncpy in the old avctp code
  in testbot environment

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

Pauli Virtanen (9):
  shared/mcp, mcp: support multiple MCP, and add non-stub MCS server
  test-mcp: add tests for MCP / MCS
  mcp: add support for Repeat & Shuffle for remote player
  shared/uinput: add uinput utility functions
  avctp: use uinput utilities from src/shared
  mcp: add local GMCS service that emits uinput media keys
  shared/mcp: on track changed, re-read values if notify not available
  test-mcp: check attributes are reread on track change if no notify
  shared/mcp: complete CCID read before considering other attributes

 .gitignore             |    1 +
 Makefile.am            |    9 +-
 lib/bluetooth/uuid.h   |   27 +-
 profiles/audio/avctp.c |  166 +--
 profiles/audio/mcp.c   |  808 +++++++---
 src/shared/mcp.c       | 3216 +++++++++++++++++++++++-----------------
 src/shared/mcp.h       |  186 ++-
 src/shared/mcs.h       |   51 +-
 src/shared/uinput.c    |  204 +++
 src/shared/uinput.h    |   32 +
 unit/test-mcp.c        | 1859 +++++++++++++++++++++++
 11 files changed, 4802 insertions(+), 1757 deletions(-)
 create mode 100644 src/shared/uinput.c
 create mode 100644 src/shared/uinput.h
 create mode 100644 unit/test-mcp.c

-- 
2.51.1

