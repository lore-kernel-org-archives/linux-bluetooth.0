Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F2A4189DE
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430621; cv=none; b=fGUYDHfiXonI/snzeVu+HWh0377Cqs72q/vvFOA/Zc+iKnNNRCr4PcJKx5YyviCqaHuB4tUdgRIrAXv9NrX7NrWpzy4t4IO1wLRV5MhQFJ9RuGm9lhOQ72c09bX3D/bGF/R4s6qNNUGImf99l/xZ2KlwRllf3oVgG+eFlMJ8X5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430621; c=relaxed/simple;
	bh=DLm9xeE0YWoR8BloFBwxautPRZz3kl5vIldW2i/jvhk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nPGNFHzVfI6GVX3jLaAGBogj/CNU8mII2dvTBElPaOYwiJzT4AKWmPy3r+Iq6IUYRzZ7dMu3/I84r+AKI9aeqlFXKac54ifKEKvi5I8kWxmGP64XpHF8V7Z602yeK36RPlTjBDTrHqvA4hg4licOp0EKKd+FUEPU+J4kNbfLHHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V3A6GyPV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QIMSkr5u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V3A6GyPV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QIMSkr5u"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683923uX3549231
	for <linux-bluetooth@vger.kernel.org>; Thu, 3 Sep 2026 10:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=XWDRsbq9aGgqJciqyBQRZKVciOJHpxAman+
	vXbP6JYY=; b=V3A6GyPV9pN5Fib1zPcB50Z+gwrcyVLneG+uHH9+tlE8XlDq8O0
	JR6k9tVnCXF+w9fMgoUeULFguoIGCPa5iNvlhCBCabyrGxJavXkvcOajPOuJXPJ0
	03bEzRqmytZqcKG3WbmWqrFVKLxVb10NcPprH+QCpNBYW4dpLE1fZ/IA3bOPAiKc
	qpsQPIZmr0SNz7wyES+wsMvlQ9ZUb7W5SABCPZAQoaNVjHmS2WMD3Dw1eLhkyS3w
	PDs6E5WG65qSDeT/20+ShKowzye+rIhDMb5GMXHbGlOlKHkQebnaEkQUcDdzt5iZ
	SAcf3iXTBivoqqHidqoTvJK6Qtr6MDdlBHg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf0gjsmkt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 10:16:48 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d959904658so41808375ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 03:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788430608; x=1789035408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XWDRsbq9aGgqJciqyBQRZKVciOJHpxAman+vXbP6JYY=;
        b=QIMSkr5uur5o+VDXjvJ5uGfnxQseYaXHe2ddF2z1nYZKUk8oIwAVgvIgbENTkAT6YY
         31B9JKGOJpDO5hSWpNG31yhaLohfF1jWNMsshatQMwXQ1rKVNFfpLSQK4pfj6OJ+cOCx
         yoQ3OLvt6VYQQTTfQNLHtrZ7R3mwsg4vwoHTP0AucuP+GMNq7AhaEqGBP93gEDWQReOk
         tVI+05heuoD6l6iRs3hQmxyKP+OKlmjEy+PWGYuOkNFisoAO8bAfUHGQtKOeCmh9zc9H
         yUf606BjisGhq036cAO5EfqDTCVmABSP0W4B1JAn2YCAqIo9SJgeAS34uCY5+4qIsbm6
         H4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788430608; x=1789035408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XWDRsbq9aGgqJciqyBQRZKVciOJHpxAman+vXbP6JYY=;
        b=TduTCs5WfJafjHUqJH51AKnSDy7rW7O7XqGkK1aowoQuRuBpeNE8/ncx3JFq9W76oW
         dc9QNztIG903uzOcaYo99tqe6vaeJwFcGwRtAddc/DJ5fCyEzoidLNWloPpQTESy6JWO
         vfczWYhkjBKRTidQOEw3vYdj/hPPd1ibtVHDqyNfDaEDM6XS9IrwRnJSsOVKHcDeDWXp
         ZopHKTLUWWXnmZWTRrEFGMFyQ4nDrIi6K4kZRXOAiDj/e8XgBH1pH4k2/qaqmeUfZp+J
         xbgFACMSAFjDBfq/ML7K/IUMf1MXiQ9gFzJSDLFkRmkwTnwtnjiA8toqRzzVXRpLgoPv
         29CA==
X-Gm-Message-State: AFuF++mCL0vS2AzuuD6Fq8SVAi6MUQRwgUB+WJ00weUoUTugNrjIGCL4
	H+QQptnw5eAbBFGG21hKXQy3xLQkYNCiU6UTTeQoclT2leSfoF+usjzSZcmbr8K1i4s7cE0HsNz
	KChWNgj5ElsTaw60hVCazU0/5rWm/3ZoUpz/iV0nnngTSJp1ZylHm8yoNpRSnb5r5jDYUv9/2Nl
	MAbEs=
