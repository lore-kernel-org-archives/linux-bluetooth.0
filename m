Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795661159;
	b=GLPNHDLaX+1E7kfdi3ocZOBm4SbnskeEr9GNOq/VJTNX88IG1JyBstAf1wikwUVzg/SW
	 lq/W9wKpsDeanivITHCD0wYSdtRa5D4zqnGQSKtE9XHM51B37eFPQaMUNbbOA4Kf2u295
	 0Vue9DBQhgZ2An9Adzbf3OFBMRlYNKFa+GdPisnLbpo6QF12gGB1mLxPRe++bUbxhicTn
	 ZdcBCMtciiIL/tbCTlpRGLhvME4+QTSSVZb8u950qmKTE6vqLIm8Z9BYs+0U51tdtOlGu
	 ZruLx6YtrRbqNz0pWyyOAnd8s+JrQYMFNL931bhpdeLPmWvEvByN67j8BwGyaqoJNKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661159;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=uBvRBzIdvP8oA62GVuk8mFEAo3ZUySsq+tH6QF4dNek=;
	b=guNm0wo/cQmY8Hr3guHs+3g4siQ70MDOi4RTLdeJoKWObvPoGXYo7ZDItrH91XDXEGrG
	 z2e6iQLlGOgiYq6nvYw3oY5yLvwS8H2dWTZtl+DewCtfiqc5PvA7CM0naouPrqVPsG4Bu
	 9cw+yzDWN321pQUwsIJgVjJh+PlEgkgaC049RCtdNhKbsdhLuDRDRyi91wewTMYDa6Ytg
	 QwLxP/xPV2hrpOR91WackhamSwP8n87saYDb+ECL8WmyjPuQmGh3OT0z7cmzeqP9XpRcK
	 rxDRZEG8m0tRR1MJEzLfqS6J5uwHzj1Xv+LCLW12SgW8VIwC9Nvz5nUE7EvVNiWtpOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IonkLUKp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ui6fA5me;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AAD606A321
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86AAD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IonkLUKp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ui6fA5me
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APJAtap1357697
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uBvRBzIdvP8oA62GVuk8mFEAo3ZUySsq+tH6QF4dNek=; b=IonkLUKpFn2SSg2+
	O43vAmLQIumANRnYA6Z9R0pysd2auJkYEdtYC7RJ3pEvxfjak6OJ1uaWtA8/uGY3
	8Fgl9eCYQIAR/PW5SDk7q2/YPFdWWvODueKdVknQYBx1aXd0jzB547PlFSQoJI7N
	gyXKD6fDxOCSVhhtBNyERuKaYwcuFvculHj+dkRoAMPxyzwTPo+C4LApv3W3hFQ2
	jrT4IaCFh8I4hBj014FGj7pDuLNsnJUAOGnx0rRc4yF4qjwHMarnSU2oKoJ4989d
	kPZOlU5QWYRhN3Y1YqqxyrVt1xQ3miBKNFIs0s2lCDViMcmlSoDoFFK+xnrTPox0
	bUCcFw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5yaxtw13-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:45:57 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-384c1cdccaaso464822eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 18:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795661157; x=1796265957; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uBvRBzIdvP8oA62GVuk8mFEAo3ZUySsq+tH6QF4dNek=;
        b=Ui6fA5meJ5gzwYkLIZv2/5Px0j+aEBiQLyRMguHOgOPxS8lkc9b2OEoHGZvGQ/HHck
         y6QChASBL/g75r7MHQPEV9GTj1Fht4tabACCQdQtltQGS64JSRMVoRJXpg+GSG23VZuY
         3BGXeCU4+E64Dovnj4uL4hdO4XJ/nYrGshmRCO7CINrLdNp2FxFHelNzI3bAFe964IWw
         93xOGNCu5G8nJQ/3sq19tl8d8aTlVYH/4MeBC1cNE8SEdiOUEZhPwtUXB33eDREVuVx/
         YnyF9kUGAwaMcRrN0PZWxnCgpInorSPhAcRtsRYpaSHMfBvd1Im8bJcQmImE0x4jtnlw
         WK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661157; x=1796265957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uBvRBzIdvP8oA62GVuk8mFEAo3ZUySsq+tH6QF4dNek=;
        b=CsMdoNVK5x1pNSt7MsYBp5xNDIj6owfSL44vUntULnzd0gECCKFZrRX4gFA3VFCqaT
         Cbo8TM0/ig1WPHVVfyrxcpyo4HTIg0sWtdeNxrB05hdZDaIngXHUUVNnJBGAW/l+5Ki2
         H8pQMfL4BMXxd33khHpSzLngNpWQjkVo3E3c9HvbEGnWNxBubEDmH+PNgPk5rE0MwvPK
         uDW040FJ61PjIV7jLL9uUHTynrqnuJEX0egmqqRQd0NiRdp6Fr3oa/qqKbb/fTQ+PDx4
         YWC6EEeGRo3bYYjtw15OXV1K5CI9GQkd2WQ+7Kq5Q1pn4k5qkyRyEl+GfaK5U1EKjLuC
         oijQ==
