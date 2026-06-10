Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE5F3AC00;
	Wed, 10 Jun 2026 06:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781073787; cv=none; b=c7dFdzjlB8R1kk+34zYtkcQjuFxxMRgmc4kE2tSQCsIPmWGZ00cqf5gF+0VP3UbYng1IJ0u+YSVpwot1ZzZvTDnAMzoDO4N8vgUPmUXRG9G6zncJGWrM1DdiMiWKxunS+9T4tzh0MMR5OkesfjPksLb3lhkTV+k7LzHlb32iB8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781073787; c=relaxed/simple;
	bh=HN7bfMFw4GGzj46CZbfoOD9OP4+EHA8cTT47FIisQ4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klqS+SSSc/WeAHrHtVE/Uu8reTbygw5H8n+wj0ibQTqw5B1eY85k0BKs7raNjH7sF27L/8murpm8myaP/rrh/xY3FGcUsRwOxDYDsN752P1yl+pXtfZhTuzzWO+NztC8wkkRQ2D7vs8K+3cXgeZpvyLGj1PTYv49Xdcjk5yrqvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U55sLG0V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U55sLG0V"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A2ei654061021;
	Wed, 10 Jun 2026 06:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=TKnsWr9jxQi
	JH5It4e8qmbTuS+kOI3sS3apHM+UCRDc=; b=U55sLG0VkLDwesKl1gjOwfD/Dl9
	nXQRaxpAiSTlKiJqHozEe0q4oftB00gmtYNd/lwjw5HgA5QrdkmstZ6sFYHlZEFO
	ryZP2Sz1Vpf2H9J9e+i1vC0E0qnVN2P7ucMGdu6cC7FLWppgLLE7X6w65Tkaxkjd
	igpgV+btpAu+FJeJNdBdIgtRZV23N2E4r0wN7DX1Y90kQNO7IxZL9kwQyUK+DXMM
	knYgQDJqUpp4vBF/VCn8hzslpnH1PVCCYVeJZKMF8aco2bkogIl4OAFIYqnTX7lt
	cRFBvw1bcJRELjqPyv30xrfysahEzHWJx8yKfLlZUO9jUi4ceVkxxq3e6xA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epwnh14ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 06:43:00 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 65A6gwWx025215;
	Wed, 10 Jun 2026 06:42:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4emcmjnngg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 06:42:58 +0000 (GMT)
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65A6gwL4025202;
	Wed, 10 Jun 2026 06:42:58 GMT
Received: from bt-iot-sh03-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 65A6gvO9025200
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 06:42:58 +0000 (GMT)
Received: by bt-iot-sh03-lnx.qualcomm.com (Postfix, from userid 2385805)
	id 0541F4339C; Wed, 10 Jun 2026 14:42:57 +0800 (CST)
From: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2] Bluetooth: qca: Add BT FW build version to kernel log
Date: Wed, 10 Jun 2026 14:42:32 +0800
Message-ID: <20260610064232.2385866-1-xiuzhuo.shang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609075417.1160702-1-xiuzhuo.shang@oss.qualcomm.com>
References: <20260609075417.1160702-1-xiuzhuo.shang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA2MSBTYWx0ZWRfXxb7koRghlkDz
 mqiBRgJvYmPYWuVKtIV/Le5+Q+90ouX89RPQj+xxcOfXEa8hCbPz8IOspcN6lLVx6+LMel73A4v
 PKHL6HmZO8LDUB1JaP46NDUhb5deaofBuUhcwL7wSMTbl3exuSE1aVLfhk+NBsZ3Ayzf57VLXWT
 6CImGpeq+pxOOXH2nQibsfGm438t85ZlR7SiuCjnX796yL9/0n4/WrFgX/MSnuDzEBwjc1GJdm5
 bnywSvM9wLKrjqqauYtw8rHbZM1PUkcTvg4Wtys9P1NyKye8a8gRmJmDOy3WFAYJnrkZiYDb2NQ
 DvyriuuqUXdm3/YV6bzkF6FaxyvpntVuwXoGiNXGgYyKMnv0WS2rHkmhe1AO0N1KWuGAxFhn9N+
 kvkBTg7yyxG8fC5XwA7Gx1yNaMKkgm8uLy1CXZTzvVM0XV/YA4XI0tOvNaWg1JGJpgTHpmIVQdS
 p52bpGo0ctG07pLT+7A==
X-Authority-Analysis: v=2.4 cv=Xce5Co55 c=1 sm=1 tr=0 ts=6a290774 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=M_F3e0kD36ftvvs9-vUA:9
X-Proofpoint-ORIG-GUID: 4FDwjlsF8H4w0fG3EC-sGY9JlPIRBcMw
X-Proofpoint-GUID: 4FDwjlsF8H4w0fG3EC-sGY9JlPIRBcMw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100061

Firmware version is critical for bug triage. Users reporting issues
typically share dmesg output rather than debugfs contents, requiring
extra communication rounds to collect this information. Log the FW
build version directly to the kernel log so it is immediately
available in bug reports.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
---
Example output:
  Bluetooth: hci0: QCA FW build version: BTFW.MOSELLE.1.1.3-00106-MSL_PATCHZ-1
 drivers/bluetooth/btqca.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index dda76365726f..04ebe290bc78 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -143,6 +143,8 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
 
 	hci_set_fw_info(hdev, "%s", build_label);
 
+	bt_dev_info(hdev, "QCA FW build version: %s", build_label);
+
 	kfree(build_label);
 out:
 	kfree_skb(skb);
-- 
2.43.0

