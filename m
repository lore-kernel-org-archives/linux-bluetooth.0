Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B482E7165
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Aug 2026 06:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785652321; cv=none; b=UdU0qxFLNFJybsChv2nPMb30Bem34G+OJwMYuy5ba4BYHBBv31P9wwnADv2Fs/TWi3pC9FfYLEShtDscbgBW+QNMR+TlHzqFiTX3ZzPZiXWbPLM6lZFwG0qehFIVTHDIIjpE9rs/KWB0xSEyBz1vhHZe8glkfobHYYJrJ8icjK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785652321; c=relaxed/simple;
	bh=nxglMMafoZFugil5p29/NuY3dPtjtSvQkONrMk8WSec=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UUkWAVnF8ZWwBWiwgI9B9b8Z/lS9qd2s63OtO0RumUoCQtQphhdUGv36ON3aCRTY0qsNaI/fZZ7s0qbUMtCQs07p0KExvJipX0xpm0bnyd3M5QDE/tv8kV7ExFv0yI17s54bQdWMrDq81nF3+ulCEJYYaV6QG/07VjVca/rj7Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XknzoBtl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c9ZYXwZD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XknzoBtl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c9ZYXwZD"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6724aXbL691154
	for <linux-bluetooth@vger.kernel.org>; Sun, 2 Aug 2026 06:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XXDPWq+Bk1D5CMfL+NqyhU
	sK6Nl3So2Z9wtilDvG9hM=; b=XknzoBtl539zMmQH91W8BbCgZBHDNdiyNupGTu
	r+4KKBRyCYqvaO72Et5Jg+Wr7+pNYdWFaUDwlt7sFDzxL3+lIrNBPrhvNJIBf5/m
	EfSNT8EJtoAboN3jk/7+p7/ve3A0oglJ2SFB48QKDESx+n4DQWp2+0cO02fN/+0P
	e1kS4C82YTgAuV+eN+1P19tzejWmSZpisf7kyniRVFP9e2VFMXCnbi8LxJFmFVLs
	LaOnMR+5GZhxQJLB4X0EXdylYZa7GxC7BngIfGxXAabLCxN7KvPGp0cxLisQX0YN
	COqcqiuUndU7tOg7XCBgkiiqs2Xjvn5aE/Y0FWHBkEZOXgHw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8r6jdf2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 02 Aug 2026 06:31:58 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c888c687c21so233672a12.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Aug 2026 23:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785652317; x=1786257117; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XXDPWq+Bk1D5CMfL+NqyhUsK6Nl3So2Z9wtilDvG9hM=;
        b=c9ZYXwZDhfZ0fUVabaYih8v20CiMBgvYJFJdwazmwnAQmIj4YiRTV+kysxr2MXxK4X
         zgYwVoN09yL9lGEWTVRGifFduHgc/08tYLgr0M4GAdfcYkPg0iEjoVVriR56Y/3VPD6D
         Hy39gjHb9W1EVQ6mfkqwN4ptcF+Me3o76TIEbTvU5YzWS2dQhid6CAJMsieDi/Oo0Wsg
         xcETQisIMH9scIh26SlhxEsHTKiKucMo7qt8toibo2AoXLP2vxZ/DDU4QPsT52Fk9IBM
         AhHV7t4hE2KMhOUHBW1gnD2YzZCVhXXXCxjFTsfeXk37LmYqmcema3sK1F42g34Pml/I
         BkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785652317; x=1786257117;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XXDPWq+Bk1D5CMfL+NqyhUsK6Nl3So2Z9wtilDvG9hM=;
        b=cBTErX7d0mj7mU3K95pf9ANKHDSnfLv3NLSX8ey+MvImpfsrtn/OBOFXfUzsxdGxh/
         FbAARjUyQ78wMg/SrzmU6LPEkSnJJYPgoF/kTxRpvUkI1BnT0u5ZqFYofdwTGChpJfuG
         H8aD2v0qkyn4FrpJf88+UgHLA9On5R7oD4fyVurt8GSCOXvqzt/yaHL67yzOq6NW5Ncj
         1bntnJfbRNDVFfdry0aRXHy3p6l/VQmJp7T+nPh5oqvfwley6IG7JskoOjLn+awsz1UU
         fvcNTjKSFvGUjeNGv39B/Vz4aKSoiKz2YU44gF6tfSJvPtVQwp/cTReUBqDNtisy3lio
         5mnQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr11x+WMJGj/7c1cDM1IMIP9kj9jTl7yCOuZT9KHSr40Q9aRobQAI/m+YykgoLOedhqnhtkJmcuWvmCHZX1G/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj6lNwGTwXcLpXQcbyd99hukKJUzCJAq1N5lL61EQ55ai2TABj
	sdVU/QxVeF3BldPLZpYUNqpGBaYxkFFVzmlCFA9NFPTEaY0xc9L/8i7fL+z1eIVGcQ68CVd71Bc
	DybmWiqVt5ubOHOQAoRNkHliZmGjzTp1xiEFhqA5RZLYbJsCj4JGv25e54auEkhhxtXP+gehH9L
	fLkxE=
