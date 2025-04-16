Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF050207E13
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744816859; cv=none; b=QY02CSKjk0Nk21hKuIQOfQtMh58gWXjh9uM2V/Rr2oJVdCTSazAy0gXzSSjkdNKttTBipoqOu6B/YGDyEHc25LOfGs7nPK+S6AW9Rf+KqmE0w6GbYbBoN6rL4nkRMX4ToCFeXquYD+Jg35D1FXtTe9nkpd91g2/uJ46MUMWX03Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744816859; c=relaxed/simple;
	bh=WbBy24XJGkF4Iab2MB0qYlW0gN08LIxHydzhtqyehMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=txkMZS7Oje7RlbJ9BGQDlh8uHWUn29wOkADOHLTxL95EAccBICDdRm4RWzTxgT2ENQfS5zo+eYgUeq1581jlELwLe7Lx/1I23k/773fuY3NlmVBtrLnk2U16LEsCIYDvvX7HqOD5Ppo4IRM6mGfSjzjGK9y2BYk8gayQ3o98/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from a.d.7.c.3.f.6.7.e.2.2.8.b.5.4.d.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:d45b:822e:76f3:c7da] helo=andrews-2024-laptop.lan)
	by painless-a.thn.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u54ZK-009SGS-1U;
	Wed, 16 Apr 2025 16:20:54 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ 0/2] obexd: only run one instance at once
Date: Wed, 16 Apr 2025 16:19:34 +0100
Message-ID: <20250416152039.971257-1-kernel.org@pileofstuff.org>
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

Andrew Sayers (2):
      build: add bluez.tmpfiles
      obexd: only run one instance at once

 .gitignore                | 1 +
 configure.ac              | 1 +
 obexd/src/obex.service.in | 6 ++++++
 tools/bluez.tmpfiles.in   | 1 +
 4 files changed, 9 insertions(+)

