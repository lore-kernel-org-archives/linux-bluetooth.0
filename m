Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12A52EF64D
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166065; cv=none; b=Z57uFOC2Vnyx5uzpGhPNIhRjtyBZ4Ep8llInob29uw1TBn2ZekOpYUTsZdQbTB3x2q9OmaAPmhrR3kjBl6QW41EjL9LxXLMBVwQOWWm52REh/P2NdQ8KgpILFeiHgTh/634IHqZu02+RltjcrlPjWWo96vuJS2B+Oo7ONVQGRyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166065; c=relaxed/simple;
	bh=1c9IwBvydkE9fCFwSU2YFNkaR+LHFxChZj2FU/TzkP8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KiDwAQ1NBeZOFq39hcMjuUYQEImg5BsyIGArEmwPrlK9yJJUeyzJG/WQaET44m/1sPTeZkQgbux3F+bTB+HiCFtJrPcty4rxvwpmKgaEuaAH8/xJCQRrykcDEOe5M1oU5y+ntEVNdmO9A7Sdmv/fvAVmtVWUNEAO0vTHzbTsRWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gA1Onqwg; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gA1Onqwg"
Received: from github.com (hubbernetes-node-9ab790f.ac4-iad.github.net [10.52.223.18])
	by smtp.github.com (Postfix) with ESMTPA id CAFA56411F9
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 03:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769166063;
	bh=yTPLBK7zxVq0MYYPJYJZCPaeh8yx/7xclOqSgOVENls=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gA1OnqwgN9qL6lj/jaUmP3IH9jCW92DIjZDmGnPuS017oF4PVEpCsg4dIMDq8aRE5
	 IzDyp/f4DjLOEugNDqpKCxcmL56MqjFhORQfzTe2GHUhBXlVPwdY+ZRYfwE1Y+AAZA
	 ZQLNvWTH2O7BrqSRy+uCJh/yrlVCk709Qp223B5U=
Date: Fri, 23 Jan 2026 03:01:03 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1046202/000000-ded731@github.com>
Subject: [bluez/bluez] ded731: doc/qualification: Add PICS and howto for the
 GAP ...
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

  Branch: refs/heads/1046202
  Home:   https://github.com/bluez/bluez
  Commit: ded731738c414a64e5a68a5db3edee3092c9b0c7
      https://github.com/bluez/bluez/commit/ded731738c414a64e5a68a5db3ede=
e3092c9b0c7
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-23 (Fri, 23 Jan 2026)

  Changed paths:
    A doc/qualification/gap-pics.rst
    A doc/qualification/gap-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the GAP qualification



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
