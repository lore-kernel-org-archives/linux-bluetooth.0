Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395785;
	b=bW3tnKK+DNodrdrnuRXvnACFMqcQJIOZnMHFxnY+JVURdTGNSiO/p9h5AIMyCCGXu/zh
	 +Ktz6CkPxXT5BginoVuoPlGPZJH4lSu4Fam6R3kWbReoKYeijYYzI7f77W+T39pvWENIN
	 du4GZD1JeUDrZX/YYTjUvLflIC4FXjXJGItc0OsWXcy3zNZM3us2rDctFK9pWOuAK6Qjy
	 bL2Te5mds5GGRPYNcMkCvb4wlXQPeZb4gZfvgSqnTKCj1f8jwLyN6tVLMSamagYBAwHBq
	 lmXVYw/CV+W61Nv18GD3debDLixTD5PnMPKpLeoi+RUlRs3QndPHh1qM0knkrs+FTUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5/H0eW49L6yuwUWGtobKXtEkWInlQauDSHgvoHhj5ok=;
	b=ct90SPAorDwQgzpGepKdREmSxNtDsWJTrMiOkohXySAlTHMEaPwPnVTOmLnny8KuIHxc
	 xYXChdFnSBUqKm4pwRGpkl+0i7sRM8tCI4OebqnoNzglM1Z9shWZMxpC87UffaP78X9FU
	 ryC0RJyQCGueyb1ZKH3ckdNEsI8dLv0F38mAps7we7HzTRC4/puPFLt58MgcCBN6lg/B6
	 kDQpCCKdEh+vK/mi3LsFOE9O8Q+82WI/yjLPSb2K/E6tUGrdNmPfhDrRu5t0wU8TBz3i/
	 cpaodU5DguULNQbs+T1dpJrGYrzkpz0Fi8Yky26eHlRgHH5mJpQRHZF7BOpNdmstoaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uB3OSIOP;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ABF606A326
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 21:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48ABF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uB3OSIOP
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5ead9f60e26so2275592e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 14:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793395784; x=1794000584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5/H0eW49L6yuwUWGtobKXtEkWInlQauDSHgvoHhj5ok=;
        b=uB3OSIOP10eOI0jn4J53xLJYbahDjBtrHLWC2hV9fO6jjspfYdcvjkNTM+a+ue5khf
         iVPcjITpSuepb5qeiMndkGPCKEr7Qg+PvqPmaRbC5vNhIfmKneAFMv9RAemDys4PnKTJ
         E3+14kM2jA4daUIwCGY8zr+yGGaWiVixtbPblqcN3zLSlMONqQfN4/D2vKZb1B23YFel
         g/80my1srWErAIMBzgm63dX9Jl1Ww74ZbHSxyJb5r1oBsoTpNnlxWk9F1yZjAXQVMFFf
         oWhJsjG/JtshvpW/mnYxCK67twWsfTTfFejpm0IMPx0VriCBiyPhTFAEfHw+btRPpzI9
         tXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395784; x=1794000584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5/H0eW49L6yuwUWGtobKXtEkWInlQauDSHgvoHhj5ok=;
        b=Llroe5G5KVvhCiMF/GQ0xPjMVu9pWOr6xt4y+k/B8ikrPU2gooBQOvp+8Fwqs6j9Uy
         QDn72iJO9IowZUiUXr8NkaJupu2Q0uzynGSNeDtXQN67dCSCTBGW9ErAyn+eJbWa+3In
         +qJfX/66jDmhYI24oMLxB4bo5kMjvn0ZcxnOyumdzDzlalTzZiP2TPeCO6UfkhremTgX
         Hsauh15wj6GZau8oo0vvYZkIZJxfvCyyD0S/Hgy6R1LgH4i7ojeVjWrhLSuEIMzEacAI
         ozY24aFN8xAkGFm4QzPWUf83TNcLQVdkLUwIjREeBzFeYyfezEzASa9eF9JqM60vukHe
         hVUg==
X-Gm-Message-State: AFq9FYKWw1uP0PKPrbKoj3a2fktXYu6UaQqU/gJ3Afn1Z8oYFqQDwx4r
	MLPOjJsohjNWwUMhnkmuqhz68xMFKnbaGsYSTPzDWA3lsmiNtmcQFSk6M4RPNA==
