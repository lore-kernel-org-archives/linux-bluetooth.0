Received: from out-30.smtp.github.com (out-30.smtp.github.com [192.30.252.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A5E2D876A
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777389738; cv=none; b=Y5Idxkrybs5JJorOgQTchuLgYNI4Tabt+GNbX/31SiRbH2MDcRnUYa2pm06A0Zp6JRPsAxz/Bv1n6kiO/IzpeEE2fUpBKJedxE21EpuiKioCGUFKbaHrQ+XpaVxgrWCPyBiJcagOXt1QF0f8ferx1VWTgoxzc4AKFhoEf3l3JJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777389738; c=relaxed/simple;
	bh=xUu2uqrCpt+cqynq/fKf7y+iduK7vk43CPvRhbgKES4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CjXec5EBvHeU9Iw9xq7F+wn3lspdZnS6mBn6zCFFocglQa78EGgfvpRgpFBVO1okhSk4RIBZzufCCcglbWYFRpw3F23WrtZ0BynSYn8LcbIa2gkh8RlErnsGMbOaa8pnCCadlILujT4eNIDMzgsQTHLDxrlfhg6W+pvp3gdWMXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dgeoBbgx; arc=none smtp.client-ip=192.30.252.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dgeoBbgx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777389736;
	bh=sbKJJMrlmmdLqK8JWkX4kgmieg8YmUE1c30IcIKfUHE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dgeoBbgxTuyAPNo08WaX/59SL0uJvZaJcLdb2ZrXpOEHii1OTnZv+42uGmaLFuylJ
	 fkmQzDPPuCr5EG+zTqY8ru0+nKeKn3PtdN4R8LvVEORkaZ8+RSMGcfYsXbBus49cA0
	 EzXxbsRrIjIr6C+Nys4ytvnewVCA4YHWVqNkMD+s=
Received: from github.com (hubbernetes-node-935ba89.ac4-iad.github.net [10.52.177.35])
	by smtp.github.com (Postfix) with ESMTPA id 9806C32123C
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 08:22:16 -0700 (PDT)
Date: Tue, 28 Apr 2026 08:22:16 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/83ddf4-b3729e@github.com>
Subject: [bluez/bluez] b3729e: bass: Fix crashing on BT_BASS_MOD_SRC
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
  Commit: b3729e26cc42fb1477f325c994b2a51b34f929d7
      https://github.com/bluez/bluez/commit/b3729e26cc42fb1477f325c994b2a51b34f929d7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-28 (Tue, 28 Apr 2026)

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



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
