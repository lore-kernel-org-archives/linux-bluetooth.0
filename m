Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A534D0A15
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 21:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.131.90.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789163014; cv=none; b=IRwPY8n3sgIadTLPGN+zYinhtlSdUGo3zbqkRMxihv7fxQY3n5lxHdm7XqX/sjfj8Q60Oc5XFY86Ql7N5uCltgeNcikK2aXWv5cvJ82fmkSR9NXA7rNJjyjCxgbwEgwnTcZpO6Fg1C/RJfnj5iMPljTC/uyFQC32k5eloItSpJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789163014; c=relaxed/simple;
	bh=6zetKOC7702JQKnViZbxj9h65uo//WIVcIDDq6hH8so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=nYAYcBTZ+aL+AZ7X76SLJOu39DtRuphFfDYENwMBiiR1rN2Ocdasd8pVwEtaq4Q2hXxv124ai9TCU7H53Gil4RKubXWT1q7V+WnIRXyDs4L+6JDaVq3OYhRqaomo9xSSUXQ4t/HjId4dPgnxYkuLOcc8LkAIYMDGe3OFB8cXcyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grantmoyer.com; spf=pass smtp.mailfrom=grantmoyer.com; dkim=pass (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b=yy+EYpoY; arc=none smtp.client-ip=145.131.90.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grantmoyer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grantmoyer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b="yy+EYpoY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
	s=2020-07; t=1789162410;
	bh=VnwRu4/qilDoW3xv4+4+JbM6gzIwzcHLyWjTORm9v94=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Transfer-Encoding:From:Subject:To:Date:Sender:
	 Content-Type:Content-Transfer-Encoding:Content-Disposition:
	 Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
	b=yy+EYpoYJMlFGVrqMNoN5svjkrjpg1PCAFQDY5Q1DF8EIWA+Id093AnisQzFlnzps
	 jCzWA0Y4d4PURcCCyMnx3ftpAwb0yLP4naUKzpxx0r88/ZrtsFAEY/6ay8I3AlGFQh
	 andebO4+S6PVZ79l3uUs68OKjHoaqTTYXQwQdhwyqELDnH01NCP5KXslifhdAi1eOA
	 a4IFD2+6yRCPRXRNC9q6BbS9JzbT/alNDWkWnQWgqYwoGgr34rdJn6lcqeBSrLeKDy
	 SN/BxrfbdUVuSResM7cIg2XD6XiBXvPavIng/1Q1M52GmgDO+b67RF9UK9yQUdEeWz
	 XfZqJMkLWayBA==
From: Grant Moyer <dev@grantmoyer.com>
To: linux-bluetooth@vger.kernel.org
Cc: Grant Moyer <dev@grantmoyer.com>
Subject: [PATCH BlueZ 1/1] org.bluez.service: enable D-Bus activation of bluetooth.service
Date: Fri, 11 Sep 2026 17:32:53 -0400
Message-ID: <20260911213253.766659-2-dev@grantmoyer.com>
In-Reply-To: <20260911213253.766659-1-dev@grantmoyer.com>
References: <20260911213253.766659-1-dev@grantmoyer.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

D-Bus was configured to activate dbus-org.bluez.service, which is only
an alias for bluetooth.service, and so isn't resolvable unless the
service is already enabled. This means D-Bus cannot launch bluetoothd
on demand in most cases (for example when running bluetootctl without
the bluetoothd systemd unit configured to run at startup). This changes
the D-Bus configuration to activate bluetooth.service itself, so that
bluetoothd can be launched by D-Bus on demand.
---
 src/org.bluez.service | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/org.bluez.service b/src/org.bluez.service
index dd7ae8f1c..2a3b05758 100644
--- a/src/org.bluez.service
+++ b/src/org.bluez.service
@@ -2,4 +2,4 @@
 Name=org.bluez
 Exec=/bin/false
 User=root
-SystemdService=dbus-org.bluez.service
+SystemdService=bluetooth.service
-- 
2.55.0

