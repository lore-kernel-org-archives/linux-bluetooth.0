Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795661159;
	b=zpc034G3Xnv+PFYl8EiQSQZqGzvaYRdTAMzCVGozakHo1WzyxdndXZ57zSPuJWGLE3T6
	 wrIp6Ues2NFfA3mcKE6pCc0XPFFdi1Ktm+vwZiJOMjuFmdyQTlvMINJMYCo0EBzqrvFn0
	 LrhBIpSBSFCoH9RaRZ776sM94cX0fp76qSMo23oje/wxsRHE4hfKXq/NwaBWX+CCBatKR
	 vpCdvNq8vs4PuQ6rFZR+iUvmSd8v/r9t86kfJOdrkTSM4QeOfCrnGyZ8BQgLKeBMteLJ1
	 j4VcS9ZpDX3Wc4GBVEKMQQOt/dqQnRpL1tOJ3W7dYNS6wy8KofzhGlH3lChctH+VJiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661159;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4WmmqNcuSDWpYGcCZ6ymKOIuZkX1o9G9OrLDwTX6vk4=;
	b=ET1aAZ4a7c+u3L9YvVSfpVyio3D4epkPMAPDEifIwKEePA+Qa624gJ7I1ouhCB0CMORC
	 FMeW53BFnfVmGpx1pqiT8CRvldQe8Q+5JkSsCuQYz2bVdTdo/i9UgKZcnDDrAwg3ghzuO
	 uGAt+lbsotBMOB6luCaqiQA7SvQSXMpK9CwJYHO0oaNQlUGhN5Wdf5hToQa+jv6txVHWU
	 QfzT4Zk8tQzjSm0Mc0kGZaTaYWtsOBjBGoYJRjKpezQYGAN2702JxxqB4TmEABUclAwx6
	 RueoEfaCGew/aHDMavezpyrXaWHCWNLX6MXDk3Lbv5M0raOkUoQLE97oXX84U1BddNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IB9ZlMaW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="a/BjpdBT";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495FE606A32C
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 495FE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IB9ZlMaW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=a/BjpdBT
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APJgtnO3661506
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4WmmqNcuSDWpYGcCZ6ymKOIuZkX1o9G9OrLDwTX6vk4=; b=IB9ZlMaW12EU1OZ0
	iAjCjIN5DxGNtTHdN52izQ77r6gRgfPVY9gxylQcGd7TAUGIvlo/rNkttC1HcQlu
	b1rEV6PrJ8Yk2jFfIYYqVNqIDZgcJ9Sb5NMrU8SivbqpOJB48sEBwqqMJIvBqkvj
	YFAmOYsc3PQVBYleLfQPV/zUb1wRLkDpUvxkUEfVKT1tBUlcbMgDJCLBEzsLjbhA
	p+2WkNksB3XtnUsBnX9k2fi/9SqdAJHyLcChgEMU3Qky6apS/GphKCK+1yUR++jF
	AOaORpt8AzTkg108qKB29WaJDtEPUSwa8eFB5ysLC+VpvkMgPv+nkh+SBbDwF3Mu
	IjUNzw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662y12gb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:45:57 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c58d35c0aso902075eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 18:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795661156; x=1796265956; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4WmmqNcuSDWpYGcCZ6ymKOIuZkX1o9G9OrLDwTX6vk4=;
        b=a/BjpdBTvs0FidPGvDPkV8UZi42BPL8LUMHmMkpFoqU50papGY0wZeu2KNxg032tGP
         PMQADhsCz3CWUstAgcDyuoRE84ujl8SMSN6T6vB2I7prUB+iQw8eENJyLbytmoG0rSK4
         JzvKmOT+BR4nwt/8aJjR5WuDa+gFo6yXqyf+pJD7MhnmkAO9LtzV8417hDypTlwNA6hc
         jZ9+/tlgX2D5CYvR9/DPzUetELodBSbIWavWllnxzJNIumH0HEvUPJjMHN5b0Z5kdiEt
         Yv7vY8YdEs8gSe7Xr6QTh9zcOEOw8O/HLS57g8djItR5niypJuS9/SAFrc/nhHMnkKgP
         cIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661156; x=1796265956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4WmmqNcuSDWpYGcCZ6ymKOIuZkX1o9G9OrLDwTX6vk4=;
        b=KJkJWjdEnbhbUNmtO2qd4SHCHt2cYI+5y4gxE5HsgOwX2i4d4/C2nKoQNg2hytwiN+
         rOrHlu2cCVpPynL0My5T9JImOHXOdPg6D0Iz6pgWoPvLQmUcaniSNNcwQEjYUR/u7Kef
         JNkvtdTKpYDsDoFx5EOQxFmAKh+/qXobr2TuybotRbI38lyMC18PnVsZf89de/cTkisJ
         N2B57knCG+zJrkpCR/N+hJwsgLMC122Y4tRTINshF/trhzemsSIXraZYhNn5Odh8WOO6
         vpfqcb0SheIrizJ0p5iP0ELJfN2cgawPkrsT6cacHiPAUKpFaDnK73FzrJpPmZ3045xJ
         CnSw==
