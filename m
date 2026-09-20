Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEE61FF7C7
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 05:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882097; cv=none; b=QpnHLLtRgS+xM8aS53/ndH8yVYX8efNt14/UIcpSjCdTmdiXLri7ZlcxXLQ0GDz66WtPwo7Lf//CmXLuh4kNqGAWBLc8GY7g0yOoaI2UyTLtxwJaO+qn+bjw0m2/jaArsSlHBIPqRJDBPk7yxQWrgbQjtfRr1UFE261KaiAsuD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882097; c=relaxed/simple;
	bh=yTZzGX9qeZmO1VwNAfBvvYgm3vuMTtKI1JWvPY1BVgY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kui8I/fLk2hLOUZqFkVD6+ll6a9EyU2O+eywvUOpeoqmE0LlVuKFx7FFcHtTmTauPTDHMQsogfPl5PGEZIDW+Dc9xBYyr8e7OAoW7mjb3QpvBi4avzPSK9+L7QvQkDGq265l59Y3V19Y5ZTFyYazEHN+cFIxHKuit9GiwYbaJyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AQBmJcSS; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AQBmJcSS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789882095;
	bh=dxhPxb+arFxSxe5z4n+o/iRf6NQHwmRN5gVYbkt9Etw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AQBmJcSSQQCX/HpVbTqKw4A1xMTiC+xvml64ZSIEHpTq+ub/Wmcp0rkbIcoLgRyFM
	 ux6RSrt2De+41+e5PWMSPtdUQg9LCR63AU+AIOl09BV38c4K3RUvFINLC8iL1qViC9
	 4OiiEVPzmVaw/jqeyQjdjSjlvJRKgnZ5PYdQDBS4=
Received: from github.com (hubbernetes-node-b6c8a22.ac4-iad.github.net [10.52.13.21])
	by smtp.github.com (Postfix) with ESMTPA id A0744780860
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 22:28:15 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:28:15 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1149440/263b7f-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1149440
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
