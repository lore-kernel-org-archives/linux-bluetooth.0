Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E7427470
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Mar 2026 01:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774227675; cv=none; b=ZHjCwdVZikIg6lgoOi/KsRqVm+FNw3Z3hhs5QspTzb7tCsfdjF2PDA83awien3tZTotIZ7+4bFb26QYnoiCpIsN0wGz6S/KsIb5EaUAWT2um3XLvHljcD6ddVx82EZWnSBDDrW8NmS1Wv0/0RHHj6qkgou+0EgjsCBWS+XtvcMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774227675; c=relaxed/simple;
	bh=iynx6kVVCxpJjbjwRw4R7AYtOrK/nP7zKsSEmJ1WPbI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eTW8RwYHzLwIZeFXM1zs4oYNM7Gh9IFKiAD0WQHRa19WFESqTu/M1QumUAh+02j7lV4GWPZAtaiiUy2YJp50XXDvqMynREwBzdAVBiYsm0/e7WC6UQ7zWaZCf89zYDl671fuinTDBWlk2cSpmsDAN4qnlQnQYXNLtzhuM58TT/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=none smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mCxQeX+9; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mCxQeX+9"
Received: from github.com (hubbernetes-node-35dcd28.ash1-iad.github.net [10.56.166.32])
	by smtp.github.com (Postfix) with ESMTPA id 5A5DA1210A9
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Mar 2026 18:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774227673;
	bh=4Vdi5abgo13PsgNlRgV9NA6f1I/6mjd2njsR7BOdCnc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mCxQeX+9tm4Q3puZ8twjjFEZ4WX+sSOlXWU1yvMIEteKsvYmrx4OjeYBk6yXTUhJT
	 4DXMvu0STBTAXOXsHRHBKCPZEzMq4WjNYbs+la5XDXjMElWvRMcvwIlEqnS2slbuTO
	 jBh04JaELSNCPHB3OUaWi9t7aewaxDVMHx47nLo4=
Date: Sun, 22 Mar 2026 18:01:13 -0700
From: maxinglo <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1070581/000000-1fd489@github.com>
Subject: [bluez/bluez] 1fd489: obexd/bip: Fix uninitialized memory and
 malformed ...
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

  Branch: refs/heads/1070581
  Home:   https://github.com/bluez/bluez
  Commit: 1fd4894b05fdb7e0af69c4f3ecbe6a20bbb3d22a
      https://github.com/bluez/bluez/commit/1fd4894b05fdb7e0af69c4f3ecbe6a20bbb3d22a
  Author: maxing <2965346066@qq.com>
  Date:   2026-03-23 (Mon, 23 Mar 2026)

  Changed paths:
    M obexd/client/bip.c

  Log Message:
  -----------
  obexd/bip: Fix uninitialized memory and malformed XML in GetImage request

This commit addresses several defects in the AVRCP BIP GetImage
implementation that caused strict OBEX servers (e.g., Android)
to reject image transfers with "Precondition Failed (0x4C)".

1. Fix uninitialized memory read:
   In `get_image()`, the `maxsize` variable was not initialized. If the
   client omitted the "maxsize" key in the D-Bus dictionary, `maxsize`
   retained garbage data from the stack, leading to anomalous log entries.

2. Fix malformed XML image descriptor:
   When D-Bus clients omitted the `pixel` or `encoding` parameters,
   `parse_get_image_dict()` improperly forced them to empty strings ("").
   This resulted in `get_image()` generating an invalid XML tag:
   `<image encoding="" pixel=""/>`.
   The XML construction logic has been rewritten to dynamically append
   only the provided attributes, and the previously parsed but ignored
   `maxsize` attribute is now properly included if specified.

3. Fix D-Bus iterator advancement:
   Removed a redundant D-Bus type check in `parse_get_image_dict()`
   where the iterator was evaluated twice before calling
   `dbus_message_iter_next()`.

Signed-off-by: maxing <2965346066@qq.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
