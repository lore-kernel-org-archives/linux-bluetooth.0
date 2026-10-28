Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793186330;
	b=pCf9uhhAWDCJGmILe7L4HWSFBVUhZRldWlQqag//CjREX6eaiT8nVt/dwjisGwN0NubW
	 368IESlai3y26pOLgqFaZQMeVZ0vlFHZSgS4+l8DR/VFb5CK4FOfV0Ib4PmbY5OZu94ob
	 wCafJ6WqDTcrDLvkAbLplTY2yYcPMKb9zVPBux6VLrPE5Jfc/KSFYyXpaD9TrCopestbp
	 TAb+ydCwYWdC4mWdnp2djRFcwsDFJ8me12XqkRQCWGF1Sf0vJpQZbSTNY6nO3Sm4oMwUi
	 sbTjX1jFEO0wwSLx8FlZUsMZCJ+XIJiZ0s2IcCq2vIxw1ouNqK7ZsRiOQEpXB9yTNjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186330;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7EpvSXca8rM2k8J3ZZT8+kGftyppNh/b/NiNwaPRO80=;
	b=Q443b62jTJmH8VdlSc2cxVD48zMHL1GlxizbGMIYEGjcUeWAAt6QyrjcunGqvvqjCOaz
	 zv8dkeV3VlzL99q4tqN0D2Nj0UD5yNHkUqeKbdoaOilVZEypbjgwTkZx4bT04Y3WEdfxJ
	 6XfHU1eqiuy9tnj6Yl4FR9cobLNlE95y0KyPUIZu727F8KmmJNYOPOlHA5XXoXu07Td31
	 /HsO7TSzUmp6CZiRR+S251gmD2XNeLhJqfnYVJ9KXfjD/p1nHYYwAWuTjWv1/oVtQteqA
	 fr57TmtM3QJTx6bnHT/lmK2uHSu7HDnl3wE4ghwLdeqPrWXsEei7oVhSNu+C78mGqLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=URe3llAH;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE660606A322;
	Wed, 28 Oct 2026 11:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE660606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=URe3llAH
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8K6Je1167788;
	Wed, 28 Oct 2026 11:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=7EpvSXca8rM2k8J3ZZT8+kGftyppNh/b/Ni
	NwaPRO80=; b=URe3llAHAtOKcnrakN4fmqiwacjSP9NwZxvcn+UxwAt1UkT8u8a
	eiVRDWajTzOSEuqMVfLkAkc8OezDlrNgqXZ7SXh268LbqIGUqWRq1Ap3vtl7AbvL
	P7bg1HyTad6cpPdnzY0jhknNOhsOHMt2IxJEClBLgU8HOD2WKWYziCwYJ1rE3N5Z
	BWDDXIOJXputeBcnmlq4u5jkhQEXT31nTlDPSSV2lwqv4DU0qa9J6Ss9wiV9jjaV
	h7mDda4JNVIJ4nZZ/pus3rnR6hJusaadlduZZfdPMGwlQockPQgeIbPGJLoEjafR
	rjI5cGYPD78LtTP01wrgD0ur6kCAcmbXffg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk7g7hwcj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 11:18:44 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBIgqV3255744;
	Wed, 28 Oct 2026 11:18:42 GMT
Received: from shuaz-gv.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 69SBIfjT3255737
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 11:18:41 +0000 (GMT)
Received: by shuaz-gv.ap.qualcomm.com (Postfix, from userid 4467449)
	id B5F2C63C; Wed, 28 Oct 2026 19:18:40 +0800 (CST)
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, chejiang@qti.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Subject: [PATCH v3 0/2] Bluetooth: hci_qca: Reopen port after power on for QCA2066
Date: Wed, 28 Oct 2026 19:18:37 +0800
Message-Id: <20261028111839.2148515-1-shuai.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0NCBTYWx0ZWRfX7aSYCT3J6AdM
 aV+p9dy72KFcn12iZmN6o3qjtdvW6IRIzU+oTCX7TWRWyjypy+bjx3fGMNYvZG8LxJB8b32e3jT
 0aJm59yJ+qi3QC3TArXDs5t6f8J8hyU=
X-Authority-Analysis: v=2.4 cv=SoIFe/O0 c=1 sm=1 tr=0 ts=6ae1da14 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=m7elg7v7XPzLZVMeLoEA:9
X-Proofpoint-GUID: Lqj9mR8Ebv-BPtPzUnml0-q0GjD8Zti9
X-Proofpoint-ORIG-GUID: Lqj9mR8Ebv-BPtPzUnml0-q0GjD8Zti9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0NCBTYWx0ZWRfX2qCCu5uie02V
 EsYzIyJ7NGyIs6ztlGmdEAqfRqjpBYBKP5TW5An0tdX0tj2Swjeemi1Tpvdd1jxFNp1e8XaGuaT
 A5dOXV+JZT2uVmnBQFHW2L6JEtYI6uM20A3GFHbY1RAU6IFGYjE+vNPY4rz81b+TuY80wH7MfcG
 BkGgbor3NQr3LOyU8aNhjFnt7L0Trfg6XsSkSL4AYUNJK1DoDZPNwzMY3HHq2380hAXeUtqihLm
 615c3XODAluPqyjf1pNLF9W6DNQThpDr9QEVWh1ZhiZGW30tBCCu+P3io7eLDeJ6wlnrAu06pde
 WuCNjXNJbs1zWoKEwQzQToa1NYsecHwJiXMLlyEnkbWVhos6doS+j/RUE+aBfHxVKNoM0m3ktL7
 wwCaWcjqPdI5KDSJ06KAOefOo1qVsU6w0waGSMJQKYNVX1MUNpiPDDfghv4gEGTugX7ZLO9XHn2
 Zf7+QSzmwKZWpjROTzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280044

QCA2066 needs the serial port reopened after the controller is powered
on, otherwise the host and the controller run into RTS/CTS
synchronization issues.

Patch 1 reopens the port in qca_power_on() for QCA2066, as in v2.

Patch 2 keeps HCI_UART_PROTO_READY in sync with the port state, so that a
port which failed to reopen is not closed or flushed again.

Changes in v3:
 - Patch 1 is unchanged from v2.
 - Add patch 2. If serdev_device_open() fails during the reopen, the
   port stays closed but HCI_UART_PROTO_READY stays set, so the later
   serdev_device_close() and hci_uart_flush() use a closed port. Keep
   the flag in sync with the port state and skip the port flush when
   the port is not open.
 - Link to v2:
   https://lore.kernel.org/all/20261016022302.4003647-1-shuai.zhang@oss.qualcomm.com/

Changes in v2:
 - Use a separate case for clearer logic.
 - Link to v1:
   https://lore.kernel.org/all/20261015092224.262158-1-shuai.zhang@oss.qualcomm.com/

Shuai Zhang (2):
  Bluetooth: hci_qca: Reopen port after power on for QCA2066
  Bluetooth: hci_qca: Don't use the serdev port after a failed reopen

 drivers/bluetooth/hci_qca.c    | 46 +++++++++++++++++++++++++++++-----
 drivers/bluetooth/hci_serdev.c |  6 +++--
 2 files changed, 44 insertions(+), 8 deletions(-)

-- 
2.34.1

