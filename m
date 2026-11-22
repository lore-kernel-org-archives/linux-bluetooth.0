Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795343678;
	b=JoP6VW2xeKuJcYwsKZTFS71OYV/GkttwklvUw784bRFLJSURreq5sP8xaZz3WBs2Y2pd
	 B0wkyZqBb6L1ABnl6DtU6Bsap9CP8tHSbaIb571lWpsQltJZYCDj4YrZLIW7r64P4SNvN
	 n7+Yz2m62NZYO7PJB51DfZdv99SFH7XlnmvT5cPOKr/qBneSti5CO1etqYe2FbnzwXsep
	 rpGWT4SmKZ51N8d+K3K85k++3SqHx+PvIlpVkIPIGoe1hWpJgBKvIIuKmrgsHL6xgpi6W
	 zDscfqd62MEsB2Roue1eRx0dpoMMKiM/xzmEpj2fFiHRcNtE27bCPZyh9MoorRBqAhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795343678;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=J5d0q0WQarbxeSn8lb6GS+4NzEmJSU1b88ZNnp3md7U=;
	b=euSN9kjrFx1GIme5F+ZnGj1XRrhFwUCECESNL2239YPrZZ45lmj0CVvgn80piZ3HP+Hr
	 EziGvOkZwlhW10EiTf2n2qQjA3C62NXBpCwFhsKyJgrNtmq0jwXOMGjAyNFf8Ntzoyp3C
	 Kh8P5A/+HCqX6QV7L/PFI3ulzZ7DtIT53LHosAw9g86InuBoOrS6cCaS5EMvMvWY0RUOL
	 NBJx+vmeL1iyBtHSqKgL9qIBbAb8b/fZBrG7ycKP/QyJwzh6k/5zfIHmxfyvzeBoFWj8q
	 h9dzivJQagI2BIEqg7Q4ry3d3mxo6TEKR6DgBZNhKamyBmqU/AKckhrvQVGJYZs/Lig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H6xzujK8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DMGQ6FAd;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C1D606A33B
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80C1D606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H6xzujK8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DMGQ6FAd
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM863AB2902564
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J5d0q0WQarbxeSn8lb6GS+4NzEmJSU1b88ZNnp3md7U=; b=H6xzujK830huuEC+
	7AZs7VQ3yHJ3xtDhwGbAMRX+mxUmK2PFA6fYh413YF2HSLDopbmwyvxKZo5fWEAS
	WbF3N/6qGXQKKK1D6PrCuwvgS7YFeNRWp1KolIm8KtMcd6g7eUO1MDMokkW7RC/P
	VixTxCJ2+gWKVqxa7OPNkYFjU+oJLtbLHZBOyGr4PdgXQ3lD3v4XqMvusxaNW7cm
	LdG+iK2QYhZPCvjpyYk7exCm08TAqriOoKIXOYamkEqb8L2iFvsNl/2iI8ODhS1v
	m8DnaGFLmdRS6vLv5numiE1yr6KLJPR2Wu5flgfmSxZBjq52iFCBXGhgqun45Ldx
	IfCIOg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j33h336u0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:34:37 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3838b531addso224789eec.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 02:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795343677; x=1795948477; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J5d0q0WQarbxeSn8lb6GS+4NzEmJSU1b88ZNnp3md7U=;
        b=DMGQ6FAdtV6foIDvZ1SfvJNVafz0bllgwWQlc0j2KZu22Af96hcMkwbxzwbd3hmWLK
         XQ8bSZjyOe+Cv6C7/KGQsaSTaCnwbhFXl9rjRhMnYXPoNVBPTYxDV6+IZhMoJTqbOi4a
         9Xvn5UF4PRjMpMXRCYB7u4aqWMlpp2fBQFlPcKsq+7UnbWUakNW04X15x2W6KJOYYza8
         94cOOm5+2jxa2KWO+/zzza/VyiAzjwwKLqE0vpxkUCQlLpjp3vjczsRdDyKo6ujP01vk
         by2IUP9WzZh2WvjQ/ov9Eidl4H6bKAxwbxihN84tjr8hUdLYaCz2CUi/jM54bj3DlIl5
         Ty+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795343677; x=1795948477;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J5d0q0WQarbxeSn8lb6GS+4NzEmJSU1b88ZNnp3md7U=;
        b=tJQecuJIf0vHUDaehz760Vl0O3JnPLV5iSb98KoacmROLM4V9uHS7R/hgCYTIIKhF6
         K9hb6LjRLNzfRkzO1h6MwfJtpYWNG1zVaSd0yVAixyytqe2if4N+LMeBoiUv5OojSlGX
         FDhmGwmZjOIhzMRWvhTuhK/1XmVFuCTbyaHjoqv6uyeqKtriHMcWFpqJotqhosx5tvNI
         XBhxp/Ba/sIMThK4Q3cVbMwQPVzS6iV3JvVuodV37uO6B+oO3WiVclBc2UqAx1cx+NCC
         ZMpO6Ip18nnNByfSiMiMebvR0sUgN31gl73cFsthJnPrpA5KtT8edqwP9NJkUn2nu3hy
         xZfg==
