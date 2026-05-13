Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C832F690F
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689128; cv=pass; b=uLcA0ilO15IowfcEEPk5985r4moopwUkhhoC5otdc0QsKz7Gq0g2o+GE3oWMwCB+oGocXqULnROXPeOI2XgBvqdqUQ47jcT9FkwWtKoVVMCf+QO+HOiW5BfZBJGKy/EuWGOAKHnQWvBsRdeB8JD3zdynAxkWEFTw310olvsSstc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689128; c=relaxed/simple;
	bh=NDeoZW36QXAPC2xOpUfuluxfMGeV878QIUoXY+w8UYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pd/bkDnEDubW0m1FuAcVOKQcYvk1XcHO2OKoDpgXnweMKkeYhgGbgWt4hJ9XM4KfZ22A/Q6m3o9Ro3nmxZD+PMcKPqF3UwtKvq5CfbxRb0Qf8lfpm71knUHu9e+/UfbfUmH5bjexSZehtGW/l2SCkMzJlModpSm4xPrdxuRIZtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=FaitGbSY; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="FaitGbSY"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gFzD50PMXz100Y;
	Wed, 13 May 2026 19:18:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1778689125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0F87y/USudzU5ykPLbN4HyXfluQEWtoHDE1oRjTIrw=;
	b=FaitGbSYCpg3xiP9MX8B+5PLGpqRNfe/JGBnZB8dUgCQsvNpflx0Qh29yx3TfSy1yR3IBu
	3uVCXutvPa7PIygXU+PvXIO6IBXm2RCcAYtRXl/NvVYyOyM4mOYLZifESP1tYMqZFwgx/Q
	i61b1/hqoI27HDDjfoCYk28D1V/PWc4=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778689125;
	b=YEf1RXWQgVzep7t3IteWnYYveECYdIHmtFLXMyNCFBBDp0ZAXlPDr4JCsZnHWWmuftgK7P
	/Kmw5vkTLrrVAawD79KXVWwVvSxNBaNxjTrb+noWap5pNm/5s8LElN8ejo+8dh71nnCX6v
	ceBSM8gFemwR/Slk1hKfZkp0IbyqKLU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1778689125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0F87y/USudzU5ykPLbN4HyXfluQEWtoHDE1oRjTIrw=;
	b=evfoHBAGTxn36aGF25Spd/IEaK0DVB2q/XgadpGgPHf1cFiVzqaVccvMjwWim2NzAEub5l
	W0rbKSCEfz/w3zNjxgnHDLZS5wtfL3VTYeKLyTT+X5v/j2bRsy/WxvciyEj6Jsm65U+ATd
	5Ak6g4lKm+No+9dxyYEmGb7SNwwwqqo=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 13/16] build: add functional testing target
Date: Wed, 13 May 2026 19:17:30 +0300
Message-ID: <6f1407516bbc942e55a96671441a3203e48f62cd.1778688966.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1778688966.git.pav@iki.fi>
References: <cover.1778688966.git.pav@iki.fi>
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
 Makefile.am  | 10 ++++++++++
 configure.ac | 22 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 76c4ab5d4..7920cae68 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -812,6 +812,16 @@ endif
 TESTS = $(unit_tests)
 AM_TESTS_ENVIRONMENT = MALLOC_CHECK_=3 MALLOC_PERTURB_=69
 
+check-functional: all
+	python3 -m pytest "$(srcdir)/test/functional" -v \
+		--kernel="$(FUNCTIONAL_TESTING_KERNEL)" \
+		--bluez-build-dir="$(top_builddir)" \
+		--bluez-src-dir="$(srcdir)"
+
+if FUNCTIONAL_TESTING
+check: check-functional
+endif
+
 if DBUS_RUN_SESSION
 AM_TESTS_ENVIRONMENT += dbus-run-session --
 endif
diff --git a/configure.ac b/configure.ac
index 52de7d665..254d90318 100644
--- a/configure.ac
+++ b/configure.ac
@@ -405,6 +405,28 @@ if (test "${enable_testing}" = "yes"); then
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
+  if (test "${enable_client}" = "no" || \
+      test "${enable_tools}" != "yes" || \
+      test "${enable_testing}" != "yes"); then
+    AC_MSG_ERROR([--enable-functional-testing requires --enable-client --enable-tools --enable-testing])
+  fi
+  AC_MSG_CHECKING([pytest and dependencies])
+  python3 -m pip install --dry-run --no-index -r "${srcdir}/test/functional/requirements.txt" >/dev/null
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
2.54.0

