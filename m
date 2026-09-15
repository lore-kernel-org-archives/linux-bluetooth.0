Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B163F4118
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 05:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789450871; cv=none; b=F9uupEv710fBJqMCPJ14W/GG+PEmpiu9QY1PGB0/ZaCe3SchXFjbHHHi6yXWWGAcNUIHcWnqPMBiQXIwp5H62KFVntgqDlNpuRjfCdHdTluMvH+jp0UR+Zx2Xcz8VbXQ5B/HVRZQsT9c04XHKPT0EfMXi9yxlnjG0VRruoGNsnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789450871; c=relaxed/simple;
	bh=JpO4JBE1VNxT+lBQjWYB0XPRrR/gMl2Dly0MPBZmz+c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N69w9mTdYfEeMh0B/SJYF2xTzrAgSkR+dBBLSXL51/xwo9UfeU5qgCj9uetiSot27dSn8vx6DKdrOUqPmaLadwyJgffJsQVkNr5cZqhZEq7w2GY1h+UBxMyYUnCh5QZBts2Gqne15Qy4Tufaf3cXUgphIRWyinwWl8VIKmHEZIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZeQoQz7X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D5U7X3TA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZeQoQz7X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D5U7X3TA"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F2nSYR2992681
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 05:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2KABN47JNikjdc7PIx0sNg
	UCf68WcstqIF1Q/UcAcbY=; b=ZeQoQz7XHja5/7/tPpDKVRJ/NfU2VzPSzjq4N8
	dZckksdX95zbuEFvsJkiKCT8G2hhACxKZ0ShZG8N8OEYfM7tay8u4szgjfhpNq6s
	svjEuSthPTbZ/WqNkSQ4d2PZPL9rMRlie9NCfyaOrarPUB8R5keja79JTjx0/IjD
	SHA1mv9ViXzW9LOuVwm+PWhaYsl91+rIDtGXMrWUvWS2P2mdHdvSj1vzsVWYI4jO
	54ZX1LHapDDJV+VK4Cbn3W0ZWxXHeFQhCWpS4DHW6ZTVBHWzwqUuj7hrHgT7niQG
	ClPMHMQScUAeeOBNUxEwg+vUocI+1cg7I+oizY8WqK376mgw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpdevvgtk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 05:41:08 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3989c51d5daso1123002a91.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 22:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789450867; x=1790055667; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2KABN47JNikjdc7PIx0sNgUCf68WcstqIF1Q/UcAcbY=;
        b=D5U7X3TAqubyZzfy/r2TTcwr1XSihXR3GjTvborA+RXhFzLefEUEvR3BKL6CpMBA0a
         BKXcG603B3VNrhLI+7LU3cW3QeJYWr6dP6iO64IDs/Q8LBOuh1OaPwDwJEo7xJiANcX/
         BgMzi0gv//UT3PQde6baPfYTufYUkBaHgrCAVKYa90l+QRvh9DOEFEhaa5w4pXfARub0
         sV68bWm/O5X627lRY40pspPKkoKzITJumaZ5goGwyxciOG5RBGhzbOau1S6LQhx9w+GF
         WNtB5vmaEHUWY6S2a6V6g7CqGLgp5Z+wnmpMUKThUuyOLZGJyAXO+5EGJBQRwVauBw3a
         OjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789450867; x=1790055667;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2KABN47JNikjdc7PIx0sNgUCf68WcstqIF1Q/UcAcbY=;
        b=S3N8GpwilLGwTKuaRIFEzdMQ83gZMTK/yivfE/Q9a3KpiO6DaznbIalo20CbYzcjLc
         0Mz5OrqFTFsOMkj0JmHy4XDCEATf/pjSisLJRQAjtXTEPtNTsgadELoh47w3BOtVj9pP
         IPeYmD/2EbhDXcgBBso+K5ckQqPsKyLEr2Vb94I2qLi6qEmzBTxiwEKT0ILTPD+IWRTx
         +2FXUp0GjHcPKRZaSbTt0pEXIDmhCGlrd68tER4bRdqqPH5cYgYSdbgiKGRle8rNKrH5
         qk9RwS3Xx/6f6KEuyVG50GQNm+rPpL+MGM8MkohEhGADm2LbyrsWZW8NUJ+RdByhZjOj
         Y/FA==
X-Forwarded-Encrypted: i=1; AKwUvBzGM7lkYF3zbsvFKkSt/7xu01lKzvXBSqveG7VZYqqhfQSZBN8b6eNWHu8iWm0uShFOnNbgxeqfKs1MlkYi0Co=@vger.kernel.org
X-Gm-Message-State: AFuF++nm2tHs567BqSFW1kp/HZBduyQslse/CBYstT+uGX+lBkLsSaN6
	NRJho5GEpExQwAvQVNmz8piM4xZuPpAvNMv+VLbsMnzta358H0A/N3L1x/2rBzww+r+/GpnxKUi
	I8YKF5BNl7hCbavpzDEqP7eKZzlDg4hHkE+KUgEQVYpy3pA7slWHtKBJdjckcfNOZTcmSwc8=
