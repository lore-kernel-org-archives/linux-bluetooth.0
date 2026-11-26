Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795661156;
	b=ysdqLYxPY6V2qLSxPOZoe/lqlBr1qtlJygBD3Z+psOPP9pFJj5Rz5LaUORR7H3eJf6kA
	 InrN/goTL9dToyGLchaaqg1uEIFa9Fn+tR04yWRBVLV/ihJBf2OLmVMj6/1dgTX3EECdG
	 CtTODNmjFBq3MvCJv7bVNrYDDVzrTto3oaGq6MxTvAcR2R3GUr1VezSHLYcVUffm3SZR7
	 wz59Jk9qSRyYDf7SBPjc45LlOshZyMzVrlDZ3r4TUqElAj+nFVP07L+fNnQGoZ00owwQZ
	 Kha9SuhFjfiVha/TW+dIyZkDqojbKkCaNbPjaso+FD6P6+cf2lXO1yE6xzpGu2ptL0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661156;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=lYpNFRnjZhkTekU2pFn6BnxngzJoQxNiVfK+7IeeJCs=;
	b=eveJv/cDCZ0026oDqLGPfIT9V4+1+xa8tA/qx6FsFwUcqtPsd/VJ8boiMJlIddnY0pjc
	 1s0UPjpmYx/YLihztwsuuL084n0M/gsCf4F4NbKHAwpT5TCBDAKS/bt9ucgH6RLGWi2yJ
	 N23RA0PZoshmPx4TP3H5YhkDi5JnzEQQLJaK/er24EqPgSMMlRfwtPLveK3/ZtnwQnfau
	 pWORzxJzPWiQqqgTaTGAwJ52fnw+8+UeNsIIxdhMafsqwi9Hk2qZEBBLmmfwl6/IzG0/z
	 E6V1IuY7dmrxI6342IW75Vw3NcadGPXaK+a+h/yBZSpEMGTLBGWt0SzBXmSFbZIc5jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iwoRuOZA;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QnDxh1I2;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAC5606A332
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECAC5606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iwoRuOZA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QnDxh1I2
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APJgvdr3661526
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lYpNFRnjZhkTekU2pFn6BnxngzJoQxNiVfK+7IeeJCs=; b=iwoRuOZA6Brhe1FH
	uhdmWHtWULrQfJKvKYvMdKZ20/89//O21l7SaKooc/arDJuSW6OpDEYiFgoYLFYd
	cQgNQN0Fvg2Y/Sz6tFuDgYPhlKMOltCJnz28mBF36vOX/Sr8omlH1BeqwpiiWqzg
	wFhCwHJCyJp16PQZLBryyIffoYs/JwDJMSNhvllS1jz3rhz6mrxMU6kHIgzhezyI
	GEsOEpKcjeNeDgV0wNKS3SaKv5U2FdUytBTFClZYSnowBrSafDRwhuXYoYlSiGs3
	sIQRgaBZfQyfHL0d9l6tYcfFs7N9X9pVjzqz3XkXVk50HlPjZo7LWuXz2EiJFzzu
	DrRliw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662y12g6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:45:55 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36a6f57c066so668227eec.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 18:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795661155; x=1796265955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lYpNFRnjZhkTekU2pFn6BnxngzJoQxNiVfK+7IeeJCs=;
        b=QnDxh1I2h02udS62cWd0PB/2eZMGD1HODvdUtL1TdiiHLYFXlR8Q6DSyNe4wjQsu+u
         E9xFD6zStQIioVWslTUrB+wzr8LECrVAQjb3Wxv8b8pDPyMsHWnf3G5CLpFLxAjMsFBE
         B1D4KDmbEsblx0iAiD+hjr8b/ybH8fn/PO/s1Sp8VzGqTTUxkvx775bG3qt4EG+Uaw2W
         5c2ullHVVGyoKQmWOLpC3dnZdUXl6NwddUzWt4C1YVozJmz3nW6MjLUbemtprPWtNRO0
         cvYx8BRMFAwi7SuBM5K19uvSeh4tnkVxTtlLq1zHKdyFf19x8jBgmy1Wd2vIc8F3mpFF
         OzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661155; x=1796265955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lYpNFRnjZhkTekU2pFn6BnxngzJoQxNiVfK+7IeeJCs=;
        b=rXwU+CADZ0CnScioopaKVMYtEEWJ/1HtuHfL/t80j7CUU64xvbi1r3GeNhcNg/Irjb
         V2qLCp4XraJZMZeFw9Pk/S6DOS1MxTkq0bZvdssWTOTJYUkE3D7MkaHcGiXIWsGpjg7+
         HsKF7nei0d3XaKR2tl4tWt5YGt99Z/9eL2ftVIRKxKzP2mVBYBOoz2PJIMC4gZR2cBXn
         CAyYSa0QZ5MYJh1/hGz60dEot97T1KdWTg7ChtlD4fRkug+sykJvnNR86o/Yo0P8xKb1
         qLcftR+01TWFNQ/tVfAwwDTGwyc2aFGXnGwSOVG+1cowcxMLkGHFiHtBi3VjJkrPT/1R
         cctg==
X-Gm-Message-State: APuU4Z/J/ZUZ3tlD5jDUc3Kl6cglU2R9m75kC0sU/wpMtRPjPJDMpPIC
	v3cVIQ2arPqZa7iiOXHdjViPdOVGHGrui/buReNs4HOthomO7DZeOXTzG2rRRup0YBL8D6OXuye
	x1Fmda6wtnQ+mvGzmy9A6/ydv/JjjDmwAtLXOeK8Run+K96v/2YsG2lCWcVWQH8vIhf8jmGvHh2
	l31v+N4g==
