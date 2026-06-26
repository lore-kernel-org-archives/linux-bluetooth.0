Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AE1369D7A
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451191; cv=none; b=bgfKgYpz43kP/YRkDzK+skHQyjhv324AOSTf+AYZIFwwvHT+PTfMOtc7tcZTZldgXpCdHNQjPJI09qRpjXrhfL05Lyx9zFj905x/di5ui4MhO6w+CtrpHxByBI4T8k70A/5slVSmiyTB6d+szCtSfzTePr95cd2NFti6816eiCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451191; c=relaxed/simple;
	bh=EKH/Vt/1xTialLQ4sM5W6HNPLWbLhK/YtG65acTMZc4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Nngxw8WOl48A6TvPsuz6fpHuVtOID3CVWHLes5nfRy0BwznqGteHjY5uDI2qhNgMC3eOt1KiimwfqHkZPMaYcYw85ww82xQy8m11QfFF/AFscGF6boxkolLLVbm+RMjPusccRauRQfC1vP5jEH/zsfEu5nyXOxWBFB2//O5GJQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OKnuzNpe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IS9ZDk2N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OKnuzNpe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IS9ZDk2N"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q2ib0F076318
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Sgef4m5C7o0jlvPodxBmq1
	elfsVOSLLM/9RER5yhqgA=; b=OKnuzNpePxc1QXfLOYYXekrXoUq8/D8ZAY7jgc
	ITTJHaL/1pE3GwpglIDFY7i7vXP8eO0Rn6yX5p6wsXaQPCKo6hfAczEHt9WZU4v6
	07kq5MIcF9XbjQnwZlf+5mavVYhWGu0zAnDdKt8ai/TTMHi5qTil9qzQbFhEdqXe
	RZTT8dn0YGFZLovE0zbs1u1G7ZqXvj222R4fw5cvaLSagwP1izsQbiBm57w9Rz3q
	jVqiwBflymLUqDhLR7cpfiOqNc3EoR3qtYsKc6omJ8Dq3Fy8H2SasX4Yk4e3uRgx
	2pL1U2bzVgRq+yD98LqSEdNKi+0SSHfCvvuGKsFekQ8R1hvw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1eew92t3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:19:49 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c5193b6bcso70821eec.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 22:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782451188; x=1783055988; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Sgef4m5C7o0jlvPodxBmq1elfsVOSLLM/9RER5yhqgA=;
        b=IS9ZDk2N402x2VYIh+RUrpdpaDEOdUEDgMnWbfQXA0iIxS4x9hsB3SzgAVpwdQaFOZ
         uRlTDeD7QtvBMCjcU4I9VMkpsnMtX41rOg+whTjjyDK0MJXR/qJvFYJQgRWOB5X4ac1q
         Tp6HOtkBNtpiogWpVQ858L+XXMbzunAfT+CkV8gSWJbVqHgxMKBpuwZzNuBBiu7oBowV
         DixVdLOYG88qcw/cgZdBUNeZ5d0qwbStczdX78UNeWj4uKpQzaVkj2zhMZOZtgEPiOb+
         QW9viHaz+eFZ5eb14Q2mHCDKl4xmYUWACeR860VP1fMDaVSoGXW4ftlI7PGB0Si5TVRy
         3n4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451188; x=1783055988;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Sgef4m5C7o0jlvPodxBmq1elfsVOSLLM/9RER5yhqgA=;
        b=TMhLvEiDx2YmtsGiP+jIgeqydfqWv+dhkO/9q1En5fQ7cawVYL8EdXEPMCvvdtef5P
         a/mA3KwknFdh6y2yzIc7PNml4Co7PuRoAf7RVwGP6TNiz8Lz41TW+tX4mMdSNnsXTWzS
         A/SE7zZVQ0o6Dh4pF46bLPk9PXmianKkqjRBw/bn0BKJwhPuRD5fxdZC6uHJcNr2A+Uh
         3sKnY2qwQPvCdMb9KnM0iVaugxAz+6oD8bEqD/b0SKK5mFA0fN/dtenTdg7TQaaguMcX
         o1sPAjCEKsBwKQCdkmBr4ozp9qw9ndxMX/3PGgQaK5UIMEjJoQA1JyARt0QSEfkbE5OL
         m3Mg==
