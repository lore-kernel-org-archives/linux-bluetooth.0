Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED593E8356
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787750786; cv=none; b=gL3QrywFl48MLlGif5FnxmFo9Og/grpntBBibP6AoyfE526xj+H10NrcMHr88kqiGDm27+pNCaqYSLXWTLpHixHERfUVZwPrZEviZHywhgJvJV+XczNdxt/D0rTevNW4ttOdSjCcjPUjRee/YJIhxaAWNR5zevl2Z+hEyowbif4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787750786; c=relaxed/simple;
	bh=WL3P/3kxIqBFn60Q+WvZbAemkhWhRtmbBkbOnojXgz0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=o0cIlRynPGHTc/XHnptXELZkvW0ek+f/Et91cVJQZkTXFs56ys8N+x3Z1BnSR7jjc8Rbcqlz7WPPNqfCNeqdFw+mZ3jaVdXmE94PEjpL5gd+EKB+azlg2t9l4ITUb5DG/MOlupmUUXITo0q6mQgHHrinvL9/h8Aj2CF6Qr87jyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id BF71C3EC88
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 13:26:20 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v2 0/2] SECURITY: Add top-level security doc
Date: Wed, 26 Aug 2026 15:19:04 +0200
Message-ID: <20260826132610.1021538-1-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTE0ZT0FRdv4au5zYGVbdfWo8+fwioI+ogq2CbL0JxU1YaaAnVbG7Huza4SOX/QUfuG2Sgyrr/a8UQZQP1FTpnDX/NB8kQ6nKAc87LGRHVTCrBN1rbSSIK42zDa6smUPOw4+7ZfHOBf9EBEigAXUrmWkaUb3iFoBv55mQteuZQxPDJ/v2uaUpXSweojrJQhO+Ip6vVr4Ge1GgRatMlEuKzOLKztrcNvMzZPYizoBVdhKfwyUvhTHPpnlmmmxjZt6Tq1uKipIxTaeb+qHWAJMOj+pcEVimPWHcPFwJl7ECu4V3PpOHK+MDcrihzFlOQ9MnZvCl3WbKRruPGyirRxiKZaVIJA4kKshwqmDhdyqnlVj9+24NjTipU08yQqC+XALZgiLLXuCgvyiLXVUouiAMk9glXl2Nc4DzqkI92cvXVCS5p0uFUTNWd+sTm1RRTh+GufPQm66YPaZVhbXuOAOuQnmsXELkDMwYrkW2BdjUMwdxEXwcMd9urHy4gNkL49RV0nFSmUrN+QuRSftYQwXti9GC9Y2eR0hYySzL2ia3WZgkKtwQ3KPa93hrLjD1z0xKAHJG/Remvpz3143rCJDNqHa0jyLMNu+qBS1wSiNuId9hU5cxYDINbkU/fBJtFEeVUOYKPu5JogAtMxZ2yB3lTns45OGHdBsaZaPFvGlKVWgXQ
X-GND-State: clean
X-GND-Score: 0

With reviews from Marco Benatto, Senior Product Security Engineer
at Red Hat.

Changes since v1:
- Added mention of issues that can only happen using vHCI, and not
  real Bluetooth adapters

Bastien Nocera (2):
  SECURITY: Add top-level security doc
  doc: Remove obsolete security-bugs.rst

 SECURITY.md           | 92 +++++++++++++++++++++++++++++++++++++++++++
 doc/security-bugs.rst | 89 -----------------------------------------
 2 files changed, 92 insertions(+), 89 deletions(-)
 create mode 100644 SECURITY.md
 delete mode 100644 doc/security-bugs.rst

-- 
2.55.0

