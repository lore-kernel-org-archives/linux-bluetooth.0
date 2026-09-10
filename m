Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025E23603FB
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058664; cv=none; b=pS63NWEalyhO0uqvQ/etnokuv6tkVATs2QHrVVuIdX01lvPqO+WgAHFZl4j6jF+0oYI9Auu/x06hB9wnJzdVAAy5Gu9irPMP//eLJNx1jKBPfikAoJHIRGBy1sHLoSFwNUT7wZmxinLdTHuba6mDepyqZseG503UxGhjojptn0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058664; c=relaxed/simple;
	bh=LADzvY1ACv2tfC9/QCQd/9c54vaRKmQ172U3pqlBKZU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rW/WUWujma3OeY6Hkt9VP6wIzBKQnwD+miq0/jwkVbTmKtzbSI9nTYR1oFfRF0Gogynd1qEjW4T5C3YPL3YrUyFekz7P4nWxr9L+lVZhwQnDGit6kE48SLy4KW0C1CG6n+K8bTkrCx9zeLqRxSssLaThtSh3f0ffnSSTD0bN4G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p6NScDJ7; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6NScDJ7"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c8c8602so46374241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 09:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789058659; x=1789663459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W/rOxXED+HxMF6+5+W9+TLJY/ccOHQ7gn++y7QsQ4Ec=;
        b=p6NScDJ7ouDLjDbXemN4vv+RgBdjRwRwBEao/TM8PX1gJyT4LHnpnIV+DdCKfP1dIT
         JL+u1FKA+AJ42BDExNtsD+M3hOufWHCg5v5eTi56CFX7XgXJqxRw4Bl6SgFJdQzttFPe
         FHFF9albGJLIG0er86Z693HY1CKiErs7DZTh41ZVjjwMXMqzLT2nbSeteFqXVvJJ8nhB
         qsTn0kzsPTc5v+tD9R3UWAf20zKNDxp6v/Es1xb9gNDyFIbvtJUtx7pIhCoUmLwaQ8j2
         HDxX2NdVHMdY96HSE465aG+rZLW+30DeqEBfWdLbbQvN7Vxcs2vnUW/IIu/EwdIIL4TR
         Y2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789058659; x=1789663459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W/rOxXED+HxMF6+5+W9+TLJY/ccOHQ7gn++y7QsQ4Ec=;
        b=THMjuUJjIDwjbD9m4MsD3mq+3IL5Z9HFXs73vvT95bx7nVesB6qLUZ51VRLTxv8dy4
         mZSlWzxmHBUn2wdQzY07QkR1osxULn7CfwD0RKot9cK54wJFyiG++h5AwU9A48R/YK8W
         31YJDWw6mQ3MVPYS+MemdK3cwC803mEqSiRxdKahjDMmpq1qA9j/fyirOZ1EpK0rw3pl
         a37SFnkZ5CQPZS0pFpVao0IGpId87hEsF46Y4CS/XSf7VqvaA0WrfwseNrdWxuXpdKo3
         GS0jovydPbaTbB9vYnriuwRdvj6Fgup8IKlH+xBo0VCCKtWxGvUzQykpobN6E0Sskp5D
         x0qQ==
X-Gm-Message-State: AFuF++lXMIZp/aeMiVn5zxuy0l5s83f7UOrZaV+OqISNPTxclSY6ZiMV
	ohqwjNAe3ERHXHInCe71lzsjLBcIwSAzIDoOsrgEYljHLWDDJpigVT/Y4+zflIeJ
