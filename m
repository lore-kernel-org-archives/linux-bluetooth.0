Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795661160;
	b=c+nvIzYdlclWStBHf0FNsKS4uFcIobEYKquy3CNbQUnUbkHR5h33Cm3nPUXzT1BaNQ0E
	 0Ps6tQxe3G1gjbTuPX7/MiT9gFBUKUpzCUKCSr1qX9EFqY9yhWUrESEhFOK9UdGki3yah
	 tkQStny7vV7B1olNQEepu6g5SWD5yrfIM0bbfKCgg8h1aYr06ks0WJZu4Qa1JLJO0VKeW
	 sGG4S4BZvzfd+wUFqaNyTRkqEFNhD0O3o3ayxhuPNW/1gNdbIEXRzbp10T5C/ub5W/JbD
	 hBfPYax/KaG+HxMmly+VJPXKcihA4xGaKCrFZjy1zu8t1ctiUeJ6muO/pN8gYvw6u/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661160;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=lgsaIhoT5jg2yZiHWMUul3nbdNhmgeKIUGmAgZiZoIc=;
	b=XZNsrrB56TzkwubMeeXvsyREHmN9Sl7oJbIzIiPBGrINAy0suppwq9FEXCEQKws/ToNu
	 ty2poG45FcnS3CkBAyQrMrsS/EGM5CfJx3OhF5rN9OqrKcDNoNrxSqfMzMoyH1ynkpXAu
	 p38cf3hvObyUUmV7yGRC032Wlnc9shzHsdXXYoU+xT2IyZwn2p/eO/XE6b64/cPA5hx6D
	 PMT9OddQ6XtuuX48wvq5JPKWd3iosesss95YpUDaFWQeYahLmZgHwOkcxUPRkC71urOJ0
	 FsC0jCGeBBKf4PQQ70GQG1gUXmw797DL2je1fpk/dEa+dIE+hkHNj0Akd8I2456SarQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FoPDtjYY;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YfZdNUQX;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398B0606A32D
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 398B0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FoPDtjYY;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YfZdNUQX
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ1hwRF1891771
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lgsaIhoT5jg2yZiHWMUul3nbdNhmgeKIUGmAgZiZoIc=; b=FoPDtjYY/uuQdUhT
	VNmJeqh7Usx/sKn6/kNHa3KbUY9lpBHahW+YeLa3MlvvuA4nVIm3ceMFYYyqMFzC
	RogAJtJSeQ5DJOcXYUysZH7++uD32iFMTi26jbILT+t6zgZ5KRTW6GyejjEVIV04
	ELuC/AQDPID4M+XUxnBz3fJkma9uhpWFB9h4zjGnPmBVA6CBlBJpDd+GnetzLpjk
	Kk678Frwin/7RsWMsD/fZb/srxBnvN52c8WhzgolMk4DXbCWdXj6wZOa1LLfAV+f
	1O9EoH5eMTuh5dJjfEVgM9jZ46E5mv/0Sd4ThXopM1yteFVkAaOOB3sVar38HegR
	6fdBqw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662s93hs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:45:59 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3838b531addso622925eec.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 18:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795661159; x=1796265959; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lgsaIhoT5jg2yZiHWMUul3nbdNhmgeKIUGmAgZiZoIc=;
        b=YfZdNUQX5A2fs+cFem6/A0+QG+ic+YR24irCpdeGBWjoysCCcHWDDhb5+ooN6s/+rQ
         1f6IQu0mXanPFWhldkF3z3FfIaW2WNthW4zRtOlvwtGLbYgL72PPsxAxXm8fGU7UwZjJ
         EgAIsgBRLI2xm7dAuyOSeANdKHmiFwko5xKe2vWEpnDut+Dm6Co5hwLLHsAba3ZSN2Xi
         WC7K8P5so6j4+XwuNCNdiMCOw9/HCylAQtn4dUNQagKZtqbsyCe+qk8c48ihKtxqWy6Y
         6+f1eBJFD8c4+7MtxmG+al7psry6mlqLMzYm5Qyzv2AiQ8ES/Fr2cvW3vJUsz6qdSC1G
         cbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661159; x=1796265959;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lgsaIhoT5jg2yZiHWMUul3nbdNhmgeKIUGmAgZiZoIc=;
        b=jBBpnn9G3omu0BVmC0HgDtYfy2XCnEJZFtR/ilNEFvSaNvaluHUknUUqd0OFHqoCsp
         p0RwZlDb8DXrIaInkYteBeJEPP5NfZKYoCHIbmCtqyAenacTrVhErQGpI/daQuw7dAJ6
         IZviDjmKvhwDRJxcxYYIU1wQJYlP+fE+BQvCGG4jnmksIc0Euj+j//rOAGkntlVAcw1a
         Kreo/xPmZ86TIrwJhiNzKmSkepGHMkFlK7icUWNVbGmYO+yAfQSSUFGuyEX9Z/H0CpXB
         ExLvBUpK9W0DKn9xzG7fIIfheKQEB9CSlPnr9AiQhpXM9F568cqpVK5P/joQ7HtSdjOg
         3UJw==
