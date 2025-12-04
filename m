Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5A42FE067
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Dec 2025 20:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764880707; cv=pass; b=u5FK0etETaMw6avZc9mY0Y4CvuTqAo+O1RhSSOdmI0QxCdRRz91Cr44sTcXpX72Hq/wavoX6ZJ6sVnHWZpg+08D17aGDJ5Wr6SVsVpA5KVWzeWyKNPpqJvoPCVSfWet8NNXTsk+lIvhhhutNCzf5L/K7HP1TAdrEED37W5DE4DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764880707; c=relaxed/simple;
	bh=Zj5Vt1bMrRMHN+jmJ6j5e+zd4F+PqtxW7YN5nhqI298=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eLTszEkOPHnZT1E1kCFZ62ZFT0y7/1fC1kROJx7xwmn1j/JuQgR8I8/1J8o4eQ21e+aQmkEi35N+eMuG+6TKVlNYqF3D25Zim5wgMsu/N1dnAOSOPX17sEbNZWnmq3yg2nbN29rNOTwvgX+fpzb0FUUf4vOPD+EXc94RBBvmJ5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=GjIOa+jT; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="GjIOa+jT"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dMmYK19n4zyQn;
	Thu,  4 Dec 2025 22:38:12 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1764880693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qv8b9OH5d5NyjOWNjHEu9zCv4snI0fLejuySzZXdNWM=;
	b=GjIOa+jTdnZJnT1cH2PVssEbe5goHEqla1USGcTXZqoux+CJkm1VD18QuN68Fz/njugOdo
	L5KtITzIIRVE7IgURF9Y32KSHLmND6di4HDwa+JdZ7+kUnxeZURm5lVSiDQbnFY6cqurYF
	/oosz+5U/JaJwobywutU7n/TdEVTYpA=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1764880693;
	b=OtIBtN90JeIry9wkDTCGMqBy5QjJbZXpNnjmiCBQpunBn8kcZ4Jt+EgYYu4KGt11yJYwmG
	OWpsvVZNWKFp4xCyEfrbg+PKwezgXFwLxM0DMKg2XIFOmTx1oupKljU+uCcriAq6jNEtV8
	3Z4PlIa+leGygygd6XMhD1nZJ0O0V0M=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1764880693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qv8b9OH5d5NyjOWNjHEu9zCv4snI0fLejuySzZXdNWM=;
	b=AVFLqj4TA2n2Nluj6lqGrT6QW3OOZLkOkgFV3ZRRAwk38WOouF7hx6JubMM6MlSw06Y7/z
	YtzgIE1xk4ynW/T9Jo2iUQtHxxaEi5JOu44+6hMfbqI9oNgeLe0pqCO53zBNfMoDcrd4Ee
	C781pol+1EJJnwAQsrkKx1eKcSGgsHA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] main: fix bool vs. gboolean type in g_option_context_parse()
Date: Thu,  4 Dec 2025 22:38:09 +0200
Message-ID: <36c55de961b5b5ceda83c019ec511f8fa7cd44b6.1764880521.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btd_opts.experimental and testing are bool, not gboolean, which may
cause memory to be clobbered and crash.

Fix with separate variable for cmdline option.

Log:
ERROR: AddressSanitizer: BUS on unknown address
    #0 0x0000005b9914 in queue_find ../src/shared/queue.c:230
    #1 0x00000057c0ff in btd_kernel_experimental_enabled ../src/main.c:721
    #2 0x0000004ff52f in read_exp_features_complete ../src/adapter.c:10230
    #3 0x0000005be40b in request_complete ../src/shared/mgmt.c:306
---
 src/main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/main.c b/src/main.c
index 558bf2888..61e5ef983 100644
--- a/src/main.c
+++ b/src/main.c
@@ -1330,6 +1330,8 @@ static char *option_noplugin = NULL;
 static char *option_configfile = NULL;
 static gboolean option_compat = FALSE;
 static gboolean option_detach = TRUE;
+static gboolean option_experimental = FALSE;
+static gboolean option_testing = FALSE;
 static gboolean option_version = FALSE;
 
 static void free_options(void)
@@ -1420,9 +1422,9 @@ static GOptionEntry options[] = {
 			"Specify an explicit path to the config file", "FILE"},
 	{ "compat", 'C', 0, G_OPTION_ARG_NONE, &option_compat,
 				"Provide deprecated command line interfaces" },
-	{ "experimental", 'E', 0, G_OPTION_ARG_NONE, &btd_opts.experimental,
+	{ "experimental", 'E', 0, G_OPTION_ARG_NONE, &option_experimental,
 				"Enable experimental D-Bus interfaces" },
-	{ "testing", 'T', 0, G_OPTION_ARG_NONE, &btd_opts.testing,
+	{ "testing", 'T', 0, G_OPTION_ARG_NONE, &option_testing,
 				"Enable testing D-Bus interfaces" },
 	{ "kernel", 'K', G_OPTION_FLAG_OPTIONAL_ARG, G_OPTION_ARG_CALLBACK,
 				parse_kernel_experimental,
@@ -1464,6 +1466,9 @@ int main(int argc, char *argv[])
 		exit(0);
 	}
 
+	btd_opts.experimental = option_experimental;
+	btd_opts.testing = option_testing;
+
 	umask(0077);
 
 	btd_backtrace_init();
-- 
2.51.1