X-Gm-Gg: AR+sD13fHJ5HlU0iokIAM7BlTLaO8Qch3/xi6g5v8cK5xBeOmyIX+szmtZpHb+MbZWE
	1j3cqn4Uyp+8pO29YEBXCEF46HkKk/CtkzWbPcVXjPGISSwjO2t6OCeInwdnpzY4yKh9GqoKw6E
	aK7S3PK0paw69TfpEa+L7poO8FCK2WphnER3qVPSMIvLyL+iwO5qz1mlh55JWjgNvgOCSxdz5qC
	E6qROz1J5HvbOV29AsylsC6emG+KgYcXd3hCTu9+Ger/RyUm+Fi9IG75nlv6ZUNaXJoUk7dJenE
	LN88fQ6O4x5ZzrOkXDFDu6g/3USiDj/ZWx2M3qd2XbpJIFGYuFQhEB2GsklFcv2v8Fit3HsnnYI
	hmI1lLY5RD1FEe2gHVS091xj0JyZgnpdpdQlqiGwCH78jDwQ=
X-Received: by 2002:a17:90b:35c9:b0:38f:57f0:1f51 with SMTP id 98e67ed59e1d1-38fbc0a5ccemr7595390a91.0.1785652317154;
        Sat, 01 Aug 2026 23:31:57 -0700 (PDT)
X-Received: by 2002:a17:90b:35c9:b0:38f:57f0:1f51 with SMTP id 98e67ed59e1d1-38fbc0a5ccemr7595346a91.0.1785652316633;
        Sat, 01 Aug 2026 23:31:56 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c93dsm24233304eec.8.2026.08.01.23.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 23:31:55 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH v3 0/7] Bluetooth: Miscellaneous fixes and cleanups
Date: Sat, 01 Aug 2026 23:31:35 -0700
Message-Id: <20260801-generic_fix-v3-0-efdd8dcf3430@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEfkbmoC/23N0QrCIBQG4FcJr3Ooa9q66j0iQt3ZZrRZukkx9
 u7pImjQzYH/8J/vTMiDM+DRYTMhB8F4Y/sY8u0G6Vb2DWBTxYwYYZwItsMN9PFCX2rzxLymuaB
 ElQwkihd3B3G9aKfzJ/tRXUEPiUiN1vjButfyLtDU+8rFSg4UE5yTQoJmnEpaHq332WOUN227L
 osDpQeB/RJiTbBIyEKoSu2p1Fz8IeZ5fgNnGznmAgEAAA==
