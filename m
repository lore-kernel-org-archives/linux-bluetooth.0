Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1054B35DA6A
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019063; cv=none; b=Jrb74ZSV2w8RDB6nCQ0p0VU5XiRv05O0eAXbvUvdyf5zpZjGWvTeJNl/8NMmkvGyR4dtJK5il3+v2VyQOEYBHDD69Q8CVJqJIYTy7XY3i3Yc2JK+UUgioD+mvAKe4UiNaoKBJZNHTIEgEsC8cBSvqlM34BKFiCXbSyP41Hvu5Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019063; c=relaxed/simple;
	bh=1g3gh3Z8pyqg3gb7wfXA/rWNEia7jjME63ihTOUBy24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GzDAGr3Nd9ly0GF6tZYXWcqy+3yPzJXGsUENVB9En8Wi8Bj7fs3hdKJcj7aVkIfc8WLKi4NTNhAS7IayM7oK5uT1/C4RRlOVzndQxQr8guQltHsqVOfM9XAIZAgH1n36ele3VER4NxjmOsbh14N77NKawFCIPcOA4ReCtGlKgLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o3n8lf+o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LFbGUmjY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o3n8lf+o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LFbGUmjY"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6SOK53718241
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 08:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9geViHtlygy
	y7YVaSU28eZKbaOGh2uxztqaqJ3yvFrI=; b=o3n8lf+oazqmW/egH1UkVkU6nKM
	dVjZeBqQKDBwWKRJ+L+Ak9fRnBwVJtwjFEiGgQ7NpUPSQui++GmEBd1z0O3fg742
	eTBAIYjS1Zpr1JxNcicM0x8K2S4qy0JqWhGbF6XeWKsxcR+MbgkQoR8ntbKYJV4o
	p6R/uXxnEORJDhWl/5EkoIoXtXP0mGBXLol1fkoSQ0RQpqc4FNSlTrbsWnroViYN
	yD5rntEGmiKNz7NdgBx+kqiZdCEvego1jjrOZZIOoMc5AvGwE/JcA3a+JMSI815C
	N4mOre7gnLO6Wevohd5inrkbb67RN6DcyKil51iJGFS97fJDLkghbnxuMRA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd7gvj4cu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 08:51:01 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ca7c1e22995so4636967a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 01:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784019061; x=1784623861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9geViHtlygyy7YVaSU28eZKbaOGh2uxztqaqJ3yvFrI=;
        b=LFbGUmjYjmwdMdy3Iyz9iL2twRf4cK6DLY0u6T3I+b8vM2YUYjguOACJ31SCXv69S4
         cFsWnhmLq6hQCQxFgNgewu0nRBoaCfQgFN/sglQiEJTkSGmZlrY3wrhMwE4XN0maOuAv
         uqhvyrKaqssM1v5j2zBLF/SnMf444Cgj5viLcTiUvQ/XMh+wBY0XX711mDRWB2R6H5YX
         CkONakjhLyQXZDsMBpw+802lhsUcbe03QZD/w0FwIJuxALaNX7ZTtDfyyPbs1r1h4nVQ
         tkHvg9hQ89qahyXpHjVgwmeAdInc+XtAU/zmAqfPpMm6BlClHNW4dwZ4+WPOVmn++XYk
         xBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784019061; x=1784623861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9geViHtlygyy7YVaSU28eZKbaOGh2uxztqaqJ3yvFrI=;
        b=SDd2AM1gqK3plA2xRTj7H5hsFeASb/eJlix8ztvDtpqDKCZ1hMjNn1MUF0eR12bcTY
         Tfkk5vbEH0dD4GrI3cNltUCtAJJV3Uay2CxE4TtjwzkRocKvimLSSh4hgrXn8eAKw/t+
         H+YiZkcvhLxFJFvYnedqz7KvryDMSpN6GPDZsUWY4JUwNDhVbKfnp96siY91n0UmNUYJ
         xOhM1nSdur14qWUIAOLqdVU/UVtyF9w4dUx7aTkdj160nJH2GKgNpaId9FMz78ueJRai
         emVnuYU0Qb18BpUDnf2pnJ3jeQtia3JuKSTVu23rV68fzF16pHbsKo2EEiKRd+k+kZ0T
         eH5A==
