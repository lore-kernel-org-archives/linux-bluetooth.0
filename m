Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768382EB87D
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 20:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765572660; cv=none; b=thZ2TXQX1U5dLhOIkPGFG/e0LPY2DJpvQsXDEJoDC4xb5aQIejyd8o4RgPisyKW3PEvsC/HOBJMGeZhgw2HTbx2tkDMTfUpGMHjGI2EJah9VF6usatg3QZVqIuSsUavpHDNyxBiAjSySDvZdOFx9g9wXKq9oSSFsJoa3/1z7iLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765572660; c=relaxed/simple;
	bh=qHLkNhnoZCfd5+ELI5yYgNxcUxeARKJNT6NOeeS8f8A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=htZu77JwrpT5UID0uV53Oax+j6oNn11va5/B1sJXZHZPq5p89Fda3DahN0od6z04GQyBAp7SGoRRPQyKCzN08usOvpam8+IfmtOr8I8evHvojdR2tzbunf5nbginCP4HvkiVexIGWXgcOo0ZtGvuCGRfZrdXma2b82DNjEAvUbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YNNcmWT+; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YNNcmWT+"
Received: from github.com (hubbernetes-node-0e903f5.ash1-iad.github.net [10.56.226.50])
	by smtp.github.com (Postfix) with ESMTPA id 80488920448
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 12:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765572658;
	bh=2AEhkhaAPvlsgssftWN8lGp82eM6wNj+ZmsggIPPSiI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YNNcmWT+m7gGk+KcAnC5izIKqYjDw2Tr54EyQw1jRk9k5UlOi1QfpIWeL26TOIxfN
	 E4VD3T5qJFJswbrVzcWIQaFZXTj5HSZfH7Y0bqVdIJyvag47tmVBvbJoqISIGcW28u
	 OxAok7SgxfUl2OfpcZ/HoTUjUQynGqWxdjn92vf0=
Date: Fri, 12 Dec 2025 12:50:58 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032751/000000-a992b5@github.com>
Subject: [bluez/bluez] 737884: shared/mcp, mcp: support multiple MCP, and add
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

  Branch: refs/heads/1032751
  Home:   https://github.com/bluez/bluez
  Commit: 73788476d4a7b1f07cfd6d8dc9653e6c069b3a1e
      https://github.com/bluez/bluez/commit/73788476d4a7b1f07cfd6d8dc9653e6c069b3a1e
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


  Commit: d2b0cc438b78636e5d93633103f7c3b07d48f53b
      https://github.com/bluez/bluez/commit/d2b0cc438b78636e5d93633103f7c3b07d48f53b
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


  Commit: 9e7e5d8f85335dc4db441453f247bd8c76b80a26
      https://github.com/bluez/bluez/commit/9e7e5d8f85335dc4db441453f247bd8c76b80a26
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


  Commit: 7c1a45bd46f6a6ce9b79e2fb007856cbf6693ac0
      https://github.com/bluez/bluez/commit/7c1a45bd46f6a6ce9b79e2fb007856cbf6693ac0
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


  Commit: 3c3f19c8600febbd944ccd573d75ec2217e79980
      https://github.com/bluez/bluez/commit/3c3f19c8600febbd944ccd573d75ec2217e79980
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-12 (Fri, 12 Dec 2025)

  Changed paths:
    M profiles/audio/avctp.c

  Log Message:
  -----------
  avctp: use uinput utilities from src/shared

Make use of the src/shared version of uinput_create() / send_key


  Commit: c4190846065d580b2050ffba60d9f2190863bb08
      https://github.com/bluez/bluez/commit/c4190846065d580b2050ffba60d9f2190863bb08
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


  Commit: a7aa7f6c20bee2b75ab71a8678745ee73fa33d83
      https://github.com/bluez/bluez/commit/a7aa7f6c20bee2b75ab71a8678745ee73fa33d83
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-12 (Fri, 12 Dec 2025)

  Changed paths:
    M src/shared/mcp.c

  Log Message:
  -----------
  shared/mcp: on track changed, re-read values if notify not available

Notify is optional for some MCS attributes. To get new track titles etc.
re-read values on track change, if remote does not have notify on them.


  Commit: 466bd25bdadc919caad5585e83ee086f5d3a7e1a
      https://github.com/bluez/bluez/commit/466bd25bdadc919caad5585e83ee086f5d3a7e1a
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-12 (Fri, 12 Dec 2025)

  Changed paths:
    M unit/test-mcp.c

  Log Message:
  -----------
  test-mcp: check attributes are reread on track change if no notify

Add test we reread attributes on track change if remote does not have
optional notify features.


  Commit: a992b51df5e35a733a62b435319fbb04153d2beb
      https://github.com/bluez/bluez/commit/a992b51df5e35a733a62b435319fbb04153d2beb
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


Compare: https://github.com/bluez/bluez/compare/73788476d4a7%5E...a992b51df5e3

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
