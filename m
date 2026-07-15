Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A47B3CEBBB
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104814; cv=none; b=kkhRwRIuGB8cI+gpkVtfnJzc+yXazt4AGcQEmyFy02gwIqXkJnAZInlWBo69v1IdqAqytCxxPH80E7vUGvKK8gGxFoAJEeMBjryMi62IW4ChK7zD7bGsSa2TOLT/CSrNiG2bQU8UCJYWJNmbcwBNajybntVMOZNgKESs+9XP2qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104814; c=relaxed/simple;
	bh=g4zeTQLeNOrPnGSlBk0Xhklq6tH7DkM/xHaytOnV7Ao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aAXVWJLQozhmenGVp594UDgKJbugddGxOCxxYJb0b2sYYHscNjkMOAwAXoB6YOR4vlgU+2gfqOzT/Od8EAc3Y3XO3ekzwgwFGXAXb832MVJVqULaWuJLvt1wBO/CiBB6u7oFxnxow4Zxfj/UYw9cfbrHxxWF5raSCg38e2F3kb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=llLjUkcb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BBwFWA14; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="llLjUkcb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BBwFWA14"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3lJEJ2621260
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 08:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=za05jnJivS40e2SwYgaDAOYTm7GaLw+teuk
	42i4XRiI=; b=llLjUkcb5MRHdXZSCvsk5Vu0+qW9fgvC/D5X6FZns3qqp+8v5A9
	yZPJWIXLQc8xJq6qkQBFHBV32BwlYHR4MqFbUqn6ETq9Wkt8MQa/6/ecloi+yR1T
	tvRUM7Sz1eG6wDgWzK8jCtTg6YncPhqPb0gNdHaWnfzqK6OvPcmB68QGAQM3r4N8
	YcJ6uYD8H/oxpdzr4IKB6WLt1HkvvmML1kz/NDKu//ICPrGV0Dx3/fiAho9ybwaQ
	i7tNFHkqXJ+J9JA+9iaGm5RflX8pd8rILoEikaV9FbK9ppK4QHO0ZaFsBuv3+ysB
	T/ENeYsFAoSm/DTorC6jqwDc4prFCShOtGA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe03vhd9x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 08:40:12 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca860baea9fso4550803a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 01:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784104806; x=1784709606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=za05jnJivS40e2SwYgaDAOYTm7GaLw+teuk42i4XRiI=;
        b=BBwFWA14zr8Ztpz1JxEnSoIMj5e/h436VaLo9XxAVG9qJcOg8BRfEb+5f4jgAOEszi
         os6nP0DjJ33ozR3n1R57no7FjUYAF5tEc49GNv+QC7fubSAHsBOkZ2qJMfaZehSijSke
         6Ha5QECY7kRGFZ32T4oIPv8PcBMJEMNu0Jr36+zUMtE+oURK+6xsG0fcLbx98uxgDesV
         vMFfmhCfh5ncPHeitOGL3GEcy/fWclC6HGKY43HxLgWIJXFgVYT5N1mdrir5GSzf6Yj7
         SMBMy+V86upCDvjJTymxYJVv2rIKFlhp3b6sqm2CE+yJy2H8EAWT/sEy1uOILQvp5QA4
         Ac+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784104806; x=1784709606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=za05jnJivS40e2SwYgaDAOYTm7GaLw+teuk42i4XRiI=;
        b=McYs58zRDDhPqx3155FDA0euaZPIhb+ekkcatIXsTfehb/Xm9PPFQkwMGVDAlb/Qzx
         iFKeiep6X+4mwiJ7u6eRnJ51vu07Gr0W/0sQBP9EvkFzw0bQ8RJqRG4E461jQFi2G6/v
         oy6FBRxNi4qZnsawk985GyFL37jqWw+M2U8wFZjVcMAcO7bA7088P7AHfQur3WX4o+PX
         G6dZgUa7A1hPbMggfmx0HCuRhqiEnZU94PUs6HDEVeumNgnmFi7V/ljYEvKw+wBb2zvS
         xqLN3xJSRUdvhSr6ly9G6x+e0BxUxREDG5wHnZLhPcZsMpMAvQp+jHlNJo/jfAaR9ywt
         QzWg==
X-Gm-Message-State: AOJu0Yw65KVlt3tPAnUdA81PraaIV0/5n9/TIhAvez0zTdT8HhHEa3/y
	PeK2ekp7CIalK5P9iwT28m725jItbZtXHrmY5Cm6HEyPp+aCqH82QTsqyAbWclEUFCJJOYuVYEY
	yK9bjZbxLj5AEtUSpLrWT/nbJOZ1XvTZOb70UmfwnRbVQ07E+VrqPmZsWH7H1K4+OYjQ+lCkzpD
	XXNBE=
