Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AB7286D70
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347829; cv=none; b=UZpPALKGHBWXymXQhkZxjruN46HpVKjMmwnT20d4rpmk5UvenO/96o/B2qMauxi8HEEd+MFgCLxRjDQvF+7bxowmsYOf8k2vWh2RLjf5xEREEUntNEp23phfC4AADaQZ4pQbgzabNKYSGuyUD1S5koQUnADMTyeL+ZG59wxToic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347829; c=relaxed/simple;
	bh=5PYQYZ76EVrnFVpDEtMTwPMf7+EEN2KKGEXFxu5y3VE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Qo3IexOL1WIVhZvBHywJBGQ2k2WPTz0fU+NbaPZmbIzkSUKwmpicr9J0mwM15gUD3RdBr8IwMEB8CD7uVSXUS0QN6VFcmra29Ns/jFQZQ2HARBI6MeaWndP/lAhG/7/Id68sO5Q7z7faBAS347pmgZ3CcqvswLy6j8AeVhKYYD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Eu2rWFIX; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Eu2rWFIX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790347827;
	bh=8yS4yXLzneBHS+OtlzZtCxw0K8Zg0KqrxWJhNX42heo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Eu2rWFIXmVCD8vwgvccc+kQSH6d3sZW76DRCOiF8DtSmNW+WyIAkGoKCD7g607+4i
	 ROOJPnxhwI/LXTuPDzv9fLfobgyM1FEIMLDtr7ajfQIPJv+bBevJ8FvTENAG1uiO3V
	 uBCdMiFAdwLWAOc0YO0b8+M8rjtDuURAOJ5G/tSs=
Received: from github.com (hubbernetes-node-aeeb487.ac4-iad.github.net [10.52.221.66])
	by smtp.github.com (Postfix) with ESMTPA id 43225401BE
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 07:50:27 -0700 (PDT)
Date: Fri, 25 Sep 2026 07:50:27 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1173751/000000-c88882@github.com>
Subject: [bluez/bluez] 7e3a67: doc/qualification: Add MCP/MCS PICS files
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

  Branch: refs/heads/1173751
  Home:   https://github.com/bluez/bluez
  Commit: 7e3a6779fe62c2d6a33bc9c9fc565185583cdd94
      https://github.com/bluez/bluez/commit/7e3a6779fe62c2d6a33bc9c9fc565=
185583cdd94
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    A doc/qualification/mcp-pics.rst
    A doc/qualification/mcs-pics.rst

  Log Message:
  -----------
  doc/qualification: Add MCP/MCS PICS files


  Commit: c88882bef3ee06c1b2ab782cd1f8fe9479a0541a
      https://github.com/bluez/bluez/commit/c88882bef3ee06c1b2ab782cd1f8f=
e9479a0541a
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    A doc/qualification/mcs-pts.rst

  Log Message:
  -----------
  doc/qualification: add MCS tests documentation


Compare: https://github.com/bluez/bluez/compare/7e3a6779fe62%5E...c88882b=
ef3ee

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
