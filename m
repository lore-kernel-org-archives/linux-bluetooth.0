Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C2525E469
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771270799; cv=none; b=rafsPX0rtXq3gBgHNsLNWklmfh7Oiv2mLhr+/fEWuLp5kBSh0hCx+nrpspoxuZyDc7j83Rxfo1IEPTpcbbbSarIca9hzwfXut6d9HuW1Hmj+EX5pwAqaGWjpGqKyrYYH9P8HWX0PPj8LptUK/qHl9N1kvMtq/6jshgpJCQS0NcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771270799; c=relaxed/simple;
	bh=+WTxgECWJDEmyqhMva/4rsnpyrRFk9DhQla7f26pf/c=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZzVef2eOax/DSO1HSY2cTWZgWdKwmRtWYX9MpGX1CfIpaR+1WlPWw5mysAfYebpjW8tVLnHCfkjUX15MdFB77Lfy1dzlw7izhVxByfLG+T2MzRuw2ZVN0Tq0F57SqdsEc6WWiLDHjnkR9pwEOh/13acWIhwgOs9UHajoECK8F6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=M0klptH1; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="M0klptH1"
Received: from github.com (hubbernetes-node-8b3cc9b.ac4-iad.github.net [10.52.173.48])
	by smtp.github.com (Postfix) with ESMTPA id 4D5D36406EB
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 11:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771270797;
	bh=2FQD0D2cYi/fTujs5ImUs8x3NaZPhF6tXDroDEFGp2s=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=M0klptH1Y6EbbYuxuUexPcTn6IsEkLvXdssPWSA7uK3j3EgCNZRhW3ygcdf2uGFkR
	 Lq2hIogv1kTEqFG7AoeA2spE86xTHBGTR25+9dS9cpmCDky9i3wJcLyxZLA34krCwD
	 dzuQOkIIKMb4JF7t0dxd3k13t0jm8a5+IJP4NyE8=
Date: Mon, 16 Feb 2026 11:39:57 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1054670/000000-18432f@github.com>
Subject: [bluez/bluez] 00ceb7: tools/btpclient: Move btpclient to
 client/btpclien...
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

  Branch: refs/heads/1054670
  Home:   https://github.com/bluez/bluez
  Commit: 00ceb74c66d8aeb73592839566b03f941d9db41b
      https://github.com/bluez/bluez/commit/00ceb74c66d8aeb73592839566b03=
f941d9db41b
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-02-16 (Mon, 16 Feb 2026)

  Changed paths:
    M .gitignore
    M Makefile.tools
    A client/btpclient/btpclient.c
    A client/btpclient/btpclientctl.c
    R tools/btpclient.c
    R tools/btpclientctl.c

  Log Message:
  -----------
  tools/btpclient: Move btpclient to client/btpclient directory

This prepares the split of btp services in per profile files for
easier maintenance.


  Commit: 7170722bb027f093ab92aefdc03eda15d5abf13a
      https://github.com/bluez/bluez/commit/7170722bb027f093ab92aefdc03ed=
a15d5abf13a
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-02-16 (Mon, 16 Feb 2026)

  Changed paths:
    M Makefile.tools
    M client/btpclient/btpclient.c
    A client/btpclient/btpclient.h
    A client/btpclient/core.c
    A client/btpclient/core.h

  Log Message:
  -----------
  client/btpclient: Move btp core service in its own file

Moving the btp services in their own files will simplify maintenance.


  Commit: 18432f110099f81b59b5649657bd49c896f61cf9
      https://github.com/bluez/bluez/commit/18432f110099f81b59b5649657bd4=
9c896f61cf9
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-02-16 (Mon, 16 Feb 2026)

  Changed paths:
    M Makefile.tools
    M client/btpclient/btpclient.c
    M client/btpclient/btpclient.h
    M client/btpclient/core.c
    M client/btpclient/core.h
    A client/btpclient/gap.c
    A client/btpclient/gap.h

  Log Message:
  -----------
  client/btpclient: Move btp GAP service in its own file

Moving the btp services in their own files will simplify maintenance.


Compare: https://github.com/bluez/bluez/compare/00ceb74c66d8%5E...18432f1=
10099

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