X-Gm-Message-State: APuU4Z986kBECfYDHRoSzHyUnVRk0dw5i2nntX9sLfC5ugk0eWE+qvy4
	uCcu5bl9Ep6JCa6Bkg7+YGUNFlEdaJFbiiVBqkNee7j1COBf/Z6CQSQeeZRZ4KcISdOuplpBRvb
	wmjylpctS5NzXf8MB27XcY2fFiS6ksEkJsy5VcglrfJhvPSOctjsfLKQP/1A//bn5a5tdulXLS/
	2QWwB6mQ==
X-Gm-Gg: AZFdTZdt8ZNzV27/icCvqqep+9MD98m1GhXyWD0HiFL2Z113P0htQUMmttVqKv3pc6u
	tp0ljLl3R6cD/udHQLzktXx10dckrnBjbCMyiEhBVkCJonwMj4mAKemI8nsMYcGo5pu8mygWx9W
	476qx7CRTX0c/w7QIYjrENrvQYBcujFVdy2TtFb7I4kRDzUjpR0MhksEdAPWZP6FuHNTiJ9itI3
	T7dTHpaOA37rhGwcZ3AaxeoLzUL/ZSWKHKbJraoenAIhjR17sHfbdweNG/zM45YrcdU0HCFUGdq
	BsReNM2MZFJSmpVfZndVbJxEKeeytstQp2RKfgh7nAuo5yWQxPnRCPD5lTMSaC+Dif44+LaDAfW
	2rygJhYfeiWgSRSx/hFJNI4SNmjZzUWsbJ51noI3K0ZQt6XPgxzDcSJsE44tERqPzKFI2LXkkkD
	JRNxLf7iqFL45gaMlNO/Vz
X-Received: by 2002:a05:7301:b8e:b0:377:d6e5:e642 with SMTP id 5a478bee46e88-3856e245b2fmr26260207eec.1.1795661158669;
        Wed, 25 Nov 2026 18:45:58 -0800 (PST)
X-Received: by 2002:a05:7301:b8e:b0:377:d6e5:e642 with SMTP id 5a478bee46e88-3856e245b2fmr26260177eec.1.1795661158086;
        Wed, 25 Nov 2026 18:45:58 -0800 (PST)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm16253220eec.17.2026.11.25.18.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 18:45:57 -0800 (PST)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 18:45:46 -0800
Subject: [PATCH bluez v2 7/7] tools/test-runner: Fix spurious 9p root mount
 error
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
Message-Id: <20261125-tr_arm64-v2-7-4f02989f17ba@oss.qualcomm.com>
References: <20261125-tr_arm64-v2-0-4f02989f17ba@oss.qualcomm.com>
In-Reply-To: <20261125-tr_arm64-v2-0-4f02989f17ba@oss.qualcomm.com>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Pauli Virtanen <pav@iki.fi>, Bastien Nocera <hadess@hadess.net>,
        Zijun Hu <zijun_hu@icloud.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=B54sQ+tM c=1 sm=1 tr=0 ts=6b079d67 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=UY4DqTd7ld3HWO6ePAIA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 5pff-Qv3NHY8hkvVkOlEXkfF3BUA-7ul
