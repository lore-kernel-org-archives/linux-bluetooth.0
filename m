Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5B61EDA3C
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 20:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765484169; cv=pass; b=klPELcK16msPOaNmwOX1jaQwtSZHy6k8n8e+MOMgz7uUqLd0unQdkKOm4fo1fuzFWOLB/sKQyPYzIR4rcLcxWWq7C6iRcBxIe01ZfP5BV9q8ts1gBWI1hY+0TjqXCHi4nRIRJsQnR6eWoYkDBlup8OcplO4T4qFHY7BA7wIAQ0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765484169; c=relaxed/simple;
	bh=HZcwbTdpuzMHhBxDSSYoAZq2jBjJVr8vI60CIZPn+hw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZ2WlueBBxBY8hOO7F0rDpHKWjdRqiYSez0/jO1fvQCMkVF+tv6K0kMMApg8MzLSUHZFlo7sH0FZrZlPCTqdXtqvuZK/AlxGN7xHfTSp6qa1KIgn7UBzh9j7S0sVx0UF4JXeKCeD1RWmPJrbJvERmb7dALIaI5TRcJid994PWB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=MbM11kz/; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="MbM11kz/"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dS3kV55MGzyQR;
	Thu, 11 Dec 2025 22:16:02 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765484163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i+Se0pBGrALJgLpDWn+04xH6Xv9WaDWKWgsBfDDqAow=;
	b=MbM11kz/juXx1wrzuYJ0wL+Sc1xzy3VEymeApLKROnx2fIEmdavPG6MwMALaLniAYk2BPC
	9lGRJQzWQ6Dfd89yY5AMwtOv0fD6ZD6nwxaeA8J0mzMgWNPg+j1yRcY+Qq9uXoZ+wP7+sI
	weZtsrHdIfN7OGyjbza6HzkeMfWMSVc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765484163;
	b=GCFNA8DSMZzTJaasP7sVsqZ0OBJ+HUWbFXJsvhQx8BOHyrtYhfS+oyqn4vbitr46i1VYCg
	TvVRvmn7m/VVst59xfcznB5kPNtM5fWupxyJ2IYTmstKcvdZDCC0osO+hNl2Pc/bM9Cb2A
	mXTVhcM9ag2H6gnq5TZ6+jRJ5MEMSrg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765484163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i+Se0pBGrALJgLpDWn+04xH6Xv9WaDWKWgsBfDDqAow=;
	b=wzRwff1quc+gmwlYniKoNN39SAbwoeCt9mNkWvOwmDX7XlUiJNnGo44gg7r+RePNT+Tty2
	dUpKy1b1PfsJKJKnD/Tds+1HGDNZb2Hzbs9EZXPMyBh3wF2KFXQjHhoSiTAN8NlkakqlIO
	+YSmeV303nhmGD2jEPTyI6SwbCfOU6U=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 0/7] mcp: support multiple MCP and implement local GMCS
Date: Thu, 11 Dec 2025 22:15:52 +0200
Message-ID: <cover.1765484150.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 src/shared/uinput-util.c |  191 +++
 src/shared/uinput-util.h |   31 +
 unit/test-mcp.c          | 1807 +++++++++++++++++++++
 12 files changed, 4738 insertions(+), 1756 deletions(-)
 create mode 100644 src/shared/uinput-util.c
 create mode 100644 src/shared/uinput-util.h
 create mode 100644 unit/test-mcp.c

-- 
2.51.1

