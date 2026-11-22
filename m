Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795343678;
	b=ImJGuSMklZs8oTqbde56MefBJ0XKGw/zdzRNKr7Pd+hz0HzEZj+Eh6y/rjZA2t4BiNKJ
	 QwKdZ91eOJiK8BV+EE2aLeA7mEIuiKC4/vRYsIpz4s8skh4AFao5dXFa9We08bEOvFi0J
	 yjfIBhXWq80gBNQEntTyHCvnXA5JKhvbeZzKQd6QFm43APwPCXK12qKMrJ4Q06EQ4nBJH
	 ZsMzzqbO2iYWIPZauejhOpzJIFM6rg4Xmz3odLvROHD0VKHVE9lwU8rETFCPCZbMVxj5v
	 /xSEn4bByAZHrQih7NeQdWn6D18FqXHlmO3jfDXdN5Pp38ZmLNxyVRSSpi1amS+ZXOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795343678;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pUgxqei4EHyVcRPna1db5GrfFDvYUqqaR57At8y4Th0=;
	b=2nP778TNXx5b+15B2BeGndojOqqumKn9T1rOth9CHSsym7Z7kkluBhI/wyD9VK+6Dm62
	 J/6I7k5SCNweUkzNi1MgHt/2v24mg7VvskJ+OP9F7vl8fc6R2fycw4me7Qj5A+3cYMO1Y
	 iI6jztnleMp5xLlYmOeLXn6CTdgaNt84WQUwA3MkK3ydL7EyzuvZf5NKM3TocPFlExgrt
	 FOO86JNhtWS+DbXjDByyvprqYWJS6WWRuIayX1d4NHL0UiNi+i3hKdNiWSKT62OtsRD+n
	 zTtKtuiXcMb+sVikzDw9qpFASW5MY8FpOLAKDOTU5+r3QoLijDLwgjY1EBOxnDqM79A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cHW94U8g;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="D7/CKkh1";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43F0606A331
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C43F0606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cHW94U8g;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D7/CKkh1
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM865VF1993441
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pUgxqei4EHyVcRPna1db5GrfFDvYUqqaR57At8y4Th0=; b=cHW94U8gsb6wLuro
	BG8hkYfEMSHRwSEb6NlIDRXJGzPUNCRrLlzz6YjNGNlBCtCp268c6ck5KOG/nec0
	KFDOKInAtE/bx/mr6g9uQVgRMY2aXQn1amwNDwzok2s6cOI7W4ZT8OiCyaAvGC80
	AY+xniAh3c/NZ+nUyrSEUHlzaD6aRZ0WRyu6MnuyfLhUiLVM/n07twNfD59rQujV
	zgtHO59WdajCIA9NEXL/PzKNpdnmxmm0eRG2PF1hnVatp+9RGAcD0vpBhjxwWrqe
	wKtTjW+sReQ8eYdqkX8kgZsCaB7+oDxNEnT1iAgH3XEDJagiGEHT0PBOcQzPvEZ8
	GXCRmw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j34ka31jn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:34:37 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3847a8f4e77so322377eec.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 02:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795343676; x=1795948476; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pUgxqei4EHyVcRPna1db5GrfFDvYUqqaR57At8y4Th0=;
        b=D7/CKkh1rgPqTO9kzBF/5LrvUkqD3gIL/381ypALWkWCFY6qRJpUwUwIc0gbd4NVZk
         xui8YDhsi4ASncyxyogUq2s2SDlo4pqND/dbuRtxY5AeXJk9Ud+yVVhVVrn93ws8N2pW
         PDh29e3qmdaqPtMuMIz/ygsdU1xFFkuBtA/zv1zywZAus05RdcIvnJHQUxoU3FPvBFPA
         ypxeTz2cxoWqH0Ilk4fevFihK+BFDHBlJS7pL4qdRY+enLkG7maClLQFPEKx9vSK9vYZ
         RoRDjWeRdqyd7t22FV7Dm4bC6PK9JJK3JLtPHibKdonrXeOZhTKOhbFre/jsbFPmgjot
         fEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795343676; x=1795948476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pUgxqei4EHyVcRPna1db5GrfFDvYUqqaR57At8y4Th0=;
        b=xHLami/mAVBrW/6U1EPNcVoXs4w7pRThzq/qWvJ8EESKFdJ7AY4aiSVoftTjLdj0p9
         teZCSEwXcd4peEuRHZeFTtbgoesVaqDn04vKE678c7+hVD5O7kQD/b3LX/2V8r9bAbfZ
         gLg3RxzRn+Ws/2eaiRUOpqim2iPy/ql6bwKsHLCfTs6xBdP0NaLNPMSUW671BT82lrEW
         XKyH71FL+vlfQbysPCe6CYfj20YId8EODak0wNi6U7mhTTMRM/eEi2ZQ3G3cUVBBtwUb
         K0kDUdCEhGLwgGm4kZSTL6HkKpWIXI4q/kstz5G65qjTtIqvN2pR8v2gn6J66A6rdK0s
         kDcQ==
