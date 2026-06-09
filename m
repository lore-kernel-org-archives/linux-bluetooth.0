Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30713369D44
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019918; cv=none; b=ij99dPluRIFCsyaSyAYTUjht6FCfvSZ3LpJCXyVcQfWpOUfDAFrb+p9RMYTNxrHf1hv3eOiwESY87jBefZH4QDqkIXg1WomDf/RhqHFVKLo4x9OW/CamiKME4BakrQpSFvpneQy4kBvt7sg6AKq3yxvvX1VT/LX9LVGdk3z9o74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019918; c=relaxed/simple;
	bh=6m1lx7y+1U7VXLVVBKnYNHzRt/IxJCOEE8Bqv1Mhpaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o+FIu/jUlEDMuVL5kUW5VbGDnunADni9AsxkWhpsmzugX7yGXM2Ye//jaXSIkpyjA+FsgvkKPGU+pO5sjn2AHJZHKpwINHx12e3ksPjvrcOdCkXdu+anA4AIRL2egsr9pnPTDIIrnRGbpLy5y+plsT2NfoRyHvBZMXWa/W/A6Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dphRdBUO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NjsvFb98; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dphRdBUO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NjsvFb98"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659Clcm72183230
	for <linux-bluetooth@vger.kernel.org>; Tue, 9 Jun 2026 15:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=yR7HViirZMi
	7KnmqCHIHvMhSNoJOl3XmsRPXvKWHdmo=; b=dphRdBUO0ZR+q2T1n9TPhZRBhx1
	UIby2W4v+6O3rbwO976bqz0c87zYi9AAvEPIzxYhQUoTXOJC6j0wNo1/5EdJTSGn
	kiqKZO/734O862hf0ixpBdRHE42HYfzGk09Hl71IQAgKVaMwh8IcQbSHc+pZFYjL
	H6RtS5+6S4flIgAuPb0EzeOm+yvkAXvx0r6syhAcL0erS5vprZLB0NpgkJ+RTObW
	8Eg7//dwsyq97w9jYN6EZPnoj1nQuyv+AmIdnxTyfezNgI0ET4brENpugTNSqUYC
	id9jRquXeZLJOTjgEo62Ql61ZOwUmpvKwLskBmVYff68WQK8KfiTIlWhxyQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epenra9hg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 15:45:16 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c85798977dcso3545635a12.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781019916; x=1781624716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yR7HViirZMi7KnmqCHIHvMhSNoJOl3XmsRPXvKWHdmo=;
        b=NjsvFb984b0fNr/LfuIdw9+HUxzqsAjCHuZUaJTmJFdcKYxi0hfl6BUFfd15mOk9q/
         qwiappbvX66bH5N0UHrLjxP2K89DX++Kch6itpzq6V9PqY9pDm6gy+k/DI0CIQ2tywFP
         YqisN/MzXbuPW0TJx4LAJyfv9+RxoWVZLSuadGUxmn63cZ4awUN1kjqjj0KnL3yrFzwa
         WOUNyBf5/l23wRk+buv2/6To42r65fPjXOTiCDd2UhxCWloCN7nJoXW4ptKDoKmyYXGa
         kjLk+jjsgjDj4dBxbppiHzBYWEInH5EUewcBd343/7Xk9dpiK9RHYwObHd4fLXSaGmi0
         pjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781019916; x=1781624716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yR7HViirZMi7KnmqCHIHvMhSNoJOl3XmsRPXvKWHdmo=;
        b=AVFyT6BDU0KwPfkqWH3EBgA8WHUUQzugHlW99iF96/Tdo+JO9ijQg6quQIBeUo0+l3
         do+/i9Aw0N4YNJ3f+BZ0SgUBUEXl2rG4Pa5Gc+kxjNVPiRYuyd9tWxiS/f4VdpPwuioK
         +n04ICnezSdER0i4KOp3siTdRVaPccJxVEGoGLSFtFcNyEVNr2Wh+heq9AaxSjmCRung
         kRSc/iGSNgASRL2W3AHenHoVBFVL4+IxPXvpP6kKLyEb4e/KFccFjkNLaMCzfOuKKNwc
         wsTmENrGZUad/8fymyQwS2s+2yOswPM2CG0LD8vWs127Tyh0n+RgHddlBfxrkaBB1pnR
         d/KQ==
