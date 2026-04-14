Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1648F264619
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776184983; cv=none; b=Oy8me+YU+OLDhPmbY3B/fcNaOcJDoo82piOEYiSMHSjSSW8OVdt+cgfM2PMJyzXZLxZyYz+MgQJsLrxWmKEPnYDsSEmpMePdj8z3A7UnsTWXXotV24AY23F1guHVwIfcJsk22zgjqQgJ86BfyQ1cBm3NK4K0iG94gUCaJJ0PErY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776184983; c=relaxed/simple;
	bh=BXTgxj1yx/dBxzcXm+ph2rNVaV72IHQjLn9u+NEIvP4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=E64VELFdrlWQRkZkjUiaf3DKQpSXNaJZcXKCaQyx4fk7yfjP/FamqS0yWwsw2UzPshr5I2gB3JD56w4Bv+jax+ifemOYpOaP66h9F5E7mp2lEo/t2gV7Eng2t2dIfChFSqENVt28r05bldga0OUwnKn+eJKyEizR7jdlWSJ0cmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gc8KW3k+; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gc8KW3k+"
Received: from github.com (hubbernetes-node-1e77013.va3-iad.github.net [10.48.209.43])
	by smtp.github.com (Postfix) with ESMTPA id 6352E9200F6
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 09:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776184981;
	bh=qdNlnwPK9RGFwSV+p5DJbDIy1zFlxLkx53LRwGzNIt4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gc8KW3k+Li+YR589DDZkcgexPNmYqaWxTZvS/fBjQykye/NnP7P+Ql1WOKYRxAu46
	 5hG2RW1cIIiVYreXyo01znokFQWANYJ1KSmtXzenNWtnmW8v4/qvsraRjlhOGmPdQe
	 1+edN4Iu6LN02aiv+IosaAoeaBIlimb6GaXXXa5Q=
Date: Tue, 14 Apr 2026 09:43:01 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/1ab128-d6171b@github.com>
Subject: [bluez/bluez] 5797a6: bass: Fix crashing on BT_BASS_MOD_SRC
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 5797a61809ae0a214389b12c99b614ddd522f38e
      https://github.com/bluez/bluez/commit/5797a61809ae0a214389b12c99b614ddd522f38e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-14 (Tue, 14 Apr 2026)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Fix crashing on BT_BASS_MOD_SRC

If assistant attempt o modify source the code would attempt to iterate
over all valid range of BIS indexes which may lead to the following
trace since the delegator maybe freed in the process:

 #0  queue_find (queue=<optimized out>, function=function@entry=0x58b8761109c0 <setup_match_bis>, match_data=match_data@entry=0x3) at src/shared/queue.c:230
 #1  0x000058b8761127fb in bass_update_bis_sync (bcast_src=<optimized out>, dg=<optimized out>) at profiles/audio/bass.c:1824
 #2  handle_mod_src_req (data=<optimized out>, params=<optimized out>, bcast_src=0x58b894661be0) at profiles/audio/bass.c:1862
 #3  cp_handler (bcast_src=0x58b894661be0, op=<optimized out>, params=<optimized out>, user_data=<optimized out>) at profiles/audio/bass.c:1910
 #4  0x000058b8761bc978 in bass_handle_mod_src_op (bass=<optimized out>, attrib=<optimized out>, opcode=<optimized out>, id=<optimized out>, iov=<optimized out>, att=<optimized out>)
    at src/shared/bass.c:1069

To fix the code will now just interate at existing setups checking if
they match the BIS index then adding/removing the stream so it is no
longer possible to free the delegator before all setups are processed.


  Commit: d6171b00a2ae342c2b8266b6ee3350133ec55f20
      https://github.com/bluez/bluez/commit/d6171b00a2ae342c2b8266b6ee3350133ec55f20
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-14 (Tue, 14 Apr 2026)

  Changed paths:
    M .github/workflows/ci.yml

  Log Message:
  -----------
  workflow/ci: Add checks:write permission and explicit reopened trigger

The CI action now creates individual GitHub Check Runs per test, which
requires 'checks: write' permission on the GITHUB_TOKEN. Also make the
pull_request trigger types explicit to include 'reopened', allowing CI
to be retriggered by closing and reopening a PR.


Compare: https://github.com/bluez/bluez/compare/1ab128f6d749...d6171b00a2ae

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