X-Gm-Message-State: APuU4Z+wVJ0CC4of9KpwCQ923LmYPEUkBva4EyH41SrjupstkXrSvPWZ
	F3vbztHFM1XPzA+31Yk8oXIaazFRsjk7W/ZC04AvVuEjVUsAF/J5oqoTwKawQZNMIWereKFQFJL
	yMxxi7zH/bW7x26MGcW2DlH8bDjdkaHVkyczQzde5f4PoxVtwYMWLBYFnOjI7nQBMJPD4ibI=
X-Gm-Gg: AZFdTZdpmBMlS90iWxqIjDtePfMZdHpa9W92XZ+bQ+gHoFioRcZ+bJ3MuUPYbWCrcTu
	aBTOMwJ+UM/UdXZRFCkht+RbtA+GmB8LR1QmY0eL2aoV/tI9K7C9AGWRWRpWl4+dKu8av0yzgaW
	1XREMmCJQpEIQvN/kAAO8+YFkrffAMXaAAETophZAGxmC0xNSZsxEN/a5Y4dbr8MjUj8eOwf42M
	Z6nSu/wMhAfo1DgJSa6i8uFpy/PDDf4R7v2aAz6HiqEyKKvFrS26yMF7opDcXLl3UXvsgifDxMz
	h/a2rfkjF07Ig9R9biWZOShPRAbU8Vxb5tsu0C7CFOeORMxEaeiNE5Fv6uTXtysVEhzpoJfXFZs
	J/mqD2ouKCWe2urjlH/YUIkadKsZpQUiCanyN6touCxE+SQYIRjQxo1eSt3n9TG/3Yx1a6SheLd
	Z5G6ApRTi8TkPT02CY5uZe
X-Received: by 2002:a05:7300:6025:b0:384:cea9:a109 with SMTP id 5a478bee46e88-3856925debfmr13721442eec.0.1795343676948;
        Sun, 22 Nov 2026 02:34:36 -0800 (PST)
X-Received: by 2002:a05:7300:6025:b0:384:cea9:a109 with SMTP id 5a478bee46e88-3856925debfmr13721400eec.0.1795343676249;
        Sun, 22 Nov 2026 02:34:36 -0800 (PST)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm23747204eec.16.2026.11.22.02.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:34:35 -0800 (PST)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 02:34:22 -0800
