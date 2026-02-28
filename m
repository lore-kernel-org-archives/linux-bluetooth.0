Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DA543636C
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772283103; cv=pass; b=SnTMq7qNwowWV6b/FBqTLPe+WEjmIOY9v25AQ6wiSQTYdmAsxLVL4VoWRmEtfqF4Bx7519SGi3O0w+X2BdY+YtPn4AjV5tgRB5/RBpp0bwyMS19sjhAHWOu9+yG+sTGLVEvPpfGBTW5/X0b/uuyHPKyiBcNFmuN275R/s8Xk/fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772283103; c=relaxed/simple;
	bh=7ARrynRS517Lak0ZabLPY2DZe2gv8MSJdmZ2UxG5hX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCMFobFuJfFMnKDYvhiqZo2tb9uw/I57WLoNpueMQGyuRxLGgsPRDKbWSatYgO9oP3HobNN8bK1Zj+OHbWX5gErnMeX/A/0T1Kxc2++mf+8zj4UVB85yqQG3u+MKMGHj/94fpcIW3dESGnBn3TAZaHBbnJdg3Dw4nutAw08s2ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=vXGZThHl; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="vXGZThHl"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fNQ7J0fkdzyv6;
	Sat, 28 Feb 2026 14:51:40 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1772283100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kmboy+V+pPlY69KX/BiiCGRRFI0CZGjqP5bdCAIhuvY=;
	b=vXGZThHlznuIef/CZtnw24bT6b9TKOw7uLy2yNQtUCNq7jvk9VVjL7pZpdHV/agLKq9Kz9
	Z6OfMFncie6UvET0umyeY3lgNXMlgzgeArzH16cLO2VCHE2+JCkz9HCXSs1d86EUiIRglL
	gJdYWK9AcAuNuGZnAc9pzWdvyiLj5I4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1772283100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kmboy+V+pPlY69KX/BiiCGRRFI0CZGjqP5bdCAIhuvY=;
	b=bwylobYrwI3CvvrJ70cjf8WtCOFc0ihH4xmuCHlXXTBTb69Fc/kCcB0goz9CJIYNniMdsG
	Afu83h62e/cPZHFO/oVfc/cjPG+h5D0BHdDmmWIcqOHF2Gm6D/EFVweI6EDBt2qscvq6A6
	4RX8v1V9lTbLP5/CeFMMSphu2pbuEhA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1772283100;
	b=Yojd3KtcLUJ4jRt89ZtjkP4XXntfmgaJE1rYvYZpUQCqqOIe7nsvZT88SzSmyYjwzWNTBf
	t5w6hRsyBOqAl7bV7RZlDgREh1i8PDiddzDWmcAzM4UcRNdN4dNdzcDKsGrPQ+KptXqb7V
	zJ/h/FGQwgF2oIpBeTeWD74guSboFp0=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 11/11] build: add functional testing target
Date: Sat, 28 Feb 2026 14:51:17 +0200
Message-ID: <a811f7fc2cb1d147205add87236b8d0dc15bb4c2.1772282574.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772282574.git.pav@iki.fi>
References: <cover.1772282574.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds check-functional: target that runs the functional test suite.

Also add a --enable-functional-testing=<kernel-image> argument for
configure that can be used to include it in the check: make target,
possibly with a predefined kernel image.
---
 Makefile.am  |  7 +++++++
 configure.ac | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index dee6aa6d0..906b3ef6b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -786,6 +786,13 @@ endif
 TESTS = $(unit_tests)
 AM_TESTS_ENVIRONMENT = MALLOC_CHECK_=3 MALLOC_PERTURB_=69
 
+check-functional: all
+	$(srcdir)/unit/test-functional -v --kernel="$(FUNCTIONAL_TESTING_KERNEL)" --build-dir="$(top_builddir)"
+
+if FUNCTIONAL_TESTING
+check: check-functional
+endif
+
 if DBUS_RUN_SESSION
 AM_TESTS_ENVIRONMENT += dbus-run-session --
 endif
diff --git a/configure.ac b/configure.ac
index 52de7d665..f4b65f7b5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -405,6 +405,23 @@ if (test "${enable_testing}" = "yes"); then
 		#include <linux/net_tstamp.h>]])
 fi
 
+AC_ARG_ENABLE(functional-testing, AS_HELP_STRING([--enable-functional-testing],
+			[enable functional testing tools]),
+			[enable_functional_testing=yes; functional_testing_kernel=${enableval}],
+                        [enable_functional_testing=no])
+AM_CONDITIONAL(FUNCTIONAL_TESTING, test "${enable_functional_testing}" = "yes")
+AC_ARG_VAR(FUNCTIONAL_TESTING_KERNEL, [vmlinux image to use for functional testing])
+FUNCTIONAL_TESTING_KERNEL=${functional_testing_kernel}
+
+if (test "${enable_functional_testing}" = "yes"); then
+  AC_MSG_CHECKING([pytest and dependencies])
+  python3 -m pip install --dry-run --no-index -r "${srcdir}/unit/func_test/requirements.txt" >/dev/null
+  if (test "$?" != "0"); then
+    AC_MSG_ERROR([pytest or dependencies missing])
+  fi
+  AC_MSG_RESULT([ok])
+fi
+
 AC_ARG_ENABLE(experimental, AS_HELP_STRING([--enable-experimental],
 			[enable experimental tools]),
 					[enable_experimental=${enableval}])
-- 
2.53.0

