Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795661159;
	b=EMkp6NwlikIZfNl9PmEJ5zfHC5gAYLV9cyjkh0bvbGSFRlGNbCSNZU55C+FbKnHF6tLY
	 ql1wyRZFq1mGWHEzfQdTRfgaAuy7JMn+Kqq6ChdkimGIYsZFaF6vK7OjM4GW2EBviwy9A
	 QFn8J2FvyMsQn9VoSiFlyj6I0mq0yvQoAYkMR7veO52K3K0wYxzXLCT2R2GPIte7sECTl
	 R5ApVmE8SGzvHyqqyHHLfaxIDnr18vOb1k0cmglHOK7s6tQE/yt/+hUQbZcN1SYkKW+XX
	 cZPpUx3+soWlb94kS4Bmvv8GVvogGDZT8uH4zssLoyiyOuWFkCynL98D1brdOWje1aw==
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
	bh=38OuaACnAGBjyBqbmyy9z9Xgy1+hW6vYnz9CUkYO4NA=;
	b=eyiZWbWQmqkppW7R4lMAoD6KgA/2nMRLV13DSSfuRfU+HEX7/KZPjI3PfShX/5XIMJtW
	 hu2Q62F0DwqFB4X78ebLxKXZIXl+7SW1XptYCdYs2AjpVrGYm6leu9yVIw5Zq4vGjXHx5
	 ygu3ZONw5dQypIFEfcJqGw0pTVMA0TKfN7ZK5a9VCP2z6xxZEmmqFn//lRonEG20q1adW
	 QlYqMju8JgIZ5W70o6pR4+gmB47s0dXO9ESTtqv7/NEHPAq4P6MvUkP4sh/Rnxajp5NL1
	 zidyfUI7RKaA+nBD8dboQxa9jUYDGaTO1C7sJdPGV2JknwuS4YvRNnSGA2cX+ALBrTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BbpeGZGc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=icfTnuAv;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5860E606A330
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5860E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BbpeGZGc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=icfTnuAv
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APJgvdu3661526
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	38OuaACnAGBjyBqbmyy9z9Xgy1+hW6vYnz9CUkYO4NA=; b=BbpeGZGceLGfBrJr
	RyXGoqSzATsTk5LbTSYDyBmuUjowA+9yvxxZeSDHmqZqx7SD1qMGJKq3p8uSDfbs
	XVIvao2q9l3o+g0vLrhPTGPMruO8yIE1j9lFL9tjNJ4Jav6IWomDqBFgOmQlanZm
	73jU1+XaGMMOjzR4oljg7eTX2Uv6K4h/Iru8TRn7q2B6S+QSswU/LaCxGBwI2BKQ
	DnBIJraP4rU8BHDfF+Esoyu9sKYVc3bRJqdcRH5/LN+z9N1A/XjcgItcE39B23GZ
	1rVSU7Qwp+KzvSSUHM6eG+WTMfIwGGgMri+Y94TnW5eSfc2yb04KXyKfTWQFzUlg
	qXhpMw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662y12gh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:45:58 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3869db50548so462438eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 18:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795661158; x=1796265958; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=38OuaACnAGBjyBqbmyy9z9Xgy1+hW6vYnz9CUkYO4NA=;
        b=icfTnuAv7vnU/yJdPuMPrzCushW/k2nyU1z24awj4B/PUJuykzxzcOQNOrioLjoe2w
         qQHiWWz0nBMDEbNPr5H443JQ0p5c+MSao+w1KwQhslmu+Bvz6x5viUyRAJ3Gsu8TGMo8
         XndQX73u20Ghj+5/tTgWYJ8xn/RNgk8rtUGXt5sggaKeYr3rdULEInhUAwdxYEMdHGAo
         5gvgJeq8UJJ9bZZSNaYSFgdlGSrzT/UypAn95R6Uaxu6K4iptELdJjTFKF9oOQb8VV54
         DZC4MgjFH0mySSmxqi1pS0e86dkMwjyRHI5vHnLzIQAqANCSQc84V3NcJnFVoIvWqaJO
         FPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661158; x=1796265958;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=38OuaACnAGBjyBqbmyy9z9Xgy1+hW6vYnz9CUkYO4NA=;
        b=h0XRSuF1cyHLbHBKxDaKQTp16vacKxExRZmcKk+GuYX0sNniNGc3zC2wiMq7w56GIz
         U6GA9Ic1UxzC696RX2n08rJo/80HJf06xRuA69uCJuhXOwWDlHYEe1/aZM2IpEnvv3Il
         TgGFw8WemF3oJOzTViFEAiliyzSQfbh4RDn/BzlOtwPHgfS9N21188lvzUWmBmmPIupp
         wvjwoMrd+LdcW267LoFe7Vna8K6Rq+JgqF3tIgLuhtVWjL/UGyxRUqVgp9Ur887nhq+Y
         BVrPkKDPiQ8kCt+lmAC9Y4Co5Vjv6MYX6UAjxnhZEGptafWdQ/+dQzodAQaIdD0oiQqG
         EweQ==