X-Gm-Gg: AYBFou3mGgtbzRP5edZJ9HC7ETF0WeHJlzq3UlLFYrpU2M0G6oiy5oHIMIYFIDTYmT1
	v672BwtFl4HCPoC+lTArLVtACzXR4RF1f0hF7xWENWwxgbZKluNmoLMjE0gDKz24eGPf7ZSVomV
	hMksFKQB74dMhT9yeSDp5IcuV8n20lkdXqZihgus3DASovjNVpa40ZVUiO4qvEZiMXgPVsYgcYM
	X7pMt6nF9Xm1YQrx4iN7R8J2HNbSlrWcnsdI8iUcx5Gc0QFWOdOMYUVsG4qOWMMPKJ7vy57Vpjo
	9Q6GEXrRA7WKctubxHBj6VGv8pDsJawumEXAwnfCc0OUDj3uH73+9tsQwstLMunc9fcPPJor+YE
	YtF5GFg4+PfWGdKM46XiCWML7h0L5Lg77We3HJ45LdA777MN17O4N9gCqx6mZvhh7JqSSXzBlVj
	baa5YBnx/3bpVvq+/26fQbygYDHYgr6f73lYanDKF5DEBEqST8L+Hv//I1eHpCYb2H0gNkL1A5r
	hi0cpedSKNrKX+OhrmPZ3+eLN16Gy3/ptDBhDx213qXMcpZaeVlCpgkKIhNHXKzDExkZzY0+gDg
	Gi1W0dsoIehE47R8bv4hfghMmquFoFfMoUcwJVSxkrqoQqNNl6JEoQcqONzrx3TI3Ih9nfb/KJ6
	PyKj1yiVtsXhZ/W4c9jeslBtjXzhQI7KylJM0ei9WP4ENSlQIKn2NluFpVhVMI1F7pgEHqbitya
	+MngM=
X-Received: by 2002:a05:6122:e193:b0:5ea:c984:5ad4 with SMTP id 71dfb90a1353d-5ec6851637emr1316696e0c.2.1793395784117;
        Fri, 30 Oct 2026 14:29:44 -0700 (PDT)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c9c554sm3696412e0c.14.2026.10.30.14.29.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:29:43 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 01/10] tools/test-runner: Default to time travel with User Mode Linux
Date: Fri, 30 Oct 2026 17:29:30 -0400
Message-ID: <20261030212940.753771-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030212940.753771-1-luiz.dentz@gmail.com>
References: <20261030212940.753771-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Run User Mode Linux on simulated time whenever the kernel supports it,
since that is what makes the testers fast and their timing reproducible,
and add -R, --real-time, to run it on real time instead. -T now only
makes the lack of time travel support an error.

Do not start a calendar when a time-travel kernel parameter is given
with -o, so guests can join an external calendar shared with other
guests and controllers, as test-functional does.

Assisted-by: Claude:claude-opus-5-5
---
 doc/test-runner.rst | 23 +++++++++++++----------
 tools/test-runner.c | 33 +++++++++++++++++++++++++--------
 2 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index 02d69b06f54c..220a2cec1c55 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -29,7 +29,8 @@ OPTIONS
 :-k/--kernel=<image>: Kernel image (bzImage) or User Mode Linux binary
 :-F/--virtiofs[=<path>]: Path to virtiofsd, or no to disable virtio-fs
 :-T/--time-travel: Run a User Mode Linux kernel on simulated time, with
-    btvirt as time travel calendar
+    btvirt as time travel calendar (default if the kernel supports it)
+:-R/--real-time: Run a User Mode Linux kernel on real time
 :-o/--option=<opt>: Additional argument passed to QEMU, or kernel
     parameter with User Mode Linux
 :-h/--help: Show help options
@@ -152,12 +153,14 @@ Bluetooth controller, or joins an external simulated clock with
 ``time-travel=ext:<socket>``. See `virtio.rst <virtio.rst>`_. ``-u``,
 ``-U``, ``-P``, ``-q`` and ``-H`` need QEMU.
 
-With ``-T``, test-runner starts **btvirt(1)** ``--time`` as time travel
-calendar and runs the guest on its simulated clock: time only advances when
-the guest waits, so it skips idle time and timeouts take no real time, while
-the guest sees the same timings on every run. This needs a kernel with
-``CONFIG_UML_TIME_TRAVEL_SUPPORT``, which test-runner checks; without
-``-T`` the same kernel runs on real time.
+If the kernel has ``CONFIG_UML_TIME_TRAVEL_SUPPORT``, test-runner starts
+**btvirt(1)** ``--time`` as time travel calendar and runs the guest on its
+simulated clock: time only advances when the guest waits, so it skips idle
+time and timeouts take no real time, while the guest sees the same timings
+on every run. ``-R`` runs the guest on real time instead, and ``-T`` fails if
+the kernel has no time travel support. A ``time-travel`` kernel parameter
+given with ``-o``, e.g. to join the calendar of other guests, replaces the
+calendar of test-runner.
 
 Kernel
 ======