X-Gm-Message-State: APuU4Z9kIZoqJAw1wV1XcjjJ6HFt1oaYXXs6t9j7OCrSdZhKjalQ70gq
	WMFvSb/0m+0qBoL0LqzhQN5ogs0vodYiiQwmv/TUKzrKKnY6HD1eveX67i0jvuYAGOkk/8iCqYz
	WrLpTrH9nhC2XpOIQP/2Ht2N6yLdOkJTqvioCNPzNOU2TwtU8c/q/3N1+q+qFGXCAwj8x80C4Dq
	E0gP0=
X-Gm-Gg: AZFdTZc3BUREHV/1K9/64+oAj9ue99OiLEMxCl0FnQhu7weQozhwNcx+UAnO0AK7w2U
	0z0ISG3tWnHcnovBICfYmPX+kq23015WsKQqhjz2z16QIBrAxINutL5446MJ08cmzR31M2RdYTI
	d4QLdONhSGqT5+odsH9Ted6HUtIpXrGRNov7aWmI80l1nPhZBcqQygccPmqe84S9WRDSmsvJGoS
	50IoGhoJq9FtoN0q1zghTxhdiLeAxr5A1zJIdYu3o9ZVGYEqoqSl1K/FZOwPPQLGnDFJQDlSAAM
	R3xC219uH0BuGbVV7vlpyLHuSEwPmK3vbQlAhytBHd3k5VsUSm2pZvcOPgMehkSxEySzBuX492a
	8QLU882BEWp71kSIMAQS+0WsDpk6/IBz3Y4Vu0k1CnKFDkvEwCVMhR9eBlKS8T1jKkz8SH24QYw
	DS2vXhJWZCshqSEVQf4QLK
X-Received: by 2002:a05:693c:26cb:b0:381:6297:8f99 with SMTP id 5a478bee46e88-3856e748babmr12498324eec.2.1795343676263;
        Sun, 22 Nov 2026 02:34:36 -0800 (PST)
X-Received: by 2002:a05:693c:26cb:b0:381:6297:8f99 with SMTP id 5a478bee46e88-3856e748babmr12498276eec.2.1795343675516;
        Sun, 22 Nov 2026 02:34:35 -0800 (PST)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm23747204eec.16.2026.11.22.02.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:34:35 -0800 (PST)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 02:34:21 -0800
