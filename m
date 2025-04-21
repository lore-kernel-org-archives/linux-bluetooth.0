Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6AA29D0E
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745234016; cv=none; b=jRvg8ygh8FujfSCxUxInt/FsdM0zs73CrmKB6p5my+YIw9iAsWlVk/QhY+zx0orWMTszKPyNbyzVGh9GCzLGgFDIFeEMNakP0gKjnJENfQQNuOeyBAfavrFwEjhqXPfLiECp9VEIzrKVKgnII66HySU9PB2BpnNpjnlFj2kJrFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745234016; c=relaxed/simple;
	bh=GI25HrXWQAU3WpowxX7mAHaQmEX4DD76QzVLvQ3iXyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPL6nMK/a4M847s3n4ZYog/SGhIybJ5xFmp3y838JHDBsxkZOYJk0fXLAU9U3mPumP1Jiu27btjkO3eDW2B1/nW5l9ooq6redtR0yppLesqd6MVIoR1DHRXY3jCpXXg77mbcUj+E5EVzit7yJPPhYLMUY9ix0NwvQh1rA6uEUqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YaF2/MyY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YaF2/MyY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745234006;
	bh=GI25HrXWQAU3WpowxX7mAHaQmEX4DD76QzVLvQ3iXyo=;
	h=From:To:Cc:Subject:Date:From;
	b=YaF2/MyY5iCioPXZjUKq/MnsAroBssWFUV2amEdGRJCbtkmrTSbWp0sq3ekA7pV9T
	 LJMLZAZWL6dgYxhKFtP2Y/iyyI+p459Aqyy0kHyPhQjj0YpR4+12mh2/Dxdj3RQdBe
	 VOBsu7uBehzGlZvophm5yMl8oI4xQIHRyboxluec8Gh52rOwkrtiWy4ZxtBEW72iwL
	 7nXPq1Sw9mzmn/q7K7XrO58A2ufAvVQ/vkTlVWMHDd3XjEFFmG7CChIuifVHujeDEa
	 eNkrx0GTzAHIc4SUrIGCsDQuyx/A7Z2Vj4s+kXFH6FWAQC53UUlsoIfHfAg5YV/rOi
	 DshN6GYFvF+ZA==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E5A2817E00FC;
	Mon, 21 Apr 2025 13:13:25 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ 0/5] Support Sixaxis gamepad with classic bonded only
Date: Mon, 21 Apr 2025 13:12:46 +0200
Message-ID: <20250421111251.108943-1-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a new "SixaxisCablePairing" property to allow us to
indentify sixaxis devices that have been paired using the canonical USB
cable method. With that information, we can dynamically enforce
encryption to drastically reduce the attack surface, compared to just
disabling the "ClassicBondedOnly" property.

The "SixaxisCablePairing" property is exposed via D-Bus to allow
clients to potentually show this information to end users.

As far as I can tell, starting the listening input server with
BT_IO_SEC_LOW and then bumping it in `hidp_add_connection()` should not
have any negative effect regarding the overall security. However,
please let me know if it turns out not being the case. 

The last commit "input: Validate the Sixaxis HID report descriptor" can
probably be reviewed and merged separately if needed.

Addresses https://github.com/bluez/bluez/issues/1165

Ludovico de Nittis (5):
  src: Add new SixaxisCablePairing property
  client: Print SixaxisCablePairing value if BlueZ was compiled with
    sixaxis
  plugins: Set SixaxisCablePairing property when pairing a sixaxis with
    USB
  input: Start the server with sec low and bump it when making the
    connection
  input: Validate the Sixaxis HID report descriptor

 client/main.c            |  3 ++
 configure.ac             |  3 ++
 doc/org.bluez.Device.rst |  6 ++++
 plugins/sixaxis.c        |  5 ++-
 profiles/input/device.c  | 77 ++++++++++++++++++++++++++++++++++++++--
 profiles/input/server.c  |  7 ++++
 src/device.c             | 44 +++++++++++++++++++++++
 src/device.h             |  3 ++
 8 files changed, 145 insertions(+), 3 deletions(-)

-- 
2.49.0

