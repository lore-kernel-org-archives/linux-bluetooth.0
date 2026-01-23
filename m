Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DC72ED87F
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187210; cv=none; b=WxcBKYHlUCPupvimnOf2hlCpuWLp3UQuA/Kzs3U0Cjt87WVDyVXZRE7l98ne5gyqL6uxzcWPi0C7gYTpFYjpOF0zCXHN9rLr1JgH5gNkFFhmmJgfY/OtjKTYbTAGOIMf14+1WGHZnHkovj2HhNrAIgYyXC4XKotFKmcUBT5bvcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187210; c=relaxed/simple;
	bh=2uTxIDXCUdwhng099xs11Hn++3Z7j4t8GcNX1RDn7eA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HrrkGsUQ8Fd4UIy0hDnosp49HQTOBNfsr67rJUM+gMjkgik6AE7Y+75VhjmemCS9lvHS992Md9j9BvwnFSh3w082Qi11kKbcImxkJtjwTZWvI/8ok049n1ifbcIRTD53LZwCf0bi9hYubNTMk87MDHmEZmH0kpD07raCOvibRaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TVPNbXS4; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TVPNbXS4"
Received: from github.com (hubbernetes-node-915d32c.ac4-iad.github.net [10.52.184.41])
	by smtp.github.com (Postfix) with ESMTPA id 604EE640829
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 08:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769187208;
	bh=vxQUlfYqbTZDiGLQnWPOVaZkwGHJ3E1q61GLvDrAMgs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TVPNbXS4XOkmR0na9HgDF0NyUXanOrxg2qqi+yFBycL6Hn509sbK0YO7gdw2wec3B
	 Xbq/iQqzx6vEhQ00Odf1B4xs4SGzls/uQSFgkJ+P/B5nhGwFLzbBxh2poL3bmdmDaP
	 HWFAIlXw/R/fH6hW2lFySISDhEspnc4CVCo7FKEg=
Date: Fri, 23 Jan 2026 08:53:28 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1046381/000000-35c39b@github.com>
Subject: [bluez/bluez] 35c39b: doc/qualification: Add PICS and howto for the
 SM q...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1046381
  Home:   https://github.com/bluez/bluez
  Commit: 35c39b71cac487650d7a44d00d71f2cddf845eb2
      https://github.com/bluez/bluez/commit/35c39b71cac487650d7a44d00d71f=
2cddf845eb2
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-23 (Fri, 23 Jan 2026)

  Changed paths:
    A doc/qualification/sm-pics.rst
    A doc/qualification/sm-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the SM qualification



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
