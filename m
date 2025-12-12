Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D51C2D73BB
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765570938; cv=none; b=Ite14s3qVutjsLUPnENtux0EBOphvHI5zAIVGVQjPK3qPKCUjADgBuMSc4002m+sjAT5JScUHYCXjRzjSPdkD063edeywuxWtpjnsjqGqogD70BdgRPR77mevNqwNbO6Uhzegxy3v3ylxQQokwsYqSfHDXfCemLt87jGinzSREk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765570938; c=relaxed/simple;
	bh=jBdKyhhS2b1JW3kYiHUEWdceV6K/zOJu/zBHx9H0Mbw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fT4RKqSDLLq9BYyfw+yVAaknZrTrnAwSfGrYQDXXxdip0tRZ1ht5SXKYRzjezOIhYrRp82oJBwOlIOdT7f/eeglbLyNohtMcyYnduuXeEQn2Ow9pgnnQYuKu9FKp+ntxbHZYAKY/u34vl4ufrQkWWRowrhk517Un53xMU2uP4Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=l80Kq5n9; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="l80Kq5n9"
Received: from github.com (hubbernetes-node-2b4eaac.ash1-iad.github.net [10.56.128.74])
	by smtp.github.com (Postfix) with ESMTPA id 8958C9211A0
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 12:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765570936;
	bh=7v+AJKDt3XLt0zZItjXInt6VDMBukQh8G7y5ZSGiIFQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=l80Kq5n9tFrqYaecPPuC05OieD4uDKS7/DetuaUKmjT2MUaSqwL21DR1OJXUOHzaJ
	 7CV5qvH8LS2L02RVbtpHirhf5KLadoXAzoT64K4WoRdEGdNzG3GuvuKx2QIrYdrw2m
	 3CWeWl/UHUCisSgRZxTX5sOImKMk6+B9RdAI2zLE=
Date: Fri, 12 Dec 2025 12:22:16 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032730/000000-b00b63@github.com>
Subject: [bluez/bluez] b45440: shared/mcp, mcp: support multiple MCP, and add
 non...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1032730
  Home:   https://github.com/bluez/bluez
  Commit: b45440cca48dffcd0cc0f33dbc4bc815edb85a1b
      https://github.com/bluez/bluez/commit/b45440cca48dffcd0cc0f33dbc4bc815edb85a1b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-12 (Fri, 12 Dec 2025)

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


  Commit: 2d71b6f901e5bf0df2b9a21058e5beea21a4a21f
      https://github.com/bluez/bluez/commit/2d71b6f901e5bf0df2b9a21058e5beea21a4a21f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-12 (Fri, 12 Dec 2025)

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


  Commit: 8f5d3d9e2d011df33050920b75412118413d58d7
      https://github.com/bluez/bluez/commit/8f5d3d9e2d011df33050920b75412118413d58d7
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-12 (Fri, 12 Dec 2025)

  Changed paths:
    M profiles/audio/mcp.c

  Log Message:
  -----------
  mcp: add support for Repeat & Shuffle for remote player

Add support for toggling remote player playing order settings.

These do not fully map to current org.bluez.MediaPlayer Repeat/Shuffle,
but try best effort mapping.


  Commit: 795424a01efd552bce742fe046842c1326365a7b
      https://github.com/bluez/bluez/commit/795424a01efd552bce742fe046842c1326365a7b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-12 (Fri, 12 Dec 2025)

  Changed paths:
    M Makefile.am
    A src/shared/uinput.c
    A src/shared/uinput.h

  Log Message:
  -----------
  shared/uinput: add uinput utility functions

Add uinput utility function that can be used both for AVCTP and MCS.


  Commit: 1a4067c650edef4385c04de80ff2ab3316b0521b
      https://github.com/bluez/bluez/commit/1a4067c650edef4385c04de80ff2ab3316b0521b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-12 (Fri, 12 Dec 2025)

  Changed paths:
    M profiles/audio/avctp.c

  Log Message:
  -----------
  avctp: use uinput utilities from src/shared

Make use of the src/shared version of uinput_create() / send_key


  Commit: 1563041a4c66c7a368de4e149b54ae9717d7bafd
      https://github.com/bluez/bluez/commit/1563041a4c66c7a368de4e149b54ae9717d7bafd
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-12 (Fri, 12 Dec 2025)

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


  Commit: a99047749c8e7cc1b642516e32c970bf7d1807e0
      https://github.com/bluez/bluez/commit/a99047749c8e7cc1b642516e32c970bf7d1807e0
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-12 (Fri, 12 Dec 2025)

  Changed paths:
    M src/shared/mcp.c

  Log Message:
  -----------
  shared/mcp: on track changed, re-read values if notify not available

Notify is optional for some MCS attributes. To get new track titles etc.
re-read values on track change, if remote does not have notify on them.


  Commit: a2ff5f082013d6be3ef60c9e1736d76b740f1abd
      https://github.com/bluez/bluez/commit/a2ff5f082013d6be3ef60c9e1736d76b740f1abd
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-12 (Fri, 12 Dec 2025)

  Changed paths:
    M unit/test-mcp.c

  Log Message:
  -----------
  test-mcp: check attributes are reread on track change if no notify

Add test we reread attributes on track change if remote does not have
optional notify features.


  Commit: b00b63b3f692db1d2ae4f9a1b1e1fa0414b9d4b3
      https://github.com/bluez/bluez/commit/b00b63b3f692db1d2ae4f9a1b1e1fa0414b9d4b3
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-12 (Fri, 12 Dec 2025)

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


Compare: https://github.com/bluez/bluez/compare/b45440cca48d%5E...b00b63b3f692

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