X-Proofpoint-ORIG-GUID: 5pff-Qv3NHY8hkvVkOlEXkfF3BUA-7ul
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAwOSBTYWx0ZWRfX80YzWLKzHPvi
 mqDU49pLj2H9k6gIyruzP3X2DrZdXCZvA3U2BpgDUx6OmpnoeYU7Wg29N8qe05ETBHs7kRu/SrL
 tS5RqxG6zDPEeiAS0jW+Aih9BsC6NNFv7c+JmyoTpEkQp2OQllwp0pTgPveNl1Rx79g+hH+8P4C
 UnQ/kRqwB0l1L/etBZ1PKXFVdy+2lHPuvqB737UaV5XxYMifPxG/bDRsjiES9geGuVgOQE3ejGM
 To+V8gdGzssFJ8SD1AaYgqyN+D+yH0vBCbuCeYDKuHVVnduj2rXiGNf+OH2Awwhi+eXCghk4kcx
 8vtILmTAInn4jNpcwVecg3o+v4/B6AU9WQ6jw957zFFCSBrTeQVISG/yIfxaQVbwFMfsq4Cm1qd
 FsMxt5HHxxl0Q4TvufQLIdGppsl4fG4IwS8vclTXZv/Th29ZISmc8sZPV48WAkeVYk1tCkh+EIM
 6XP7t/6YjGnJyHBHnJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAwOSBTYWx0ZWRfX6D72ac9xnXUl
 bLftgredEFGhqr8Zyhxsv3Qmt1DX4nOcp9ilPEmvVxlo7h8Jlt8jzTEvBhP7NbvLpYPDAAtb/hy
 AXDWqgmvM0j1iKEC8l4QozfmpR2B5fs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_05,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260009

Booting with the 9p root logs a spurious error:

  9p: Bad value for 'source'
  VFS: Mounted root (9p filesystem) readonly on device 0:25.

Without root=, the kernel first mounts the 9p root with an empty source,
which is rejected, then retries with "/dev/root", which happens to match
the mount_tag.

Fix by passing root=/dev/root, as already done for virtio-fs and UML.

Assisted-by: Claude:claude-opus-5-5
---
 doc/test-runner.rst | 2 +-
 tools/test-runner.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index f468a869e7ab..95f15eb3ca2a 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -82,17 +82,17 @@ available, a ``virtiofsd`` process is started alongside QEMU and exports
     -numa    node,memdev=mem0
     -append  "... rootfstype=virtiofs root=/dev/root ..."
 
 Since vhost-user requires the guest memory to be shareable, the machine
 memory is backed by a memfd object.  Otherwise, the fallback is 9p::
 
     -fsdev local,id=fsdev-root,path=/,readonly=on,security_model=none
     -device virtio-9p-pci,fsdev=fsdev-root,mount_tag=/dev/root
-    -append "... rootfstype=9p rootflags=trans=virtio,version=9p2000.u ..."
+    -append "... rootfstype=9p root=/dev/root rootflags=trans=virtio,version=9p2000.u ..."
 
 9p passthrough is noticeably more CPU intensive, so virtio-fs is used by
 default whenever possible.
 
 Either way the kernel command line also carries the launcher settings::
 
     -append "... init=<test-runner> TESTHOME=<cwd> TESTARGS='<command>' ..."
 
diff --git a/tools/test-runner.c b/tools/test-runner.c
index 10ccc949589d..3b9708f61149 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -944,17 +944,17 @@ static int start_qemu(void)
 					"testargs\n");
 			return EXIT_FAILURE;
 		}
 
 		pos += n;
 	}
 
 	if (!virtiofsd)
-		fscmdline = "rootfstype=9p "
+		fscmdline = "rootfstype=9p root=/dev/root "
 				"rootflags=trans=virtio,version=9p2000.u";
 	else
 		fscmdline = "rootfstype=virtiofs root=/dev/root";
 
 #if defined(__aarch64__)
 	earlycon = "earlycon";
 	noacpi = "";
 #else

-- 
2.34.1

