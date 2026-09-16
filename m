Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8C4353A81
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 02:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789525057; cv=none; b=BbwCRPFwEXZ8XDuWMwyjG4wy83XCMZaKTny6oVYk5PBaitzaoCsQcCuN0C/oQc9Dc0wUrjjM2LQsSHviKX/pwP4QX04YGFNEefyi0FEz3o4ecl+miFe2LLb8u6n5u/hreeb8mm+WSGWMe0c+GcDWVstoOA9HACkfbhqEmVn1wRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789525057; c=relaxed/simple;
	bh=iof1zXb002NaOqoYzc+ExFqbyMk3w5l7UWEzjQfpIEw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r5Svw/pqDfDhn9iyO9bIG83ukbMWsP+EW4IW0wvZ3dixCJJA/+IwEQSr+PMe3UJc36XAO0fBO2TRokjVpHxekSaYZ8E50pD6qm5bQy4LciBvSz5slG4BT9TVz4Nx945EnIo8ManB4DGrdC4DnPwHL/3eOP8/mxq5bSOMK4spqlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ma6aZsWR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AEXfMr8R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ma6aZsWR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AEXfMr8R"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLZXKQ621056
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 02:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=dTwXA+ejGEJMiIPB+/n8Ge
	EfGidhGnX195FHDBlCMQ4=; b=Ma6aZsWR7CSX5RjGin0h1tUoyhDIW8PEM+r+zO
	aBTBIM27+C0AUbwKFCZzoiL5IruuWpWgWOhRfnI/qNZ/55dzREhYJhZ1L3O/GUyu
	jwktNCASxHpEmmquBox+RmbdNNlGtjkxUXMNv4gIbQxy6GZTK0SxwLDMcOJz2kBj
	RU+z6sfKaN6sJVRE9VJxm/veiOdb7FMef/UikfaPJ5GPBKOVrzC6hh4OsltFAhS8
	xIeY2FPbWPnY6sbETDpRhdK7fcyxRxiNQyoIE0jhIjzB2ck3KsNltGKrP2qhDE7z
	op6CqXWBeFDxRuL70+Dli2kWP+s4hX5qZOfIL7mO3fv0z0Rg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq2y2m886-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 02:17:32 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1cb9b67bcso264497a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 19:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789525051; x=1790129851; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dTwXA+ejGEJMiIPB+/n8GeEfGidhGnX195FHDBlCMQ4=;
        b=AEXfMr8RoO88wd7FrPEy+w/3nS6fZ+zkrhIF7td8fevDlEilYlPwmJdF1A/bdH82CO
         PZDcPJBQHwb22TgMxAyikJaHtMg4DDrOtRmUwyx5GHhLbzpjNg5NiZtjRxggYNcFiyux
         lMnBLJtziKokxcPBGN/NRNe2jHlosmjTGR641dQpj9U4mtJZbOJ9L4BHx2wAUH2zEafP
         u8f6o1fD+g3qzZy32dM9ELWWcbPd4pensP5hTpZuh+EZ3oQFoT/BP1oX1MqHq8Loovgu
         Qs3bIRwKo71WKlr772nTPcvIO0J7F5ENMimyReno9T6Z44/rOPyBeJgSB1QEm2HHtlF6
         kobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789525051; x=1790129851;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dTwXA+ejGEJMiIPB+/n8GeEfGidhGnX195FHDBlCMQ4=;
        b=McWdlBdi/b3t2Kstu7QcIYHPjeZsfHXvPuDJ40EiVSk94vJ8uepNdpZUMiK7kvDsj8
         QPD5+LbsrX6yd8DeosxhMKeTQJnq5xGs1Zq8PbwYii4aKBJaIz5gnP6xk0J4t3m0Ec/O
         ArnoMGg/V4LjHQU0ZoY+CZX9jbBPR1bD1YkP969Y7qJ9+btMfXCgMNwSIyNXUd2NS45y
         /8l/OnQWFkVunJ1wl8UJi+Ldy2I0sA/kIMOYpuCZA0sqTgFhxA+llSV4K41yvgmst8iQ
         zqeBJNIYAupwUzj+k6u78w6V+X3+KkgPhwb66bRLyqaVZPP4wcpCdIJjN1E4/X2ZupH2
         XIqA==
X-Forwarded-Encrypted: i=1; AKwUvBzgfxpQVi+939ji3Xy6bIY8dF08biova3WMmkGEsoKoRaaLBjpVw2GWb233Qn3Q6D7gdhUMHdtJ713l51dj0zU=@vger.kernel.org
X-Gm-Message-State: AFuF++nNOggmOuyFLKaUgRszgfV7XDWCzZNs64XoEqhOiR5znRmZfp/Z
	BcDFID6NsOAiayDDfXiDtMIsc+tLYu+yXHRKDOBDN70uCH/eMgmEd1o2H8Z+PRoM/RQQHmxmn/0
	EjT3bTHUUMm57WheHqrieQ8JWjzcJ37dM8z8sVEbsmgkSPcuU49osfl2xoSt/E8p76zW58pM=
