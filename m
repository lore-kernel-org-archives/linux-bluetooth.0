Received: from mail-vs2-f39.google.com (mail-vs2-f39.google.com [74.125.227.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9743470EB9
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790628465; cv=none; b=nMPuEqtsHAKvNA97iyLyp6RW8ICR5inDwp/bAAbKdojoWANhWHtg63ygu4IAGdhQ9TrR+GlyjDhYDFfQJEdmfUfYq18Gxv97kiuNrVmFBxT2dUlRRsKcOkiLA+8h+OIClHOC7zP8M9yP+mf/8mMxHdE3M5wgEndoAhb1iTsJK5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790628465; c=relaxed/simple;
	bh=vtDOJ1Ziql+81C3vRoez4Gh7CKZTycwyXgW5Wz3piQQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=caL2xb3cOm4txEa8Evu3r5jwUm59SZ3JHGIj/nuCFRYTTgX4zFMzxOgD15mVPGJkOIaC9OVsWLWe1JOcTSJCBBuLeow24erpyVFEVXa/4jrgnVA6NP3ddjvBig+zjLuWNXQDllrGfMxRVYSXegmtmlTD4YFQDRFiP06DB5CS6n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfgWe7bX; arc=none smtp.client-ip=74.125.227.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfgWe7bX"
Received: by mail-vs2-f39.google.com with SMTP id 71dfb90a1353d-5cd13e9ec34so1426977e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 13:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790628463; x=1791233263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ksOnSpCxNpRdsRYQbAn/5tAA3A63Y6ZSFEFj69CvSOU=;
        b=BfgWe7bXdNTi5MWCyprCyOAni5EcxItl3Bc+U6x2ppJ2Z3Jwx9U57X4N0dgcikDI6i
         GAgUl5uRHKRziLDK6t4iQqmBhqdJ8hRltbgZaoJcYSXMQIIR5WWALjlIx8+FuUh/POVn
         jOkcB/PqbRTS9QnevJJGYhYR8pW3p3RLn9TsGhDcjw4aKuNb+tVZfFfqX14vxSbK5U+R
         qwlCnAputyPWcz4uLDSSa4hWDNIC31BiVa373UaorLsGqYN5gq0hLGgLSdd//0eNqtKh
         H6JJwtPzXBtUptX77nJo4qNeconHwRV1Jty+/SWrlkFNyKSgFH3xeqbr4DUVYxq+wa/l
         e+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790628463; x=1791233263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ksOnSpCxNpRdsRYQbAn/5tAA3A63Y6ZSFEFj69CvSOU=;
        b=sSsMMb4ITouXgnD+m/aGCJksWBssZujEx8UXfQy0kjTYi8ieva0eiFBAsuIjuUu9qJ
         ubUZPMX1QwLHJ9SbCwA9B8hKEx2AwMENoaupfFCMgIncKHMjrRBF6zwcXFnmUaJ9Gn+j
         HDFTwXMgyZCDf5U3cBIga4KYiI8qX2NBa+fsvprX8TP8wzkxLAEJ15IERLZgtbnEU+WM
         fV76+GUOqhjV1Zb3Gf8nsHUMdOZ47EPrY+f5SaIZO3lhtPAN8x0qEK/Vgo1jljKIttoJ
         b63XVw0eR7rL5lkUqAIFudLmtMdc459vT8MKdHoE+IvCE0aPZ8Y55yA0enc1tujHLr4w
         ttJw==
X-Gm-Message-State: AFq9FYIxAnjKntn4Apl6aHz5JN517QIeaYK/wrYIikVo4vnuEBl1YXsK
	bJDFQLJWy8OPewUDyhVkMG6LJEG+wyNMo6ehnB2oGkFRuM77kUb0xBhXyIuD7QQs4rk=
X-Gm-Gg: AYBFou2R7EVrVj8p5OkAfcibrByQ7Lbxj2BSNKV54UxL7AWPDqRD1fZNsR148jj3IAr
	WVYKFh2wNYmZt7PYcnYFia3aFoW+zUnOJ0y7MZV+J4FvQ4hxAc0dFazFvvxDPXAJ/peBr00Sv/8
	Ry+n42Sh7EDk1SEZosEb0vWmjwG6JVxrPMTtki69TlbwkfKxGdpdI5bQGaYVFJIXWD91d19VpYr
	YVnRH8+yW3vR7AuLCygTBZT2o0qYT09oY4tRKD7B1yDkvAL13LWdF6ihUjWL9PmVeqk3kTXCGPU
	warCEbEnIKPQE387hhRYLNdKqg8oPh7ZrK//HQhIVSjFR3SSXlLNRbgVSHjgDd4+7KQma7xkuJX
	ZpcwlyDCxZHZ15ZQIWxid3/KsGRwzIqLeUkLzvRuKV+JZnQv0vMY3RySMUmDJEtWldBlQRktoyy
	rADANhR6X3yhBP+11GtT2OyNjKi/AKrTymxjC+0doKroPVUP9SawuDD4eTNCJPkSQGDWVdqFzJJ
	4mZiLFAvsJjb10H/MGYkpGoKRsYUnAtEifpZUSFPSyTFs4k4O8SKLvV4SCFVpqV
X-Received: by 2002:a05:6122:d97:b0:5c9:a617:580f with SMTP id 71dfb90a1353d-5cb0b48e12cmr6201103e0c.12.1790628462542;
        Mon, 28 Sep 2026 13:47:42 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cde587a790sm10296980e0c.9.2026.09.28.13.47.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:47:42 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] test-runner: Share build directory writable on coverage builds
Date: Mon, 28 Sep 2026 16:47:31 -0400
Message-ID: <20260928204732.1265535-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928204732.1265535-1-luiz.dentz@gmail.com>
References: <20260928204732.1265535-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The root filesystem is shared read-only with the guest so gcov is not
able to write the .gcda files of binaries run by test-runner, e.g. by
the functional tests. Share the build directory writable over 9p and
mount it over the read-only one when coverage is enabled.

Assisted-by: Claude:claude-opus-5.5
---
 Makefile.tools      |  3 +++
 tools/test-runner.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/Makefile.tools b/Makefile.tools
index 671b40fb0e42..658f92d7b9db 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -325,6 +325,9 @@ tools_btgatt_server_LDADD = src/libshared-mainloop.la \
 						lib/libbluetooth-internal.la
 
 tools_test_runner_CFLAGS = $(WARNING_CFLAGS)
+if COVERAGE
+tools_test_runner_CFLAGS += -DHAVE_COVERAGE
+endif
 tools_test_runner_LDFLAGS =
 
 tools_rctest_LDADD = lib/libbluetooth-internal.la
diff --git a/tools/test-runner.c b/tools/test-runner.c
index 338e5b9da544..674ce072d959 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -577,6 +577,46 @@ static void terminate_signal(int sig)
 	terminate = 1;
 }
 
