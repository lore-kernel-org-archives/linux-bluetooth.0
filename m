Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0944E27FD74
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Sep 2026 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788713420; cv=pass; b=P7LJWswXp1jhR0DA4NLEAakz+6+0C1DF82ajCWsMbmUGOWfnpyBEb+fGtaH2YV8s2sRnXo19PK1+NSaydPCcY///X6/ACsx+neGyx2E1c9kOMQHXkeeu09LgV9OKgOMt5EwgTERhj0e0R76RlNF+hpmdw72vZGlDFgluDXjIO4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788713420; c=relaxed/simple;
	bh=dp80RoBjJ07wpdUXAijDDmltP92VRKRhbpgLgLugrBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBJyZEJdLfjf6RQYwZnhzAKW4SROPpVv2Gw1fFu5WXv4ALSI6XPnsyCAqMHvr6chPLRfU3PkhNo9OQo9sGdgkIGUc0k+3ZMv+T6POTy5DYedqOqA0dh9Sp88Zo9cstB32PT/SQSGzkFen25Yq4VYmnbSZsF72iRH30nLigSRdgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=t4Yd3HFc; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="t4Yd3HFc"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hdGQn43Kfz10TN;
	Sun, 06 Sep 2026 19:50:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788713409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wjMKbJotomQtmgUVcg6oy4zxJpBjf2llRVV+s+Wl/0M=;
	b=t4Yd3HFcp5mllaDrQpf2tyQh9ts0H0E3OenkdPi5UqLrIrqHOFqjdVVzrr9JN8+B8FByEH
	LIjLzzjXeXAiyBsoyPvtfxCzyi8BmfXhPtIhh+SwhV5broFqSNOb0Lt5UBcksXX4n061tk
	rXrGfycdUijrFx+M2XN+QlTD8rdWyRs=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788713409;
	b=ZYL26Au2wssY4T1ai5XLu68dGwptip/sVHQSrAeD0Zjjh4BLuSt0nSh3Cf6Ga7T6+J7wgR
	oiQSNGQZaAOHWJCUulGekWj7AV6VmIrxaJ3Nr7FAgauaf06mq4miIQYkwFqnSQOg9Maxup
	p1459shVBHtkbIxywve1DWKk8s1r1yc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788713409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wjMKbJotomQtmgUVcg6oy4zxJpBjf2llRVV+s+Wl/0M=;
	b=Hs0roy8BmhnvtlLg6UM5oLMEot+7FdAY+cozrbkNe9AwAqIuA1n/sTACYtPUdUs2vihCrK
	m1+2O8ub51q88c4eIao19Au69kwKrNQftfYncKPrX6Oyz8tjASS5kVNBkkdnL8qi+UNVpZ
	YaTTksaIAv2Q0GAcwkf+nbjJJyRD9Jk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v7 3/9] build: add functional testing target
Date: Sun,  6 Sep 2026 19:49:45 +0300
Message-ID: <32c17e5eab1be32c9fb1f85bbe900f3805937039.1788712996.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788712996.git.pav@iki.fi>
References: <cover.1788712996.git.pav@iki.fi>
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
index 723210f93..e152ead0a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -857,6 +857,16 @@ endif
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
index b011e9b0a..b1354d7f8 100644
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
2.55.0