X-Forwarded-Encrypted: i=1; AHgh+Rr5CBjBnwLgJu2EUom0ujM//SQu59wbLZKWd2QNqnv4OUwWNe9URxJwkHQ9WcL8wPXzBPZcaLj1WrJ6+7tsL+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOpO1iBrohg34ywa2SDpqNP6pthUSXmwvg3cWTKx8znOKgz3bT
	qEMtsw9nbb0Ah8smeRUcUvlPqJlmvr3umYet9IuGeKGpFc9fAZcM8AoaPfwihx5GuYNTlm4lfc2
	iWCauXuu8v9WJP+GAW5X41aDrbl+v74wrnfPY10DUk4DlH81Gf7xln4J6LGf3+vCrVC6uUXo=
X-Gm-Gg: AfdE7cmRcoZw9jGX59pAqgFfIqA6GVO/G8vpfVAOJKPkDQ7MzjaY83xANoXy/vOXYFC
	lMdIwyCIHvYH5MmG3O4ELg5J7JZ8Tgtb7KsLRYx9CO5CoPEFTkLfWad52/nK/M83VhtLvsdlbmj
	6lPR63dDb6HQxcD0a7Odz/hGvOW4WJZ8gnMXNZUUUsVFJFFOE0ENVqUaXL/EVeZbVI/lFWqNlFA
	YnoGB+7n1BXQj+1XCk5HuZQCXbfqMweNIKyBl9hcRSoTQm2V3SOyhs4HipY/yeZ06yqTRtsmfUD
	//VcxM79tCGlIzq4tsz9wTnU20n+fYiH4441tTuIv2gqnOERBXfJiadPt1mhirNMTTQOfHSLE2c
	i0u4ccnUsZR0cpd8r3Z7g4CCh7l0Btt+PLAnIiZpCa5p2rBoXnn59jmeguQ==
X-Received: by 2002:a05:7300:d517:b0:30c:5197:3a09 with SMTP id 5a478bee46e88-30c84d5fea7mr2311806eec.7.1782451188364;
        Thu, 25 Jun 2026 22:19:48 -0700 (PDT)
X-Received: by 2002:a05:7300:d517:b0:30c:5197:3a09 with SMTP id 5a478bee46e88-30c84d5fea7mr2311782eec.7.1782451187736;
        Thu, 25 Jun 2026 22:19:47 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4ca240sm14345291eec.4.2026.06.25.22.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:19:47 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH v2 00/12] Bluetooth: btusb/btqca/hci_sync: Clean up btusb
 and fix several bugs
Date: Thu, 25 Jun 2026 22:19:45 -0700
Message-Id: <20260625-bt_bugfix-v2-0-93396a6f7d5e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPELPmoC/22MwQrCMBAFf6Xs2ZRklWg9+R9SJEmTdsE2NWmDU
 vLvxp69PJjhMRtEG8hGuFYbBJsokp8K4KECM6ipt4y6woAcJZeITC8PvfaO3sxpjUIaJZxroPz
 nYIveW/e28EBx8eGzp5P42X+VJBhnQrjmKLvLyZ7x5mOsX6t6Gj+OdRloc85fo2HUCKkAAAA=
X-Change-ID: 20260622-bt_bugfix-fbb216ca1ff9
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Tim Jiang <quic_tjiang@quicinc.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX7LG/IeXcL4D4
 RERbe4+OFb3zB8B5NNXHo8xboOYcS+1asrVnGA6Y7c01FmLXYnoxknGbYywC984BbJxjq+LaGjN
 B1KTkGjYQnnMYnfTWQ+y9gegMjqCrZI=
X-Proofpoint-GUID: HH6LlWLvYx3TYno6YwTRP8JGAWK9oP7H
X-Proofpoint-ORIG-GUID: HH6LlWLvYx3TYno6YwTRP8JGAWK9oP7H
X-Authority-Analysis: v=2.4 cv=P7UKQCAu c=1 sm=1 tr=0 ts=6a3e0bf5 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=39u25PDU96R9StkX-l8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX/Hcn/qvLkn1M
 TBaGou3Gdj3LuYUTKzXvg8/cdNIScYARJNQr6PQ/wVc49han3cVZPUeCl9q6M4XWVpCaPQh9799
 MHCoCpoxrfD9fwoI4YkgEzmgM0w3c3Dxsey3Vx6Ts9BGFo68YFVaZrkqkMMiEgmJukuE/67n3ZR
 gf01ceiEFVIMTL0TQqI1by0ptin02uZYlX4KiZ7eiCO4Pgc3V6CZN2VRzcFNXrQAZ5O2xNEp3fw
 s7p2eI6sR3haX/VdVpmgPp8VXSCu1PrzTqsJrgTP/tnVPdsxvjWMPuJHIoZ5kYcG2aQC5u0HO0l
 jH/fntvo13ZEaY2cfIYS8p4aJUI3S5MPgcbzcMFD5KiRTsdnj1tk7N819h3UhozV+RKKXXz/Vy8
 qmJt8b0BsknKucgahY/7ThJ2TG74JMO1tkDvCJr4EkoE0Jb9xhnf9M+DQLfUi12f8O2n90XDfQp
 8vIEtT5xgl3NIIMQGaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260040