Subject: [PATCH bluez 2/3] tools/test-runner: Support running on arm64
 hosts
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
Message-Id: <20261122-tr_arm64-v1-2-4eccf35daeca@oss.qualcomm.com>
References: <20261122-tr_arm64-v1-0-4eccf35daeca@oss.qualcomm.com>
In-Reply-To: <20261122-tr_arm64-v1-0-4eccf35daeca@oss.qualcomm.com>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Zijun Hu <zijun_hu@icloud.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDA0MSBTYWx0ZWRfX2b/NRwEzbK+g
 aGbOnA5BUyvEkTo4/JuEKGv9v38R4L+NEEm7fSvdVbJmZh17+/Koy2rlSqu5b0HvAxwhV+qOlv0
 9TACMHXbTPgp34IGHSZqmoPd08T5hHTdCMgXBJuG/YqEbF/SXQFLWhj75+mobOcWJ6MsifU5fA4
 qd5Z2KLTuEyaZoF26aTqI3MElpj4/i9UG1vygwfUlG2chE14nFvoxVNFb3HSgccY7gqCcVYymTB
 mHJJamcLBQtzSuUh/WQh6WpEzRIjzMjN6H6TSNcg5WBGZ8ISwth29wAWQMwbt3ofvdprgFKOEqf
 5+d1uerowtqavydAAMDBPUw4NSfjc5TzyLA+1eHq2DjUtu+qM73xnndFO5g7d4No68z5vx5LxNR
 bxJ8/x37MQ9W6zpd7oCO+P7cBTxBGr+zHyvYGXQYPGyMWHjIOTcZbarSMTq6xaA+Y+6JOQd74rC
 f7R3E67LytVguVxUscA==
X-Authority-Analysis: v=2.4 cv=RJEmjIi+ c=1 sm=1 tr=0 ts=6b02c53d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=ZyjHm9CvDxc0lJP29wEA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: a0g4-GvM-Fozg-MPhkVQSMfpcwLqn6ul
X-Proofpoint-ORIG-GUID: a0g4-GvM-Fozg-MPhkVQSMfpcwLqn6ul
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDA0MSBTYWx0ZWRfXxR/4TnOSUtuG
 ujdDYYtJQBCIJlnWFjnRUxUOuktacsdIiIyFo5iKtLLKK5MIIeNuDi1WN5VpF7KnEmrVM9TC3UB
 Maj+Upj+WKvtEUx8HwpXf4Qe/vcCxm4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611220041

Add arm64 support by:
- Using qemu-system-aarch64 with the virt machine and the arm64 Image
- Passing -cpu max or host, as the default virt CPU is 32-bit
- Using earlycon and leaving out the x86-only options
- Warning when /dev/kvm is not accessible, as QEMU then falls back
  to TCG

Assisted-by: Claude:claude-opus-5-5
---
 doc/test-runner.rst |  5 ++++-
 tools/test-runner.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index b5876e4f5108..4ff9d1b02c1b 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -21,17 +21,20 @@ OPTIONS
 :-m/--monitor: Start btmon
 :-l/--emulator[=num]: Start btvirt
 :-A/-audio[=path]: Start audio server
 :-u/--unix[=path]: Provide serial device
 :-U/--usb=<qemu_args>: Provide USB device
 :-P/--pcie=<qemu_args>: Provide PCIe device
 :-q/--qemu=<path>: QEMU binary
 :-H/--qemu-host-cpu: Use host CPU (requires KVM support)
-:-k/--kernel=<image>: Kernel image (bzImage) or User Mode Linux binary
+:-k/--kernel=<image>: Kernel image or source tree path:
+
+    | x86: bzImage or User Mode Linux binary
+    | arm64: Image
 :-F/--virtiofs[=<path>]: Path to virtiofsd, or no to disable virtio-fs
 :-T/--time-travel: Run a User Mode Linux kernel on simulated time, with
     btvirt as time travel calendar (default if the kernel supports it)
 :-R/--real-time: Run a User Mode Linux kernel on real time
 :-o/--option=<opt>: Additional argument passed to QEMU, or kernel
     parameter with User Mode Linux
 :-h/--help: Show help options
 
