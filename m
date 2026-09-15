Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E7B13777E
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 00:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430860; cv=pass; b=tnjfakmLU4YpzyAvYuMl6ltdsEFhP6sLrb4dPavnzpfZEJh+jSVwBzcKYLND+lJf2A0jCAxWfK7ZSa84gU+1SKxZZfqZmY6zTH9+bKxW40QfRBxyKVmIhY5H69ju0WhvBWhuaSWMp0BCBN8wDBH9tJOTEzQyqWzB+7NJ+1SC3LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430860; c=relaxed/simple;
	bh=b+5bdc6nnkgGLs7dmePe+61rCCMwflbLr1MAMEWlFoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BuZhq4SKFXxOycO/z2Spdy+szvAuQO2C9+1YQxetBzf7NMhfy37Atu1L96wOU2dpQxl7R+Y/TQbk1HKFeSWYyOCFPNI7PBxZQAy65ni5EmNAN8fBuixjZjxH06wH2LCs4MuSMYyVqHXzB6IezXvMcFLJ5c8mte3deuk7+/1UCIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=mhogHKlo; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="mhogHKlo"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hkMld1jVzzyQw;
	Tue, 15 Sep 2026 03:07:25 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789430845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nVj4UEjpDQ35vczKr/R/Z7tX18HtSIUxfYGvMwC8VTo=;
	b=mhogHKlo6DhZbM6AMKIco6eU5IfVZbK7Naf1JwMJya8nfE0TjaYjLffgIyYnG3zGT8A9qv
	DdyxTyszk0dVCJUHXospRLMP8oBYwTVVSs843xgHq+R93UYrf2v+6DdexzlSFXR1Xpw/4D
	Nwlo6AZdDhLeYwKzaS012CyvYu4YXCI=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789430845;
	b=QzLh0HqNMWJnTjY7hoT8c2z0KtvAo62sngnOW+LfaMaq2ExD5sA4SvxngUr0zVtsw3hTwA
	nEYno4r7t6kB1bWcryPUlnChajsadb0VpR7D9NlRsJBQREtVLHbSsDZOS+EaxMBLg7YJKK
	w/ZyfunvgxWKU7QmlmuOky2NVN4QyMs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789430845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nVj4UEjpDQ35vczKr/R/Z7tX18HtSIUxfYGvMwC8VTo=;
	b=F+xSJi+RQtSwDsb+SdeHM/PD+vRWRbUaFJt071dN0jYPnSEyiw75TXKwXs6NT79O0rg6VY
	bsezGqVu+qxjQdsWB7/4XfdrHU8Mf0Ov5vjeCd7IfL1W9EZkhHSy5YFh4ScFCvumHGbT1W
	9CrcVcCIZUXOAAcOpNDK+e9ThlkywtY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 0/3] test: functional: add mpris-proxy end-to-end tests
Date: Tue, 15 Sep 2026 03:07:17 +0300
Message-ID: <cover.1789430529.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for:

MPRIS -> local player -> AVRCP / MCP -> remote player -> MPRIS

Connection and basic operations are tested on smoketest level.

The code is LLM-assisted, with manual design and details input. I
reviewed and tested the result.

Assisted-by: opencode:qwen3.8-flash-next

Pauli Virtanen (3):
  test: functional: add mpris-proxy BR/EDR test cases
  test: functional: deduce pairing bearer in shared fixtures
  test: functional: run mpris-proxy tests over LE via MCP

 Makefile.am                         |   1 +
 doc/functional-mpris-proxy.rst      | 180 +++++++++++
 doc/functional-testing.rst          |   7 +-
 test/functional/conftest.py         |  23 +-
 test/functional/le_utils.py         | 195 ++++++++++++
 test/functional/test_avrcp.py       |   4 +-
 test/functional/test_mpris_proxy.py | 467 ++++++++++++++++++++++++++++
 test/functional/test_obex.py        |   8 +-
 8 files changed, 873 insertions(+), 12 deletions(-)
 create mode 100644 doc/functional-mpris-proxy.rst
 create mode 100644 test/functional/le_utils.py
 create mode 100644 test/functional/test_mpris_proxy.py

-- 
2.55.0

