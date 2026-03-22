Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3319A10785
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Mar 2026 21:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215086; cv=pass; b=Nx/oYujuzbqH9LHtGzLRIHSNJL/n1K9A1NSRWk0bBMh7S4VppNTdh900pfa2YZjsE7l5Oe2/B8P7xb7sHNKI1+S4anJC2KiTEXSsLy++F8/6IDoxtR9W5Vmkvs51k4eOzEztJk6+e4Fc4xgFA54o6rT8DJJn05l+p23R0Ch9oiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215086; c=relaxed/simple;
	bh=jHsNvFJoH5BjkNsGuy7f6GLELwUce+CslgSFXIsB37w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSRHDF8nojRPx6vcDK6ygVrQMjbxSYVBaAgmqHl43kMtg+K7VIgLHU8Zc98B5bU1dBlfNeKdsft5agY7Uqtg1zQg4XMLjfdikc15Q4IEe0g6GltOyf1pC6hKfRQBHmdM3jqWr8TLpHiziInvNOnHyMxYxeC2gpQ+epJ89dtSdfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=vT1NqkOW; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="vT1NqkOW"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ff8cq2g0wzyXG;
	Sun, 22 Mar 2026 23:31:23 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774215083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5IbZILnalc+K0/7Rn06+rBfl3AhgYOS7Eks+8/MojfE=;
	b=vT1NqkOWZY4XVra9/rcVGCzWaAqWNQoqxBVKHiAJAJj4rHtlj3nkecz40aKgznDc19KtZ4
	dPOyyeV0nkMY2rUk30etaPYYDlzl0MTnOQeFA9CDscXE4OpmNbs2esbN8NeyyQzN69pisR
	hdvrhIx+vSzyAkyN9sEm/f8dMJ2xl8E=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774215083;
	b=JfL+K0vjT5BvZKkYa3qNnRnyJXtuEfGezdqNHfUyypmxtoFV9G5TWXbPrnGU1Lz3/cnZLO
	aD06HsCCeaTCu018bjggA+f4UHZcTSNul5aBt2cG1ASMaGQvAvwCUV6yPsbxGL2+YK4gs+
	2PvMUGLjtavbPf2efy7amHaCI39nPxI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774215083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5IbZILnalc+K0/7Rn06+rBfl3AhgYOS7Eks+8/MojfE=;
	b=C/Mt4XdKukV2Mt9hGoQ2chl/nqTfI053VpRUwkoTTELka/JizH9lRla1eg4yGyRQm+O42/
	2D0my2wHxtYPf40FVDQjKm/Vsk46HMFxlG/zuZEe2eGdcM0dnpMEhP3UaJdQFU1Ut9vzsl
	qLwj6LMfrzR7ioHVH1wvQFLmyiNtIRA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 15/20] build: add functional testing target
Date: Sun, 22 Mar 2026 23:31:15 +0200
Message-ID: <46b93c500e573a61d98c23104e4f6f7767295666.1774214693.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774214693.git.pav@iki.fi>
References: <cover.1774214693.git.pav@iki.fi>
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
index 3bc1f5c44..8a94cb294 100644
--- a/configure.ac
+++ b/configure.ac
@@ -414,6 +414,28 @@ if (test "${enable_testing}" = "yes"); then
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