Subject: [PATCH bluez 3/3] tools/test-runner: Allow suppressing noisy
 bluetoothd debug output
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-tr_arm64-v1-3-4eccf35daeca@oss.qualcomm.com>
References: <20261122-tr_arm64-v1-0-4eccf35daeca@oss.qualcomm.com>
In-Reply-To: <20261122-tr_arm64-v1-0-4eccf35daeca@oss.qualcomm.com>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Zijun Hu <zijun_hu@icloud.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=EsxHPicA c=1 sm=1 tr=0 ts=6b02c53d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=wOjIOvMYMMCE2G19r9wA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: RGoQCTUt02tOMhRloTsGnnifHxAasbnN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDA0MSBTYWx0ZWRfX6PDZe0AnYygX
 O8b+DbesLZe3GtewQjXmVU4PyDlF56dQYv72bPGjXuSWFECg13PaKAhg8/wft4f3eSdag/qo9Uq
 qQhFuscWE8fVQwXJCylxk2zlS6fsKa/aHa/BvAhqWgi+RsMcXMCAJflN2u8IWaoPlKUvmz/s9tx
 iKUSgexSVRzNcxLApMWXYbdZreGPRG5vORIuHdP+VAdEct9EQgRF1lNpiqb8dxfVeRUSs1tMLX3
 wj2WYXRYa4FEmvIJYYrQTaflRhBcwGRLkBNEhz042v4N89tYMuSSnwuguwCtiAZU03YzQxIEmvc
 ujIifNTZVI1wPOwIGlXMpwErIVn+mHFOj0HQUjt8+DkkFAdUNdCkhEQCxBAeC26BbPSHzkqGQgP
 VVd0qiGA9OJ2jnZZyC0HRLyXSbpeqifj8RZEGtZMbfxq/NUIX4vpxtamPSH13GMlBZLKnDO0t7P
 FuwrTPFCB973Y5glL7g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDA0MSBTYWx0ZWRfX1CzUfS87eNpJ
 ySZS/PgKWHYOBsX5kvWqTSfTDWb75RpciRZGewJe5rnk3oJn67zwzk4q7qILrO8C5XArWnYZLLl
 dprCegXqbmCa74q6qpPrp9xS9asql94=
X-Proofpoint-GUID: RGoQCTUt02tOMhRloTsGnnifHxAasbnN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 adultscore=0 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611220041

test-runner always starts bluetoothd with -d, which floods the console
with debug output when only the test output is of interest.

Add an optional bluetoothd run mode to -d, e.g. -d2:
- 1: --nodetach -d [-f src/main.conf] (default)
- 2: --nodetach [-f src/main.conf]

Also make supporting other run modes easier in the future.

Existing usage in doc/test-runner.rst still works since -d without a
mode behaves as before.

Assisted-by: Claude:claude-opus-5-5
---
 doc/test-runner.rst | 16 ++++++++++++-
 tools/test-runner.c | 65 +++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index 4ff9d1b02c1b..b9dc4f1f45a1 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -12,17 +12,20 @@ it launches a virtual machine using qemu(1) with the host filesystem mounted
 read-only inside the guest.
 
 OPTIONS
 =======
 
 :-a:--auto: Find tests and run them
 :-b/--dbus: Start D-Bus system daemon
 :-s/--dbus-session: Start D-Bus session daemon
-:-d/--daemon: Start bluetoothd
+:-d/--daemon[=mode]: Start bluetoothd, mode (default 1):
+
+    | 1: --nodetach -d [-f src/main.conf]
+    | 2: --nodetach [-f src/main.conf]
 :-m/--monitor: Start btmon
 :-l/--emulator[=num]: Start btvirt
 :-A/-audio[=path]: Start audio server
 :-u/--unix[=path]: Provide serial device
 :-U/--usb=<qemu_args>: Provide USB device
 :-P/--pcie=<qemu_args>: Provide PCIe device
 :-q/--qemu=<path>: QEMU binary
 :-H/--qemu-host-cpu: Use host CPU (requires KVM support)
@@ -359,16 +362,27 @@ Running bluetoothctl with emulated controller and audio support
 Running shell with host controller using btproxy
 ------------------------------------------------
 
 .. code-block::
 
 	$ tools/btproxy -u [1]
 	$ tools/test-runner -u -d -k /pathto/bzImage -- /bin/bash [2]
 
+Running bluetoothctl with host controller using btproxy for normal output
+--------------------------------------------------------------------------
+
+With -d2, bluetoothd is started without -d, so the bluetoothctl console
+is not flooded with debug output:
+
+.. code-block::
+
+	$ tools/btproxy -u [1]
+	$ tools/test-runner -u -d2 -k /pathto/bzImage -- client/bluetoothctl [2]
+
 Running shell with host controller USB-passthrough
 --------------------------------------------------
 
 In addition the above kernel config option the following is required:
 
 .. code-block::
 
 	CONFIG_USB=y
