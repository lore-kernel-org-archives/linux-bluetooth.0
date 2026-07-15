Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E0227E049
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104822; cv=none; b=JATqhgM5/586EbVLnc92LEdOK7XMdXfFYU04fHFE3jfiDOEDxrYyrbIzMG8B0+a2lzMpTWGYhweg6OlXAyww5Sqlbq+o+uX3DH4iStKKa/3spWfmv+zUzGD82TGoB/8iOLvErrcVEmsODYuDKtsDBB0/uzzh2WCzwzlJI1HIG/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104822; c=relaxed/simple;
	bh=1g3gh3Z8pyqg3gb7wfXA/rWNEia7jjME63ihTOUBy24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X6S2FA57jRoL/O86ZbJRcJfVXE7/Q92D/2M6anvQ43QG8OcqCF255mdEPPfJn1vBUddlXVzuNaXx2UScl+jxPeOOHcOkKMlaYyI/0sqMxePNcR2NhqgvKl8B6dIpC3zpYzDzi/ZNfFYeRyMcPUAWClOxnG1dwXdwAOqfmYnvgbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dZF7kLgl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QRbGS9n3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dZF7kLgl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QRbGS9n3"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3lX612528350
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 08:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9geViHtlygy
	y7YVaSU28eZKbaOGh2uxztqaqJ3yvFrI=; b=dZF7kLglUFHA4b1NroFFLTvTmvI
	ZvUah3LykUIxqEu+FajTSRxHDjt0Foq/5FbGhpIxXNrRzUhdGoUnvB3Djo3cwowq
	XnD0h+Xuymdou17Q202+CqsK7ar4AUzYtpK9ldCuGaPOqS7I2lME38FNBlP8vrMx
	dFj3KMv/ruL35jayxB+047Hx3f9GzA2bsSARCH+ccTdr9+IRc+JIFMZU1pM71jmp
	kJnHekNtAMtUUFh89BguOvJIfREOGzTpEO1LJpK+AyDKOWmxCLEabCtrs6bdB3Tr
	glpuQwYKgPXs4lpakElwvcpFUaFLWDchPtTBg3uwwXa6Hcr97RF6BnHMtfg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnr3tum-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 08:40:19 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cee1ec30f2so28714875ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 01:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784104819; x=1784709619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9geViHtlygyy7YVaSU28eZKbaOGh2uxztqaqJ3yvFrI=;
        b=QRbGS9n3VxeqFiR9kpSTZYRzGcwy+iq7B/jc2UacuS2eNoSrv9yKKBoFjIeDED+wj7
         lTPfu+xpAQhhSTHEitxzud3fpN2pcARJlOzf2zBurv0BV91fY6/0TbGC/3mITLg9zl3C
         4340vrKpm+y4OecZPU3JaV117QPIbyWFST92FMr1j+/81xPXQZmpbeaeUEva37T82QoY
         qkUnW5lf/EeRrrXx6NFseMXUwfWSB7LwlWhZY4gJN1ce56yBPS1WesoNhfxMie3aqhVK
         XTWfL/fDdUMYLvuY1+ZSt0FF6BGHG1U4BQnPkKLWmOMHuykBSYltZWyNHv8lafV7XMIp
         uP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784104819; x=1784709619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9geViHtlygyy7YVaSU28eZKbaOGh2uxztqaqJ3yvFrI=;
        b=ByID2g5zXimoLLgbs9cwhzBcxhWj3MYLAqBhajts2tx97ChaRajsXh5wWtLm7oTWfd
         iRzatwsCHArAGvdfSi4wU7rcXVuUnVo1CpPC7by9riz6g8xj8tk4uXtwVVR5+fnfdwmK
         tZJKaZq7PIMWlpvcMVUobzm//UQ5LojraVYSpwj9qWA/zc8PupHohkwCRb1cxpx4T7oU
         IcNWIaUbkq+1kbEpgN1HnY50ViWC2o0FttoTQll6+T0rLqYcAyRzR753weyH19ed3V3e
         iJGIHpkcvcZuj9jVBgg3hJBAZmMZDfjirZDF8dqvh7EVy+dvGeLplGn4pquxSRQrwxWh
         AZEg==
X-Gm-Message-State: AOJu0YyMVRAI/jCa5+89S2jvMlgxlPlKEu5woMjEdtsZ+W/QQo3zVZ5v
	8bWjNqkpHxXBWklRlhYi8m0WGMmD8yNbl1ZSeyV3StiHy84/h0ChR3bebq1G9kkby/hDJTfHDsX
	nMTSwycfTCOtKcPC37yipo120e0ZjZiUQGCOAvBUHI4qX28SLbNSF44teQIypF2ZnZQXzfakUWR
	luRPY=
