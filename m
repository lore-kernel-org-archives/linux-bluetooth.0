Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795661155;
	b=n0DVvayCnjSJn6KdRd8hATdfELMFKb7l9gQkkzi+7syJIWTWZjyzXECudlw2BybYsCwo
	 6NPl+Tw4gHwBG5YgtrJg0gAVWbzMYl+Kx2PJ/p5R/l9J80whohVfvQ/8zeutooymcvRTN
	 muO9XV8XegHGwAulkFc1/LWzF6/krnUzfe+bxMYTEE4pZzAYXjz0GDR6VZwhDA+pB+TUe
	 Hcbd0uotP1RemuVQezy0YRGgG1cetINg97uqf6ZPZOxtowuwokoBcHBeM+ciwa9SuqMgl
	 zDKBSgl4gfTdpemSuuzfkDJjQSKh+JOZLbqnOPcStZP4WW816ozOtZV/6VPDVvPdJfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661155;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=fU3I9u+77bnn60ADBuA1cRZwq8cT+8IYFFr6caVXHmQ=;
	b=1CmbRC0KFWiEemOZuzaJIUyBaynNesiUYcXicLn0RaKy9sV6aJzc/WvhnTOypOiUDam3
	 pmNeDwlJv6pCBbLMoUmwGtDj+XxKooQzINjqyrA0+fVonc8jaoEqS8OVQggahS5gvciPH
	 gun8oWyZy8h4iUfvAN4gBsJcn+/fBu4TLMlAvR00PuBh4QKStbqdAAoc/Yrf+hZVcnLbW
	 s5aFjnKEycMnsFGut0KA3IkmHwR8DhiPaIkLNALt0z81lrF23xoUusBfHHa03PIUmFzv3
	 OxrxmkKI7f6Vn23MmplyE7Eui1F58swhGT+OfRQSCWDG6T4IPs7XsRpcMrWrqUH7fFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jOMNstKB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M5h8C6xI;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C27606A327
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1C27606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jOMNstKB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M5h8C6xI
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APJAnXK1357574
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fU3I9u+77bnn60ADBuA1cRZwq8cT+8IYFFr6caVXHmQ=; b=jOMNstKBMV6yE4yn
	Dlg14aJE8x06yTZTs76E1XNahq/KFuJUbZYtMiw0syV31CnsdruZFbg4I1ZCufNR
	DZXGy75GO7ZKqJ/C6AulmyutUj0BzJr0jaRRQd/gPoWGYYi235nFN1Y2nJWe2UeZ
	2swIrAMB9SufvZkz+RW77o73VYzru1pRCtBet4IVolqILCaUPpokd3J1tRpvspQr
	PBirnW0VGW6Jo2wQxmztO2bnVYcS6ZnbpZHv9mhBfn46pSDhmOw/M8eSvHyzN6vJ
	426vjChVLY5RWwy3yZr9n/mivPXpi9T7Dza0W1k9qWxOESU91C1YhxlhZ80I4p+u
	8VeM8w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5yaxtw0s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:45:54 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-386c4e8b81eso243951eec.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 18:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795661153; x=1796265953; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fU3I9u+77bnn60ADBuA1cRZwq8cT+8IYFFr6caVXHmQ=;
        b=M5h8C6xIuA/6sNb67rEgH5Tbj1jMtBvKdY2udELVZi8Ou/2GFT5tALqQJjqA+/8XHN
         phSs1UgdQxyF7kuS4LF7Jc7me62TSLbJDOxy9d1luLubmaL1MeLnaqQkDKGpDhda2bdZ
         mc6OlCVpiOP0ugfuQS0LoTvO4KJohGVtK83aBlYmyGlyV0mYoOeCeQGRzwaBrCNjIyg5
         DlmgT1EvzzXbA7VXPtk9fKmxjdHV1vCQWI3lAyTbtMLaks8lS4NBrSsax3fYAUwOgw+5
         Zj8czqH+6mhYACylzVCP4C2GoVq2yCtkxaOsKNmgcRTDImFe+FUFJi4Q8DiZ+pavxjSr
         J0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661153; x=1796265953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fU3I9u+77bnn60ADBuA1cRZwq8cT+8IYFFr6caVXHmQ=;
        b=Y6sJPGmg0DX4i9+NWjNFNHLkYVmzAdA9ul6G8GHXbqNibZt6JvanVivJO1Y2wlf3s1
         EcjVxrsgWQ4PRYuUiuMhRpN0uLPPGODoXMzDX5g/GP0rWB70/fepsaRQU8dGoq1EGH4C
         vnHjdINAvyDDAU2WwK2I4HPfPF49/W9JrEZ3YP9H14u9V/pVk5UR0zzg8vTB8ct/Pwbd
         jfYVc9DSuEOXh8yGEWT0KTEURYPw+T3PzLPHR5ItEnt2U1kvqWkahwe/p8ujzbaU4zTJ
         4eTlNLKSER0yfWeOAFelf/mvvW4A4rzgr3QQYk7kOCPuFWEESefOJLsleeFKm4SLBWRx
         UVIQ==
