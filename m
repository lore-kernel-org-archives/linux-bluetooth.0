Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6E918FDD8
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277851; cv=none; b=NB2rcGmV0TAEQXHAlVPBdi8UzumiIGQH+hnOSrIf26M+Yi0nsfF4Z9pLz4e3Lt7vfiO7B2vH7fhwFtZN2WnUOkhbOXNUSfxJ0gGs91TpuJ+5Kkxci/ftmf8HJPEzWoDZO3R2b1orgS6gpRmJlJt99L/vup19M9x/H/76n5n09ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277851; c=relaxed/simple;
	bh=135KIuSVdj46YXIEKCxQmQ9mCHkAoyXYTTSdSK2eIY8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Wwe4A28/MfszAdfWl16QQrXt2GYY5vGqZdcsXjCBK0/JAThdRwp+TuozLroJpK7vEx0syEFJzbCx+yUyoNj1zN/fsgAAr7nkD1FFZSniF6/2Yvp+klLhRT9CI9MGdeJURfL7A7nzI9vLImphT5xNZUfwkONWcZ9Tb19cw1jfO6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=COKEqNIB; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="COKEqNIB"
Received: from github.com (hubbernetes-node-6e64cb7.va3-iad.github.net [10.48.201.118])
	by smtp.github.com (Postfix) with ESMTPA id 634CF4E0BF8
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 08:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1741277849;
	bh=2d/y1pIgZmh6E7B9GSTNV6MtHUBo2VIQIR13vpFYi/8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=COKEqNIBYeiOou5aJvKvw+lDWT++p+IPMhvY9RoH2c8Rjub4ClBmE3fWDZ96WLdxo
	 esm+JA4CWd6OovsPWpwnkX915i3O6th2gl5FnftBF337t34PJV5/YuUnLBXXDq2CUD
	 JYoYKyfTpPloW34Fh1VVmUuonpH9Z4Yc//mO/ee4=
Date: Thu, 06 Mar 2025 08:17:29 -0800
From: iulia-tanasescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/9a32b6-26bc1c@github.com>
Subject: [bluez/bluez] 2ca6e5: shared/bap: Add APIs to register broadcast code
 ca...
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
  Commit: 2ca6e5215830919b699deadb6e64ebbd37a22bb7
      https://github.com/bluez/bluez/commit/2ca6e5215830919b699deadb6e64ebbd37a22bb7
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-03-06 (Thu, 06 Mar 2025)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Add APIs to register broadcast code callback

This adds support for registering Broadcast Code request callback with
shared/bap, to be called when a BAP Scan Delegator needs to receive the
Code from peer Broadcast Assistants.


  Commit: 518d2a7aa566f6826367a3a5330cc6344f81e7cb
      https://github.com/bluez/bluez/commit/518d2a7aa566f6826367a3a5330cc6344f81e7cb
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-03-06 (Thu, 06 Mar 2025)

  Changed paths:
    M profiles/audio/bass.c
    M profiles/audio/bass.h
    M profiles/audio/transport.c

  Log Message:
  -----------
  bass: Register broadcast code request callback

This updates BASS to register Broadcast Code request callback with
shared/bap instead of having a public API, to avoid making direct calls
between plugins. The registered handler will be called from the transport
plugin via shared/bap.


  Commit: 26bc1c9cd9dfe3877220173edd58f53c457b9d26
      https://github.com/bluez/bluez/commit/26bc1c9cd9dfe3877220173edd58f53c457b9d26
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-03-06 (Thu, 06 Mar 2025)

  Changed paths:
    M Makefile.plugins
    M profiles/audio/bap.c
    M profiles/audio/bass.c
    R profiles/audio/bass.h
    M profiles/audio/transport.c

  Log Message:
  -----------
  bass: Remove interface

This removes the BASS plugin interface, since plugins should not make
direct calls between each other, but use the shared files instead.


Compare: https://github.com/bluez/bluez/compare/9a32b6144d8a...26bc1c9cd9df

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
