Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DCB4E235C
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887202; cv=none; b=U7IIb5tiFfzkNv7gNypbEPgV56EW38Of+7euXzFF5aL0BAUGIc+oJA54WRKIlvX7gDrMMVqUCYseiyMXFW79pcdB8VegZWvPaKwC6aA0arE7WtGYvRudE59/c05Um+CB38D9hsno3KeTk1IW3PVgPUWQTNTcGgu2ts/Qj4EUEw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887202; c=relaxed/simple;
	bh=yx9KnM1Kx0jX+T87X6vE+Cc6nPhumVTcXGDKVLDvxk0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=n7ABrDyWvgTZBASCZYm+vubTTAKVJCSK0vYB1xcbAitjU2e1u0Si15Luc977ANoI6U3BbF0SvInBvoQyy6fMP1aQfctbF5KPK6SWBWFhHdj3iGHoGJVeYRy7wgES1Ep+T22TOQ4KlkehuRxU6PUMFGgFHdwLVFsfGZtUGa7HfaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=M+jHYGXP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="M+jHYGXP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788887198;
	bh=yx9KnM1Kx0jX+T87X6vE+Cc6nPhumVTcXGDKVLDvxk0=;
	h=From:To:Subject:Date:From;
	b=M+jHYGXPH9aJ8XSGg+ghnL2PA7elCUSZ4Xxuwzj0d9aoV8b9aScL+Q45GELjbpGjz
	 NPPrYgsQ/z07gwmguBUQCYgf6JQDRpp3WmA/DivK1mesJYcpjIj42gGmxDrsjlUkh0
	 zzwHE1fz+2ALsL5O4qSBE6bzTv061OoD6zAagfVAGEgsxtgaC06yx0Y/O1YGTYVELG
	 WcicaPMqMfrzSOpNekefLCgtpUfoj6DHWzd2rLKMZo8CQxkTOXIresJTQ95TKXN3Ps
	 tLfs6FKSXvxQurgPEzN6q8qle53muruHc8HsDXBv9D87ipJoY8aVNukwFj2WiRrkdm
	 mzELBg/BlkVWg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CCC2417E0917
	for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 19:06:38 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/8] client/btpclient: Add BAP/ASCS/PACS support for auto-pts BAP tests
Date: Tue,  8 Sep 2026 19:06:25 +0200
Message-ID: <20260908170633.510244-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This series extends btpclient with support for the BAP, ASCS, and PACS
BTP services required to pass the auto-pts Basic Audio Profile test
suites (BAP/UCL/*, BAP/USR/*).

- Patch 1 adds BTP_EV_BAP_ASE_FOUND, needed by BAP/UCL/SCC/BV-004-C
  and BAP/UCL/SCC/BV-019-C.
- Patch 2 fetches Codec capabilities when replying to an ASE.
- Patch 3 introduces ASCS BTP support: audio endpoints are registered
  via the VENDOR service's ASCS setup command, and the
  SelectProperties() D-Bus reply is postponed until auto-pts has
  requested the ASE and PACS characteristic values, allowing
  BAP/UCL/SCC/* tests to pass.
- Patch 4 adds BTP_OP_PACS_SET_LOCATION support to store the expected
  location for a local endpoint.
- Patch 5 adds BTP_OP_BAP_SEND support.
- Patch 6 extends ASCS support to cover the BAP/UCL/STR/* tests.
- Patch 7 fixes CIG/CIS id assignment to be deferred and based on the
  Unicast Client/Server role, matching what auto-pts expects (0/0 for
  Client tests, 1/1 for Server tests) instead of eagerly assigning
  CIG 0 to every discovered ASE.
- Patch 8 adds automatic stream acquisition and data sending for the
  BAP/USR/STR/* tests.

Together these patches allow btpclient to pass the BAP/UCL and
BAP/USR auto-pts test suites.

v1->v2:
 - Fix incremental build for Patch 5
 - Fix stream connection when transport interface is created after
   auto-pts requests enabling ASE

Frédéric Danis (8):
  client/btpclient: Add BTP_EV_BAP_ASE_FOUND support
  client/btpclient: Get Codec capabilities on ASE reply
  client/btpclient: Add ASCS BTP support
  client/btpclient: Add BTP_OP_PACS_SET_LOCATION support
  client/btpclient: Add BTP_OP_BAP_SEND support
  client/btpclient: Add ASCS support for BAP/UCL/STR/* tests
  client/btpclient: Defer CIG/CIS assignment based on Client/Server role
  client/btpclient: Add stream auto acquire for BAP/USR/STR/* tests

 Makefile.tools               |    7 +-
 client/btpclient/ascs.c      | 1649 ++++++++++++++++++++++++++++++++++
 client/btpclient/ascs.h      |   21 +
 client/btpclient/bap.c       |  381 ++++++++
 client/btpclient/bap.h       |    4 +
 client/btpclient/btpclient.c |  194 +++-
 client/btpclient/btpclient.h |   36 +
 client/btpclient/core.c      |   75 +-
 client/btpclient/gap.c       |    3 -
 client/btpclient/pacs.c      |  107 +++
 client/btpclient/pacs.h      |   13 +
 client/btpclient/vendor.c    |  103 +++
 client/btpclient/vendor.h    |   13 +
 src/shared/btp.h             |  156 ++++
 14 files changed, 2752 insertions(+), 10 deletions(-)
 create mode 100644 client/btpclient/ascs.c
 create mode 100644 client/btpclient/ascs.h
 create mode 100644 client/btpclient/pacs.c
 create mode 100644 client/btpclient/pacs.h
 create mode 100644 client/btpclient/vendor.c
 create mode 100644 client/btpclient/vendor.h

-- 
2.43.0