X-Gm-Message-State: APuU4Z/Hrv1gxMiTePfwwT1WidAXrPekYlV4H7ZhCxtAIrph/FfpcZwX
	dld7GOnu47hhZyl71X3EBnafD1Zm0N9IcaHH2KSU+jpP5yE71oaEBkJwnNfoVcJrhICKngvhPTZ
	NUUbsDStuDKUX9I3o4M4x7FXeDklSy6WIhPpnrX29/ZYm/Cm22T/ZGDWGmnjiuqXg6Zvvtha+y1
	2+AK1zoQ==
X-Gm-Gg: AZFdTZeiyHEXCdev1LooNJRm38RbqTk1nGc85D1/lnl/7YTfO78yEP8DHspTXUr5dvj
	upNrjxt8bJzFESs0Y+dYMUaddMMAcwVGWfxIjYHw3ItXN9sA/5z0RtF6QyssINmKUv1UtyKkM/5
	Npk+AljBy1Jj8l35NAqiWjZc0X8utEgOQ2Suih63HjAICRpU7NlYi7+V8yXOd6CkjNUvLOoF/1l
	EI2ccpUVnPtHvb6xCQuzVwkZTZy8t/yX1MW6v8hlcFw5tF1Pg+OppZ7G5xLwiSjBadoWAhBDxyT
	TG9Bh1duRuQPf+MVLS0IqTc32De+JZJmHf+VKB+ssZ7LHyPoun+OiUMMPxfjqavGzX/ZodKz71m
	LFFu/uYA37kD+G5MTk+1Nkxxljb5+bm+hpBWXirUefAr4vO97huJ4edEKILw2XW+AqNWnMo3MX5
	UIe2rrX5PUL6zH4oRd+5G7
X-Received: by 2002:a05:693c:829b:10b0:386:c3c4:b914 with SMTP id 5a478bee46e88-386c3c4ba54mr11406998eec.0.1795661153342;
        Wed, 25 Nov 2026 18:45:53 -0800 (PST)
X-Received: by 2002:a05:693c:829b:10b0:386:c3c4:b914 with SMTP id 5a478bee46e88-386c3c4ba54mr11406952eec.0.1795661152788;
        Wed, 25 Nov 2026 18:45:52 -0800 (PST)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm16253220eec.17.2026.11.25.18.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 18:45:52 -0800 (PST)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 18:45:40 -0800
Subject: [PATCH bluez v2 1/7] tools/test-runner: Fix TESTHOME parsing for
 short paths
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
Message-Id: <20261125-tr_arm64-v2-1-4f02989f17ba@oss.qualcomm.com>
References: <20261125-tr_arm64-v2-0-4f02989f17ba@oss.qualcomm.com>
In-Reply-To: <20261125-tr_arm64-v2-0-4f02989f17ba@oss.qualcomm.com>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Pauli Virtanen <pav@iki.fi>, Bastien Nocera <hadess@hadess.net>,
        Zijun Hu <zijun_hu@icloud.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: kwckIH4cVED8Dl1_DhGE4i_Jju4Kz_4M