X-Gm-Message-State: AOJu0Yz9WFk0/4Ej+FLbnAEzvkiKYXJLRHYdBNQ/QJ3/WeWil82qz3TV
	kHWxB0n6zj+u8mrzPYzBy3uDMzYf0bU2GFd7Pb9u5HcaOaZVTB8yXonPoIDf8BoBXNPi9SmxeRE
	cdh3lxetYfMCTGBOg92rkrBK/dG2WlClNAvtY3pQjG89Zdytp0wNMg0RVFealy3DI6EQTgxQbZo
	pWsCE=
X-Gm-Gg: Acq92OFDTlzJ6elPcKl4bgYTOEpPq63lvsFF2JCNqcbydDWtjJtaHO/UFvWslec3MC/
	57QVuz19dKllfEZyF/arrJzrVa5jdIcWiWaOlKWiNvyWmgt694UPzYnnDE3p4hHnet4SLsQG0tR
	wEMbjRYKr+RA4msNNic/PG9qweGw/LsWYEBAqOgkAmoRCBBxTscJ/a+DyjxbaQCsO/zuGQgoxs3
	TQi/OK5DMefBSpclGrCXbVKNoSVqWLU5gCNn8+xJYqROsD6U9z24l0jbJkl37/su30Ge8ShAyAS
	hDfxVKZCb7lma9suEzIg6HFnbG6LmJE69vgdMzOAzglfxbxVVMtQfdFqpWdu4tg6q+nAeLYRYGQ
	WbBAyYMhTM2yO0WEivwre4piBav5b0QcrJCAsJ+zUwznF0Qvu1x4620lLoNzwEw==
X-Received: by 2002:a05:6a21:514:b0:3b4:8818:fd20 with SMTP id adf61e73a8af0-3b4ccd3a373mr24101597637.8.1781019915688;
        Tue, 09 Jun 2026 08:45:15 -0700 (PDT)
X-Received: by 2002:a05:6a21:514:b0:3b4:8818:fd20 with SMTP id adf61e73a8af0-3b4ccd3a373mr24101572637.8.1781019915309;
        Tue, 09 Jun 2026 08:45:15 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df03387asm20411085a12.4.2026.06.09.08.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:45:15 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 1/2] shared: rap: Check role before sending CS Sec Enable cmd
Date: Tue,  9 Jun 2026 21:15:01 +0530
Message-Id: <20260609154502.3430147-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609154502.3430147-1-naga.akella@oss.qualcomm.com>
References: <20260609154502.3430147-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IPOXotgz9DddZclnvj1wi1qqZT5h0kr0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0OSBTYWx0ZWRfX6jI6hE86iMpV
 8Fviv4SiSm1AfDOsvimEGWAl4+yP+UzWq+rvOquA1g93MiC9YPLmZdqV3rIBDiB6SkVyRHoVNuy
 JAphUHWakUTAChl1bPgmNzVVwyNkzP6weSH6vzIRfZPzI4E58P6laskhYOBsz86Xrpv1CYouegW
 7iuHgvXdo2XdyFRgHAiUdY41LZFnpqdZZyIaK9a69wygzkRkBEA5HKSVZNs29wD3EEZ92mw6SEo
 XbdRHPtcnWxJdqj/xKYtF2xIKHoVLqrNFio641R6PmHgl5Pz+6XkpgmyrVnVV6MrzhkZ8Vn12+s
 hwgyRPzljDv2E1BlG+gnBOSwjb2I/jwJLCvHeVYL/Fc0hSgzJ78d9+zqj+Pd7X7pmxtjavwNb0a
 1zeMH8IEiDZbBDRe9gjbLpXbaMgSoJfv0h7WgEaNV2whMNb7Tx7Rt8vWrorLgFXkezn+CMa59Q8
 wjrD2p1KEzh8/kNpClQ==
X-Authority-Analysis: v=2.4 cv=NKPlPU6g c=1 sm=1 tr=0 ts=6a28350c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=9WorQFKdWhnm8Ds_4BAA:9
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: IPOXotgz9DddZclnvj1wi1qqZT5h0kr0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090149

Add the is_central parameter to verify whether
the local role is central before sending
the HCI CS Security Enable command.
---
 src/shared/rap.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/rap.h b/src/shared/rap.h
index d3ced61b1..8b4f47757 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -213,5 +213,6 @@ void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm);
 
 /* Connection handle mapping functions */
 bool bt_rap_set_conn_handle(void *hci_sm, struct bt_rap *rap, uint16_t handle,
-				const uint8_t *bdaddr, uint8_t bdaddr_type);
+			const uint8_t *bdaddr, uint8_t bdaddr_type,
+			bool is_central);
 void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle);
-- 