diff --git a/tools/test-runner.c b/tools/test-runner.c
index a2105977c1ee..bcfa4b2971ff 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -50,25 +50,26 @@
 #endif
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 
 #define _cleanup_(f) __attribute__((cleanup(f)))
 
 #define CMDLINE_MAX (2048 * 10)
 #define EXTRA_OPT_MAX 64
+#define DAEMON_MODE_MAX 3
 
 static const char *own_binary;
 static char **test_argv;
 static int test_argc;
 
 static bool run_auto = false;
 static bool start_dbus = false;
 static bool start_dbus_session;
-static bool start_daemon = false;
+static unsigned int start_daemon;
 static bool start_monitor = false;
 static bool qemu_host_cpu = false;
 /* Simulated time with User Mode Linux: -1 if supported by the kernel */
 static int time_travel = -1;
 static int num_devs = 0;
 static int num_emulator = 0;
 static const char *device_path = "/tmp/bt-server-bredr";
 static const char *qemu_binary = NULL;
@@ -1578,17 +1579,17 @@ static const char *daemon_table[] = {
 	"/usr/sbin/bluetoothd",
 	"/usr/libexec/bluetooth/bluetoothd",
 	NULL
 };
 
 static pid_t start_bluetooth_daemon(const char *home)
 {
 	const char *daemon = NULL;
-	char *argv[6], *envp[2];
+	char *argv[6] = { NULL }, *envp[2];
 	pid_t pid;
 	struct stat st;
 	int i;
 
 	if (chdir(home + 5) < 0) {
 		perror("Failed to change home directory for daemon");
 		return -1;
 	}
@@ -1603,25 +1604,40 @@ static pid_t start_bluetooth_daemon(const char *home)
 
 	if (!daemon) {
 		fprintf(stderr, "Failed to locate Bluetooth daemon binary\n");
 		return -1;
 	}
 
 	printf("Using Bluetooth daemon %s\n", daemon);
 
-	argv[0] = (char *) daemon;
-	argv[1] = "--nodetach";
-	argv[2] = "-d";
-	argv[3] = NULL;
+	i = 0;
+	argv[i++] = (char *) daemon;
 
-	if (!stat("src/main.conf", &st)) {
-		argv[3] = "-f";
-		argv[4] = "src/main.conf";
-		argv[5] = NULL;
+	switch (start_daemon) {
+	case 1:
+		argv[i++] = "--nodetach";
+		argv[i++] = "-d";
+
+		if (!stat("src/main.conf", &st)) {
+			argv[i++] = "-f";
+			argv[i++] = "src/main.conf";
+		}
+		break;
+	case 2:
+		argv[i++] = "--nodetach";
+
+		if (!stat("src/main.conf", &st)) {
+			argv[i++] = "-f";
+			argv[i++] = "src/main.conf";
+		}
+		break;
+	default:
+		fprintf(stderr, "Invalid daemon mode %u\n", start_daemon);
+		return -1;
 	}
 
 	envp[0] = "DBUS_SYSTEM_BUS_ADDRESS=unix:path=/run/dbus/system_bus_socket";
 	envp[1] = NULL;
 
 	printf("Starting Bluetooth daemon\n");
 
 	pid = fork();
@@ -2165,20 +2181,21 @@ static void run_tests(void)
 	}
 
 	ptr = strstr(cmdline, "TESTDBUSSESSION=1");
 	if (ptr) {
 		printf("D-Bus session daemon requested\n");
 		start_dbus_session = true;
 	}
 
-	ptr = strstr(cmdline, "TESTDAEMON=1");
+	ptr = strstr(cmdline, "TESTDAEMON=");
 	if (ptr) {
-		printf("bluetoothd requested\n");
-		start_daemon = true;
+		start_daemon = strtoul(ptr + 11, NULL, 0);
+		if (start_daemon)
+			printf("bluetoothd mode %u requested\n", start_daemon);
 	}
 
 	ptr = strstr(cmdline, "TESTMONITOR=1");
 	if (ptr) {
 		printf("Monitor requested\n");
 		start_monitor = true;
 	}
 
@@ -2218,17 +2235,19 @@ static void usage(void)
 {
 	printf("test-runner - Automated test execution utility\n"
 		"Usage:\n");
 	printf("\ttest-runner [options] [--] <command> [args]\n");
 	printf("Options:\n"
 		"\t-a, --all,--auto       Find tests and run them\n"
 		"\t-b, --dbus             Start D-Bus system daemon\n"
 		"\t-s, --dbus-session     Start D-Bus session daemon\n"
-		"\t-d, --daemon           Start bluetoothd\n"
+		"\t-d, --daemon[=mode]    Start bluetoothd, mode (default 1):\n"
+		"\t                       1: --nodetach -d [-f src/main.conf]\n"
+		"\t                       2: --nodetach [-f src/main.conf]\n"
 		"\t-m, --monitor          Start btmon\n"
 		"\t-l, --emulator[=num]   Start btvirt\n"
 		"\t-A, --audio[=path]     Start audio server\n"
 		"\t-u, --unix[=path]      Provide serial device\n"
 		"\t-U, --usb <qemu_args>  Provide USB device\n"
 		"\t-P, --pcie <qemu_args> Provide PCIe device\n"
 		"\t-q, --qemu <path>      QEMU binary\n"
 		"\t-H, --qemu-host-cpu    Use host CPU (requires KVM support)\n"
@@ -2247,17 +2266,17 @@ static void usage(void)
 }
 
 static const struct option main_options[] = {
 	{ "all",     no_argument,       NULL, 'a' },
 	{ "auto",    no_argument,       NULL, 'a' },
 	{ "dbus",    no_argument,       NULL, 'b' },
 	{ "dbus-session", no_argument,  NULL, 's' },
 	{ "unix",    optional_argument, NULL, 'u' },
-	{ "daemon",  no_argument,       NULL, 'd' },
+	{ "daemon",  optional_argument, NULL, 'd' },
 	{ "emulator", no_argument,      NULL, 'l' },
 	{ "monitor", no_argument,       NULL, 'm' },
 	{ "qemu",    required_argument, NULL, 'q' },
 	{ "qemu-host-cpu", no_argument, NULL, 'H' },
 	{ "kernel",  required_argument, NULL, 'k' },
 	{ "audio",   optional_argument, NULL, 'A' },
 	{ "usb",     required_argument, NULL, 'U' },
 	{ "pcie",    required_argument, NULL, 'P' },
@@ -2288,17 +2307,17 @@ int main(int argc, char *argv[])
 			reboot(RB_AUTOBOOT);
 		return EXIT_SUCCESS;
 	}
 
 	for (;;) {
 		int opt;
 
 		opt = getopt_long(argc, argv,
-				"au::bdsl::mq:Hk:A::U:P:o:F::TRvh",
+				"au::bd::sl::mq:Hk:A::U:P:o:F::TRvh",
 				main_options, NULL);
 		if (opt < 0)
 			break;
 
 		switch (opt) {
 		case 'a':
 			run_auto = true;
 			break;
@@ -2310,17 +2329,29 @@ int main(int argc, char *argv[])
 		case 'b':
 			start_dbus = true;
 			break;
 		case 's':
 			start_dbus_session = true;
 			break;
 		case 'd':
 			start_dbus = true;
-			start_daemon = true;
+			start_daemon = 1;
+			if (optarg) {
+				char *endptr;
+
+				start_daemon = strtoul(optarg, &endptr, 0);
+				if (start_daemon >= DAEMON_MODE_MAX ||
+								*endptr) {
+					fprintf(stderr,
+						"Invalid daemon mode %s\n",
+						optarg);
+					return EXIT_FAILURE;
+				}
+			}
 			break;
 		case 'l':
 			num_emulator = optarg ? atoi(optarg) : 1;
 			break;
 		case 'm':
 			start_monitor = true;
 			break;
 		case 'q':

-- 
2.34.1