X-Proofpoint-ORIG-GUID: kwckIH4cVED8Dl1_DhGE4i_Jju4Kz_4M
X-Authority-Analysis: v=2.4 cv=ULpIjyfy c=1 sm=1 tr=0 ts=6b079d62 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=G5P7SNOwV1t5QV8yHXQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAwOSBTYWx0ZWRfX1TwMhyWzJIsR
 ZsO/EBCBTzYqgHeoi2SrDpuBv5K5T020UY4G8WEiaBirPK1uLvrC2mzV7Pe5KZ2+BAp21EkSIQ5
 KyJlKQ+g/IVwKsCND43diQkc8r5TJ+06rz4tnr/MvqqyzsRf4142iJce7kaNJ6cFFD790Tvoo58
 rUG0hV8gj4hWZQuxfgKh9sVmeWq0CvbV/k1yEb0i/pWnzUddC/UXAtUBvNEsoyXVhS2fpH2P9nr
 esYx8av1HDRPA0a7rdzmCHjdTgxGvMyEiT7Wg9NsZrMRIQ7qYRuqt2D2uqQoGhkhi2CISDI47G5
 D3KAlru9f/5lngJwFiK277BybMVy+qMtnUOuJf4oiyI1XdPlhloAvZOtDQFmktDFfYUYVKavTmV
 ovsf3eNkNizaBhO811EeKgOBs1aPz8FcQ43xFPWNejDIxZgwIjnIXyHw3kMRMElVGs7DKT+k1su
 yBFyouok65HkTF8rvXw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAwOSBTYWx0ZWRfXxGEsehowZzrI
 Wfr6x3HZbo1I24e22ik3Nu+jsA0I/4JyNXgzyJJqHN6HSxAarBMwspDeagD4jTWA277CmQM5rqo
 ephk/ILn57z4qAvRncITC+2oh8xftVE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_05,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260009

TESTHOME is parsed wrongly if its value is shorter than 4 characters.
Taking command line "TESTHOME=/ TESTDBUS=0" as an example, TESTHOME is
parsed as the wrong "/ TESTDBUS=0" instead of the right "/", which
causes the following error:

  $ cd /
  $ tools/test-runner -k /pathto/bzImage -- /bin/bash

  tools/test-runner TESTHOME=/ TESTDBUS=0 TESTDAEMON=0 ...
  ......
  Running command /bin/bash
  New process 67 created
  Changing into directory / TESTDBUS=0
  Failed to change directory: No such file or directory

Fix by searching from @ptr + 9, the TESTHOME value start, instead of
@home + 9.

Fixes: e622e623de13 ("build: Add test-runner utility for virtual machine execution")
Assisted-by: Claude:claude-opus-5-5
---
Previous version:
https://lore.kernel.org/all/20261119-fix_test_runner-v1-1-ddad300e86ed@oss.qualcomm.com

Changes since previous version:
- Improve the commit message with command and error log
---
 tools/test-runner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 0bca31a46351..6b8d0522fa7a 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -2167,17 +2167,17 @@ static void run_tests(void)
 			audio_server = strndup(start, end - start);
 			printf("Audio server %s requested\n", audio_server);
 		}
 	}
 
 	ptr = strstr(cmdline, "TESTHOME=");
 	if (ptr) {
 		home = ptr + 4;
-		ptr = strpbrk(home + 9, " \r\n");
+		ptr = strpbrk(ptr + 9, " \r\n");
 		if (ptr)
 			*ptr = '\0';
 	}
 
 	run_command(cmds, home);
 }
 
 static void usage(void)

-- 
2.34.1

