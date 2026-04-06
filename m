Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C510E31196F
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 10:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775472922; cv=pass; b=XsULJvOlDnG8Cg6X0bH6NcxxVU9iArMwysNgFUeZoiZWVys8HK/cgBFm87QXfWnccj3hTU7/jrrIuHHC+tdAg0pZ+7cPz/pS49w/xx5vq1E1V71EVPvOljnBaLfjYOmYMS8l3uit86HQHUwDMw5gwb51Y+uer31jtLE5iHYMbvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775472922; c=relaxed/simple;
	bh=9M7RvlJo7+tGa8w/d7k3uKpS1bXT3jVkfGfjBZhL3jE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cAPACWISuaIfWMU92i5A46JuNkhpMhoc4yARfR8FRNp6/Bst4DbDAGLcKcvwZqV4+D5n22a8yLxcpLYsH2TjPIvwLuyk8/8VhcgYMYdB/NE/xowppKLIE0P76a+o2HuVxN+pYKSCYG9HQRvs7zoeHcxdbg59ZuF0IWU6XwiUQBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=oBILFveI; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="oBILFveI"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fq5ny2BtwzyTm;
	Mon, 06 Apr 2026 13:55:18 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775472918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=77C8Q0xGscW5pCWQw1SK/eAvloovRnjfi8GQhOY4LF0=;
	b=oBILFveIDcZJOISOo6tsYImt76c5qVEgy/NgNP8ZULKzAGs9RCEx4ay2fG3qcGH123osdg
	Mh1b5106IUnWxyyDXRg0TaLRrRoZfjGBElRqMEFx/QmLVxAP9p/nNDdeOIQq0Nm1YmaWJ8
	lUcISEchS1Kbbd+2N4MRXccadkE1sws=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775472918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=77C8Q0xGscW5pCWQw1SK/eAvloovRnjfi8GQhOY4LF0=;
	b=QXeVr4HCQIzxyiCisUJW+81B8ApYROHp8ypX30qg5q3ycrEW3BOpHKcsQ3YEJRxITVAPUx
	tEOt30GPCbSgRI+BjzJXAuJqX7DImqJIT+xuCWgz721Y0ylhXD29x22omRrNgUNowbizL5
	i3JiR4nh1UChNOTi2S/R6HbYAcAq0Qk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775472918;
	b=fAa8wSMP59aabOP6/HSaIvFOI8WO3viUE2jG1fs8YVkRbWqidbHHtoo1nhnrKThFncUG2P
	H3ob0UN7/GFnay6Rzwu/dxKhUq0FMH2+s87DriU939LRcJGifgXtHlAa7IyHLT+gNKeX3X
	Iv/tEmrI90jM6XzxS3CGiwYfewi3Xac=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] build: never build test-runner with ASAN
Date: Mon,  6 Apr 2026 13:55:15 +0300
Message-ID: <968d832c1d78d26409ed751f2901ea5eb105541a.1775472833.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test-runner cannot run as pid 1 inside VM when built with ASAN enabled.
Drop MISC_CFLAGS/LDFLAGS from its build; the additional flags they
contain beyond ASAN enable are not important for test-runner build.
---
 Makefile.tools | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile.tools b/Makefile.tools
index 4a51762c3..8e0eae04e 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -321,6 +321,9 @@ tools_btgatt_server_SOURCES = tools/btgatt-server.c src/uuid-helper.c
 tools_btgatt_server_LDADD = src/libshared-mainloop.la \
 						lib/libbluetooth-internal.la
 
+tools_test_runner_CFLAGS = $(WARNING_CFLAGS)
+tools_test_runner_LDFLAGS =
+
 tools_rctest_LDADD = lib/libbluetooth-internal.la
 
 tools_l2test_LDADD = lib/libbluetooth-internal.la
-- 
2.53.0

