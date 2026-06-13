Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628933FD96B
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781365743; cv=pass; b=ryUnoEmSmnvzAznh4vnLFY6Ww6KFiDFLCkee/QLgrUEf5sOK+AjtSQqIg4iLqO9Q8wf7/5qifIftRpCH55orU6z3JRB1omgBbu0IcYdADk5SBpl5dQGTvamL9yvCg0QneGZQPZvNTa6oNUOCZKSsvXu3Q8Sma6cAgPWB7SafJ0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781365743; c=relaxed/simple;
	bh=5hD8Qy3mUXDhBlBirNx65AUDQQYczC4Xx8KIm9nx8zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eawFmr9LPW9sonKcXwIG531Mx0Dqxm4c91vWWgtGXRoqB67j7LmE0ES1jJ0P9tdiO4RNoG3z7fyaPr92W4ZsF9CfpOcZHCsJ5AOAarNcnMgPiPmT2fAFxzBTPtqHbzMIbWautRTdW5EB9H4CKiulnXN/wFhEhv/rMXYgtbraTbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=f5aoOOLa; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="f5aoOOLa"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gd15S1mgQzyfS;
	Sat, 13 Jun 2026 18:49:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1781365740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6evaIRhJWDdFKUZenmg+h3XDj/F66TxVMCOK7+DPdg=;
	b=f5aoOOLa8t+LMgmfhPDzEphwcGpSmqRYupq3rptUdNeVMYfmo7Tqlw7rz2NVhPv8dzuOLm
	nB8nlZZzDvWEe/YUwqVDBpU3gBY3sZmZHhWZpIJ/FIzb1C9L7/djc7nzOa6ssyq+2igVYM
	DnJcs4Rn3fAuPnh4z1UuLQ6NijhaewM=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1781365740;
	b=nbWfgWilieZ5pVZ9cXLEkW6cxVvmo565+ZIyPofkjnCqVDL3KlSSNAOPZSLXun3qKKeeeE
	cYPa7kFumxkOijxn1T4ZgMM0Ed2UE8E5HY9RelTXBAVEvBqVTbHszNAClnRtD7ceeXrQUA
	np1R/p8N+2OwmKRN/+O0j4xpoNVAeew=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1781365740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6evaIRhJWDdFKUZenmg+h3XDj/F66TxVMCOK7+DPdg=;
	b=aWFyx+CiipsGGwB2qblLjEHsN7piIP8XGvi/jm8C7Thr6gdDsh6+y5qslqY6zVVi3vFCAo
	sAX3OwOWJuZE02wg0S6OqDS+q3l6nIe3ru8Ihin8dmV6x6JQHyljN3COSw+7M4fQekblmH
	kStbGl50vU+PQbtwCrI97hWKeOiW1yw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v6 3/6] build: add functional testing target
Date: Sat, 13 Jun 2026 18:48:49 +0300
Message-ID: <199523aaa32d2be835216f583dfe9bf7d9eacf42.1781365708.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781365708.git.pav@iki.fi>
References: <cover.1781365708.git.pav@iki.fi>
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
index 1cdd551f6..f50d8c9b3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -407,6 +407,28 @@ if (test "${enable_testing}" = "yes"); then
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