X-Gm-Message-State: APuU4Z+kUF/FoiaUOP5HdoNTlAM2sIwAHbrXVhW9A0U6DunBDis0fy8E
	ECIPzhwSB0zVnq8AZ2MIqxof+R7FMUWX/C5tgGqZCcdH3vPVYE3XkhA5yMmQFEYXF16r0tO0yfw
	XMn808vMJxD4TV6yH5lUQfuy3zaDJnOoaHO/I3yUhiYUO5NTRlUKhijVwsw/hvBkhu++m/iSG1v
	BEd+E5Ag==
X-Gm-Gg: AZFdTZcQN8wbK46VDwKJh//UI1+bOvMVtx4Qbi8v1/YkwrCfSQwLF3slEJRpNxin+Gq
	+s0sSMQNepkVayayNYyJkZ39mni0/DurEfjnAEXrSPLsn5zghaAnnMaEXaFVRsmh0teC8DVSXeg
	z+L6p50x8JvlvZbTwP06U4DCNcBYCfm/wkqvQVsg5UDwhJccQwpFjfg6C/5zzjh2tOwlxvPEg3a
	TegHrtsqDNAqVOjc+NRK9zymL5HSZM/6jxuqWKaeuRg6TaQIsYYkHkSHw1NiQYn8qbETCIdsWjK
	uU+i3cgoBZS6e32q0SemKWVkAkdM9ojRmVbMStaVLNqRG4yXqa2PB27xjSWPmjwLDZx5cECS2bJ
	t+XKnhj7vC3I5pFLlYxBDhO4ei7cIzrJPVUuu/gPXRGoilIMUkNs2qrXeojVezCGx+vWVkL7pAY
	dDilptcg0KSRClQrvofHN9
X-Received: by 2002:a05:693c:26cb:b0:381:6297:8f99 with SMTP id 5a478bee46e88-3856e748babmr30221013eec.2.1795661156291;
        Wed, 25 Nov 2026 18:45:56 -0800 (PST)
X-Received: by 2002:a05:693c:26cb:b0:381:6297:8f99 with SMTP id 5a478bee46e88-3856e748babmr30220975eec.2.1795661155661;
        Wed, 25 Nov 2026 18:45:55 -0800 (PST)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm16253220eec.17.2026.11.25.18.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 18:45:55 -0800 (PST)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 18:45:43 -0800
Subject: [PATCH bluez v2 4/7] tools/test-runner: Add arm64 support with
 QEMU
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-tr_arm64-v2-4-4f02989f17ba@oss.qualcomm.com>
References: <20261125-tr_arm64-v2-0-4f02989f17ba@oss.qualcomm.com>
In-Reply-To: <20261125-tr_arm64-v2-0-4f02989f17ba@oss.qualcomm.com>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Pauli Virtanen <pav@iki.fi>, Bastien Nocera <hadess@hadess.net>,
        Zijun Hu <zijun_hu@icloud.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAwOSBTYWx0ZWRfX5NpUKu5JegNN
 +6T+OQSEPP4AAiJxIcR4l7cNkH/taAscbrsja99su8HNVBwuPGQvkp9SXOMByjwp78sfW92maD3
 K3h90gaHEm+tJ46tw009b3grJ7WKpl1kQGLDxdyieC33Qk4T6X9l/PEwGMk1ImZrkgIPvGpFSHR
 izoDZk4gHoMlQvVd3skvywBw+qmb6/01bHDjYlDI6UeDH8Zj8qge+eX0xBO5h0gxyQguJ/LVys/
 mpp42nP3RTBB7TyB2pE56DhYT/rMuq6ieWVKPlDN3DlXl9Jb5BUwtkO0hswShfJOip5GGXxmuTn
 zVtoBWuQj2tWepQ6YXAzOe4cauEnSn1zfYR5q62r8YgjqRXE2v9+1wiZ0wtxs6fcxvcuDcfSnOH
 FMoEolP3P67y6K3hOBYqTYc13HXvMdXwPRXqmhpOKR/PAJDaQIl6+pVLGMVe65LiivFzJfd/8eO
 PdQ5DYrlHvvnWb4oaig==