X-Gm-Message-State: APuU4Z8IJtZwkWE9ZBYB4CDehHLp7DeGEcK/gN6KxpJyuHTgkl9UOY8u
	E4VtxbYrLvP6ywR7gSWFphUT8hMkq4Lqezdc2VSSqIsWKuhaP+N9S/Npw8uaEzNETVdADQs/lCz
	l1LR0KLdAXT+uKZtdR4FcM5tKFM2lzwv5sSfO3eITPsGGnDy0FaWuDGbLQeddWEiMZUSqAPr0Vo
	f88tvofg==
X-Gm-Gg: AZFdTZf7Z//eTcIBG0p/s9dXKL3g1srnH0u36YMg/Pj8EIpzSbJz3utjtHD5lEQP/VM
	E7uYkGz4BfvPIBkm43aNjoaOuAR2QxFY1XI67myGYyQx6Ga+zZM4Dg/X7i8sbADjbiVj32vt/n8
	wWBa5TQfzK7rJuNA07VVknpcI3eONpOZBZQsRMU0TGGCsI5CFvu4ZxbB5NuJ8clgVXU1o/9MaFo
	r7By7G91rvAvkdZcRjGcMnWRUhDIlbw2v4w3vebfLE2ySSZb52JoEASsoQ7GsaDq0uqjD0nYa+2
	Le9pjjA11cQ0QWvRkkar39tAWmoTXUP8N8azUY2Y0eF6GoOtjGb+ML7XLgHR+7zSN+rrVR28QJa
	+VtbLH2ZgJdylXDkpJq7wNcdP/OHx9dpbIyivgBnOM0iJZFaeDCSKPIw2AzhBToH8TEssH5JeFK
	//mj30QWn3SMcZgp+652dR
X-Received: by 2002:a05:693c:8211:b0:35f:ea17:d171 with SMTP id 5a478bee46e88-3856e74909fmr31097734eec.2.1795661157764;
        Wed, 25 Nov 2026 18:45:57 -0800 (PST)
X-Received: by 2002:a05:693c:8211:b0:35f:ea17:d171 with SMTP id 5a478bee46e88-3856e74909fmr31097708eec.2.1795661157188;
        Wed, 25 Nov 2026 18:45:57 -0800 (PST)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm16253220eec.17.2026.11.25.18.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 18:45:56 -0800 (PST)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 18:45:45 -0800
Subject: [PATCH bluez v2 6/7] tools/test-runner: Fix snprintf(..., "%s",
 NULL) with -a
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
Message-Id: <20261125-tr_arm64-v2-6-4f02989f17ba@oss.qualcomm.com>
References: <20261125-tr_arm64-v2-0-4f02989f17ba@oss.qualcomm.com>
In-Reply-To: <20261125-tr_arm64-v2-0-4f02989f17ba@oss.qualcomm.com>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Pauli Virtanen <pav@iki.fi>, Bastien Nocera <hadess@hadess.net>,
        Zijun Hu <zijun_hu@icloud.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAwOSBTYWx0ZWRfX3uv/Gyf8QyHO
 d1aQPC4NmHJcvk/6HENHNAjLu02ki/MkWxm4Bxs+FRV+FrWuEp5VSITe38LNGjKEWrWtTJIN5Cd
 suC2VSXYd2jhTm2wUSEr88BfJDZvsVn67RMuTan3b/XedRuhzSWX4Gclifxq0oLCBlk4XuG9Z3c
 1w3+kP6nbQ1RHQR2c7EcpD9GdKeiOzdts5pt+mYazdfnD2zqwN/PoqIFJjecluio7QpKxzYZEWx
 f+lBnfmZ5P1Fjq4E0APpkOht9DTWmuab3NyNqHfzFDpHwGX4nR6US/HGrwyxv6A5u04TzfIcZzA
 h7gFyJIGiqclINpnFUxqE8FEfD9vZwK2nfXNHiPbJ+6U37opZ7CT/xy3Vc3u79hGcIoZtysO/oE
 JAzMYIcppCCS6ZNLgeTXKHsT2g9MgM5AamYwfEVjgEVE2zeNTTU0G78g0DnSqUpycZxeHhfbPAJ
 KeiRVCaG/Hxh/Mxn2JA==
