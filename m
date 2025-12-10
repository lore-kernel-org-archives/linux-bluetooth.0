Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F58E30DD21
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765383204; cv=pass; b=P5bo8GVjUqUXBwkAkOYuq06gPVE8zxU0AfURxZmINIp+eWru3rTiBrYTPIjXErCZzmxOwyx3rgu6pFhVweJcujybcx2cU/Cre19H84KOb7eNGlCszDoZfofkb/pNH6ldSOUDRiOj4iL3TGDirOKooiVtl8lM9d4niNejah3VxIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765383204; c=relaxed/simple;
	bh=edS7Bg7Wcp17ok4o96iyFZodnxfUjK6coSreMOKDeXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8Pl9T/HSWxTalMqduzay5sOMaUlie7jiqLlU2esbwd7NZQTpsbIF6yehlmmJeWxYgol4PSFneNkDHnd07JQbQcw7McyBIXTsMqQXq52JKfGmP7e+Ds6SFf7S1xx4qpB4H3CPfmLnOJGWiVtRyM1rikIJ/IScbALi77IveseW7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=gRyBIeCy; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="gRyBIeCy"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dRLNt4FjczyQH;
	Wed, 10 Dec 2025 18:13:18 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765383199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rJsHIdcKngxMlrZ+apc4qplVamCY/DEbQFbcpLrNG7E=;
	b=gRyBIeCynGbDhZjOsCPTKydCOqM6f+v/+J7h5uVUHsv2DzY90UZQCkSSwkYjFAp8hQSVsq
	JIpyJghzx4jQEXzu9p3qNfJgmk1iTuMJROhhlVNAKWqUfSa7P7Vki3f2TqaAS38Yl69I3O
	2Ga6GGlIs1R14KbVaPIMG4ZdTCiZ294=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765383199;
	b=I+vXJRG2u9QGTaq8Te5bp92ZZMszSSncnYKLdRYIrF+wovcBQ4qceKBN/yZaTc47rUVJi8
	QSW+R+fNhPqLDEAhTVbB4fLtZoiFRWM9GqIckQcvKFgidA3TqNzz0uwWzdHF1XkI8hO1u4
	VVkpKUlQ8OYDeqSrQjn1eZdKwOAChY4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765383199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rJsHIdcKngxMlrZ+apc4qplVamCY/DEbQFbcpLrNG7E=;
	b=G3liKR1IP/XERgZIhH0+3jM4BaxAYUYDfa8QhL3vdbEH5NxLHhSDs6FtEHT8zFELjtIr3a
	Qp+Zq2j4wa9yGTo55U+mfojKR7Nygr+S2ZAZruU7L+ePpGyFmlAc2O9OLCf9+1iL/XBXCs
	0ARLegz13eahFNoCiY0goEQVbBsy3w4=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 0/7] mcp: support multiple MCP and implement local GMCS
Date: Wed, 10 Dec 2025 18:13:08 +0200
Message-ID: <cover.1765383173.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 profiles/audio/uinput-util.c |  148 ++
 profiles/audio/uinput-util.h |   23 +
 src/shared/gatt-client.c     |    3 +
 src/shared/mcp.c             | 3216 ++++++++++++++++++++--------------
 src/shared/mcp.h             |  186 +-
 src/shared/mcs.h             |   51 +-
 unit/test-mcp.c              | 1807 +++++++++++++++++++
 13 files changed, 4652 insertions(+), 1741 deletions(-)
 create mode 100644 profiles/audio/uinput-util.c
 create mode 100644 profiles/audio/uinput-util.h
 create mode 100644 unit/test-mcp.c

-- 
2.51.1