X-Gm-Message-State: APuU4Z9jwQ95boRAz2YqRg9NQ6lC9BVONVFIlI1IT+rzUaLH9X63b+hM
	pFRdg7n5QkNhnsRSfau37971Yq9pxo7UC3WEA0GMpip6BK047M+p+kV+xpNhARf6CXCBFbB/yGw
	ncue94d0SfDeJohPDaExteHD4Ea4llWliHI66a1BKnYt9dXd8XP4oLlxRZX9bJiZ19gzmS+QuI2
	cQX+jfxw==
X-Gm-Gg: AZFdTZdUYpTU6DrOhGFWZQ6prCZ3MmIB7wCMfZBOJODQuSe/yJYOozkY5CEzI6STYy0
	tPu/OibhD8QGiTjMJB06DDx5Lxv++YyA6WYf33wOK3gOg+pLJs6UNNLgwiqqrvqpFOEwnCxcO6B
	lh7ervKlCtQ8VvNLKpbOJ2TL+7cG7MQhL2v0HepL0eZed/7xVXH1OmWWwNRBn7NFyLgTrSdbkXG
	Qjg/eSbBaW2Z1HmkyhgY8U/1D6rJsQI90/VtMe/P5SdwUTKs/fzkmeE88lAiach2pEgxiVKTCn/
	cZWbB2HrDTJivgsbOGTC4qItRkC/eIHcLxyqjwpdyU4llvDMws1Z7qATMZ01prQevsAgF4F0gc8
	FF3MLG8cGpOw+gbBgiBjNwhtaXKQpf2vaL2Ay80w8M0cURl0m53pugptPUiEYTC+OELhxfbreqA
	UnUn0BeJ1TPI36/q/CbsqT
X-Received: by 2002:a05:7300:1c24:b0:384:a0cb:a6d0 with SMTP id 5a478bee46e88-3856de58f7fmr32556151eec.1.1795661157103;
        Wed, 25 Nov 2026 18:45:57 -0800 (PST)
X-Received: by 2002:a05:7300:1c24:b0:384:a0cb:a6d0 with SMTP id 5a478bee46e88-3856de58f7fmr32556109eec.1.1795661156454;
        Wed, 25 Nov 2026 18:45:56 -0800 (PST)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm16253220eec.17.2026.11.25.18.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 18:45:56 -0800 (PST)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 18:45:44 -0800
Subject: [PATCH bluez v2 5/7] tools/test-runner: Allow suppressing noisy
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
Message-Id: <20261125-tr_arm64-v2-5-4f02989f17ba@oss.qualcomm.com>
References: <20261125-tr_arm64-v2-0-4f02989f17ba@oss.qualcomm.com>
In-Reply-To: <20261125-tr_arm64-v2-0-4f02989f17ba@oss.qualcomm.com>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Pauli Virtanen <pav@iki.fi>, Bastien Nocera <hadess@hadess.net>,
        Zijun Hu <zijun_hu@icloud.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: A3pLCbOAD2eq1VZHiaxHrHxtjm3J7hhn
X-Proofpoint-ORIG-GUID: A3pLCbOAD2eq1VZHiaxHrHxtjm3J7hhn
X-Authority-Analysis: v=2.4 cv=ULpIjyfy c=1 sm=1 tr=0 ts=6b079d65 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=wOjIOvMYMMCE2G19r9wA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAwOSBTYWx0ZWRfX6nhwzvytcUtu
 6dntq2SRDabYEKdssH5gdytMjE6Wb6agVK0Wdimg2Mj3hk65VnKCW1Pr9KB0q4ep8BTG+H79e6X
 QwtoiED7H7zc3Av1W7Kpl0LVJIzTJFjehaTWeVqHPcAeC9inn4anQmOFUAbFmfrYQd3+7jVcN5P
 bSbSJHh1d47yrCAQDCj1BE7Rn00RPUQsf5kXSIPGCtUiME8lJMs8x88PUsuA7l1TMTxr3dyRI8h
 MOPhYwIWNmS4UDf7rwOBRAsHaI01fj6JGpfqnPhl1ICxuJWBeltNAJ5Ty1RBpElGJcfKYmeiQBV
 r3UTu/cRHabnak692ysOSaByw3y33PeVnJ2a6qbPTzsVpYrNzXUYIVaAvKAQAx+H3icdTnSKCRp
 WvONxGhiC47h7999k+Y1wudDbpxRTQnCvjO9LLW0e6h2QGKP8dYyMiM3qVTR41baAupaWew1xRr
 6uUEk522TWZQuBhIK7g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAwOSBTYWx0ZWRfXx0GEv+3D+vIW
 ORcIXyXqL92XFkm0JGo/np4TVlGeK7yOl2G1kE7fLmAwmlGbsVkGoikLwGDdnOZhCUDvtkfYhPO
 MjSFsx8o4VEvUWMa/xRoRl6yxyMCHNo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_05,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260009

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
 tools/test-runner.c | 68 +++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 65 insertions(+), 19 deletions(-)

diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index 35dee021d8a0..f468a869e7ab 100644
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
@@ -360,16 +363,27 @@ Running bluetoothctl with emulated controller and audio support
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
index 06573c5d3005..28cfa296e167 100644
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
@@ -2309,18 +2328,31 @@ int main(int argc, char *argv[])
 			break;
 		case 'b':
 			start_dbus = true;
 			break;
 		case 's':
 			start_dbus_session = true;
 			break;
 		case 'd':
-			start_dbus = true;
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
+			if (start_daemon)
+				start_dbus = true;
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