+#define COVERAGE_TAG "bluez-coverage"
+
+static bool coverage_enabled(void)
+{
+#ifdef HAVE_COVERAGE
+	return true;
+#else
+	return false;
+#endif
+}
+
+/* The root filesystem is shared read-only, so gcov would be unable to write
+ * the .gcda files of the binaries run inside the guest. Share the build
+ * directory writable so it can be mounted over the read-only one.
+ */
+static void coverage_setup(struct strv *argv, const char *dir)
+{
+	if (!coverage_enabled())
+		return;
+
+	strv_append(argv, "-fsdev");
+	strv_append(argv, "local,id=fsdev-coverage,path=%s,readonly=off,"
+				"security_model=none,multidevs=remap", dir);
+	strv_append(argv, "-device");
+	strv_append(argv, "virtio-9p-pci,fsdev=fsdev-coverage,"
+					"mount_tag=" COVERAGE_TAG);
+}
+
+static void coverage_mount(const char *dir)
+{
+	if (!coverage_enabled())
+		return;
+
+	printf("Mounting %s writable for coverage\n", dir);
+
+	if (mount(COVERAGE_TAG, dir, "9p", 0,
+				"trans=virtio,version=9p2000.L") < 0)
+		perror("Failed to mount coverage directory");
+}
+
 static bool rootfs_setup(struct rootfs *r, struct strv *argv)
 {
 	const char *mem = "256M";
@@ -826,6 +866,8 @@ static int start_qemu(void)
 	strv_append(&argv, "-append");
 	strv_append(&argv, "%s", cmdline);
 
+	coverage_setup(&argv, cwd);
+
 	for (i = 0; i < num_devs; i++) {
 		strv_append(&argv, "-chardev");
 		strv_append(&argv, "socket,path=%s,id=bt%d", device_path, i);
@@ -1456,6 +1498,9 @@ static void run_command(char *cmdname, char *home)
 		return;
 	}
 
+	/* home is "HOME=<dir>" */
+	coverage_mount(home + 5);
+
 	if (num_devs) {
 		const char *node = "/dev/hvc1";
 		unsigned int basic_flags, extra_flags;
-- 
2.55.0