X-Gm-Gg: AfdE7cm29y2a+CvyYse1ObnsdLTn5QmdWA4i/pzWUyNTHZrtfxqjbZiTjskT/tJb1sp
	EYXlS1KplhM7+J+XrnGEUxpT7ceQbrPyPIsssWtf65uxwb7NfDDNcjiBGEjC4pNcC8YOuQBAYS1
	d3SxvfJByA09Aa2ojqa73DvoC03od/oQaijMtpWOdH6N87XHcrBf5KACRc0PVa2Iux7HZbdAI1j
	TgY/5wzCmrU2xvgFAHHESA9U/mOn2VqH4RLjrVuAniZxfHMiupLO+5b+ZaNeepCbq8GtlNBXS5s
	situovPwWmFpvFxaLTo5BNgT5Jnh6m7sywYr9K2sruF1hloyH7UtPH4wLz2AglhzChv3+aBGbl7
	yGc/VOUzjGdicmwmIi5QznOSgb3iYIZ9yzMgkiaOO
X-Received: by 2002:a17:903:2b0f:b0:2ca:d976:95ce with SMTP id d9443c01a7336-2ce9f3b414bmr153411655ad.39.1784104818705;
        Wed, 15 Jul 2026 01:40:18 -0700 (PDT)
X-Received: by 2002:a17:903:2b0f:b0:2ca:d976:95ce with SMTP id d9443c01a7336-2ce9f3b414bmr153411355ad.39.1784104818263;
        Wed, 15 Jul 2026 01:40:18 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm163872322c88.14.2026.07.15.01.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:40:17 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v6 3/3] client: Add scripts to start cs Initiator/reflector
Date: Wed, 15 Jul 2026 14:09:58 +0530
Message-Id: <20260715083958.2723407-4-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715083958.2723407-1-naga.akella@oss.qualcomm.com>
References: <20260715083958.2723407-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA4MyBTYWx0ZWRfX9WFuhTUrr3gP
 PmZFlEDmWbBwfQQaxqqLOW92yGhh+Y3AHQz8EZ2YLyjIc6EuwQvfZFrUQEQ1uKuZp7yqp/pAYKY
 UG/IQA3os51H7kpgx8oZ2Yi/ukalVhg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA4MyBTYWx0ZWRfXwFbL5F7xsqUH
 A1UNThoWzKZLPBnmjBNwEru7vQ5IV4umHDyW7UgXrlEyHEcnoHEm8AAUGIwUrFJCkGadu9fybth
 h9sWrpovcYpdAjH2BIKSAcOFukfU/de+Eq9zVZjAcqpRMFj4hKrA2m7YqmCKM21fqKK0vBeZ9xD
 Vz7QYiEzSzS74q2kJgYSfYOXaFBRvQ7YcuU5CqvH6vCAFEWgTkQ66htMZTxg5dJpP2nDkrM2Iwf
 rwYZjvtsRGsJUm0BXtA1zD9LL2Kqwq9XIODf6fvN4cy96pcCTDuFuvQW5amPGhMKuThtsiwwquA
 l7Hd0E56OxEVg+1geXGk1HU/vg1iqWe/621ANLSo6OXgLp5Lt3aR6Roefj//Y06PDAo4VzmFmix
 FRqHrd4phZuQEJoL5NpgQnDU1QHE7qdZw/14ith0S2cguwvLuT5c2jEz2KY5iVCxItouvByUutj
 9f7L7SKcthyd8yaTM4w==
X-Proofpoint-ORIG-GUID: E4v4wxWb8wj189MjGrD6sTYIAxN7hNoz
X-Authority-Analysis: v=2.4 cv=NfPWEWD4 c=1 sm=1 tr=0 ts=6a574773 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=0vyF1ivmPAi-RmPqk_YA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: E4v4wxWb8wj189MjGrD6sTYIAxN7hNoz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150083

This adds sample bluetoothctl scripts for cs initiator/
reflector.

cs-initiator.bt sets up and runs a CS measurement as an Initiator
cs-reflector.bt sets up the device to respond as a Reflector
---
 client/scripts/cs-initiator.bt | 6 ++++++
 client/scripts/cs-reflector.bt | 5 +++++
 2 files changed, 11 insertions(+)
 create mode 100644 client/scripts/cs-initiator.bt
 create mode 100644 client/scripts/cs-reflector.bt

diff --git a/client/scripts/cs-initiator.bt b/client/scripts/cs-initiator.bt
new file mode 100644
index 000000000..8e439a1eb
--- /dev/null
+++ b/client/scripts/cs-initiator.bt
@@ -0,0 +1,6 @@
+power on
+cs.role 0x01
+cs.main_mode_type 2
+cs.phy 0x02
+cs.sync_phy 0x02
+cs.start AA:BB:CC:DD:EE:FF 30
diff --git a/client/scripts/cs-reflector.bt b/client/scripts/cs-reflector.bt
new file mode 100644
index 000000000..7765804ed
--- /dev/null
+++ b/client/scripts/cs-reflector.bt
@@ -0,0 +1,5 @@
+power on
+cs.role 0x02
+cs.sync_ant_sel 0x01
+cs.max_tx_power 10
+cs.start
-- 

