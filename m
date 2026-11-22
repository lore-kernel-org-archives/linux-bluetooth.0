Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795347417;
	b=K+UUxFGm0HSQw2xPe5HYH8/1Yy+3qi5SrMeUThX4ARyCMkMSOGeyDHv7X+g4cZdYc7rn
	 eczUyL8kv91RxCXnId5eFk9N4bDSR3ub0kndqFSYA3ONTe/pv0U5hXxtCK2rVQeAdESpV
	 onrxuaQ9Qa8hAblOvTVxCvz0wpyf0Syfb+D/MpGepXPTaiZoO60n9fYLRnsHU/Z9c5S0w
	 7pmkT3dOWZXrzahNTXLsXnRtZM272jLD8LUWD1G/lO73OMTknV+iNK2vk4lyiEhYSBLgs
	 u7TQgSaA+PiiryTW8cVQhMYEEQ9IIUQfuxeGj1hCZ8p3Ue+A7cJt3+QlcH/N47dHUbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795347417;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=qBWW5VUsys1Gyj9qyyCoCDYAGc39ft6gEvOmqVHSj3g=;
	b=ZHU9XJl3UFFEfHm8CWZU7BU2H/UhbKSz4yScd05xQVFL06w6k/5zWnee5rxbEDoQrsk6
	 9xr9LyTTplHWJsFFl/gkpYiYTAVCycKmHkxgKISn18S8N+gkou5I2Fysd8pJqxsJaVL+t
	 poPJ6553PPI29NATrotyhgSV1O4zaWvpvUj/OuC8xuxnX8cuj5n4yxbMA38FoLav9X9N8
	 YILiW5r5VMB6fzYInctaUUsw3VYgnJpWyED+sjO1okmhtlzUq1F3TQ5Fte9si73EaSymX
	 MpquE4MGYBcstISTK4fPzZjJXIEdDPbEHCs9tv/7VQ+Y5hnPTQO/QlpOz5OmKVuA9dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=avhbo3eM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F57xYVHw;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548F5606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 11:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 548F5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=avhbo3eM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F57xYVHw
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM86YBW2498216
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 11:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qBWW5VUsys1Gyj9qyyCoCD
	YAGc39ft6gEvOmqVHSj3g=; b=avhbo3eM3BxVHUkvmueu6n/H5DKcG7Um2k4c4O
	9uoCa2rs1rQDwtRe5Vp0/gP4IUlhm+FEwMkdg5KUKLvwVOinyQhbjBfif+IaJOYz
	h+gSXJdhFZvG5MN7hgLBypQoxKPrF5BWcXBUjUgkjGP1XlRVjo0/GyEk2U6bgVbp
	eMXS3HB5t5mM1sm//h8ApwbLxYoUdeQV21pP5ym8Vz7ToxUeyVZ+VuCO3yeXM/TS
	jrqf2/pVoBrRbqOZ1ese+xdYi+GckVxJ2XZBmdfg0qLsAv6CgmLdnjtF/0McIEeX
	qZfdMy25y1TCjCpm4esTBgvEYokvQchlqyEq1s3HcKojOQyQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j33p7u7b3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 11:36:56 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1b23f91cd47so71872c88.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 03:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795347415; x=1795952215; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qBWW5VUsys1Gyj9qyyCoCDYAGc39ft6gEvOmqVHSj3g=;
        b=F57xYVHwxajRxKOI1Yidz5+mQgWX2s800FG/pJ2ZXzRLiKnDw01Qj86k/D3q+MhjJO
         2qwFou69WU+YLlW7EsP3wuOJyWONGKjFIOJfJg+qiRb8wbiwixCXOT4X2j9uk1LsN4X0
         MwyEKeIxurtRqHI9u0smoFmmm8ss6jULzkHKH7tHtFlnIFEsfNZyc5bHbRm9ZF9y+1D3
         MP5sEbzhhLNmoaZ6XBVOqszuHDY60nYP7uq+xECcO7refY3JLRvrX5eFYEPdY3vNBYlC
         RKBahZ+/0yfHoxrE1QN9AGSjVauEUOcRouRxCNdPZo37yEF9181KTCxEc24eqnKs1Lsi
         CoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795347415; x=1795952215;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qBWW5VUsys1Gyj9qyyCoCDYAGc39ft6gEvOmqVHSj3g=;
        b=Fg4LxHLLJDzqt+2P1m9ZsA9Bm2wjrTBniq9m0KVG2WiyHrttD+mHc1yAS3CNmxo+q/
         VTiA07Qw1WV1FkNctjBe2aWvY5WQwwBhl3elm0xwpgEjKbQQt77jaSY+vPXsf0GBvHWm
         BWQoaY6mjOjZ1cPiJXb1jdYPIVg/eGXe2e88/mmaOLbZojHDcCHPra1bhvI9ISoJjB4D
         H+gV/L+iMCywSpZma7QoixgajjmawhfSG0L5irY0LcCZdXki1rozpQuJswJlpffpxsaK
         wpGJ8/f/g7QilZvtz0uqQb8hA+wJC6TE3mbVOj2Akt5mqqWtO3mc2dLTnHGpqHJjpCbt
         uGAw==
