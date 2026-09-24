Received: from mail.discnull.de (mail.discnull.de [46.224.56.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8853C2B80
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.224.56.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263487; cv=none; b=r8uyzCiYCP7kP4lKqm3NQNr5uXh/c70mjsOETH5esFvpk5aS5XFntXOjYceBvz7c1cGZILIz7SJzsDzINoffp0Qsi/YqF+9Ok/B+N6dVu/KHYZfL3VRK6EsHPqdx533Vkdz53J7NAhKmbFAl6OTptCMsM/cCunVaDJfn2Str5Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263487; c=relaxed/simple;
	bh=2xpmdN4Wb0ASiyJSGHRYfEje3W4UzB/elU0omys230o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=swkBEIid8nTQ1j/szG1u30zsSug1YQd0Sb0t3tb//UXUyikZ10z2Wr4TjSdtkMOqhHDzPmZhL9Ms9pb+rWa06BxT6RqjUos3sjJrtAUEfjcju4fd6bf4V48vYXueYFZ60+V4b5ytSb7S+pH3DeaRH+H2R2tuI4HoPCZuvd4u2pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=discnull.de; spf=pass smtp.mailfrom=discnull.de; dkim=pass (2048-bit key) header.d=discnull.de header.i=@discnull.de header.b=JXI0VP5j; arc=none smtp.client-ip=46.224.56.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=discnull.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=discnull.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=discnull.de header.i=@discnull.de header.b="JXI0VP5j"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BCE727D492;
	Thu, 24 Sep 2026 17:17:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=discnull.de; s=dkim;
	t=1790263076; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=oBZQY+2rty7dB/5b0bZkJe62NgArOolGEg3wvNA3HNI=;
	b=JXI0VP5jVXrmHyiUeAfRULobhfhZlHvKazp6lG1QVBWipetUO8AvuZJMr+KjqtCG5H0EbP
	0iDypaFLx0qLQsEwVS0XPuGd6ZZySzzN0tucuQhoo8fcJNYvwI50hubo7gIGmW/fsYYaUU
	UmhuiSkxiLHEPbONN4D0IteRp17ND0Ba4uLPZ3hW3VAS12w77hm37uFIsUKnE67dUMaLQ3
	u6bgjvTjFxIkxedMBKWcDEHFFx86xxf1aq2+S4X7+xcdeMLOEWDo4eoye42KcWcwQ8Uwke
	ejQPX/+Qz/yOSZrrsOcrb6Wik/q7V58SYmcsUUgvyOcynifK4MCx6G4B+og8Bg==
From: Alexander Sarmanow <as@discnull.de>
To: linux-bluetooth@vger.kernel.org
Cc: Alexander Sarmanow <as@discnull.de>
Subject: [PATCH BlueZ 0/2] org.bluez.LEAdvertisement: Add broadcast name support
Date: Thu, 24 Sep 2026 17:17:18 +0200
Message-Id: <20260924151720.1769259-1-as@discnull.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Alexander Sarmanow (Televic) <as@discnull.de>

This series adds dedicated support for setting the broadcast name via DBus
to the org.bluez.LEAdvertisement object. Should make it easier for upper
layers to set this advertisement property.

The Public Broadcast Profile (PBP v1.0, see section 5.1.1) restricts the
string length to a minimum of 4 and a maximum of 32 characters. If the
provided name is shorter than the minimum, pasring returns an error.If it
exceeds the maximum, it is truncated, consistent with the behavior for the
local name.

The BroadcastName property will be parsed in any case, but only added to
the advertisement data in case it's of type broadcast.

Tested by setting a broadcast name via pipewire bluez spa plugin.

Alexander Sarmanow (2):
  doc/org.bluez.LEAdvertisement: Add broadcast name
  advertising: Add broadcast name property support

 doc/org.bluez.LEAdvertisement.rst |  7 +++++
 src/advertising.c                 | 44 +++++++++++++++++++++++++++++++
 src/shared/ad.h                   |  3 +++
 3 files changed, 54 insertions(+)

-- 
2.30.2