@@ -421,9 +424,9 @@ Running mgmt-tester under User Mode Linux
 	$ make ARCH=um olddefconfig linux
 	$ tools/test-runner -k <linux>/linux -- tools/mgmt-tester
 
-On simulated time, with a kernel that also has
-``CONFIG_UML_TIME_TRAVEL_SUPPORT=y``:
+With a kernel that also has ``CONFIG_UML_TIME_TRAVEL_SUPPORT=y`` this runs
+on simulated time; to run it on real time:
 
 .. code-block::
 
-	$ tools/test-runner -T -k <linux>/linux -- tools/mgmt-tester
+	$ tools/test-runner -R -k <linux>/linux -- tools/mgmt-tester
diff --git a/tools/test-runner.c b/tools/test-runner.c
index 8be4bfb09265..b4947f113607 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -66,7 +66,8 @@ static bool start_dbus_session;
 static bool start_daemon = false;
 static bool start_monitor = false;
 static bool qemu_host_cpu = false;
-static bool time_travel;
+/* Simulated time with User Mode Linux: -1 if supported by the kernel */
+static int time_travel = -1;
 static int num_devs = 0;
 static int num_emulator = 0;
 static const char *device_path = "/tmp/bt-server-bredr";
@@ -1224,9 +1225,14 @@ static int start_uml(void)
 	strv_append(&argv, "TESTAUDIO='%s'", audio_server ? audio_server : "");
 	strv_append(&argv, "TESTARGS='%s'", testargs);
 
-	for (i = 0; i < num_extra_opts; ++i)
+	for (i = 0; i < num_extra_opts; ++i) {
 		strv_append(&argv, "%s", extra_opts[i]);
 
+		/* Time travel mode given with -o, e.g. an external calendar */
+		if (!strncmp(extra_opts[i], "time-travel", 11))
+			time_travel = 0;
+	}
+
 	if (time_travel) {
 		calendar = start_calendar(dir);
 		if (calendar < 0)
@@ -2164,6 +2170,8 @@ static void usage(void)
 		"\t-F, --virtiofs[=<path>]  Virtiofsd path or 'no'\n"
 		"\t-T, --time-travel      Run User Mode Linux on simulated\n"
 		"\t                       time, with btvirt as calendar\n"
+		"\t                       (default if supported)\n"
+		"\t-R, --real-time        Run User Mode Linux on real time\n"
 		"\t-o, --option <opt>     Additional argument passed to QEMU,\n"
 		"\t                       or kernel parameter with User\n"
 		"\t                       Mode Linux\n"
@@ -2188,6 +2196,7 @@ static const struct option main_options[] = {
 	{ "option",  required_argument, NULL, 'o' },
 	{ "virtiofs", optional_argument, NULL, 'F' },
 	{ "time-travel", no_argument,   NULL, 'T' },
+	{ "real-time", no_argument,     NULL, 'R' },
 	{ "version", no_argument,       NULL, 'v' },
 	{ "help",    no_argument,       NULL, 'h' },
 	{ }
@@ -2211,8 +2220,9 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "au::bdsl::mq:Hk:A::U:P:o:F::Tvh",
-						main_options, NULL);
+		opt = getopt_long(argc, argv,
+				"au::bdsl::mq:Hk:A::U:P:o:F::TRvh",
+				main_options, NULL);
 		if (opt < 0)
 			break;
 
@@ -2267,7 +2277,10 @@ int main(int argc, char *argv[])
 			extra_opts[num_extra_opts++] = optarg;
 			break;
 		case 'T':
-			time_travel = true;
+			time_travel = 1;
+			break;
+		case 'R':
+			time_travel = 0;
 			break;
 		case 'F':
 			virtiofs_auto = false;
@@ -2324,17 +2337,21 @@ int main(int argc, char *argv[])
 		}
 
 		if (time_travel && !uml_has_time_travel()) {
-			fprintf(stderr, "%s has no time travel support "
+			if (time_travel > 0) {
+				fprintf(stderr, "%s has no time travel support "
 					"(CONFIG_UML_TIME_TRAVEL_SUPPORT)\n",
 					kernel_image);
-			return EXIT_FAILURE;
+				return EXIT_FAILURE;
+			}
+
+			time_travel = 0;
 		}
 
 		printf("Using User Mode Linux kernel %s\n", kernel_image);
 		return start_uml();
 	}
 
-	if (time_travel) {
+	if (time_travel > 0) {
 		fprintf(stderr, "-T needs a User Mode Linux kernel\n");
 		return EXIT_FAILURE;
 	}
-- 
2.56.0