X-Gm-Gg: AfdE7cmc8/t48Oi2y+Os6JebgoP++RVbLzQAxsSohIfgj8J4xUxrOQXheTj5Qcd153Z
	RUeMkLoP9JALKon9igQ0XxLsxKNY6XDVQSRecOIIh3cgisL4KWbCg04Zzc1PsXZg/0Lz92oPYkQ
	kInBv5fWPVjpg6uouv7hXktYeW0KdksvgwA5a+paqnk08toGqXn6KFod2G6eFpZpY5kEYcfksMD
	kb5b3Yv4WKJJcjHjaLensDJkr/UBIbG/Ra1uZTVDyzIXwyV4P+WwdtUckDBl7b0BW1uN7DNd8DG
	aAtcRzMxxLAGBlX13ACNI7BzupLW+cdQFxUU1lnTFfwvFBTJMgWktAfh5lIfa7J6L5Aqy8kxCeG
	xKZaJB5UDPQePs/btFNQJOs+qpQ6lEpeDmB2eYaba
X-Received: by 2002:a05:6a21:3282:b0:3bf:db2a:d164 with SMTP id adf61e73a8af0-3c1108c1221mr17822734637.53.1784104806177;
        Wed, 15 Jul 2026 01:40:06 -0700 (PDT)
X-Received: by 2002:a05:6a21:3282:b0:3bf:db2a:d164 with SMTP id adf61e73a8af0-3c1108c1221mr17822715637.53.1784104805754;
        Wed, 15 Jul 2026 01:40:05 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm163872322c88.14.2026.07.15.01.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:40:05 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v6 0/3] doc: Add Channel Sounding API
Date: Wed, 15 Jul 2026 14:09:55 +0530
Message-Id: <20260715083958.2723407-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ife3n2qa c=1 sm=1 tr=0 ts=6a57476c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=iSzkMiWJHOwH8bCpblYA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: pKiLi5B2bX1te4hWS5uVQL3TQeXCP2Em
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA4MyBTYWx0ZWRfXwh5ehYyiSxCw
 xtVD0z/HGFBfwrZGYLEbLlJik9C1AIhlir9HRnQsgk+cjhHqINRsHUADhJnf7IeUT15MWdbNA6s
 LSH4nCSG4L1dnBWxPTk6KbipTVGfdRB6gzciEijSJkPK4ZJcU1rWFXKAcoPXL9CsQAW7L+d9xSY
 K2iMI7YNrsIpQ/Zg01mAYxsUuTlpdxD9iQQRXRNktfIWOOTlimTqegvzqALBDY0zos1n7um0Bmt
 B/W0qB9Xtx/Fh7orp58B/6rbf/9WSobIDgId97I3jq1VdCeZhnHYDuNLpntem15pp2SbbnbPwbT
 Na6SFMD+qc5G6QyPsyIliyNLSqu6G21Quq5RC/iajxzPzDJTFfaUjUzrbCPiV/WPzsTzTW2yudd
 1k3sjMQsAq6dh7gUeYqkl7u5m03yzX3t+xxrwXxhDe7yjZ9j2C5+7dqlUhYoB9xOjTOuzXbkZ6r
 bn1mGSiQMUU73qg5pbA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA4MyBTYWx0ZWRfXz81rjb6t5mtU
 QeI1vD3wVOTZbbQ+Y6DBCLo6Jrg/tzMHZbTys+U640j5CHp1VF+Teva7llof/NIHtn/vKm5hUBy
 V3iNz1x3kxDYKRmKZvQ4vJHRPQ6jD4o=
X-Proofpoint-GUID: pKiLi5B2bX1te4hWS5uVQL3TQeXCP2Em
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150083

Improve Channel Sounding documentation by adding cross-references
between the D-Bus APIs and bluetoothctl commands, along with practical
usage examples.

The D-Bus API documents gain :Used by: references to the bluetoothctl
cs submenu and examples for methods and signals, while the
bluetoothctl documentation is updated with :Uses: references,
argument descriptions, and usage examples.

Changes in v6:
- Drop previously submitted dbus interface used for sharing results

Changes in v5:
- Add Example scripts for cs reflector and initiator 
- Document CS params per-command

Changes in v4:
- Addressed review comments.
- Dropped the rest of the previously submitted series pending redesign

Changes in v3:
- Addressed review comments.
- Dropped the rest of the previously submitted series pending redesign

Changes in v2:
- Addressed review comments.
- Dropped the rest of the previously submitted series pending redesign


Naga Bhavani Akella (3):
  doc/org.bluez.ChannelSounding1:Add Used by reference and Examples
  doc/bluetoothctl-cs: Add :Uses: fields and document arguments
  client: Add scripts to start cs Initiator/reflector

 Makefile.am                        |   2 +
 Makefile.tools                     |   5 +-
 client/scripts/cs-initiator.bt     |   6 +
 client/scripts/cs-reflector.bt     |   5 +
 doc/bluetoothctl-cs.rst            | 546 +++++++++++++++++++++++++++++
 doc/org.bluez.ChannelSounding1.rst | 534 ++++++++++++++++++++++++++++
 6 files changed, 1096 insertions(+), 2 deletions(-)
 create mode 100644 client/scripts/cs-initiator.bt
 create mode 100644 client/scripts/cs-reflector.bt
 create mode 100644 doc/bluetoothctl-cs.rst
 create mode 100644 doc/org.bluez.ChannelSounding1.rst

-- 