X-Gm-Message-State: APuU4Z+324bps1kuYhkBHrRT2nV6dKyyWYROmnvQ43gLF88NnXWpm7QU
	9nvJ+QmO6brN6ZE6jUabiszk0R6hJGygJmoO+J+7TTifwnhm3+o+Gm17Fo3Sj6AVFasYc2bznZn
	Wzz3k/ECtPwke+H96ajm5xJCoXrqlJI9tIw03hjjl3lp9O0Gfxtq+j0T78UcEVERAdUwql7k=
X-Gm-Gg: AZFdTZdlUbPEBXp74oqVfSdFG6Qmebn21pMTughQ58VWWe4cvDgwYqnOXi9xU7iqOXM
	RuKSXhTqBDGX8esZrlyPuUaLYRoKufbycvyinq5539bF73HKvWY3sEiHrJ0EV6jfzOsm29H1E2C
	auOl0a6O8PX2chBVSqVuT6emscim8WI+mr1AA9HHFi+UOoUmUBG3QACd4pMU0mMzymflLXPHMhf
	0pvEXHzT4ppDRnQtB5paUS3gtwT4uExIOSOLChIYWVjS9VYMJ6jiXH0G4WU5PFm5YzKL1ytQKox
	f12jsI8qrpIih3YzbA7BCoGmC+iXyAuZ+UAQgm362n2dMKEVsr3l9eWPHrcQwgL75D7kCXNurZ8
	U4JNKyGfF7xRBna1NWULDfzmjXHpKyMko9dhmp5EHEhIA4Mw4U/CDYfcqBZtkfHx7LYfFqX5NSJ
	AT14/KZ2vrqaSPd0jOhXTz
X-Received: by 2002:a05:701b:2919:b0:1b3:a881:a67b with SMTP id a92af1059eb24-1b5568a8a08mr11700053c88.1.1795347415128;
        Sun, 22 Nov 2026 03:36:55 -0800 (PST)
X-Received: by 2002:a05:701b:2919:b0:1b3:a881:a67b with SMTP id a92af1059eb24-1b5568a8a08mr11699982c88.1.1795347414454;
        Sun, 22 Nov 2026 03:36:54 -0800 (PST)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ff27bsm21693117c88.6.2026.11.22.03.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 03:36:53 -0800 (PST)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 03:36:51 -0800