diff --git a/tools/test-runner.c b/tools/test-runner.c
index 0bca31a46351..a2105977c1ee 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -128,20 +128,25 @@ static void strv_cleanup(struct strv *s)
 
 	for (i = 0; i < s->i; ++i)
 		free(s->strv[i]);
 
 	memset(s, 0, sizeof(*s));
 }
 
 static const char *qemu_table[] = {
+#if defined(__aarch64__)
+	"qemu-system-aarch64",
+	"/usr/bin/qemu-system-aarch64",
+#else
 	"qemu-system-x86_64",
 	"qemu-system-i386",
 	"/usr/bin/qemu-system-x86_64",
 	"/usr/bin/qemu-system-i386",
+#endif
 	NULL
 };
 
 static const char *find_qemu(void)
 {
 	int i;
 
 	for (i = 0; qemu_table[i]; i++) {
@@ -150,21 +155,26 @@ static const char *find_qemu(void)
 		if (!stat(qemu_table[i], &st))
 			return qemu_table[i];
 	}
 
 	return NULL;
 }
 
 static const char *kernel_table[] = {
+#if defined(__aarch64__)
+	"Image",
+	"arch/arm64/boot/Image",
+#else
 	"bzImage",
 	"arch/x86/boot/bzImage",
 	"vmlinux",
 	"arch/x86/boot/vmlinux",
 	"linux",
+#endif
 	NULL
 };
 
 /* A User Mode Linux kernel is an executable with the .uml.setup.init
  * section, through which it registers its command line options.
  */
 static bool is_uml_kernel(const char *path)
 {
@@ -420,16 +430,19 @@ static char *const qemu_envp[] = {
 
 static void check_virtualization(void)
 {
 #ifdef HAVE_GET_CPUID
 	unsigned int eax, ebx, ecx, edx;
 
 	if (__get_cpuid(1, &eax, &ebx, &ecx, &edx) && (ecx & (1 << 5)))
 		printf("Found support for Virtual Machine eXtensions\n");
+#elif defined(__aarch64__)
+	if (access("/dev/kvm", R_OK | W_OK) < 0)
+		fprintf(stderr, "No access to /dev/kvm, falling back to TCG\n");
 #endif
 }
 
 #define PCI_DEVICES_PATH "/sys/bus/pci/devices"
 
 static char pcie_bdf[16];
 static char pcie_driver[64];
 
@@ -894,16 +907,18 @@ static void qemu_signal(int sig)
 	if (qemu_pid > 0)
 		kill(qemu_pid, sig);
 }
 
 static int start_qemu(void)
 {
 	char cwd[PATH_MAX/2], initcmd[PATH_MAX], testargs[PATH_MAX];
 	const char *fscmdline;
+	const char *earlycon;
+	const char *noacpi;
 	char cmdline[CMDLINE_MAX];
 	char *argv_strv[EXTRA_OPT_MAX + 64];
 	struct strv _cleanup_(strv_cleanup) argv = { argv_strv,
 							ARRAY_SIZE(argv_strv) };
 	struct rootfs _cleanup_(rootfs_cleanup) rootfs = {{0}};
 	int i, pos, status = 0;
 	pid_t pid;
 
@@ -933,54 +948,71 @@ static int start_qemu(void)
 	}
 
 	if (!virtiofsd)
 		fscmdline = "rootfstype=9p "
 				"rootflags=trans=virtio,version=9p2000.u";
 	else
 		fscmdline = "rootfstype=virtiofs root=/dev/root";
 
+#if defined(__aarch64__)
+	earlycon = "earlycon";
+	noacpi = "";
+#else
+	earlycon = "earlyprintk=serial";
+	/* PCIe passthrough requires ACPI and APIC for device enumeration
+	 * and MSI interrupts.
+	 */
+	noacpi = pcie_dev ? "" : "acpi=off pci=noacpi noapic";
+#endif
+
 	snprintf(cmdline, sizeof(cmdline),
-				"console=hvc0 earlyprintk=serial "
+				"console=hvc0 %s "
 				"no_hash_pointers=1 %s %s quiet ro init=%s "
 				"TESTHOME=%s TESTDBUS=%u TESTDAEMON=%u "
 				"TESTDBUSSESSION=%u XDG_RUNTIME_DIR=/run/user/0 "
 				"TESTMONITOR=%u TESTEMULATOR=%u TESTDEVS=%d "
 				"TESTAUTO=%u TESTAUDIO='%s' TESTARGS=\'%s\'",
+				earlycon,
 				fscmdline,
-				/* PCIe passthrough requires ACPI and APIC for
-				 * device enumeration and MSI interrupts.
-				 */
-				pcie_dev ? "" : "acpi=off pci=noacpi noapic",
+				noacpi,
 				initcmd, cwd, start_dbus, start_daemon,
 				start_dbus_session,
 				start_monitor, num_emulator, num_devs,
 				run_auto, audio_server ? audio_server : "",
 				testargs);
 
 	/* Make sure qemu_binary is not null */
 	if (!qemu_binary) {
 		fprintf(stderr, "No QEMU binary is set\n");
 		return EXIT_FAILURE;
 	}
 
 	strv_append(&argv, "%s", qemu_binary);
 	strv_concat(&argv, qemu_argv);
 
+#if defined(__aarch64__)
+	strv_append(&argv, "-machine");
+	strv_append(&argv, "virt,gic-version=max,accel=kvm:tcg");
+
+	strv_append(&argv, "-cpu");
+	strv_append(&argv, qemu_host_cpu ? "host" : "max");
+#else
 	/* Interrupt remapping is required to pass through a device using
 	 * MSI-X, which in turn needs the split irqchip.
 	 */
 	strv_append(&argv, "-machine");
 	strv_append(&argv, "type=q35,accel=kvm:tcg%s",
 			pcie_dev ? ",kernel-irqchip=split" : "");
 
 	if (qemu_host_cpu) {
 		strv_append(&argv, "-cpu");
 		strv_append(&argv, "host");
 	}
+#endif
 
 	strv_append(&argv, "-kernel");
 	strv_append(&argv, "%s", kernel_image);
 	strv_append(&argv, "-append");
 	strv_append(&argv, "%s", cmdline);
 
 	coverage_setup(&argv, cwd);
 
@@ -994,18 +1026,20 @@ static int start_qemu(void)
 	if (usb_dev) {
 		strv_append(&argv, "-device");
 		strv_append(&argv, "qemu-xhci");
 		strv_append(&argv, "-device");
 		strv_append(&argv, "%s", usb_dev);
 	}
 
 	if (pcie_dev) {
+#if !defined(__aarch64__)
 		strv_append(&argv, "-device");
 		strv_append(&argv, "intel-iommu,intremap=on");
+#endif
 		strv_append(&argv, "-device");
 		strv_append(&argv, "%s", pcie_dev);
 	}
 
 	if (!rootfs_setup(&rootfs, &argv))
 		return EXIT_FAILURE;
 
 	for (i = 0; i < num_extra_opts; ++i)
@@ -2193,18 +2227,19 @@ static void usage(void)
 		"\t-m, --monitor          Start btmon\n"
 		"\t-l, --emulator[=num]   Start btvirt\n"
 		"\t-A, --audio[=path]     Start audio server\n"
 		"\t-u, --unix[=path]      Provide serial device\n"
 		"\t-U, --usb <qemu_args>  Provide USB device\n"
 		"\t-P, --pcie <qemu_args> Provide PCIe device\n"
 		"\t-q, --qemu <path>      QEMU binary\n"
 		"\t-H, --qemu-host-cpu    Use host CPU (requires KVM support)\n"
-		"\t-k, --kernel <image>   Kernel bzImage, User Mode Linux\n"
-		"\t                       binary or source tree path\n"
+		"\t-k, --kernel <image>   Kernel image or source tree path,\n"
+		"\t                       x86: bzImage or User Mode Linux\n"
+		"\t                       arm64: Image\n"
 		"\t-F, --virtiofs[=<path>]  Virtiofsd path or 'no'\n"
 		"\t-T, --time-travel      Run User Mode Linux on simulated\n"
 		"\t                       time, with btvirt as calendar\n"
 		"\t                       (default if supported)\n"
 		"\t-R, --real-time        Run User Mode Linux on real time\n"
 		"\t-o, --option <opt>     Additional argument passed to QEMU,\n"
 		"\t                       or kernel parameter with User\n"
 		"\t                       Mode Linux\n"

-- 
2.34.1

