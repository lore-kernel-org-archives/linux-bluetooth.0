Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0B23D9690
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 22:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784326141; cv=none; b=LbyEEzZrTPVEqGLxoOkJ2SyZoDI6Kcdfxhn/Z9aXqwBoG/KW31I5Sy8SE+D4nkrTDZMBzhmchXZek0WCNPnqDBtaO5fLvlmKzKAAAcbyYTzauPxyw/OIYmathXzsiAF1FUfPznRwr2M3jlmO4ADXWg3PgT639s1SOuFfZvG/QT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784326141; c=relaxed/simple;
	bh=2mg4lcCoBOrma6IefKKbH4/A1AJkOSonKY92QFoY8Ws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mN4x+FVaquMKtzRDusmUJGMB/ZeMRpaTe0VOec+WTsIU39l0z9RIWYqscx65a+VWpSr2ou4maDiRh7LGRnGIT67f7/5gqnyQ2Ekt3PaHlXQS4ATG2+lUTlw9SLM+y5SpjrbS/ij2fdbqKcKe7/iqX98uLmg/tmGGHBUDGvhuWlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WGEOQCxG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OpEqQgWP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WGEOQCxG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OpEqQgWP"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HJtTek2449817
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 22:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pPC05PLfPQYtBhoBw/chggXx2GVa+E6AUpymsBU5IM8=; b=WGEOQCxGA5+b0OEe
	MvMXY0+O1P58e5E7sQWzw2V7F3Z5QdLadTwQLEqJvuUNoi9CkrAB+IPXJDPkR9QW
	hkKOicwbD374nL1wZEsk067wQCvDMwzoLP9pd6Rj9TCK/gySbCJAdRtDVeEqV0ZV
	vXxQnUYJHIDHgVcWUhv52C4AFtlrpfnO62kEEqXvQ2OXuZVoASfHkZo5BOjtoNtx
	Ewre3rjwpXYwVddIrGIxOuQ06zmEqp6Xds3XKX8wXa8Q7i7vKcLxD6Wzvr3VCJ6Q
	ORulOz0k4XtnyZNLO6NRLzCMJiCloG6+6tCfZ9yRiJP1dUUypHCCsNrqJxic7r8J
	M89kZw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffj78trsu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 22:08:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccbdbeffb9so28189455ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 15:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784326139; x=1784930939; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pPC05PLfPQYtBhoBw/chggXx2GVa+E6AUpymsBU5IM8=;
        b=OpEqQgWPuHAhpuchLikLDOxtBDBRV045CaWb+QLS9W5LxzNb3mMpC943Ty4+czKoKi
         0nIQ0KHvP6dcbiZA4r44hCKthTAFhTXY5EGOEL4JFEASUVhvh0K/JOGFkQb9AfK2J48R
         HHdGh6FlqFsCA4n4Zi6GutpR98YuKqYJseQEiZcGtIqgwDe5PlPMq6160s8dtXyGdw3C
         yNrMmlW8SN0+Lu+QWxDYBbVmW4yt3iHBAn62e06iMUk+kJmmN02z9ZMn63Vx1Yb4hH8L
         3wig4GY3XZr4t8bpWZ6iwr5/JJtP2aAvPwn3apuUU2xsjeKgPbE8q2bDCZiBF0kdBFpv
         vipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784326139; x=1784930939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pPC05PLfPQYtBhoBw/chggXx2GVa+E6AUpymsBU5IM8=;
        b=o5Uo3yk0IAVdMT+ToF2ZibeLeviPgMiGbgdxV421PmAFYWbbnrTHOqzy7AO6pjB5VG
         dqGGlNog1OjJ9BvClA008jgqy8TGTGhlndTGFjanugaRK22ihN3u8r4KJvXf+r/9hFvM
         2Bq+2Vb+qkS0eDTG4akMinEMlBR4mCwgMiUek1q3xx0GAETd2fzoGuUulmdFIHtMh8MW
         46Hy+nofl2z6r/LJnB2Nf0rzlWNumoDNU3sHRugQD9RJTXcqOF2ueleODWp00rw6NzEU
         jyEvIYMFH1baE+LCCS+j6M5KDqIPwFevA735WvJkj3een0engCbxsscZC/yfl7wWJeJt
         uZ1A==
X-Forwarded-Encrypted: i=1; AHgh+RoLhWjCtuuPuGOao91bbryoVPsmG4/WgUIhbYqDLftdCWHZswsZToJA9koMoUbhS8wRxNatyyvLp3emsiXOTxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7AOXmHWrAbU0+sxDGHPgWEusta9PD4qaDNM6taD556jh2TmFI
	ZX2NmvUamU1XhVsnqB6xGg0dvk/xiH5bUxduIo6TMswTdZWLyniURyPhxNfPqHPQ+jYoWEcsLD/
	uqhm25RlCJq3cBDrSnSchImI6jg6zO3FIDKGMajHL4tPrjgJ7BUMVHIfgW0lwfWiZxH24vtA=