X-Change-ID: 20260724-generic_fix-6f13710b92ea
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Neeraj Kale <neeraj.sanjaykale@nxp.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDA1MCBTYWx0ZWRfXxKQWkNCrc1S9
 rdHZED2ufqkOFXmL1yDw2j/mC+GlHZ0MTs2gEVIew3+y0KSzMxxgJbvsAYU0UxY2ywVav/P82im
 aO4jWhLnsvkpBFvb0F47w8ScVvQhBVs=
X-Proofpoint-GUID: -ybwrfPgOp9sTCVjS5tzOlUZsJksIW9_
X-Proofpoint-ORIG-GUID: -ybwrfPgOp9sTCVjS5tzOlUZsJksIW9_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDA1MCBTYWx0ZWRfX44vc1lQkh3B/
 vYlJSj0iMqmTBTUnDxYIDzuZDjAvXb09w/D7u98s2JdE3MsjRXnYde9B7hRG1+D0Jn4+/z79ZFu
 O7d5EdStKhX7gsDR2aSfF24dzEPgpD79Z16PEEvddu3AOS3V/D19lb4w3w0jOaOueDg2pkOiRdP
 zV6QIMUijtGa5/X4LLJcJ9ykWKmSCJylwpub/oKeMeXcvRTl/BDfGXQl5A0NXKySRiXcjo20IpM
 pVzM0W8gEzJCwih9QcPR3OP/5prPI8rfrBvCJY4A5k0H4J7T5sd1LYvnl6MEGorSTsbgrr6Xk/g
 3Dazq8io5jJktSvRvwrRtOIVxqZtel3nTFXEmZgPwjs1FiM5FTXbAJNpwsYAvtbZy8ial7Tvs7s
 gIplhKza77TAPpHmrvN3kf0KwRWw1zskCPL9FrskpeE71fD5VXo9iY0mfITxeskH/gq7yHoHtaT
 amwsj6QedqTYYD03JsQ==
X-Authority-Analysis: v=2.4 cv=Q5ziJY2a c=1 sm=1 tr=0 ts=6a6ee45e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=D7qAKwe3XlSyvODc5mcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608020050

This series has bug fixes, cleanups, a new helper, and a new hook for
transport drivers — all simple.

---
Changes in v3:
- Append 4 more simple commits.
- Link to v2: https://patch.msgid.link/20260727-generic_fix-v2-0-a57bdb81ac67@oss.qualcomm.com

Changes in v2:
- Rework patch 1: guard with (@len + 1) against skb->len, per Luiz.
- Add two more btintel/coredump cleanups.
- Drop "hci_core: Don't treat HCI_DRV_PKT/HCI_DIAG_PKT as unknown type".
- Link to v1: https://patch.msgid.link/20260725-generic_fix-v1-0-305aec261a19@oss.qualcomm.com

---
Zijun Hu (7):
      Bluetooth: btintel: Fix diagnostics event detection
      Bluetooth: btintel: Remove redundant (hdr->plen > 0) in btintel_recv_event()
      Bluetooth: coredump: Expose header size and end marker to drivers
      Bluetooth: hci_core: Introduce __hci_reset_dev() with a hardware error code
      Bluetooth: btnxpuart: Simplify nxp_set_ind_reset() by __hci_reset_dev()
      Bluetooth: hci_event: Introduce handle_ev_vendor() for HCI_EV_VENDOR
      Bluetooth: hci_event: Use 255 as max event payload length in hci_ev_table[]

 drivers/bluetooth/btintel.c      |  5 ++---
 drivers/bluetooth/btnxpuart.c    | 14 +-------------
 include/net/bluetooth/coredump.h |  7 +++++++
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h | 10 +++++++++-
 net/bluetooth/coredump.c         |  7 ++-----
 net/bluetooth/hci_core.c         |  6 +++---
 net/bluetooth/hci_event.c        | 22 +++++++++++++++-------
 8 files changed, 40 insertions(+), 32 deletions(-)
---
base-commit: d264c90ca22e2034ef46b1831d38b1f47af44380
change-id: 20260724-generic_fix-6f13710b92ea

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

