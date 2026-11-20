Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170405;
	b=vuxkfANk036wigVf7PmmRBNN4RnuVcLN9C/TN8EuqcIu+tQfbGE+D3+sY09xD1LQuDNC
	 HAI/OTaOm+86Lpk8M6NH26BQgJ69nwpZ/0olU3c/R8LV+kJXUpgGyn45zSSVJzHuCdegz
	 dnhCCaJldiM2gUOyJhT2r8WSzNedqSAMFn+C0pHCtAAevAo+zdWmj4qA95EhOuNKmLtn3
	 cYJuvfFu6ZxS5df4ShyGw3I6mSg63PvHwpZ3ccXmzqy/A8LKfOMRcREZRysrBvkItF1vN
	 FferGaYM205+b7npDDX5KDyEFv9HsvnxGjJzjXWe8sZQUbLWtZ2RXr7xAIIJq/OJSEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170405;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TQtlU4BlBYhXVsXRrWwAJfHIR8SEqpHhepGSGQgguuM=;
	b=eZ5HYsjuKZjXW7hvsgD6CdvGxhXGdJmHCKuhHB2nKARTCjq1KrvNaI4dEtb/Oh+/Hf2Y
	 UNmWeykMJH7IaExOhJF/qYqI16YuXhnvIBksgjNLDsOvgSPORst5OYI2bX1vnj+eQSlHV
	 2XUNtiBswg/7zcqo3n9AnInXpfZQPRSdMBKBMem/mx6KBUqaHqci16uACZ4uWQC+ifWBv
	 hMlcpDfwXhjnF1s7LK1UipgFBJzuP7bsgBCQDMhuJ7gQP1CzHq6WXybImreMFXgZcZUes
	 Q5Yq/TGzSsj255EIBWq+iBxDC94qh1GENuDk4MeyiDJ/FWnw/ncYAAliy16XdIOk+iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Bz8u8teh;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ABhYdolR;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8676D606A320
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 10:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8676D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Bz8u8teh;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ABhYdolR
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7ewmv605974
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 10:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TQtlU4BlBYhXVsXRrWwAJf
	HIR8SEqpHhepGSGQgguuM=; b=Bz8u8tehE0JVArV9VCenJVQzLY/Z15GKmSYegi
	0arH9yIjKqtrnC3q24RcK3PC6QHTwi+8XiiKM11ZMyLUz2hNNLxQCUAs0Dmi+Yjr
	9CZR/5eI7c/kAWO+5X/qOSiRyZSdtii4FVmNQH25K1jgMWm27gC33tXebC250F4h
	CVhws3qEmCkb5AmZyyQoj4bPbcXAmC6Nbzx5GU/m7sx/wECyFvHV5AO0D1gAX2vg
	1pvPfIpElRcaBjQ4dxo11Tvkav/YyHUdztUPp/wkrq8D4kYnD+U9HVgCM14TdxmY
	DFhtiOQd6T6whWtvU7v6phpWxLPhzW/rBWTiFXnlzdY1n1yg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2ggqs2qy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 10:26:44 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-385507d6e0bso75615eec.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 02:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795170404; x=1795775204; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TQtlU4BlBYhXVsXRrWwAJfHIR8SEqpHhepGSGQgguuM=;
        b=ABhYdolRefFukALozxSgqMT6Gwlfwg14kFv2a80nIV1JrnwQIRufhNb77K1J//je8G
         FvSHa1DVOKlyk/KY8AgnmZn5bELdZVjl73vtvcwdpRGnTFlGkMeU8FbyNi02GTceVeQI
         8MYVeA3RUNDGf4mzErXU7USL3MCvfwV9l/qPjcbqekv486fzS2epMUCui7csGsXsgl05
         L58jNNJsmri/vR5dg+YJqGtELd2hGIFblGeC9tYfmIpi1SNS8HmcEe3MMEdZLmi1ejhG
         kLlv9KsHA9pdaG7ocWaW7VCH9eAoiXeND9wKfsfyG2AUY5hpTDl6iqVYJ38dWDdC93/p
         TVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170404; x=1795775204;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TQtlU4BlBYhXVsXRrWwAJfHIR8SEqpHhepGSGQgguuM=;
        b=fMuVwVjm0No0yfrVYZ7SSl02Hdn2vDDibGrFtjuhLbWIsV665TnGcwL+WOgG8yU0IV
         YWhVmf2ySNDb4MvBYfHRmYpv90cETJxyFSwLTzfWnZvpGW8jkF5bIfZL+hn5NfU7OI82
         2aROhglp1ApdEzFG4tlJpKfdC1Fe/2Bfhw6dccTigu7y5nXHizKzSXw/nRxEb2g9g1CR
         4DrCbIBtNlsb3w2vW9Qjl8bMIzLz+EtL7OsHxrkzyRVAlY2c6rBgEYhA8949/4KQ0Ifu
         afPdS37vx4pufms2z2jRotYYvV/3IO1dcYOy41TQTqBzpCiB5dXRPSo48oypcdLMNEuq
         i9gA==