X-Proofpoint-GUID: 5Og6VQeVEg4OVBmJ6b7Plbr2-Ln2jb3u
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAwOSBTYWx0ZWRfX+lQ67CxFxCQn
 9Dsqsmb5xGWZDCE8WCydC3kz5hF874eMJG89mvAP9N1b0oDR+/CTD2qbNU/g1mUWfCGX5zaOKRE
 X/scIzJyNLKAqcYMGzPWTEuA92mK9Z8=
X-Proofpoint-ORIG-GUID: 5Og6VQeVEg4OVBmJ6b7Plbr2-Ln2jb3u
X-Authority-Analysis: v=2.4 cv=W/KtxhWk c=1 sm=1 tr=0 ts=6b079d66 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=aUT-qO4hWwOoQgJP7AwA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_05,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260009

With -a, no command is given and test_argv[0] is argv[argc], which is
NULL, but it is passed to snprintf() for "%s" when building TESTARGS.

Fix by using an empty string if test_argv[0] is NULL.

Also correct the messages for the tmpfs config mounts, which are
mounted rather than created.

Fixes: 1856a335d8d6 ("tools: Add testing target to run all known test scripts")
Assisted-by: Claude:claude-opus-5-5
---
 tools/test-runner.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 28cfa296e167..10ccc949589d 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -393,22 +393,22 @@ static void prepare_sandbox(void)
 
 	printf("Creating new session group leader\n");
 	setsid();
 
 	printf("Setting controlling terminal\n");
 	ioctl(STDIN_FILENO, TIOCSCTTY, 1);
 
 	for (i = 0; config_table[i]; i++) {
-		printf("Creating %s\n", config_table[i]);
+		printf("Mounting tmpfs to %s\n", config_table[i]);
 
 		if (mount("tmpfs", config_table[i], "tmpfs",
 				MS_NOSUID|MS_NOEXEC|MS_NODEV|MS_STRICTATIME,
 				"mode=0755") < 0)
-			perror("Failed to create filesystem");
+			perror("Failed to mount filesystem");
 	}
 
 	enable_printk();
 }
 
 static const char *const qemu_argv[] = {
 	"-nodefaults",
 	"-no-user-config",
@@ -928,17 +928,17 @@ static int start_qemu(void)
 	if (!getcwd(cwd, sizeof(cwd)))
 		strcat(cwd, "/");
 
 	if (own_binary[0] == '/')
 		snprintf(initcmd, sizeof(initcmd), "%s", own_binary);
 	else
 		snprintf(initcmd, sizeof(initcmd), "%s/%s", cwd, own_binary);
 
-	pos = snprintf(testargs, sizeof(testargs), "%s", test_argv[0]);
+	pos = snprintf(testargs, sizeof(testargs), "%s", test_argv[0] ? : "");
 
 	for (i = 1; i < test_argc; i++) {
 		int len = sizeof(testargs) - pos;
 		int n = snprintf(testargs + pos, len, " %s", test_argv[i]);
 
 		if (n < 0 || n >= len) {
 			fprintf(stderr, "Buffer overflow detected in "
 					"testargs\n");
@@ -1244,17 +1244,17 @@ static int start_uml(void)
 	if (!getcwd(cwd, sizeof(cwd)))
 		strcat(cwd, "/");
 
 	if (own_binary[0] == '/')
 		snprintf(initcmd, sizeof(initcmd), "%s", own_binary);
 	else
 		snprintf(initcmd, sizeof(initcmd), "%s/%s", cwd, own_binary);
 
-	pos = snprintf(testargs, sizeof(testargs), "%s", test_argv[0]);
+	pos = snprintf(testargs, sizeof(testargs), "%s", test_argv[0] ? : "");
 
 	for (i = 1; i < test_argc; i++) {
 		int len = sizeof(testargs) - pos;
 		int n = snprintf(testargs + pos, len, " %s", test_argv[i]);
 
 		if (n < 0 || n >= len) {
 			fprintf(stderr, "Buffer overflow detected in "
 					"testargs\n");

-- 
2.34.1

