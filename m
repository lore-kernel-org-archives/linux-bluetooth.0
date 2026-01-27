Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1192D060B
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769534796; cv=none; b=metaZoP9ChtQ4yTE+u0ugZ0iZD99FhkdoNAiRWjd02u8QyhG1jtEuwxfTcZsebi7SmYtslRi7BpICimUUO+Pwo58KEa7ic+pudFmUMIjwDP6slDAFuMdLORmcNBqjQHhV6EldplbmEUc52mNEEb/Zk3YX1CJ5LvM0soQcRGO4fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769534796; c=relaxed/simple;
	bh=uaCuWrVEl6LhTBrJiIxXTwhtp9dkKyPr2zgROPdmunk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JT0EqpzdPenVXQvCDphjTPbKGfLpjgpyYh81FQR0rXPLO3ra3BYuohAbpw9tQN411xMs8z4wg7rEoZ/KdYyrCVCp1jcx87HDSKDwMHdN509ZCDE5HTMfwoPfYu6RmeHjsxGvTEpX0YKqyOsDHfrBn/vB/vIt4LdLGt5c7VLQlaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=msM8S/uL; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="msM8S/uL"
Received: from github.com (hubbernetes-node-f3a5782.va3-iad.github.net [10.48.204.29])
	by smtp.github.com (Postfix) with ESMTPA id 22B0DE0BC7
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 09:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769534788;
	bh=z3T7qoiRG0GR7rfXMyy8O5DD0tdGM05GBczGDa6dUPk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=msM8S/uLpCoO4X5VGbuCTvYwjrHvjyplaQ8k8lqSWalmOc3QOEv1EN4FHsz1qLQOx
	 ktjLS8qZcFKiwwrLyAAakxI6/KhNxFOO+iM7xvCayEx/FAPIxxH994CcCLBoOobbYj
	 TiMWUwn82o1Mt8oJzjkHPgxdhlnLdxVEPXdGzPcA=
Date: Tue, 27 Jan 2026 09:26:28 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047697/000000-221b97@github.com>
Subject: [bluez/bluez] 221b97: doc/qualification: Add PICS and howto for the
 ScPP...
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

  Branch: refs/heads/1047697
  Home:   https://github.com/bluez/bluez
  Commit: 221b9788ffb224e6a6a5c3296106177a2a2eea71
      https://github.com/bluez/bluez/commit/221b9788ffb224e6a6a5c32961061=
77a2a2eea71
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/scpp-pics.rst
    A doc/qualification/scpp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the ScPP qualification



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