X-Gm-Gg: AYBFou1AV21N8mJeKUCGsnV+Xa1qNL+m93zUGJawYT2VzjBiEOS1wQdnmwb2Jx7vsrs
	aC2DqLKXstH3Ysij6M88/ldwACd/ChqHyNDvIFJ1QbuUOzpv3FNLgpk8XTiVY3oWPcg5NfLzC3V
	e57Bopi0OTdGoFzPDIcm0aoFvTg47lZ+fabIMrLCSXlKQavJAOJql1+d/VyLSVm58AfQhh2fGHF
	RPCikYM1y4KKKaE+Qf6TWuwfaBjROnRtyi3dZPiDV//t2rNb673gNpKpLOBTwaamIRNXsWH/kmf
	Tt2L8Y+kfEOofme4tg5tDOdHE7PQ43ahlduOLM9DL9JGfFznAIIvFOWf9Oz8NFJ+wX1ke1c/RYF
	4GfphbOY0MB30RiJlQnmuYBn6BOhNZ6RyTpH30Q12UUvs5P0=
X-Received: by 2002:a17:90b:538c:b0:39e:b7:cbee with SMTP id 98e67ed59e1d1-39e00b7d2d5mr2590269a91.6.1789450867550;
        Mon, 14 Sep 2026 22:41:07 -0700 (PDT)
X-Received: by 2002:a17:90b:538c:b0:39e:b7:cbee with SMTP id 98e67ed59e1d1-39e00b7d2d5mr2590247a91.6.1789450867005;
        Mon, 14 Sep 2026 22:41:07 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14390c0be29sm1589960c88.9.2026.09.14.22.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 22:41:06 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH v2 0/2] Bluetooth: btnxpuart: Simplify ACL handling and fix
 skb leak
Date: Mon, 14 Sep 2026 22:40:50 -0700
Message-Id: <20260914-misc_fix-v2-0-6178d838c946@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGLaqGoC/22NQQ6CMBBFr0JmbUlbbQOuvIchBupUxgjVDhAN4
 e4W3Lr5yZu8+X8GxkjIcMxmiDgRU+gT6F0Grq37Gwq6JgYttZWl2ouO2F08vYX11htVeLSNgaQ
 /I6bzVnWufsxjc0c3rP+r0RIPIX62rUmt3p/aSQkpjCmcwoPURVOeAnP+GuuHC12Xp4BqWZYvy
 JGT0LkAAAA=
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
X-Proofpoint-ORIG-GUID: ec0g0rqhzRBXio8KjU-4PfbqjPPKgh2e
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDA3OSBTYWx0ZWRfX5dDBdlxg7Mio
 QUDOTEk3EKL9S3fSriY3VqjuPU+ASYGNYykL9rJ3YAAW6hlckyKE0Ip6VgRBzKDcR4SkD+kGGQB
 r9aC97zTKOiDaw6BvUclA16B0o0/5Vs=
X-Proofpoint-GUID: ec0g0rqhzRBXio8KjU-4PfbqjPPKgh2e
X-Authority-Analysis: v=2.4 cv=ftpJ914f c=1 sm=1 tr=0 ts=6aa8da74 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=jqfNI8RexKxqlRSoiHwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDA3OSBTYWx0ZWRfX+cMrwuT8c6yq
 BT2d1l/oTsO0g9YSlJXFKf45TOhWG0QC4QvqG4TyPMwEoKTOrlLCao42ZETXEnPo40V69WqjPoy
 COm1GuREardgjoQY7DCIhDB5TQx5UowEh5Vt/Sm2BEDqLud8RXNWbEP9IMxiJwUfWYzEqAPlRLr
 twfNUyOLPrzLLm1ItF9HU9GHORbnpGvu7JVBy2wbgP9VNVIKC+BEAmJqcS0bSuNLg3My1RdJBl6
 pBCm0NNxdEaJ3M515r3rdQGH0QIN5+XPA0+RHNUBT2rl/XESo3iquqLYq3DuKHn2RekQ7oWBgbR
 jgIhcT0VJ65rVnYKjpWWLwAIBwfekCIQHhlQPRsz8YQSkbrcvS8Rfs4gQorTfxB4xoUP+VgH924
 bMVfnYcMPbMEcEgymT2qynvTWLJ/TNo8HvQJzRhBBshc7xnwLKv2VC8BGKd4Kev6clZtV4LuIXv
 M/vnilxoXJNMmyLCqhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_01,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150079

This series simplifies ACL handle extraction in btnxpuart and fixes
an skb leak when devcoredump support is disabled, — all simple.

---
Changes in v2:
- Add a minor ACL handle-extraction simplification in btnxpuart.
- Fix the skb leak in btnxpuart when devcoredump support is disabled.
- Link to v1: https://patch.msgid.link/20260913-misc_fix-v1-0-558c1e4028b9@oss.qualcomm.com

---
Zijun Hu (2):
      Bluetooth: btnxpuart: Simplify nxp_recv_acl_pkt() by hci_acl_handle()
      Bluetooth: btnxpuart: Fix skb leak in nxp_process_fw_dump()

 drivers/bluetooth/btnxpuart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 0186e4e1e5c26a21058a263cccd878fbf894677e
change-id: 20260913-misc_fix-6f6f518fe6b5

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

