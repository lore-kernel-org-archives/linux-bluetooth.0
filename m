Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA49379C3F
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347823; cv=none; b=sWfcSbt127lUF/ZNeS/3ePP1mqOFBg6IBLbehbQUcqVac9bTGr1DN5TMSt97PQ6Vi8aYgHMoZfs4mWWp7jXOIm/dlU4onn06vu8fkXil317WVx0qvhudv+Yky8Sc2Hfv8TO998ZYxyeYIKpYiwyJ7wSRNDYMUXynayT3Aif/uZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347823; c=relaxed/simple;
	bh=myIK5hZlRBUuG9/xygDJ3e3uewXn5rAuc6pMXpXGjxY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cydLYBDPo2so1udwuVvyRCV1O4d+WXcTWUvHALSVgDHVg+limY51gjkypyPVm3BUAYDNq32/g7iS7bXxDr4um8mYZJ0fHq82Zu0/6czU0KyrdOFGGBDG5eqiUk58XWNXZ1UQZDHByyU9c2lzMkQffiIjqZYl/jcARs1P3z3wI+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jA2u0L1f; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jA2u0L1f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790347820;
	bh=2mp85FKbFm+fn9NrNRUZaT1jpxfn/CWtylr+DN8FQZc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jA2u0L1f5MDCibF/SQyepIjlTAy3VDlBJneyFyItqOqJHYs5PDFiVpuFDvwItudts
	 O4w1b4XkXsntNYI/+aehXCexcKLF9wI88sxfdZHz73Q8jwQU1oviSGnx4I3b3zqrvK
	 t3uradrKiFisY1gaNB/jA7TCN47yJQRG9TPwN0iQ=
Received: from github.com (hubbernetes-node-534e425.ac4-iad.github.net [10.52.13.16])
	by smtp.github.com (Postfix) with ESMTPA id 9954E781339
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 07:50:20 -0700 (PDT)
Date: Fri, 25 Sep 2026 07:50:20 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1173750/000000-419a14@github.com>
Subject: [bluez/bluez] 25e41d: doc/qualification: Add MICP PICS file
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

  Branch: refs/heads/1173750
  Home:   https://github.com/bluez/bluez
  Commit: 25e41dadbf70701273bfe95be0c12bdc5c3a5e45
      https://github.com/bluez/bluez/commit/25e41dadbf70701273bfe95be0c12=
bdc5c3a5e45
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    A doc/qualification/micp-pics.rst

  Log Message:
  -----------
  doc/qualification: Add MICP PICS file


  Commit: 419a1439809b080fffdfe99160e5fea4e77eab0f
      https://github.com/bluez/bluez/commit/419a1439809b080fffdfe99160e5f=
ea4e77eab0f
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    A doc/qualification/micp-pts.rst

  Log Message:
  -----------
  doc/qualification: add MICP tests documentation


Compare: https://github.com/bluez/bluez/compare/25e41dadbf70%5E...419a143=
9809b

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
