Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528E82EC0AA
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769534793; cv=none; b=Dt6nELidq+gy+hpngvVJt5ZRzinPZXzLn/TipdnxpXEBFjiQph/UXQIYx0JBCxMRCa3xalV00orqxVp8nyX1SVrNpkaJydKpXahHOroQZL2d1HGKqBWKzY2l1MOS46FmzRAEVjQtJtSZNjuOyC6m48vBOcWOV7jDHR8mz1kz04I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769534793; c=relaxed/simple;
	bh=2W89PWsOEYlvecUzPCd9las2LOBBQMAPExFSZKTd9Jk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TZd0xnJOXK89gugOdgfZVDSQyL9oqspa0J1lwsqjDdxVMcKEyzfYSq3T+OEA891Tr72nLwvr2KNK1FVFxVvndEzF+psiRXUPDusemHnwvBUYbqfaFjMnxzSqoz5Zv4V2R7GDvyaoweBUklt3iKRgPYY+21aWfbHiQ4FrwzwwwPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fceNcb/j; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fceNcb/j"
Received: from github.com (hubbernetes-node-3bdede2.va3-iad.github.net [10.48.222.66])
	by smtp.github.com (Postfix) with ESMTPA id BFAA84E04F6
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 09:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769534786;
	bh=RhYzB7rsbjQi/J/mdirPb3C9tbjZQqHUc99WFlsyihs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fceNcb/jgQ3/MApgrQTTZMBGgVzFgqHPf8gr8F3b82bkSwhd01d9xpRV2qxaNa+ZF
	 P0O6kt8IGZe8ReOULCbdxBzrlm0uuO3e9OSpY29aQCULaD3bS3HIxOiXnYgdcFraUK
	 1xhW0G5nP36l4F1xkXGnrSo24GpOj22LMlJirJvo=
Date: Tue, 27 Jan 2026 09:26:26 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047696/000000-27bdfa@github.com>
Subject: [bluez/bluez] 27bdfa: doc/qualification: Add PICS and howto for the
 RFCo...
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

  Branch: refs/heads/1047696
  Home:   https://github.com/bluez/bluez
  Commit: 27bdfa76342eb6a1fd081809caba89454edeaeab
      https://github.com/bluez/bluez/commit/27bdfa76342eb6a1fd081809caba8=
9454edeaeab
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/rfcomm-pics.rst
    A doc/qualification/rfcomm-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the RFComm qualification



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
