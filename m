Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECC93064B5
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775392887; cv=pass; b=A1X1SxP5wbPFVzg0froDsiw0SR1xIQ/nnHm3wmHwtkx/BsiabMZtvJiYVPOm8BNi2qEp5sQAI3KIB4X1+vVNzPf6l/2QPpcwT3QkoPFB8HvrWvttvpFBDWfax17ovcACXXYo1oJN4LORTlPokdE796a6dFcblEj0U1m4c8zC9v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775392887; c=relaxed/simple;
	bh=PQ+Fmv+GM8CVmZCsRZ5QIz1eo9T+MX5mlzXs12AYdd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRyoVJjzZca4zdvAakHdGZfEGxhjTHnmY9k3Y0xVkoQQKORmhGEBgg13jKut5AnU1pg4p9YRN77vTl2f5aYiQzjE1m82FkIziIAcEZORqvux60ebzT4NjmJHqn9HVSsxRJCrRqg075uT5XS3fHg+Zi+fUlqxBPDboku2rhGx3Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=TFL9BL9z; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="TFL9BL9z"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fpXBq28RkzyxD;
	Sun, 05 Apr 2026 15:41:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775392883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MaCMwgXIZrlppSsYG2079OSdAnkGOQ23ZJUWof0xaA=;
	b=TFL9BL9z0IAGejdxtJ429SDP+ATNRS3bOC9+B64fjxeENHl3amiHT8ZfVUkPpQEeM0IEq8
	QPmpevKW9c0cL/iAElb/I2fLem1UoGnNMqZ9d2/zzfwVsjS/2BUyhGDH1Zav9yakuRh+1J
	bswh0cFRNmXzEWgznpZTPG0ZUjh+c34=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775392883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MaCMwgXIZrlppSsYG2079OSdAnkGOQ23ZJUWof0xaA=;
	b=O99iwPG7aLahdopmDuZL2CqCv42znueSYEY70gqtKvzL7npMBkYpOzUC60u3dQ4Rovu68O
	dzQs1dQTQCJNv6ig1ny4tS18gjY9ArOM0F3zI+aEqobPInNboksdVDTWb+3zAp92Oak5oY
	e5QwamDXo4JxMV7Yzrx3ojRPCfrA9H4=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775392883;
	b=HcXTKtCjoCRytC0hgcx8HYQK/Se7EOynxg9L7gzFgLBDzVt03fouGVpUO4YymHYOcCFkT7
	EWSUpY5QARfK7AzIjVWZMtu86IJ4ttbBm6N0KbxA50ko3YD0oW18labBRc/PdNGWFokZD0
	IvSqnltFvBvrotGI7fCyLcYoRs2oqWc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 15/20] build: add functional testing target
Date: Sun,  5 Apr 2026 15:39:56 +0300
Message-ID: <4f1eb2329419ea339808ef787b9c18712459e876.1775392680.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775392680.git.pav@iki.fi>
References: <cover.1775392680.git.pav@iki.fi>
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
index 8fdf8d7fe..c65c02370 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -806,6 +806,15 @@ endif
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
2.53.0

