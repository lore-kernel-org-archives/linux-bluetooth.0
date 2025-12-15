Received: from o10.sgmail.github.com (o10.sgmail.github.com [167.89.101.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22E933892F
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.101.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765817385; cv=none; b=LsqqNAvmX0QBlyjJn3eTLtJDc1gYuJmg0NFzVXnHHT7pKg7gcXhaU2m5S7+v2a82eoa+uYIyJxpWLldSVDrSdch5Q767TL5/QdbomERsDbNkk81IG4Rx6eZ4AXPz9dKYvYKUlPPidMUmE+O3x+fmz5K0SLL+wgmkgqmvfoRyIig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765817385; c=relaxed/simple;
	bh=VTsXvjDVgxhUlcPhE0XRrufuxfwv+Hrvw4glxpHiJto=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=GPwg1KOcoqFj3cSq3bjh9pdiaGcR2zRY9QjWRPbvU2z1wErGiVWsQPCBybWP4OH64hhQ3i1j2LyhlNWKsP32njbm1oPlZPcyI1A5ilx28FNxgbDPq+x+uAGp7U344ew8OEZ564y9t83yVYWz31iPVYTSCIGd/ioxcgGHPYCsAjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=beiEwfdr; arc=none smtp.client-ip=167.89.101.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="beiEwfdr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=FEZ2GtBkp9Hv/hwSD099sd8g8IhskIVO+zRpkx88sFU=;
	b=beiEwfdr6r/rdiIMZ+nsaMwVxZa0fxTww5b2YhCWWERDkdOkfam2+PGk+HBmk7ban/rg
	GBbVzmXy0n3XRxgSIeRnlHOFw5JqbVouXzNVl57DPSISxUcraneHJPWIL7r44M5ax6/v1F
	5tDFPTQCCfJk3h0t2khvXk/ZI+cxZr+uU=
Received: by recvd-78f8dbdb7-k7l46 with SMTP id recvd-78f8dbdb7-k7l46-1-69403C26-10A
	2025-12-15 16:49:42.77669042 +0000 UTC m=+2395258.503991893
Received: from out-21.smtp.github.com (unknown)
	by geopod-ismtpd-8 (SG)
	with ESMTP id umZk3LR_Sh2n0hCF95GZgQ
	for <linux-bluetooth@vger.kernel.org>;
	Mon, 15 Dec 2025 16:49:42.768 +0000 (UTC)
Received: from github.com (hubbernetes-node-d5b3929.ac4-iad.github.net [10.52.133.35])
	by smtp.github.com (Postfix) with ESMTPA id 79A824011DA
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 08:49:36 -0800 (PST)
Date: Mon, 15 Dec 2025 16:49:42 +0000 (UTC)
From: Pauli Virtanen <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/master/a2ef82-2ec29c@github.com>
Subject: [bluez/bluez] 9027ed: shared/mcp, mcp: support multiple MCP, and add
 non...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: 
 =?us-ascii?Q?u001=2Ezu6eUoWwK70GvXWP+kE2GIYMQflaq6Ix3rraxcwcvSqstVpfwwfs1H7iT?=
 =?us-ascii?Q?j=2Fu7Mau0w5pPZd2OpCSrPHF+2C5b3td6fDaSkgc?=
 =?us-ascii?Q?gtnx58HouwkKvE6=2Fev=2FDWeyHSJO6n2KuMn41oW=2F?=
 =?us-ascii?Q?zZHxutLcOzakRspIvAU5KN02IwbSElM0oH3BCMb?=
 =?us-ascii?Q?AuAMSwzVU1HXBhlMidl1=2FL2Y7UnfyFGS+LEHz=2FW?=
 =?us-ascii?Q?io+Cwa5Eu00iYzxq=2FXh8FhbIgI7Olm9jdZt9hMq?= =?us-ascii?Q?LeDV?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 9027edc4604ed6be3e1d8d741df1441577d1ae58
      https://github.com/bluez/bluez/commit/9027edc4604ed6be3e1d8d741df1441577d1ae58
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-15 (Mon, 15 Dec 2025)

  Changed paths:
    M lib/bluetooth/uuid.h
    M profiles/audio/mcp.c
    M src/shared/mcp.c
    M src/shared/mcp.h
    M src/shared/mcs.h

  Log Message:
  -----------
  shared/mcp, mcp: support multiple MCP, and add non-stub MCS server

For Media Control Client, add support for multiple GMCS / MCS services
on the server. Revise the API accordingly.

For Media Control Server, make it a complete implementation (OTS still
missing), and add an API the profile can use.

This is mostly a complete rewrite.

Adapt also profile/mcp.c to use the new API, adding support for multiple
MCS services on the remote side.


  Commit: 90d78210f222c0960ada7b39839d6ce5291680d8
      https://github.com/bluez/bluez/commit/90d78210f222c0960ada7b39839d6ce5291680d8
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-15 (Mon, 15 Dec 2025)

  Changed paths:
    M .gitignore
    M Makefile.am
    A unit/test-mcp.c

  Log Message:
  -----------
  test-mcp: add tests for MCP / MCS

Add tests for the Media Control Client / Server implementation.

This contains basic GGIT and state transition tests.  Not all state
transition tests are here, as they'd largely test the upper layer of the
profile which is not tested now.


  Commit: 0a4a07d9a1e871d05ad8706d84e0171af8f9ffd1
      https://github.com/bluez/bluez/commit/0a4a07d9a1e871d05ad8706d84e0171af8f9ffd1
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-15 (Mon, 15 Dec 2025)

  Changed paths:
    M profiles/audio/mcp.c

  Log Message:
  -----------
  mcp: add support for Repeat & Shuffle for remote player

Add support for toggling remote player playing order settings.

These do not fully map to current org.bluez.MediaPlayer Repeat/Shuffle,
but try best effort mapping.


  Commit: be02c3e92e1671e0eb88628384147be466790699
      https://github.com/bluez/bluez/commit/be02c3e92e1671e0eb88628384147be466790699
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-15 (Mon, 15 Dec 2025)

  Changed paths:
    M Makefile.am
    A src/shared/uinput.c
    A src/shared/uinput.h

  Log Message:
  -----------
  shared/uinput: add uinput utility functions

Add uinput utility function that can be used both for AVCTP and MCS.


  Commit: 174e812b8aea92b741b3ba6d7a1a795428a9dc42
      https://github.com/bluez/bluez/commit/174e812b8aea92b741b3ba6d7a1a795428a9dc42
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-15 (Mon, 15 Dec 2025)

  Changed paths:
    M profiles/audio/avctp.c

  Log Message:
  -----------
  avctp: use uinput utilities from src/shared

Make use of the src/shared version of uinput_create() / send_key


  Commit: d3089866bd2e1787bf69635e9625c083a785af4e
      https://github.com/bluez/bluez/commit/d3089866bd2e1787bf69635e9625c083a785af4e
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-15 (Mon, 15 Dec 2025)

  Changed paths:
    M profiles/audio/mcp.c

  Log Message:
  -----------
  mcp: add local GMCS service that emits uinput media keys

Implement simple GMCS service that is always inactive, and emits media
key presses via uinput for Play/Pause/Stop/Next/Prev MCS commands.

In practice, this seems to be enough to support media control keys on
headsets.  Some headsets (Creative Zen Hybrid Pro) also refuse to
connect if there is no GMCS service.


  Commit: 6734c19cb4c62e8ad47d9075a41f8e900de68c66
      https://github.com/bluez/bluez/commit/6734c19cb4c62e8ad47d9075a41f8e900de68c66
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-15 (Mon, 15 Dec 2025)

  Changed paths:
    M src/shared/mcp.c

  Log Message:
  -----------
  shared/mcp: on track changed, re-read values if notify not available

Notify is optional for some MCS attributes. To get new track titles etc.
re-read values on track change, if remote does not have notify on them.


  Commit: 809091c8b3ee4596fd51d8d5256c15e8f3621577
      https://github.com/bluez/bluez/commit/809091c8b3ee4596fd51d8d5256c15e8f3621577
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-15 (Mon, 15 Dec 2025)

  Changed paths:
    M unit/test-mcp.c

  Log Message:
  -----------
  test-mcp: check attributes are reread on track change if no notify

Add test we reread attributes on track change if remote does not have
optional notify features.


  Commit: 2ec29cc98ad5d32e9323e654ae5c1ec3bdac3994
      https://github.com/bluez/bluez/commit/2ec29cc98ad5d32e9323e654ae5c1ec3bdac3994
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-15 (Mon, 15 Dec 2025)

  Changed paths:
    M src/shared/mcp.c

  Log Message:
  -----------
  shared/mcp: complete CCID read before considering other attributes

Service is shown ready to upper level when CCID is read, after which we
should notify upper level about current attribute values.

Make sure the values reach upper level, by reading them only after the
service is ready. Otherwise, the reads may complete in unspecified
order and upper level misses some events.


Compare: https://github.com/bluez/bluez/compare/a2ef82f1aaa9...2ec29cc98ad5

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