Subject: [PATCH bluez] tools/test-runner: Add /usr/bin paths for btmon and
 btvirt
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
Message-Id: <20261122-tr_paths-v1-1-044cfb9521ac@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANLTAmsC/yWMUQrCMBAFr1LetwE3VgteRUSS9mlXpJZsKtLSu
 xv1c4ZhFhiT0nCsFiS+1PQ5FJBNhbYPw41Ou8LwW38Q8d7ldBlD7s0xSt3sQ9cIdyj5mHjV929
 1QnxMnHH+a5vinW3+brCuH2PH2+dzAAAA
X-Change-ID: 20261122-tr_paths-eb1475ad71e3
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Zijun Hu <zijun_hu@icloud.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=OrHaWC/t c=1 sm=1 tr=0 ts=6b02d3d8 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=FAVf5eMEncyQ3ltaWo4A:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDA0NiBTYWx0ZWRfX539QB+VlHvPq
 /7PbbgpIO3FJFL6YHC1r0wkFyTNe8HvSKlUSk/XUMQe1USH4yxLifxBVJJxKdmbeX8JQB1VpnMR
 9xErPg1yljLp9g2dnNa5SiTdNrSemYo=
X-Proofpoint-GUID: X9tv-slfSduDge-4odoxwEsCZkI29EN9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDA0NiBTYWx0ZWRfX3+zxZDc9SdC8
 OOcjZzlf7lBZ4NghmRUoTpLlLqjY5WJ4Fws5kfvPAhx7YzCOhjIFTDWzisiTJKpe49zeNAkKdW5
 RTGhA64Qgbta++iScKrYPOuNvkcpoZ4XAwq4TM/c8qLkKA1QPsN2lpDV4XyW47ytMWjD4hyUwVI
 uV/AEhwzJktORzO/YaRCCYikzGIKrcoOJ+VFhtLrWYLggoMhp+aDu3/JrfGfkoDNcbHvhq5VsHX
 jxXNvLAk2HBsSmoUE9O0PMog/ZrOYQmQexOlg1wZq7ctj5Xbejcl7TflmYv5jV1EwFliSmcOFWy
 y1Ef0wiXfJY+ep1Hwl8vpqMMqhZpGfAH4wMiCtHcHcMea6jkjIlgQ1Hl0F7iNwCN+8TjdRK+3FL
 GJxkR0IOlkC4xoqGrT1Bn4Ou6Xapcn0W+eFsiWtGLzqfj2Zd21u9I694zI9gDZIfx7PLJNXp60C
 aGUGEUgwG+SzOeZsPvw==
X-Proofpoint-ORIG-GUID: X9tv-slfSduDge-4odoxwEsCZkI29EN9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611220046

btmon is installed to /usr/bin, but test-runner only looks in
/usr/sbin outside the build tree, so -m fails with "Failed to locate
Monitor binary".

Add /usr/bin for btmon, and for btvirt as well.

Assisted-by: Claude:claude-opus-5-5
---
 tools/test-runner.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 0bca31a46351..8a8406642209 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -1628,16 +1628,17 @@ static const char *test_table[] = {
 	"tools/bnep-tester",
 	"tools/check-selftest",
 	NULL
 };
 
 static const char *monitor_table[] = {
 	"btmon",
 	"monitor/btmon",
+	"/usr/bin/btmon",
 	"/usr/sbin/btmon",
 	NULL
 };
 
 static pid_t start_btmon(const char *home)
 {
 	const char *monitor = NULL;
 	char *argv[3];
@@ -1685,16 +1686,17 @@ static pid_t start_btmon(const char *home)
 	printf("Monitor process %d created\n", pid);
 
 	return pid;
 }
 
 static const char *btvirt_table[] = {
 	"btvirt",
 	"emulator/btvirt",
+	"/usr/bin/btvirt",
 	"/usr/sbin/btvirt",
 	NULL
 };
 
 static const char *find_btvirt(void)
 {
 	int i;
 

---
base-commit: 1adfe662efeff12997df9ddd0960dbd0de9c8ea7
change-id: 20261122-tr_paths-eb1475ad71e3

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