X-Gm-Gg: AZFdTZesGYSkGF/45KyPxnXEyaeOuXAAe+sc5JSmIg6Ybx5jzV5kvEa+HQh5QWplC0S
	cAeVYxv+MO97UEjaVlBTuoaJOSY04ML4t4ZL/38BvBcPh0ssfCwep47CShDKBBHlbMkd/Sm4mxv
	lbkuKhnkA5/a+KeKlxeq80L/ztqKXCun49YM9Om8hLQdlSE0My/oLdKLPCcoJ8T8sh5ylupc3EY
	XiGKmgg+jrElvYc1ss+K05i2WinDOSfW16VLXEFT/skNMcMRLgMK4lM5CA+zzWU7IMff2Wb2WKA
	C1Si6oTcd2i72IT6VZNd7+YYmz6z0tAOJq6xMdvfXwNLuQtw+F8TUbxx2tl0kk2yy0dHrLS5hkQ
	NJi5kbO+6X4PUu1x6mWc/W4tr7gFafHLePYx+8YDgjOwUuGUJeTzmdc0TXWRTSb5nxVb+IHRI/J
	6DcWzcZBzI1DkZICQtmWZz
X-Received: by 2002:a05:7301:18a6:b0:36d:cd5d:d809 with SMTP id 5a478bee46e88-3856e84e391mr30585808eec.1.1795661154519;
        Wed, 25 Nov 2026 18:45:54 -0800 (PST)
X-Received: by 2002:a05:7301:18a6:b0:36d:cd5d:d809 with SMTP id 5a478bee46e88-3856e84e391mr30585783eec.1.1795661154018;
        Wed, 25 Nov 2026 18:45:54 -0800 (PST)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm16253220eec.17.2026.11.25.18.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 18:45:53 -0800 (PST)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 18:45:41 -0800
Subject: [PATCH bluez v2 2/7] tools/test-runner: Fix termination of the
 emulator
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
Message-Id: <20261125-tr_arm64-v2-2-4f02989f17ba@oss.qualcomm.com>
References: <20261125-tr_arm64-v2-0-4f02989f17ba@oss.qualcomm.com>
In-Reply-To: <20261125-tr_arm64-v2-0-4f02989f17ba@oss.qualcomm.com>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Pauli Virtanen <pav@iki.fi>, Bastien Nocera <hadess@hadess.net>,
        Zijun Hu <zijun_hu@icloud.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAwOSBTYWx0ZWRfX9OAC/UzZuRXA
 zZ2VUZl14B/8WTnCQrux+VUblz6WR1KsWG7O9vBzgyfP1xmzrlZvxvZKTaEEzw8g3p2gAlpx9EY
 4HZALcq9+jy2cBgX2SHaVHZ4s/tl68EhL6cMvPdQApmQG7cLSvp+MHTAeI9iYt+n8eREbGxTgeO
 jI9iDVvLsi9ff9VfSZ4JwDYr12HDeMCMmgeWNVu0QV2BEAm4VP/3NggDSFl3EZw63gWUwUltWHi
 scZkjJjWKvK1JYI3BjG2HegZqrPn5l+wV1k90811kv7LX7aj6QSVYDuHkIolFAX1vgxy2Q9dsXT
 5ItQB4qHjA4RMqlSFjOVVeJHZXaPH3/fGjhZX7fckJhuUPZ6XNIHWc36t3sGzM3zN8GmA3L3TnX
 dAHFDkLo7HZgfwvRaLNuGil1TjA/oj3m06sjuP+GE5q9ZLENx3SL8mf7oV0HJQOQpD41n6EBwQe
 Qj8qsupyJb++rHUTeiw==
X-Proofpoint-GUID: 1D6Ti-QwMG90NbjOe7_Bgepr9IuX4LYG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAwOSBTYWx0ZWRfX7tD+T+XjaQBI
 oqgpGyn2SxgYb93wmJVbJNp2lU0/iWlzzZqbXGRirZtj2BsvT9jzLPOaUjS8R0d35RmkeBLOpq+
 b15w+hHV932n06EXZHABdbrIZY3d9m0=
X-Proofpoint-ORIG-GUID: 1D6Ti-QwMG90NbjOe7_Bgepr9IuX4LYG
X-Authority-Analysis: v=2.4 cv=W/KtxhWk c=1 sm=1 tr=0 ts=6b079d63 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=r6dI4-qf353Lnqhz0U8A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_05,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260009

There is an obvious bug in run_command(): it intends to terminate the
emulator, but wrongly sends SIGTERM to the D-Bus system daemon instead.

Fix by sending SIGTERM to @emulator_pid instead of @dbus_pid.

Fixes: 850003734a74 ("test-runner: Add option to start emulator")
Assisted-by: Claude:claude-opus-5-5
---
Previous version:
https://lore.kernel.org/all/20261120-fix_kvm-v1-1-234e5043b516@oss.qualcomm.com

Changes since previous version:
- Improve the commit message
---
 tools/test-runner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 6b8d0522fa7a..a14f21e50d50 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -2064,17 +2064,17 @@ start_next:
 
 	if (dbus_pid > 0)
 		kill(dbus_pid, SIGTERM);
 
 	if (dbus_session_pid > 0)
 		kill(dbus_session_pid, SIGTERM);
 
 	if (emulator_pid > 0)
-		kill(dbus_pid, SIGTERM);
+		kill(emulator_pid, SIGTERM);
 
 	if (monitor_pid > 0)
 		kill(monitor_pid, SIGTERM);
 
 	if (serial_fd >= 0)
 		close(serial_fd);
 }
 

-- 
2.34.1

