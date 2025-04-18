Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B7770823
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Apr 2025 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990297; cv=none; b=Fl34Zy+XHGFhKAiXj1sdbG2m2Ob1NbE+Lz3PSSGlJlESm6mptsJaYenj8Py2yYHOeVjMR6KTBtFnljM1rgY4KenOpfrxQUQDSvyEnVDW8KaliZdaxz+KU9x0QxBFDDSro9IFBXwDHJUflwT7sUA7WlZVTkfO3QME5C06bWyrI4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990297; c=relaxed/simple;
	bh=0CxcX2xKYv6mhYqLZwAPhBNB/2Oogl/f9FdDwTiEpPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XLc+0hSOq1iPfrX17AaiUSbirUcLTYi09tQoO4bihieRLCnI3SlSBlnGYi/5kh9YF0creo7DDhdwHj1Ua8Xo6ZU6iYr4HMUpNM+/bp9+Q0FeWgMjeluLlr3IENDS/Ufw/CQoaanpraDlQrrEW8jKqpHY/Lo/2S/4/fLMDrgHAEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from 7.5.f.b.8.d.6.0.d.e.a.0.1.8.a.f.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:fa81:aed:6d8:bf57] helo=andrews-2024-laptop.lan)
	by painless-a.thn.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u5ngj-000vF1-1P;
	Fri, 18 Apr 2025 16:31:33 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH v2 BlueZ 0/2] obexd: only run one instance at once
Date: Fri, 18 Apr 2025 16:30:50 +0100
Message-ID: <20250418153115.1714964-1-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Obex is a device-oriented protocol, so only one instance can run per device.
But Linux file security is user-oriented, so obexd should be a user service.
Tell systemd to only run this service for the first non-system user to log in.

This series causes systemd not to run obexd if it would just generate errors,
after adding a new bluez.tmpfiles file that distributors will need to install.

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
---

V1 -> V2 add a hint in obex.service.in about installing the tmpfile
         (recommended by Luiz Augusto von Dentz)

Andrew Sayers (2):
      build: add bluez.tmpfiles
      obexd: only run one instance at once

 .gitignore                | 1 +
 configure.ac              | 1 +
 obexd/src/obex.service.in | 9 +++++++++
 tools/bluez.tmpfiles.in   | 1 +
 4 files changed, 12 insertions(+)

