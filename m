Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CC8353ED9
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823372; cv=none; b=b1WrO3Ay8ymsRUTtS20Qua4IaJJfD6IXSz6Muo6rCCCuXOeJnxT0XqdOsizviT8qV/KADJ3YPDNL6aWF9yCniSFegobhwrL0j1xvtLXVvGZyRjazzZMZxHs/PkIe12aBtu0yHQR1quN4ASxmHnlum0y0O4UDaZzTJJOf2p7nwuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823372; c=relaxed/simple;
	bh=7xAGWiJpfXvJ4KSV+qv9XtYCq5I0OMvLwp6LtC/jQ7A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=P7ho77O89SrInzF2vDjEg+eU7RRFK0lxQSe8lJBR0P6t0y+cnjO5DxaLMcjmp4Erqjthebnmi9DEQl9Ww0WE7bk2Bye0JU2GvCv51u7023kjsKpPg86VpKjQHs+4oOjCsa6ruUL6yW1iUegtmLYEvYTg2j4qvZyKOmEkd3xJD+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=L4iU02Cu; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="L4iU02Cu"
Received: from github.com (hubbernetes-node-9b54ba7.ac4-iad.github.net [10.55.90.25])
	by smtp.github.com (Postfix) with ESMTPA id 46CF021413
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 10:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772823370;
	bh=AH8YYJ4vetItR0emuOkf0SSMrfHUO8oXfGDjl/4ZlUU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=L4iU02CuylIwYtYym+sXMCVh5pFF0Dl9XB0MlyqCHAi6m8Yeg3B+WIqkDi6O5RJzJ
	 tTBoZR7gLzeQljQlYM2NL9C6DBX2tI14tw2J6u+Lx83A/+sHTc3fVQbCgS4saR2M6Y
	 tVNLwsXQ6jitOy8U+cylNpSz9P3iZW6SrQ85uicI=
Date: Fri, 06 Mar 2026 10:56:10 -0800
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8d82d3-33388c@github.com>
Subject: [bluez/bluez] dfc43e: gap-pics: Add footnote for TSPC_GAP_21_9
 feature
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: dfc43ee483fcce5ffe61c0809501ced197cd8596
      https://github.com/bluez/bluez/commit/dfc43ee483fcce5ffe61c0809501ced197cd8596
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-06 (Fri, 06 Mar 2026)

  Changed paths:
    M doc/qualification/gap-pics.rst

  Log Message:
  -----------
  gap-pics: Add footnote for TSPC_GAP_21_9 feature

Unfortunately, v1 of my patch series has been applied to master. This is
an incremental update to v2 of 1b7e682ef4b7 ("doc/qualification:
gap-pics: add footnote for TSPC_GAP_21_9 feature")


  Commit: a843a95b4cd11f0feeb524876cfbee474a7ac986
      https://github.com/bluez/bluez/commit/a843a95b4cd11f0feeb524876cfbee474a7ac986
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-06 (Fri, 06 Mar 2026)

  Changed paths:
    M doc/qualification/gatt-pts.rst

  Log Message:
  -----------
  gatt-pts: Add description for GATT/SR/GAW/BI-39-C

Unfortunately, v1 of my patch series has been applied to master. This is
an incremental update to v2 of db7d1a9c770c ("doc/qualification:
gatt-pts: add description for GATT/SR/GAW/BI-39-C")


  Commit: 0ca7685dd6b9263b1d993d77402d253cc9986468
      https://github.com/bluez/bluez/commit/0ca7685dd6b9263b1d993d77402d253cc9986468
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-06 (Fri, 06 Mar 2026)

  Changed paths:
    M doc/qualification/gatt-pts.rst

  Log Message:
  -----------
  gatt-pts: Add description for GATT/SR/GAN/BV-03-C

Unfortunately, v1 of my patch series has been applied to master. This is
an incremental update to v2 of 268d715b80e0 ("doc/qualification:
gatt-pts: add description for GATT/SR/GAN/BV-03-C")


  Commit: 47bf221d31831f796c91199472251ec72e974af3
      https://github.com/bluez/bluez/commit/47bf221d31831f796c91199472251ec72e974af3
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-06 (Fri, 06 Mar 2026)

  Changed paths:
    M doc/qualification/gatt-pts.rst

  Log Message:
  -----------
  gatt-pts: Update description for GATT/SR/GAI/BV-01-C

Unfortunately, v1 of my patch series has been applied to master. This is
an incremental update to v2 of 7a2d04492f98 ("doc/qualification:
gatt-pts: update description for GATT/SR/GAI/BV-01-C")


  Commit: 5ab15728068cc142e8bc2d4ada48d8fc3f431254
      https://github.com/bluez/bluez/commit/5ab15728068cc142e8bc2d4ada48d8fc3f431254
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-06 (Fri, 06 Mar 2026)

  Changed paths:
    M doc/qualification/gatt-pts.rst

  Log Message:
  -----------
  gatt-pts: Add description for GATT/SR/GAI/BV-02-C

Unfortunately, v1 of my patch series has been applied to master. This is
an incremental update to v2 of 04af0bbeca63 ("doc/qualification:
gatt-pts: add description for GATT/SR/GAI/BV-02-C")


  Commit: 33388cb1d6f1aa8925b048060c1ca5833e8909ee
      https://github.com/bluez/bluez/commit/33388cb1d6f1aa8925b048060c1ca5833e8909ee
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-06 (Fri, 06 Mar 2026)

  Changed paths:
    M doc/qualification/l2cap-pts.rst

  Log Message:
  -----------
  l2cap-pts: Add descriptions for LE CFC tests

Unfortunately, v1 of my patch series has been applied to master. This is
an incremental update to v2 of d99f2e129634 ("doc/qualification:
l2cap-pts: add descriptions for LE CFC tests")


Compare: https://github.com/bluez/bluez/compare/8d82d3e1e539...33388cb1d6f1

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
