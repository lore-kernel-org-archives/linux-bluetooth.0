Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1D91F3D56;
	Tue, 27 Jan 2026 02:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769482476; cv=none; b=fojjSjXqSGBWnVeMzC5Gn+f/Z9pe1N+y6uRV2U2N0/C8bzqfUXxN8chaF0smbu5AO3+FW7xOo6J4iFAu3kMe/LCPVOo7vP9OQmtYvfE6kNSgvDr1XQddT3Dku+8Hnhv9pekA6CIB9DSgppgq+VReIjdnpaEpLlVcVhxpb0eDSB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769482476; c=relaxed/simple;
	bh=I5qAil5dacMY0Ml25FR0dejIdZO2u51/wm8D8UBQsws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iz655otdITh2Ro8rxNHVYyReTjlq89LzwygpoSENFVCqUH1iY8BGY7B4+f2ad/+nN9x5SyIIoFMZSxVE5kIe0whBwaxdGWu7hIIbO1odzEsCooDMJH8FIGIvq+Wu6Kk501sleK4UsqRjRqqsyj6XEj0Ax/BoKt6eIYHoVLKzOPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JTxMzOis; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JTxMzOis"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QKggbB3481587;
	Tue, 27 Jan 2026 02:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=C647dvd8CoVgSl2Qof7y58TJfaP29GAh8pp
	cnEmkxfs=; b=JTxMzOisvNJEG1FCEqXwa2PVN5/8LuG5dvy1xLkaptRwqfHtIL1
	6YuU3iaTQetu48a3iI7364+vdD54u8byz2b6NfXiVGPewGbcXby1AncTAozivFgo
	98HiG8HJd6zhGwTsITg5loN4hu93tCz2A61RXVHGdJ1n8pZ1NAg2LCfIaAUsHNSo
	MrXbm5L5Sarmohutcou5zGnBj/VqxAXrurGFMYwJsDZX83utWbigcMeGygFJSQoW
	Z+ECaB3dEtA1z7X7lsfZauBcT4CQTeW3xHg2u9WK4w9wPuePoELUjF2x8Uk2NFR/
	BbYP9/PLL422+GiKp+crgzX9gW4GhepzIgQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bx0v33ejh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 02:54:29 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60R2sQYE027876;
	Tue, 27 Jan 2026 02:54:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4bvq5m1720-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 02:54:26 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60R2sQa3027871;
	Tue, 27 Jan 2026 02:54:26 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 60R2sQj5027865
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 02:54:26 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4766378)
	id BF2CF23977; Tue, 27 Jan 2026 10:54:25 +0800 (CST)
From: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuai.zhang@oss.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com,
        wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com,
        Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Subject: [PATCH v3 0/2] Bluetooth: hci_qca: Refactor HFP hardware offload capability handling
Date: Tue, 27 Jan 2026 10:54:21 +0800
Message-Id: <20260127025423.1418207-1-mengshi.wu@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDAyMyBTYWx0ZWRfX+rS+R1clNuhi
 nryuFKcDj7caraETh8S6//JQ1kAWGKuBN6GAYQpHRKThZOD7j7x7O/Vdt1+leYzMRPLiP8EPgoo
 tqpXc2D5CooW0wuPDB19E7Aeokz29AezPGU7U4A5y1wvklL1xjCiHivZo4yVTyXo1cWq1x89JPd
 3DnODF/jStLuod0PEerjax/7gtGkQICMAMslAQbgs5McGELtjyno0kwOOzAbZBmOxf69/9/TieX
 4QEhM+fjBZdn7OxyzXlR7MlSMnzpu5mtHgDZEMyIDDsyrmJ2fcr5gDuLhKdvBFb9cbqFr+ZOL/l
 4rUrvuRJyVTkiGGbKrXAH4SZeYRS5OMeZQCCYpLgom+MCBYfZfpMPG03aYeDj9rdiMb/FT3te7x
 sF5yBv6JSbvH72VwfAwaaCysfCmVkxMTQcbavv8LaAHbjig21AjVuSpItuugsVLBW9K1KoAxCEr
 abow4Nqte5R065zMZAw==
X-Proofpoint-GUID: qfUraP-sVVQ7AyNmFACZ8kfKrm6mu5SK
X-Proofpoint-ORIG-GUID: qfUraP-sVVQ7AyNmFACZ8kfKrm6mu5SK
X-Authority-Analysis: v=2.4 cv=JYyxbEKV c=1 sm=1 tr=0 ts=697828e5 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=9NKWiH58WbxvsMdF9fIA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270023

Changes from v3:
 - Add QCA_CAP_HFP_HW_OFFLOAD capability flag to WCN7850

Changes from v2:
 - Add QCA_CAP_HFP_HW_OFFLOAD capability flag at first commit to avoid
   breaking original logic.
 - Link to v2:
   https://lore.kernel.org/all/20260126162444.4194293-1-mengshi.wu@oss.qualcomm.com/

Changes from v1:
 - Refactor HFP hardware offload capability handling.
 - Enable HFP hardware offload for QCA2066 and WCN6855.
 - Link to v1:
   https://lore.kernel.org/all/20260123055243.2634107-1-mengshi.wu@oss.qualcomm.com/

Mengshi Wu (2):
  Bluetooth: hci_qca: Refactor HFP hardware offload capability handling
  Bluetooth: hci_qca: Enable HFP hardware offload for WCN6855 and
    WCN7850

 drivers/bluetooth/hci_qca.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

-- 
2.34.1

