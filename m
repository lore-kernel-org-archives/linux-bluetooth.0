Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3522F5322
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765570368; cv=pass; b=LnPBnYrbu89+PNcu/PDkOghSkqRXKj+Zz81VATWKwCSC/16Omj/WY10+8FG3DWdBvoKzHTmwdv/BgZmEwhShR172h3XDseZawY8dLwlBOXEPteEjyBQ3foCkkrRUSoYHBUbAEfNYuZsjxcG3ylkUozD7rwuJxHL4GwnncAz8U94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765570368; c=relaxed/simple;
	bh=9fxMb3/ECy54AW9dXxWw9LPQ6VC3XHaUZCXbbMFBuR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WtfVFdy+5YlNhfgkJJOzGgaEVC9JeEV/Tz+l7MQx+uoDyZdtA1jkJZqbadicC6i0SLsKl1mfzQoFYlIar3JMmuaRNmh6Gv9N9Zux+kevzaAhFE71B4u7OZ2vtGEAWqr+b/RjWNSaBYSUO3coueKF/RBNd8NwtlGEIZFA6RHG9BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=BuHb92Vi; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="BuHb92Vi"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dSgc30dg5zyVp;
	Fri, 12 Dec 2025 22:12:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765570355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kBJ3cGpH2o5zXh3q253V2MouW/w3V2ecERBDgk5Tsts=;
	b=BuHb92ViLZ6+G/8K0d4Y7lA0XACX1/lB5JsZ/Ta76Mj1ZW1HYUp6+rbEAok7zpMFJf5rwF
	luWwsRpeieJzulzPzH8Is1n2eEtu+0UaeOkOUTn5Hkegt1ctklk3L9bLBgAUjzXZ2IFxWr
	cUE+lv9rTsOpcu4XLwxP29ho6MCDFNc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765570355;
	b=cN51NzETOLqCuTa3J8s2IZoPGlB3ZXU6ds+7BZOwSgZ/0qL6qc49yHLLfWf4vX0ecm2ihD
	Ia24AhVOy6lOBVEgoN0JFk009o6/CsnnEK5GgHsOKjdGhmW3Sr2dPtFdvuWOSpYqWFAYMn
	O7RMtoAbRRDaRPeWlqZKFAdl4f0iOJI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765570355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kBJ3cGpH2o5zXh3q253V2MouW/w3V2ecERBDgk5Tsts=;
	b=pa/VcznTfpoipukZgxNPFE1ZaC6E84Nli8CvuDLdFnX5UW+GsnmdTYiEoBTlmF/P5BA3fJ
	Xr3415Th4BrHAYyWun6xPiussNbr5OZ9tfA7+mI/YFyceOOgHil79h16cykbvu/VZJlRQF
	S6k/E74AutpjSFd7y7SRHls5QBvDx2c=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v6 0/9] mcp: support multiple MCP and implement local GMCS
Date: Fri, 12 Dec 2025 22:12:22 +0200
Message-ID: <cover.1765570334.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

