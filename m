Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B60F283FE5
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 13:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979913; cv=none; b=a8kMXWsZJhgSE6xkancUI9wxyFrJ/ikFdbrRy5wAu7LYX8iJNJlui/KcKUJAws87W2hImvBmMYR0+l+zDkgpBsEmADwFEuKl+EHoEe9Z3M+wTYxyMblxvU/eVgEGce/53DpgxAmhAUgGR+CgZTlKukQ7MNN6Qm3XQy2N1p1RYo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979913; c=relaxed/simple;
	bh=kZ1yfK59F6QVou4CGJyPXpcQXAgGo/JDvsQppOAN22w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RM7JKAVjUmVh60Nxx4Tf/idH0XSWDVFiA9+e9IC0sl107kKeXRr86Sj3MuYj+iOnHFAI9E+vvNi5We/5Ixwv69jR0mL+IvYUnEYygIScHtHDuaIdhgvbzpDGqEUk7upneq7gdMQyS1JMAmQjR8L2sCZro5aJCJrcPzFBDR1x+ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=e4n4dIy7; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="e4n4dIy7"
Received: from github.com (hubbernetes-node-c933555.ac4-iad.github.net [10.52.169.42])
	by smtp.github.com (Postfix) with ESMTPA id 96B17701232
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 06:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751979911;
	bh=xwJ0Soip1wLvv1tqA1h50UY4ZJg0INpiNw+U0bVy1tY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=e4n4dIy73R1XXF0CCpqHpQ/TNjykcTZHYVawYifSRGs43pxCKU7kM5DgXvn8X1EMc
	 zdotQ4g37o2YQEgtl91QR3/YH+31mZgqqUoM2XxQUOF+ja7PXRElUvHMfMoAPmcpXU
	 Jdp4HZtu/qojbkRiEkWUKyT+a1LxVA8CBub9xgIg=
Date: Tue, 08 Jul 2025 06:05:11 -0700
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/980052/000000-ae0f45@github.com>
Subject: [bluez/bluez] 7a7878: mesh: crypto: remove dead function declaration
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

  Branch: refs/heads/980052
  Home:   https://github.com/bluez/bluez
  Commit: 7a7878dea8d3ef872ddf5f49caf9a4ae9871db6c
      https://github.com/bluez/bluez/commit/7a7878dea8d3ef872ddf5f49caf9a4ae9871db6c
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M mesh/crypto.h

  Log Message:
  -----------
  mesh: crypto: remove dead function declaration

The implementation of mesh_aes_ecb_one() has been removed in commit
dfed4839463f ("mesh: Convert crypto to use ELL wrappers").


  Commit: ee1b470e458441079660fc7a2725d56d84c9d579
      https://github.com/bluez/bluez/commit/ee1b470e458441079660fc7a2725d56d84c9d579
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M mesh/crypto.c
    M mesh/crypto.h
    M mesh/net.c
    M unit/test-mesh-crypto.c

  Log Message:
  -----------
  mesh: crypto: remove unused function parameter

The 'relay' parameter isn't used by mesh_crypto_packet_build().


  Commit: 4f46f3ae455b09dfeaca918abed98f600de70f2b
      https://github.com/bluez/bluez/commit/4f46f3ae455b09dfeaca918abed98f600de70f2b
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M mesh/friend.h

  Log Message:
  -----------
  mesh: friend: remove dead function declarations

The implementations for these functions have been removed in commit
f246d31a7752 ("mesh: Friendship clean-up and rewrite").


  Commit: 8cded5bc96e801503cbdf7d441767c8f4e5b3a1d
      https://github.com/bluez/bluez/commit/8cded5bc96e801503cbdf7d441767c8f4e5b3a1d
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M mesh/mesh-config.h

  Log Message:
  -----------
  mesh: mesh-config: remove dead function prototype

mesh_config_write_address() has been added in commit 78668a02d6c4
("mesh: Change mesh_db prefix to mesh_config"), but an implementation
has never existed.


  Commit: ae0f45a0679c42a9408142eb9f48f6eb2299ebdd
      https://github.com/bluez/bluez/commit/ae0f45a0679c42a9408142eb9f48f6eb2299ebdd
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M mesh/mesh-io-mgmt.c

  Log Message:
  -----------
  mesh: mesh-io-mgmt: Fix NULL pointer dereference

Don't try to dereference 'pvt' if it's NULL.


Compare: https://github.com/bluez/bluez/compare/7a7878dea8d3%5E...ae0f45a0679c

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
