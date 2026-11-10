Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302989;
	b=z40lEECCkUe0EmKnDuWOCwjLdM+W4s7yQF4GCgKuKLaJnQVh57NSrakkeztsWYoD896a
	 95Aphb8zHtSuSuq0UcfbPI7IKG8dFeheBdtXj5QQsLn7ynF+V8CPBWaRpPERdpOc9TnoQ
	 Z4/YyYGY7zKTIDfmNTiR8XaqjmKE8OHbh+bfx9orhb9nw46F071YLkRX76j9jTnqBWE5w
	 RwrS5nRIplGZhveia41cTbndlcR1H/ayz31Ts70b6UoTzY0Mdg7/MTBmT5JNnah9s8Ndq
	 feqqjOIFF3lehfSzr2LMgtcA8rIg+xoVR6GYqPggu/uKfkmwMBUIqlQT6munZH8pPKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302989;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=NaB8Zj3ws0wS+/cUF/fIJL6zYycU0qwIEP0n2A4GI7E=;
	b=3QJ/b/SlM+WnnRxNkUlCoTlEgHMYHBKhW8Z7XIe8FASrbKGcMMxUHKYB2w2H9ZYkrW9X
	 YgZJsomkSjJDjCNCdLBf/hNTZb6haMC8/DNa074mkBkmHIZ6eDH94i63CwBL9n9Wghoj+
	 d/NCvBxmjI/LuXPpfd2AIXwkCMilTdSigh8Cv36TpSnlyNG5l3E4aRFbwKCnXThmGJP0a
	 x97HQDZhklgjJPaKJxQIjgKi+o/Gh/Ihc+Cfn13Zx3RS8NAB/1ADw2gYSbbMLdJH2lG+8
	 LoqtvZo3pMswVb3V8G+VX4YCbOVCEgxJ6ndHiHey47wLojT/8QLS7L6M/8zyHnwI2rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nmTK6lgs;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE74606C668;
	Tue, 10 Nov 2026 09:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFE74606C668
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nmTK6lgs
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7l4fm1155019;
	Tue, 10 Nov 2026 09:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=NaB8Zj3ws0wS+/cUF/fIJL6zYycU0qwIEP0
	n2A4GI7E=; b=nmTK6lgs11g0/11eXJsI95Y+inygOeKz6kOsFDMiAR/8lEz/qyf
	6ckVO//h8XQ6B284HRg8uGlHllEDudd81facVOAB9Fx1a8M3IHu4u5uKHrW6W7KP
	JLFXr/1wL67RTiavmV/G3ZWFK3J1o+6cwNKKAm1I6g/ngz0gSRHtVTZgiCwQnbme
	tX+kQ32Rg6LT9lZXcHjZNx8F2GkzQ/HMyscIEVmlFcje3/z3dx5jlUUzYN/HVHAJ
	yNBb8vqzKOQZS6W1xItPmQQ4jQ9QkRuCj6TWWEG4PjZZ+ayyCqx2Tf7yJ4wQqFTQ
	0cZDl0grtneVm9Htzhmdw+oI6kkO49rGCoA==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hutv49f9d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 09:29:39 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA9Taeo629488;
	Tue, 10 Nov 2026 09:29:36 GMT
Received: from shuaz-gv.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AA9Taci629479
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 09:29:36 +0000 (GMT)
Received: by shuaz-gv.ap.qualcomm.com (Postfix, from userid 4467449)
	id DD52E671; Tue, 10 Nov 2026 17:29:34 +0800 (CST)
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com,
        Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Subject: [PATCH v4 0/2] Bluetooth: hci_qca: Reopen the UART after enabling QCA2066
Date: Tue, 10 Nov 2026 17:29:27 +0800
Message-Id: <20261110092929.234617-1-shuai.zhang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzNyBTYWx0ZWRfXzQLEjUIMg+cW
 dfIulsLYWNwTE73f7ix2zVtpoJ6MWFC7JJLc4UUOHvCcTkyVOlkXuT7TAPXD4+i6GePJWKt08hn
 9H8Yf9Zt9TU7z6bsxqiQ6v7IqeltK5c=
X-Proofpoint-ORIG-GUID: hf6yQIwgapJpRkXqFdG2X9d-xzUwM7rg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzNyBTYWx0ZWRfXytUjKKv8YZ7r
 8Z/fx3AOA6Nsp3ckfaZUO7Lno4jt/xAaKPvkGQwFL07SsIkzZRefmEJlAtJAgVWYbTuPJtu4SXr
 j3P4I35CQTcttzR61ya3lG5am65uw8QLzDfc4oDmQ5nu5YzZDWkxHDmnkZHu1cFKVTDYFMks8fZ
 eM+JTZYnvkPbCOk/tDX5qSYOiplbo4s9KXxtzSFBq0vNYabWTBIWn6BHW4AaMV9OlGlDcr4JCUQ
 jKEG3qWMCz5f6whyUGTWOH6gb+W/Et4s0ddd7YoKLVaYxQbUIwNjoNzVt7gmJ6gP79t+2O/w7Ls
 6ov368rnnEd19Ea4qOgCDfW/TDn0lHSMgoRJBSu9TdKw7Yn2ets5guiptOAp19cAcJUBQIS7oJm
 HBik/+3pVb64KWhpiiiizGEOk4HarF/xPd+8463quj5hSAzLUmChBt2xa0+ScnSdaeXytXh0aRp
 OhNSki1OPavFKhm3q4A==
X-Authority-Analysis: v=2.4 cv=B54sQ+tM c=1 sm=1 tr=0 ts=6af2e403 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=DZK7GW7QJrmLQIWYei0A:9
X-Proofpoint-GUID: hf6yQIwgapJpRkXqFdG2X9d-xzUwM7rg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100037

QCA2066 does not reopen the UART after the controller is enabled, which
causes RX/TX out-of-sync errors. The UART has to be reopened once the
controller is powered on.

qca_regulator_init() already enables the controller and then reopens the
UART, but QCA2066 does not go through it. QCA2066 was added with its own
SoC type and handled in the default case.

Let QCA2066 go through qca_regulator_init() as well, and handle it in the
other places that check the SoC type in the same way.

Patch 1 reopens the UART after enabling QCA2066.

Patch 2 keeps HCI_UART_PROTO_READY in sync with the port state, so that a
port which failed to reopen is not closed or flushed again.

Changes in v4:
- Let QCA2066 go through qca_regulator_init() instead of adding a QCA2066
  specific case.
- Link to v3
  https://lore.kernel.org/all/20261028111839.2148515-1-shuai.zhang@oss.qualcomm.com/

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
  Bluetooth: hci_qca: Reopen the UART after enabling QCA2066
  Bluetooth: hci_qca: Don't use the serdev port after a failed reopen

 drivers/bluetooth/btqca.c      |  1 +
 drivers/bluetooth/hci_qca.c    | 46 +++++++++++++++++++++++++++++-----
 drivers/bluetooth/hci_serdev.c |  6 +++--
 3 files changed, 45 insertions(+), 8 deletions(-)

-- 
2.34.1