X-Gm-Message-State: APuU4Z+jLcaDy/UGEZKpzidQ3nPb3IKrIDyXKbBZj0HzHiUmQoba+aLB
	BP6Dh8XCnlP9McITTbhr17DwEYDoadWTMk7RKeIlLkTBPlHtdIMtYfgZNTeAlWwskUcp3zO9I07
	HayTMlbwj4XLURj6yTofUoYAu+vDc2SDX8jSUMdkniWXiDFM2/f4rv031cWhZFacTrQuBpTMcTu
	aqH2k=
X-Gm-Gg: AYBFou3YZfIfNGEwodjVnpcVAvEqxyuVKdko+12YB7e5HY+VJrEVJXjs1pHGkDVtT1Y
	CDqsl2REdNhmmawRM5xyo1asnNtyL4cva9Q4uhDpgTmF8HV+waq+ooNcFB+LlCkdSZ1aQo9fnBs
	ZYlcfbCaVtJN4Io8tDIR+sM6KOxg/hw9Lrlsnq9O53RFOfYugk+k/iTmtfvoSrymSeJeQecWciu
	Yv112pPdSeH72gh4PQr5a16gwaFghiwULrqyqWNK9TF7/fPW28xloIAUyWp+Z8KoOw4xVudEimm
	Ze1xiWonrYbpUE8a4A5yL3TY0nj90aeVMzEmDbrzpsamy/4chKfcYwkFycqyWs+Fowtgb6bUaoS
	P4CvjXHMts7xnNk0AM+G/beOVFLcyN1BCHL7Fg2ukeyfzP1ByBEKF0sfRSRGqji50aeybvOJATm
	4Xx4H3fARjNlvzjLnR2qU=
X-Received: by 2002:a05:7022:b90d:b0:127:def:dd72 with SMTP id a92af1059eb24-1b55687f1a1mr3337004c88.2.1795170403776;
        Fri, 20 Nov 2026 02:26:43 -0800 (PST)
X-Received: by 2002:a05:7022:b90d:b0:127:def:dd72 with SMTP id a92af1059eb24-1b55687f1a1mr3336973c88.2.1795170403190;
        Fri, 20 Nov 2026 02:26:43 -0800 (PST)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567e495bsm8259182c88.4.2026.11.20.02.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:26:42 -0800 (PST)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 02:26:31 -0800
Subject: [PATCH bluez] tools/test-runner: Fix termination of the emulator
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
Message-Id: <20261120-fix_kvm-v1-1-234e5043b516@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFYgAGsC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyMD3bTMivjsslxdS8skkyQLM4vEVOMUJaDqgqJUoBTYpGilpJzS1Cq
 lWIhwcWlSVmpyCcgUpdpaAPfUdcxyAAAA
X-Change-ID: 20261120-fix_kvm-99b4b868ae3d
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Zijun Hu <zijun_hu@icloud.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MSBTYWx0ZWRfXxTWA1eo7Cqaq
 cc1t2uvMoqF/Y+LFnm13xDWOyNtN28QpjLlx+dlsgw9cDtJgKfCM6Zbj5htLmLEie9XhgO6XXGp
 T9oQym0dCVCCownaV4OajyT409BaJPaXvWl3elmuQcsfNalz8Xv9B2ai2DghnImnB0JGBHwgzMG
 yIt6ZqJRQfixRIGkitINa2OGem2x8c6G4jcHxtreoAkXb7GyeUV963KYBTBZHBVpFkdj6zMSLhn
 hWmf83Iz0oQliT+cbng3uWNUuSXgrK9Rj/R/BgLoh7NZPFj7VlMJ8LOYi57colDN/TF8pZ34pkB
 GqEB1qoMMVK/1Yqaan2Th7k30W2Uh3FROa6rVjE0ZMFSw0OKgprmj0q4+Lq+EkuTaHpswHpo13z
 ZIolItXbalaE9XmKmJJwpeNw91+YKyn4pZY/9ckmOTxLr0s0pH/h9tMsOI10Mlu/sSE3oCHJYoN
 ZQhvxpUBEojautooR6Q==
X-Proofpoint-GUID: bWOP4TQDzXP8B9j-fgfoIPqzDFHfO9lL
X-Proofpoint-ORIG-GUID: bWOP4TQDzXP8B9j-fgfoIPqzDFHfO9lL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MSBTYWx0ZWRfX+XGl6mVhiGWZ
 4BFh9Gw4lCxjD4NAs9zknRG9TfN4v1Yi0NfR2ajKP5G1ZhjEP+gHzF1UPvPLkpbWg3PMCFARg6D
 hFOx4HI5xPB3cRyyvHPxDf2n8nvzbGc=
X-Authority-Analysis: v=2.4 cv=CNy/zhrD c=1 sm=1 tr=0 ts=6b002064 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=-4XN4jpdNxS-NnsmqvkA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200041

run_command() intends to terminate the emulator, but wrongly sends
SIGTERM to the D-Bus system daemon instead.

Fix by sending SIGTERM to @emulator_pid instead of @dbus_pid.

Fixes: 850003734a74 ("test-runner: Add option to start emulator")
Assisted-by: Claude:claude-opus-5-5
---
 tools/test-runner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 0bca31a46351..52b58df7618e 100644
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
 

---
base-commit: 1adfe662efeff12997df9ddd0960dbd0de9c8ea7
change-id: 20261120-fix_kvm-99b4b868ae3d

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