X-Gm-Gg: AYBFou22+vejZpokFW2MHCszOkWt6YpLYt3KXhTL2O4NIBdtNtTOGcaB6IbmmYNk90Q
	ra1CNzOj8Zt0hvXsE50wDOlxap46+x4jptlARkuE3dxmbt2IJ4T4cL0yFnaql6ZL7gIf0GT88lz
	tafd+Z71F1MWSA4EivlBHzc20Y5ijE9E1H3bPv3AMTXWqYHbBkfPqIB5iB8u/LoAaBLTI47RDuP
	8ioIz0W4Eizsr/SPNyMWmDSf6hbn9p2ZRHex1lymso7e75DUWtOL9k4rHNsbXywkjUpkfdApF+b
	th6kD1k4JmQLlHpjtXRVf/Ztskv6f2oP3P1rzwXVZPXxwFdQcIPf+rjoaCQfDxIvCPpEVftdT+T
	UjVEWHnaY0KebTuOCV8c5qMmDlCPm8w==
X-Received: by 2002:a17:90b:2f04:b0:392:b509:b1a5 with SMTP id 98e67ed59e1d1-39aee13d5a1mr18091006a91.14.1788430606938;
        Thu, 03 Sep 2026 03:16:46 -0700 (PDT)
X-Received: by 2002:a17:90b:2f04:b0:392:b509:b1a5 with SMTP id 98e67ed59e1d1-39aee13d5a1mr18090948a91.14.1788430606428;
        Thu, 03 Sep 2026 03:16:46 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14319875cc0sm4933483c88.1.2026.09.03.03.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 03:16:45 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 0/2] client/cs: fix crash in reference ranging provider
Date: Thu,  3 Sep 2026 15:46:33 +0530
Message-Id: <20260903101635.3370149-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA4OCBTYWx0ZWRfX3VZlZ6hq2elu
 JhlW80yuXPxUGhPczkDzuUZ0m47CoWOssO7XcDd0bDw0pbD81weRuq16anT7oaN7tk/e0xvEPNd
 1cLfTipt+4P2tbJlTu8I+oKDmejQTx7vhK/NfhrrAlVO1Wjhsm7tZv4kfwmUDKKjPOqviAu9IUZ
 jiucHExPDLaAU/O/zsNNMkwVApGvvrb4tYSpLdW0toIwOVUCAJIweonmDB5ohcJItxbxtzQ5XgZ
 LXAbGGrnbLawoWrhNZz1ld2hNq41SNavgYTLcZD57p0xfc1DsHIEh0NbK1EGU/UzsQVNsewhTmX
 VHf2dnqA0yXrW3jzRD/HOpFEiwEh9CqBBDCuCNEoymaeGmwYNl5OcA9qOjw5b94bxGMFxLxoV1D
 o+LmftOqYwqAFzxL8UmWQOwqZn5NX/8J1Jx+QCbT6Or0E0c1539OlFdj2EBRuLHt1nBkc/NYFjn
 qjZmPRhcaVMmNuLM24g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA4OCBTYWx0ZWRfXzLDNqI/EEqar
 A63r7F6RYSHuuYVLFSZgTu1SJd3e77KA7z7C3c522yCcNR8xOkel8RBh8sUISOcz1l/rHSHdtkV
 8OkmIyRbOjjZ7RdvjjrsUYbyaVFIAQg=
X-Proofpoint-GUID: xGY_jSmRVPVbTjgbUAMDgnyCq4b2iZcO
X-Proofpoint-ORIG-GUID: xGY_jSmRVPVbTjgbUAMDgnyCq4b2iZcO
X-Authority-Analysis: v=2.4 cv=LZ4MLDfi c=1 sm=1 tr=0 ts=6a994910 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=ubQkc5ZVy9BJmzX_uREA:9
 a=zZCYzV9kfG8A:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030088

`start <dev_addr> 30` followed by `register_provider /` segfaults
bluetoothctl on the first ProcedureData signal: cs_ranging_obj_create()
exported each device's RangingProvider1 object as a direct child of
"/", the one path with real gdbus object data (its ObjectManager), and
gdbus/object.c's invalidate_parent_data() dereferences a NULL parent
in that case.

Nest the exported objects under RANGING_PROVIDER_PATH
"/org/example/ranging") instead of "/" directly.
bluetoothd's provider watch matches any descendant
of the registered root, so discovery still works.

Patch 1 is the fix, patch 2 updates the docs to match.


Naga Bhavani Akella (2):
  client: avoid registering ranging objects as direct children of "/"
  doc: note RangingProvider1 objects are nested in bluetoothctl-cs

 client/cs.c             | 28 +++++++++++++++++++++++++++-
 doc/bluetoothctl-cs.rst |  8 +++++---
 2 files changed, 32 insertions(+), 4 deletions(-)

-- 