X-Gm-Gg: AfdE7cn2UBmKwreuVDcPy6KGWu9hJOLBO4syBS6Fgvq6Un3Xw2izxplgpjXStuIg0rn
	3jN97yj6XDy2GttUQTiRHgjVe136grxjUgK/WBHoj5iA4MOAGi1dk8nj6vZjN4PqBCdR1PbgroC
	rkyyO/agFji//yWS8orv3AfYE5FOE6/OlCkgT9jmGmokBdeT6lLGa+Oe73RiRn0JXqAsebIrUQE
	+BRhe4bEEiJg/JIZhtQIJjnnmTUPFjI8mP0POQ0H8Kq1L0ayolMFhH6yYnitxVSmm9D6retCEe6
	Sl2sDcjXp/RmtLZm0Bia5WPub3pz3RkIie5a5NW9M9meXWyZ+4B9b4ILU6o2Swm95m5N00MVFTe
	xdCUuxvTu/GzHkIpXP7rcSi2RDDW2l0MW7op7c62hirwgkyU=
X-Received: by 2002:a17:902:f650:b0:2c7:ef84:c58e with SMTP id d9443c01a7336-2cf3480b3abmr41455275ad.1.1784326138913;
        Fri, 17 Jul 2026 15:08:58 -0700 (PDT)
X-Received: by 2002:a17:902:f650:b0:2c7:ef84:c58e with SMTP id d9443c01a7336-2cf3480b3abmr41455035ad.1.1784326138457;
        Fri, 17 Jul 2026 15:08:58 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29c2dcdsm7668667c88.1.2026.07.17.15.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 15:08:57 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 15:08:54 -0700
Subject: [PATCH 2/3] Bluetooth: btusb: QCA: Replace HCI_VENDOR_PKT usages
 with HCI_EV_VENDOR
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-fix_vendor-v1-2-f22263c1175b@oss.qualcomm.com>
References: <20260717-fix_vendor-v1-0-f22263c1175b@oss.qualcomm.com>
In-Reply-To: <20260717-fix_vendor-v1-0-f22263c1175b@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIyOSBTYWx0ZWRfX38C1p4AijWXn
 sPBnAxwSv/MaRmBzyM1rAzzimKaf+81jvfa/2lejKi+SbYxPAFWqy7yZiGhTmZ8M59uIcZ7TDtU
 NDNtPleEf6nc7E+qzQS1Kz9qqS0o/6Y+W6JyWCvd5KqDuFHyZEhNf/jR6FRAfjiFT31r6RrS5Ke
 rR1vggV2JzkNPPy/LkDAYwpcDL6II6eftd4RfpIRa035ouSrTRQinEyMM89v5Fu0jFXg9GBCa0I
 lJampuVnnsl0QbY3F5+D9vWFM73Vb2N7L7IHb7AFUJMhCwZFRCHsiAKSbWJN6S4MyavqjqE04vm
 fr6ODKmn50+cpfvxXhyoOVvtxlSy+N3W84ogHHqCccuVGsWNLp/VkgRqPb+vdJNHIkaN5hl2mPQ
 g37bWLCJS4pMftViFlT3REBhf4Jx4UMYCsy6rPqfknaKD14DDF6lbt1WgHN+AwM9YN57FRx/PLJ
 ZKqEBfyoXcVO/zPD/ag==
X-Proofpoint-ORIG-GUID: exPdUjxI5SsctleT9cZH51byv_rfRsQZ
X-Authority-Analysis: v=2.4 cv=U9Ciy+ru c=1 sm=1 tr=0 ts=6a5aa7fb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=_0CnrhXH5lyLv-Mul2kA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: exPdUjxI5SsctleT9cZH51byv_rfRsQZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIyOSBTYWx0ZWRfX4ve8MPCluAIi
 /PxanqiC/k0GczR/IaQbQd9r8sHlmPOfviyt4Uurex+L2jBXMhMWO3WYDTjsKfkfaNYwvqe1AH7
 udSkQZ9CFdrlnTjaZ6LacabJgIUImVA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170229

The macros below have different meanings even though they share the
same value 0xff:

  HCI_VENDOR_PKT: HCI packet indicator or type
  HCI_EV_VENDOR:  event code of a VSE

These usages of HCI_VENDOR_PKT are wrongly checking an event code.

Fix by using HCI_EV_VENDOR for event code.
Also fix warning "CHECK: Unnecessary parentheses around comparison"
given by checkpatch.pl.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4c3193ec2d52..d69eec8b2911 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3276,7 +3276,7 @@ static bool acl_pkt_is_dump_qca(struct hci_dev *hdev, struct sk_buff *skb)
 		goto out;
 
 	event_hdr = skb_pull_data(clone, sizeof(*event_hdr));
-	if (!event_hdr || (event_hdr->evt != HCI_VENDOR_PKT))
+	if (!event_hdr || event_hdr->evt != HCI_EV_VENDOR)
 		goto out;
 
 	dump_hdr = skb_pull_data(clone, sizeof(*dump_hdr));
@@ -3302,7 +3302,7 @@ static bool evt_pkt_is_dump_qca(struct hci_dev *hdev, struct sk_buff *skb)
 		return false;
 
 	event_hdr = skb_pull_data(clone, sizeof(*event_hdr));
-	if (!event_hdr || (event_hdr->evt != HCI_VENDOR_PKT))
+	if (!event_hdr || event_hdr->evt != HCI_EV_VENDOR)
 		goto out;
 
 	dump_hdr = skb_pull_data(clone, sizeof(*dump_hdr));

-- 
2.34.1