X-Gm-Gg: AYBFou1dVeK+rgdNPUqcFc+kJa+evMtC+UTKADP1QTdSzqDUdM1+ohWsip3OjFD6nDe
	Acqnb8Jl8mfb3gYWGceNmhAIXmLzucIqeFvCHM/FT55YuPUp7smbjR7JnHPh7WO4A6HJlZOHVOv
	UTBEwhYnTn+oz7dNOK554WYiglhJOnZyoisBkTOAZbh3/Tw/T/o0c1znYMutE4GQrJ/zhrIpJSa
	Tcb1jtacnXvNmMc9VYt0XMXMCHd9YwZzjKwW/vbVAqWDdAV6wYTqiXOku2AYhPf9evQhC1Z1eLe
	euXZmhA38kmDn+/1cVjpnl++l5u6HM5dzR14FQlvKsRk50BgbTmt/XJJoxGGGmynv3hjENyOPqG
	9DlqXfH4mzQX5h3pvw7tNzutWteQ32zc9XKI1xlYX47o3WzM=
X-Received: by 2002:a17:90b:1e0d:b0:39e:261:4e13 with SMTP id 98e67ed59e1d1-39e22510289mr576174a91.3.1789525051462;
        Tue, 15 Sep 2026 19:17:31 -0700 (PDT)
X-Received: by 2002:a17:90b:1e0d:b0:39e:261:4e13 with SMTP id 98e67ed59e1d1-39e22510289mr576140a91.3.1789525051042;
        Tue, 15 Sep 2026 19:17:31 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5ad9ed5sm3200332eec.22.2026.09.15.19.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 19:17:30 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH v3 0/2] Bluetooth: btnxpuart: Simplify ACL handling and fix
 skb leak
Date: Tue, 15 Sep 2026 19:17:16 -0700
Message-Id: <20260915-misc_fix-v3-0-31fab8976ac1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACz8qWoC/22NQQ6DIBBFr2JYFwMoFLvqPZqmUYRKU6VllLQx3
 r1gNy7cTPJ/3vszI9DeakCnbEZeBwvWDTEUhwyprh7uGts2ZsQIE6SiBe4tqJuxHyyMMJxKo0X
 DUcRfXsd6nbpc/xmm5qHVmPxEdBZG57/rr0ATtzMbKCaYc6moLgmTTXV2APl7qp/K9X0eD0rrg
 W39cuOz6At6lK0spKpKseMvy/IDFWa6VfkAAAA=
X-Change-ID: 20260913-misc_fix-6f6f518fe6b5
To: Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Neeraj Kale <neeraj.sanjaykale@nxp.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: dd7aic_TwnBrOEMhN4OiK8V6y5izOYed
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDAyOSBTYWx0ZWRfX7WO1MFVGBYgc
 hMLk8L0++dTvnLFtFx40Kp3uvJfV/Zi7aopDCcZe11Gpjdct63LQN8QTtyVOManA5omLJS0tIMQ
 86/O/CZiF8nKLHwzIJo/t5wJQIDf0IBACLqTVgLeG0grA5tspU1fdusT28xpoQutcgvUsMklL7S
 vCaxDAg0cmtiJWgK1+NtHfFSok8+CvyMA8gg57SajlREibdrba6l7Q5tviSJ2mKtFIbz9xk53w6
 gGSG5d6W+BGWZbXGLkqQClb5e+tkTg96C9HuwvJrtCQdT5uTThRcYvfp61AjOMftd0h1yTZh5NU
 9IzBeHhStrcRbEVgpDA/0zGwdvVhs3/FhGiOSiG8YL3bXQz9Zh1AmrxXCkGUAy+zM9ea+HGrXZK
 d+fnrhUnOoVedYrt0r2jT4/NBX/UL28uG//GYydwT2fKGJm9klvCPneUKzW32f/SulqplaO40JR
 PiGdT2g/Xg+jy8iDhXQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDAyOSBTYWx0ZWRfXx2QOjPUnY9iA
 v/UBDiFsqQNzELWBEEodmOvYxeMoIAr3Fp/2dpafyHvdS8oKERoXygm3KXLaKyf6gDzEW8HAdXE
 rz60ReD7da3NsggeJUq6b9h882Z2MOo=
X-Proofpoint-GUID: dd7aic_TwnBrOEMhN4OiK8V6y5izOYed
X-Authority-Analysis: v=2.4 cv=IcISymqa c=1 sm=1 tr=0 ts=6aa9fc3c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=jqfNI8RexKxqlRSoiHwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160029

This series simplifies ACL handle extraction in btnxpuart and fixes
an skb leak when devcoredump support is disabled, — all simple.

---
Changes in v3:
- Use IS_ENABLED(CONFIG_DEV_COREDUMP) instead of #ifdef, per Luiz.
- Link to v2: https://patch.msgid.link/20260914-misc_fix-v2-0-6178d838c946@oss.qualcomm.com

Changes in v2:
- Add a minor ACL handle-extraction simplification in btnxpuart.
- Fix the skb leak in btnxpuart when devcoredump support is disabled.
- Link to v1: https://patch.msgid.link/20260913-misc_fix-v1-0-558c1e4028b9@oss.qualcomm.com

---
Zijun Hu (2):
      Bluetooth: btnxpuart: Simplify nxp_recv_acl_pkt() by hci_acl_handle()
      Bluetooth: btnxpuart: Fix skb leak in nxp_process_fw_dump()

 drivers/bluetooth/btnxpuart.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
---
base-commit: 2e63b55654e0ea35cbc4fae20244026718f56755
change-id: 20260913-misc_fix-6f6f518fe6b5

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

