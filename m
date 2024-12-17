Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C9B1F37BF;
	Tue, 17 Dec 2024 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445516; cv=none; b=neAodUhPLGtT9Sp/Sg6TVMCcZSwv1aUfZa2HB/bCfu7+WU/EOhdRNAsZylxWltuhBtKcyhVwljgQKHdWgWnWfy9j/BLEyayhQDC0GmGkAWgqU56QrJbXcPFbph3flSxZ6cPp0HItFrocTkjhq6EGsyQpkgAmK9/xas6WUG18o+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445516; c=relaxed/simple;
	bh=mzqy8jSGA9jiMASN8KJPpPw53S/rBRrnUaRXOATicRg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TKZy4Q+PCUYWOwZ4Rp7zjZvlw++FrCDChxnV+1s5PYMHKTyh3YMFaGKivxthD5BYFd94juLSryivpISuyKzwyuQbhN6gZsX9+ZJRQzM7u5p+Og6O0BId+lbN9vEZUznWw87plVqeIaHsieFA1T+ffaN9T+arO1QS+XewzWd4ou4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ExeALter; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ExeALter"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHAldw4025596;
	Tue, 17 Dec 2024 14:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PjFvU3DAQKea7VV+uu437A
	HW4cM6vqDCYwSVIfgnL5s=; b=ExeALterstVd24BxAoUTuH5U3V05ctqeXKhEmd
	J3yL0Gfkn+HsPyOUxJ1N3BKSbtza37IsDw6JvP0kLfFEpZ64Z8jsiN97jKtDkCYn
	LMBd63kFUFCmq4ggRGohtLMYAiYGuaORZKOQ9GS0m+FipHnWCZuglTmC3EHrcv/L
	OTHFUKoGj91ODR5dikING0U3ljoV1VuOyRvBQp4HGEOUL3ZHFkXISmINq3199pP0
	hCuuZrWwSn1Yj+0Xevn1AwnGseD/T7dgzqryCfa35AclRtYSYCSmWLz7N6FcQNno
	aL+JYXXpf51uxYCTfEZFjv6XbI3An14G2zf7ZNjLyhy6cg2A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43k7v08j3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 14:25:09 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BHEP8wr010889
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 14:25:08 GMT
Received: from chejiang-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Dec 2024 06:25:04 -0800
From: Cheng Jiang <quic_chejiang@quicinc.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Balakrishna
 Godavarthi" <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
CC: <linux-bluetooth@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_chejiang@quicinc.com>,
        <quic_jiaymao@quicinc.com>, <quic_shuaz@quicinc.com>,
        <quic_zijuhu@quicinc.com>, <quic_mohamull@quicinc.com>
Subject: [PATCH v6 0/3] Expand firmware-name property to load specific
Date: Tue, 17 Dec 2024 22:24:51 +0800
Message-ID: <20241217142454.614551-1-quic_chejiang@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: icKd9PaZALVILNU1XrkCDkeQFkfyOmVg
X-Proofpoint-ORIG-GUID: icKd9PaZALVILNU1XrkCDkeQFkfyOmVg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 bulkscore=0
 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170114

Expand the firmware-name property to specify the names of NVM and
rampatch firmware to load.

This update will support loading specific firmware (nvm and rampatch)
for certain chips, like the QCA6698 Bluetooth chip, which shares the
same IP core as the WCN6855 but has different RF components and RAM
sizes, requiring new firmware files.

Different connectivity boards may be attached to the same platform. For
example, QCA6698-based boards can support either a two-antenna or
three-antenna solution, both of which work on the sa8775p-ride platform.
Due to differences in connectivity boards and variations in RF
performance from different foundries, different NVM configurations are
used based on the board ID.

So In firmware-name, if the NVM file has an extension, the NVM file will
be used. Otherwise, the system will first try the .bNN (board ID) file,
and if that fails, it will fall back to the .bin file.

Possible configurations:
firmware-name = "QCA6698/hpnv21.bin", "QCA6698/hpbtfw21.tlv";
firmware-name = "QCA6698/hpnv21", "QCA6698/hpbtfw21.tlv";
firmware-name = "QCA6698/hpnv21.bin";

---
v6:
  - Pick up Acked-by Krzysztof Kozlowski for dt-bindings
  - Fix type error in btqca.c
  - Optimize the have-suffix function
  - Seperate the sa8775p-ride.dtsi change to another patch
  - Link to v5: https://lore.kernel.org/all/20241212150232.3823088-1-quic_chejiang@quicinc.com/

v5:
  - Update the dt-bindings decription.
  - Extract the have-suffix check code to a helper function.
  - Merge three generate nvm name functions to a signle function.
  - Link to v4: https://lore.kernel.org/all/20241210151636.2474809-1-quic_chejiang@quicinc.com/

v4:
  - Split nvm and rampatch changes to 2 commits.
  - Fix the dt_binding_check error.
  - Change the qca_get_alt_nvm_path return type from int to bool.
  - Fix the nvm name suffix check error when path has '.'.
  - Optimize the nvm file name generation function.
  - Link to v3: https://lore.kernel.org/all/20241205102213.1281865-1-quic_chejiang@quicinc.com/

v3:
  - Expand firmware-name property to specify the nvm and rampatch to
  load.
  - Change the driver to support two items in firmware-name and choose
  the NVM file according to board id if there is no extension in NVM
  file.
  - Update the dts file to idendify the firmware for QCA6698.
---


Cheng Jiang (3):
  dt-bindings: net: bluetooth: qca: Expand firmware-name property
  Bluetooth: qca: Update firmware-name to support board specific nvm
  Bluetooth: qca: Expand firmware-name to load specific rampatch

 .../net/bluetooth/qualcomm-bluetooth.yaml     |   5 +-
 drivers/bluetooth/btqca.c                     | 195 ++++++++++++------
 drivers/bluetooth/btqca.h                     |   5 +-
 drivers/bluetooth/hci_qca.c                   |  22 +-
 4 files changed, 152 insertions(+), 75 deletions(-)


base-commit: fdb298fa865b0136f7be842e6c2e6310dede421a
-- 
2.34.1

