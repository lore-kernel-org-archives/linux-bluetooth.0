Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B441EB5B
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748422786; cv=none; b=MnA65P+DvPY0YW2nPhUBNXCZ3Annj3Kv3usf6XnY0As90ED1gpKN13QgM+BHfeyogtGwGkar5XxSCkMhvdGCzpQqkJPnq+auvUvehYDanoquVr2qc5IoOTneAl25IhcM0EaFhDZm44aCYOvn/NCFDXQWgnt4DH2w22EedjuWI94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748422786; c=relaxed/simple;
	bh=DKqI+rjwFuyOolO6HJs5XWGX4ixmBttY8yGdQUtWYVI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=S1JOE53SF/HWu6bUfnLXo9nRvp1ohdJlaroTPpY2kMqV7eVyHgLOiEKHFnOYms37O6b045jiBzP87BMgfgwRH0jUxX16kKwZ7pwza4l7sFUDb6DwysHaTuC2sZRyMjLPKlzK6rqe9aUIy2ySzDqfl5LvnljqStc32Pm/rXf4JS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JnCI0QXV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JnCI0QXV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1748422776;
	bh=DKqI+rjwFuyOolO6HJs5XWGX4ixmBttY8yGdQUtWYVI=;
	h=From:To:Subject:Date:From;
	b=JnCI0QXVexdHLzWORARy2IWzAWtF1py77A1SQhrD9tWVRd+nxOzwsP84F0kFOt7q3
	 b+zDyuUmMz36zB7XTg4Nkwj8AcYYwr37k0LQfpzg0BBDPQKKJs+qM4XcD1Gh9oUJ1Q
	 Ff1GdeLSbpZO4RYBRqgPMmOMCAgu/Q9wcIr5lhpupU7yOnERZ+u85RMxrYfJxRfv4Q
	 iE5RMGUzNX4rhRnDhi0/eCjrJafDtF2NkxqqE+Xd2ZVVPOwBv8NFb+5wPOQcacJG6+
	 MjFYsR7v10LkKpPPPTRM3BvKCHm2opNU6xqgM42QV0cIDt2JFhAn1kw1J77YbOpca0
	 NAPdMMgH231+g==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-AF44-1001-C79a-7427-1C18-f6a9.rev.sfr.net [IPv6:2a02:8428:af44:1001:c79a:7427:1c18:f6a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8792217E0188
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 10:59:36 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 00/10] New Telephony interface for HSP, HFP and CCP
Date: Wed, 28 May 2025 10:59:20 +0200
Message-ID: <20250528085930.227816-1-frederic.danis@collabora.com>
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

This will introduce a new Telephony interface wich is intended to be
shared by the profiles able to control telephony calls.

The idea is to split the call control interface from the audio streaming,
as it is done for AVRCP and A2DP.
As for A2DP, the audio part will be delegated to the audio daemon (like
PipeWire) by the creation of new endpoints for CVSD and mSBC, LC3 endpoint
already exists.

The interface is mostly based on the one done for PipeWire's native
backend.

This will simplify the qualification of the telephony related profiles as
the qualification will no more depend on external projects, and calls can
be controlled from bluetoothctl.

A first implementation allows to dial or hangup a call using HFP.

Frédéric Danis (10):
  doc: Add new telephony related profiles interfaces
  audio/telephony: Add shared interfaces implementation
  audio/telephony: Add skeleton for HFP profile
  audio/hfp-hf: Add HFP SLC connection and event support
  audio/hfp-hf: Add dial support
  audio/hfp-hf: Add hangup all calls support
  audio/hfp-hf: Add answer a specific call support
  client/telephony: Add new submenu
  audio/hfp-hf: Remove call interface during profile disconnection
  audio/hfp-hf: Create existing call during SLC phase

 Makefile.am                       |    4 +
 Makefile.plugins                  |    5 +
 Makefile.tools                    |    9 +-
 client/bluetoothctl-telephony.rst |   95 +++
 client/main.c                     |    3 +
 client/telephony.c                |  524 ++++++++++++
 client/telephony.h                |   12 +
 configure.ac                      |    7 +
 doc/org.bluez.TelephonyAg.rst     |  200 +++++
 doc/org.bluez.TelephonyCall.rst   |  144 ++++
 profiles/audio/hfp-hf.c           | 1299 +++++++++++++++++++++++++++++
 profiles/audio/telephony.c        |  713 ++++++++++++++++
 profiles/audio/telephony.h        |  110 +++
 13 files changed, 3122 insertions(+), 3 deletions(-)
 create mode 100644 client/bluetoothctl-telephony.rst
 create mode 100644 client/telephony.c
 create mode 100644 client/telephony.h
 create mode 100644 doc/org.bluez.TelephonyAg.rst
 create mode 100644 doc/org.bluez.TelephonyCall.rst
 create mode 100644 profiles/audio/hfp-hf.c
 create mode 100644 profiles/audio/telephony.c
 create mode 100644 profiles/audio/telephony.h

-- 
2.43.0