X-Gm-Message-State: AOJu0YxZefdfn/26VirjSO9rlE5WzN0qUd7cnKym4q7ajmWM4kIFq6nx
	Y3ArXWiJfl9BMeHf5zXegQ0J8nRYtcuZumdztG2IuBG1HTjMf6gP1XYF4RNYYp4F9gDCmbGdsuv
	TzEf1rq7MHeYMgkYQ+/nAmOD1xwiqFAPdSrKYfAnUcOj5KZmQ9syzr0NkFcK0KnQcKKM45ZI7ws
	eAHbM=
X-Gm-Gg: AfdE7cm0I20iRb9kcqB7+L+4KD1KhDd62PLpsQ4FtmQuhmsvO4aNsThljLulX92zmuG
	1wM6SATqfanF6Xho6O9xg4HJgSdpKiAb99vjl0sFE6r2R6fyFcuuXSzVvK+wMQq4VNnp92vigpn
	7D9ucLTMFhepXIaj5mtiL8JQABRcQO6nSRYmeU/wfpWZGNDhqJMoYKVespOXkdJrvg0u1nFEygq
	5kYDoYSDgMUhT/vBCGTxy9TMRFwt7FYC8hlR/FEtVOCBsdozl1KZjxMBE/Fr6Ickqy+rafWBPJW
	ZWuadeyHDvR94g3B2KfRjnrMw/n8eH4qJ9yAZIj9pAV44/5+Ln2hqVpG8LSlT2uPkz0Q8QC7Bbg
	eE9XsLt6Lq3HQzttTkjNCgak331rSlGMFh+uXGOMm
X-Received: by 2002:a05:6a21:1f87:b0:3c0:cb82:508c with SMTP id adf61e73a8af0-3c1108b0c10mr13896116637.49.1784019060616;
        Tue, 14 Jul 2026 01:51:00 -0700 (PDT)
X-Received: by 2002:a05:6a21:1f87:b0:3c0:cb82:508c with SMTP id adf61e73a8af0-3c1108b0c10mr13896080637.49.1784019060189;
        Tue, 14 Jul 2026 01:51:00 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b9081d5c3sm27645721c88.9.2026.07.14.01.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:50:59 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v5 4/4] client: Add scripts to start cs Initiator/reflector
Date: Tue, 14 Jul 2026 14:20:37 +0530
Message-Id: <20260714085037.1285756-5-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714085037.1285756-1-naga.akella@oss.qualcomm.com>
References: <20260714085037.1285756-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA5MSBTYWx0ZWRfX6gxbCMTlK6ll
 q0cONQ4x+mnnqL3wOP5b5Db+FM5TKAbuvnc9ywLgRIemsL2A7hOd638PBnuYRrx8d1e6D91LOtg
 2gefFybHI201OfTf9Kwu9ZaLMEXj+r2VXOvqwGW11Eb+WLML1Pc8NsbBi1yeoltjoIrsqHOpDSV
 D6Kh0FZ+AqZUt3FbAtGx44DcqaB9zx7T4hBIdpDsQriA7iIa1+4+CMLVkv1cuNmZfL+4ibcrb1w
 FSjT7N+C7XXaJbnUFqJq7wVOMvTgCMVA24y1brO0VCOHwjszrxrnm8yQXyB1obGMTJNx3zl8I6O
 HLLAobE3bQysrXXbK1cDFjR0nKr7TgIbYXLRE06BqeX3Z/D7lbv86iU6xpCXV2kVoK54R0pi4X+
 nBQtNySkz86zMAppeY8rdfwzRrh4GdiL+z3pRqFqBQoUy7orFty7nTinnVuq1MVrw9XYpq/CtF8
 +IN5E7fHyHOzaHNINow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA5MSBTYWx0ZWRfX6pxWeL3+lein
 J3INgyhxXN/8IEblPEiVJLkKVzrs9k5+7CLFME42WIr0Smo8Cun2iwQabIpx6OlkKRxXnbP6xcX
 1jkCpvkwqahCXWd/Z64JJg1SdrXQF64=
X-Proofpoint-GUID: X7e-t4XhNkCftgpfZcQa2cSl5megfgav
X-Proofpoint-ORIG-GUID: X7e-t4XhNkCftgpfZcQa2cSl5megfgav
X-Authority-Analysis: v=2.4 cv=NYjWEWD4 c=1 sm=1 tr=0 ts=6a55f875 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=0vyF1ivmPAi-RmPqk_YA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140091

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