This series cleans up btusb in preparation for adding a new chip,
QCC2072, and fixes several pre-existing bugs found along the way.

Bug fixes:
- qca_set_bdaddr() waited for HCI_EV_VENDOR, but the controller replies
  with a Command Complete event.
- btusb_set_bdaddr_wcn6855() sent the BD_ADDR without byte-swapping it.
- btusb QCA populated devcoredump fields on devices where devcoredump is
  not enabled.
- BTUSB_IGNORE is a bitmask and must be tested with '&', not '=='.

Cleanups:
- Add __hci_reset_sync() helper and use it in qca_send_reset() and
  btusb_shutdown_qca() to drop open-coded HCI reset boilerplate.
- Simplify hci_reset_sync() and log an error in hci_cc_reset() on a
  non-zero reset status.
- Record the matched usb_device_id in struct btusb_data and move qca_dump
  into a dedicated struct btqca_data.
- Reduce a redundant assignment in btusb_probe().

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Changes in v2:
- Reorder the series so each helper is introduced before its users and
  related changes are grouped together.
- btqca: reword "Fix qca_set_bdaddr()", add the btmon (WCN7850) trace,
  and add Bartosz's Reviewed-by.
- btusb: add the btmon (WCN6855) trace to the BD_ADDR byte-order fix.
- btusb: rename and reword the devcoredump fix.
- hci_sync: simplify __hci_reset_sync() to return __hci_cmd_sync_status()
  directly; rename the patch to "Introduce __hci_reset_sync()".
- hci_sync: "Simplify hci_reset_sync()" now returns the status directly;
  drop the separate "Fix return value of hci_reset_sync()" patch.
- btqca: replace "Fix undetected error HCI status in qca_send_reset()"
  with "Simplify qca_send_reset() by using __hci_reset_sync()" (cleanup,
  not a fix; dropped the Fixes tag).
- btusb: reword "Simplify btusb_shutdown_qca()".
- btusb: rename "Initialize @priv_size at declaration" -> "Reduce a
  redundant assignment in btusb_probe()".
- New patch: "hci_event: Log error for HCI reset status error in
  hci_cc_reset()".
- Drop "Move struct btusb_data and macros into btusb.h"; deferred to a
  follow-up series.
- Link to v1: https://lore.kernel.org/r/20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com

---
Zijun Hu (12):
      Bluetooth: btqca: Fix qca_set_bdaddr() waiting for wrong HCI event
      Bluetooth: btusb: Fix BD_ADDR byte order in btusb_set_bdaddr_wcn6855()
      Bluetooth: btusb: Record matched usb_device_id into btusb_data
      Bluetooth: btusb: QCA: Fix populating devcoredump fields on unenabled devices
      Bluetooth: btusb: QCA: move qca_dump out of struct btusb_data
      Bluetooth: hci_sync: Introduce __hci_reset_sync() for device drivers
      Bluetooth: btqca: Simplify qca_send_reset() by using __hci_reset_sync()
      Bluetooth: btusb: Simplify btusb_shutdown_qca() by using __hci_reset_sync()
      Bluetooth: hci_sync: Simplify hci_reset_sync()
      Bluetooth: hci_event: Log error for HCI reset status error in hci_cc_reset()
      Bluetooth: btusb: Reduce a redundant assignment in btusb_probe()
      Bluetooth: btusb: Use & instead of == to test bitflag BTUSB_IGNORE

 drivers/bluetooth/btqca.c        | 25 ++----------
 drivers/bluetooth/btusb.c        | 86 +++++++++++++++++++++++-----------------
 include/net/bluetooth/hci_sync.h |  1 +
 net/bluetooth/hci_event.c        |  5 ++-
 net/bluetooth/hci_sync.c         | 16 ++++----
 5 files changed, 66 insertions(+), 67 deletions(-)
---
base-commit: cb20f6afc25b2b54c0fec61b45ac0ec9eb875d59
change-id: 20260622-bt_bugfix-fbb216ca1ff9

Best regards,
-- 
Zijun Hu <zijun.hu@oss.qualcomm.com>