X-Proofpoint-GUID: Pcqye3frw_7NAUEHQNr9HZInY1DZkH5l
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAwOSBTYWx0ZWRfX/QaWQGW7XCC9
 J9vwJfq8R3R/1A/BrJo4+Hdyr43Hg4gj67PW5b8yxvKYLSl8cf96rjWb1jt1ue3r2Sq+kgRAX7m
 4iXdu5ORYxNG9xHRXEsAGoUKDdLtUD8=
X-Proofpoint-ORIG-GUID: Pcqye3frw_7NAUEHQNr9HZInY1DZkH5l
X-Authority-Analysis: v=2.4 cv=W/KtxhWk c=1 sm=1 tr=0 ts=6b079d65 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=UW8u6GPafOAVS71PcgIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_05,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260009

Add arm64 support by:
- Using qemu-system-aarch64 with the virt machine to boot an arm64
  guest kernel
- Passing -cpu max or host, as the default virt CPU is 32-bit
- Using earlycon and leaving out the x86-only options
- Warning when /dev/kvm is not accessible, as QEMU then falls back
  to TCG
- Documenting that test-runner must be built for an architecture
  compatible with both the host and the guest kernel

Assisted-by: Claude:claude-opus-5-5
---
Note: the upstream kernel does not support UML on arm64.
---
 doc/test-runner.rst | 18 +++++++++++-------
 tools/test-runner.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index b5876e4f5108..35dee021d8a0 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -21,34 +21,38 @@ OPTIONS
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
+    | arm64: Image, Image.gz, vmlinuz.efi, uImage
 :-F/--virtiofs[=<path>]: Path to virtiofsd, or no to disable virtio-fs
 :-T/--time-travel: Run a User Mode Linux kernel on simulated time, with
     btvirt as time travel calendar (default if the kernel supports it)
 :-R/--real-time: Run a User Mode Linux kernel on real time
 :-o/--option=<opt>: Additional argument passed to QEMU, or kernel
     parameter with User Mode Linux
 :-h/--help: Show help options
 
 ARCHITECTURE
 ============
 
-**test-runner(1)** is both the launcher and the guest ``init``.  When run
-normally it builds a QEMU command line and starts QEMU, replacing itself
-with it unless it has to stay around to clean up after a ``virtiofsd`` or
-a passed-through PCIe device.  The same binary is re-executed inside the
-guest as PID 1, where it sets up the sandbox and runs the requested
-command::
+**test-runner(1)** is both the launcher and the guest ``init``, so it must
+be built for an architecture compatible with both the host and the guest
+kernel, and fails otherwise.  When run normally it builds a QEMU command
+line and starts QEMU, replacing itself with it unless it has to stay
+around to clean up after a ``virtiofsd`` or a passed-through PCIe device.
+The same binary is re-executed inside the guest as PID 1, where it sets
+up the sandbox and runs the requested command::
 
     ┌────────────────────────────────────────────────────────┐
     │ test-runner (launcher)                                 │
     │   ├ virtiofsd (optional)  ←─── vhost-user ───┐         │
     │   └ qemu                                     │         │
     │      ┌──── guest ─────────────────────────────┴─────┐  │
     │      │ kernel (bzImage), init=test-runner           │  │
     │      │   ├ prepare_sandbox()                        │  │
diff --git a/tools/test-runner.c b/tools/test-runner.c
index a14f21e50d50..06573c5d3005 100644
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
+		"\t                       arm64: Image, Image.gz, vmlinuz.efi, uImage\n"
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

