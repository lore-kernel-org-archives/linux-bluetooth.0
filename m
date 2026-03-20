Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A6B36212F
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041136; cv=pass; b=a2vKUT1N2f+Q2aJQExNk6yuFzcDIHNfLW5G5gFmVAGKuQ1mu3iQYYLJAkW2VRcHM0WQgajaWGiLjaObQaahSwoC21ckxf/upSQcUIY9oRqxxd6plZ9kFWRiq8cHQrgLNcFet5O3kqVJwAY3tiqm0fMZvVVGkf35J/qeBzQljdsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041136; c=relaxed/simple;
	bh=KG0n1RwDPZxWl0cJXYm9cdejIdG6//TwMwiOcT+qcF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L38hAW5+BoIQ1o3QSXWYDM9IGVhH7ILZiAlYp6LU6t3pmjJK8glwjlaN69TGQlEa1R/YRHEVVE9+xCbQDZnEY22FeVw3rNOxYMsFBurCOLiipyXmZCLvlfpbf+zEiIWtz6U137Xaw+iMMTK+IhwzSCOc0FKfKt3p/ESwc5WDRNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=XjMIz8fT; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="XjMIz8fT"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fcwHc2q8bzyW9;
	Fri, 20 Mar 2026 23:12:12 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774041132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFscMxMqgtBzMdanwVmph9KxlbYyzw5DyqqKMDtUW9k=;
	b=XjMIz8fTbQVsZHxs4oIPQBBY0uhBBXCiCOvjboeMKJxYo+FN3ArcLy83TOH4sHT3+ccS3h
	diMHqwaY11v0cQWljBiz8Vg8Jngy4rWmc7ghzO4uURAgFC3K7hq4iTYeIM95Pm1c9OzMGQ
	K1aiz7OKxP8yL12TMJ/g76AjTlu8Mng=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774041132;
	b=QUyJNbSa2vIpfjbGfemA71c+a25+Mth+JtQ0UMGJ7s+y5XLXbsrpNa0P4LDpCBV6ISlldT
	OakDjQjE8ULN8+Bl2QzILv0yNpxOwrXnLIQeomWh1NQcjyUb7u7fSIfxh72A/vJqibe0X0
	XiSO8L56ax8uWJ6q85AKDIwh1KCs5Fo=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774041132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFscMxMqgtBzMdanwVmph9KxlbYyzw5DyqqKMDtUW9k=;
	b=mWQAWmMYUhswntPWOORlhG+xgq80KJ6v4hzqhER6ZLyJJe9l0NXd2wjABBoqwxOaTNlPOc
	At3opu9EoKyaaMPz04OR277lKm3Eelrf8WcUyGsjI1Q/lhadTfGY3IR6He6cwzln/scR6o
	ZkBvY2wuPrRC/rQ/zkciObZIvyTnWko=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 15/20] build: add functional testing target
Date: Fri, 20 Mar 2026 23:12:02 +0200
Message-ID: <af41c06b53de6e50a82d0c5bafb42cf0a4b0a6b7.1774041047.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774041047.git.pav@iki.fi>
References: <cover.1774041047.git.pav@iki.fi>
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
 Makefile.am  |  9 +++++++++
 configure.ac | 22 ++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index dee6aa6d0..1c080b6ce 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -786,6 +786,15 @@ endif
 TESTS = $(unit_tests)
 AM_TESTS_ENVIRONMENT = MALLOC_CHECK_=3 MALLOC_PERTURB_=69
 
+check-functional: all
+	$(srcdir)/test/test-functional -v --kernel="$(FUNCTIONAL_TESTING_KERNEL)" \
+		--bluez-build-dir="$(top_builddir)" --bluez-src-dir="$(srcdir)" \
+		$(srcdir)/test
+
+if FUNCTIONAL_TESTING
+check: check-functional
+endif
+
 if DBUS_RUN_SESSION
 AM_TESTS_ENVIRONMENT += dbus-run-session --
 endif
diff --git a/configure.ac b/configure.ac
index a87e9211c..410696078 100644
--- a/configure.ac
+++ b/configure.ac
@@ -413,6 +413,28 @@ if (test "${enable_testing}" = "yes"); then
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
2.53.0