X-Gm-Gg: AYBFou3xKevj8SWuKGBLzxuWozElndlSzaQ8wFGKBHFAYyMpbM3ebUdIX6my7X9UjE1
	osQamx8eAD04Nj0tiQhlTPNC4OAZWXeJsIoo3m8+DJ9+LZs4Z3b0Ul7bRZJHdlMJ/xbJR33TMBZ
	feUbR9HAZ/Hkn1VPdMOjcFWT2Jbtikaq7hBq+6RDryjYpgxyO4jbfGS8ZAZaIXZ0titcKVGSkOf
	nzVNbRbu1sGsETNI7d4c6M2sEO1KFUQllEbgKuUeZUp3tmXA6gcQUadSGrJVI90defSGy7wpqHv
	8rm6zCZZuCefm0+39DI3x6Np3sW2VEZfUhNVsr3m9F+/fgIPYKtVL3yQtkJaSr/krIubF8HYy4l
	YgxraV2B/IV5PEV201X6LCVHHu3RZHV42e9rplmxxavlD8ZLNo7K8eiLrfYYdbDFnx1KIvXpdam
	Kqyuzat88dl9P8Xk2xFeCUluooJSurlOfym+UTX+Qy5FAzUtwlbpSrA0CuS+y25w6FXM2PCYnIf
	UrEgtNDBCJtVu58ByA9vKf9BpiVD9pnJh9F75q/LghPH+Bz5mzf5jng1ScUSt4rYTE=
X-Received: by 2002:a05:6102:5719:b0:78e:1e0f:ea42 with SMTP id ada2fe7eead31-792a47f4705mr53600137.2.1789058658667;
        Thu, 10 Sep 2026 09:44:18 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-982ba1105f6sm53822241.11.2026.09.10.09.44.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 09:44:18 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] build: run the test suite in parallel
Date: Thu, 10 Sep 2026 12:44:12 -0400
Message-ID: <20260910164412.1495535-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Both the unit tests and the functional tests were running serially,
which makes "make check" unnecessarily slow.

The automake test harness spawns the individual tests from a sub-make,
so adding -j to AM_MAKEFLAGS for the check-TESTS/recheck targets is
enough to parallelize the unit tests.

The functional tests are parallelized with pytest-xdist. The loadgroup
scheduler is required since pytest-bluezenv marks the tests sharing a
host/VM setup with an xdist_group, so that they are kept on the same
worker instead of each worker re-creating the same setup.

The number of concurrent tests defaults to nproc and can be overridden
with CHECK_JOBS, e.g. "make CHECK_JOBS=1 check" for a serial run.

Assisted-by: Claude:claude-opus-5
---
 Makefile.am                      | 11 +++++++++++
 test/functional/requirements.txt |  1 +
 2 files changed, 12 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 3840bdbab17c..7164700ae896 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -859,8 +859,19 @@ endif
 TESTS = $(unit_tests)
 AM_TESTS_ENVIRONMENT = MALLOC_CHECK_=3 MALLOC_PERTURB_=69
 
+# Number of tests to run concurrently, override with e.g. CHECK_JOBS=1 to get
+# a serial run.
+CHECK_JOBS ?= $(shell nproc 2>/dev/null || echo 4)
+
+# The automake test harness spawns the individual tests from a sub-make, so
+# passing -j to it is enough to run the unit tests in parallel.
+check-TESTS recheck: AM_MAKEFLAGS += -j$(CHECK_JOBS)
+
+# The functional tests are parallelized by pytest-xdist, loadgroup is required
+# since pytest-bluezenv groups the tests sharing a host/VM setup together.
 check-functional: all
 	python3 -m pytest "$(srcdir)/test/functional" -v \
+		-n $(CHECK_JOBS) --dist loadgroup \
 		-m "not tester" \
 		--kernel="$(FUNCTIONAL_TESTING_KERNEL)" \
 		--bluez-build-dir="$(top_builddir)" \
diff --git a/test/functional/requirements.txt b/test/functional/requirements.txt
index b8a1d99ee4d8..078c3fc6b656 100644
--- a/test/functional/requirements.txt
+++ b/test/functional/requirements.txt
@@ -1,3 +1,4 @@
 pytest>=8
+pytest-xdist
 pytest-bluezenv==0.1.9
 black
-- 
2.55.0

