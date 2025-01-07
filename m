Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809B7647;
	Tue,  7 Jan 2025 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736242025; cv=none; b=V6feo4K5yKmgTahyE6rHyXh4xVIu6VKAuKH+8FZmNMra7D/F8WciPxmlQdyncdEufZtZ4c037fjZDPzX6A652xTTKCrmOMNpmzHQzRXlkll5JLiFop1a1G/rGYhuy83k08lZWKb9kc8w89cgQI3kCOL0nDruBlZWb9+mnTRTybM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736242025; c=relaxed/simple;
	bh=mzqy8jSGA9jiMASN8KJPpPw53S/rBRrnUaRXOATicRg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CVSug3efE8kD9NANfO3udC0VxdYG77+OtTmffdLwCSElaWpJdssGqu1eh906ax14ALXZC18DIVqZzt1wvLlsoxgTrg4PHTJ2mkqT2DMULMTkN0mjVGN74IvAx26xgPrdk1GWDcRSpC5xS7mbptMCWRujt6MSE+WqJNATJIlBH0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y9JJA4Vn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y9JJA4Vn"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5073xfbs013187;
	Tue, 7 Jan 2025 09:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=PjFvU3DAQKea7VV+uu437AHW4cM6vqDCYwS
	VIfgnL5s=; b=Y9JJA4VnORnsOn3K96qQCx6pS+PIIxdGvG5Q9eTOJZZYZfHHrDl
	IFAivXv60gDBm8W27UihdorIvGz8oDW/WQ/4coZMlG2xNlnQI9S7fp8vJYMGHYT6
	wLtCdS7VJTuieIyWu5+4WujvfAhYSGFg+QFCpWTV9p28IzfYx8nxHDlpyigfP1nC
	4eOLkO0IfhnMuzlt0OEEbvt/eoUZcThtTo7XvnqRcoshghApEydpjGRAZvHYIFra
	ZL4Spc2pXwT8LS2F/90ognMv3Kn7h1AIcOdK1al/Str1CXTQrQ+JGUEbhYyQI2pb
	/b0n56Ac7zR+CSN+XdbMutRU3ltKqQeJTBw==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 440vuu0par-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 09:26:57 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5079QshC015394;
	Tue, 7 Jan 2025 09:26:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 43xx2kj3u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 09:26:54 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5079QrBf015389;
	Tue, 7 Jan 2025 09:26:53 GMT
Received: from chejiang-gv.ap.qualcomm.com (chejiang-gv.qualcomm.com [10.233.43.239])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 5079QrFH015388
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 09:26:53 +0000
Received: by chejiang-gv.ap.qualcomm.com (Postfix, from userid 37913)
	id 65888F55; Tue,  7 Jan 2025 17:26:52 +0800 (CST)
From: Cheng Jiang <quic_chejiang@quicinc.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chejiang@quicinc.com,
        quic_jiaymao@quicinc.com, quic_shuaz@quicinc.com,
        quic_zijuhu@quicinc.com, quic_mohamull@quicinc.com
Subject: [PATCH v6 RESEND 0/3] Expand firmware-name property to load specific
Date: Tue,  7 Jan 2025 17:26:47 +0800
Message-Id: <20250107092650.498154-1-quic_chejiang@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kubkaH0BklssMPhFluXUNdoPd6kS9wrF
X-Proofpoint-GUID: kubkaH0BklssMPhFluXUNdoPd6kS9wrF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070079

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

