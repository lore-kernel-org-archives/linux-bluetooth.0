Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D9A35958
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775126350; cv=none; b=nAUt2/+PZm4H+HldPJvgy7HkCpKZMcSn8l+2ogyrqwOCSM9FfhlhC8p02nybocSgrQjRVHSvlKJgkDKM9JBKgrb98yVDSakyUPs3sJxrwsovKSv9dwfN/zt44OafAQuvlOKhXoztt25XF5FsoC4wI3X4/+OSQ7b8rw8r3emhKok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775126350; c=relaxed/simple;
	bh=IGo+VtTVcAdLl7TWd6StLn712Rxqirrb6mcXg9VM+BA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fwxSa41jHPZtW18ILeTyw9yWPStBPC56qWs1BtSKM/d2L9A7jCBzi4QAeSC+AafE49AEhv3DNPQ5pc+kGtA5SU7KzEpIUFwsM9DZCJjpTajLUY7I3cQvMiFAkrxymf98vduFjjBMypzhQWgrnu1YJmzcs4zVwQ8nl+yHmLcbmYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QVLTPc6z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GYfY25PM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QVLTPc6z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GYfY25PM"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6328d9x81249504
	for <linux-bluetooth@vger.kernel.org>; Thu, 2 Apr 2026 10:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=yqS0tMww/Zk7y4AE29MnOMKWNHSW0aOdFmd
	yJCB9xHI=; b=QVLTPc6zpTh9FsjgfC1XNUMgercFJ7fJU6vgzRjdbWQA5rrAxYt
	gHQLRirs1JOuIl53AwYfy6eg/7yGUOq/0kVW7cxGjerhxpdRyegY2WId8krurjcl
	fuCZ95EHi/0i9ECo5FeHR476ncvNy2WZO0Lv1SS8LQ1doMqX55VS33guE4UCDAoR
	tP02tvYHGxp6b7rkQsUI6CQM5yHR69Jenn8kID7Mb+V+xI1JJzHey9QXV96AmdrC
	GdLk22+qQbW2vTvqwqGAT2er4XMLJO/+VVMv3OdS9okB5NvM4xoNEeNB5PZNht6s
	IsVmLaV0t7z9p0WIs+ImRL+uzOqLplZrG/g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9n4t0f11-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 10:39:08 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso788983a91.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 03:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775126347; x=1775731147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yqS0tMww/Zk7y4AE29MnOMKWNHSW0aOdFmdyJCB9xHI=;
        b=GYfY25PMVqx3a341OF8aSTn40utvad+yPtDMWLWaFsLG7nHU1kAldAoAu3DfSiP+TQ
         XtH8cNkTkVhKahi4mBjJ0NEwT+Jp3y3c0lkhkkyFdOi05Y6rDw0UStHXrPwW+GH0EfgC
         ha0K5tMdVpBt9AlwjNOVFbyz8eIWh5HvVXS2GIfyj6AelcSWeqWUqAYOVXr7kfD/opfp
         vPyS0EkIL/KyW/MCAJxXdbngQfJUEPXBV/kgI4Wd0md8w7QQpQTzqPqdVFinsC6BaHG7
         35Y2MEu3RIce0/Te8kwhEZbKDGfHAxCC2MKYaVtE4ejG1hs97EF+WJ33/25Eo8W7n6kh
         NgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775126347; x=1775731147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqS0tMww/Zk7y4AE29MnOMKWNHSW0aOdFmdyJCB9xHI=;
        b=f+6eyzlErbvf/BBeIbqTwBaX29bDZdMxFzenVhf65SkmHlgmhhIgCUYxnRqhMUFYT9
         MG4BzGkZqOMy9P913KAkXSzCTzGpfumWcyxp/d7DRfsGLqpfEwHTf4reDVM6B2j8IXLq
         fL5YFeH9tXHs8rPnG8/Xz2WE62lUbDHBZnvYVxXgDiO0niYARuJazhh1HZvDnlVZKMVi
         zw6v9/tTIzsqeiF4J/GOWKFwpc3xkd2pxE61XrXnYBsceT9Ejk9VabPIreaBxD3XZjXb
         8uIGBemoZoLKkoS/6L6PPhdYEN9ZEgPwyXGqCAzYJjtlZZNJKs4lbvImOSaFk/ES8YoC
         h7Kg==
X-Gm-Message-State: AOJu0YyRIqemW+Y/cR9sq8xdj0Th+f7hS0THE+mPZ1NOUjrLj0GZh92a
	4alJt7wT85TF2jhpd6E2dc9SuQnjYGvgEQbriUwGnf56B2B01RLMco2GNigSsvPzvl6zQBp5rRO
	5ZiWbkMSBZMU/ZJQ5jI+i7Ut2vvLnuO+Ej+l5S1uvU+ii9iYrooL2bwxC66Db9J4V5IY/CRK2x5
	tCHHE=
X-Gm-Gg: AeBDievmnBKV+t+aBBM0i/TWL0t/3PHrdDVPBFXMzyP2XBUrVCQwBLBcLqE9XHjlZYD
	KfI0eEU3cXp8HKEo0MG3VHcj/ULEFroofZyAJd6qV+3S7zRQiH6hab57kbU1eYWiXt6sxWvzWVr
	QjZNHB5jz8N3R+1atfDcU4Zg1R6RIqysH9upzanv808lgTRLbmpjcPpFvVaP/WTcw0rGkHPG942
	vHvZZa15N3Xv12FwGMkpKi4imZcc1LE5nULkrHmDrOXFM9+RYcTYLGlvTcovVFLx+ru5yeCm9hS
	4r6zP6dYt6QTz5469zrnJdW+BnWEvARulL/w7VmGGUcVq69+gQLlkUpJ5ihqaiQ8chfmYc1h6RZ
	jQhDmkW2Z/TFUUDWVgieszMIKxk53o2bgbbdvdvBfkYQuJUUjmKI=
X-Received: by 2002:a17:90b:4d81:b0:35d:a412:3c79 with SMTP id 98e67ed59e1d1-35dc7079cb6mr6350374a91.30.1775126347237;
        Thu, 02 Apr 2026 03:39:07 -0700 (PDT)
X-Received: by 2002:a17:90b:4d81:b0:35d:a412:3c79 with SMTP id 98e67ed59e1d1-35dc7079cb6mr6350350a91.30.1775126346759;
        Thu, 02 Apr 2026 03:39:06 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe624756sm9993420a91.5.2026.04.02.03.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 03:39:06 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 0/3] Bluetooth: Add initial Channel Sounding
Date: Thu,  2 Apr 2026 16:08:57 +0530
Message-Id: <20260402103900.310778-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mNlXwV_HZ7AKewnmP0uJ0Xozxy0ZtsZE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5NSBTYWx0ZWRfX2RWON+VI9ZE2
 Wf91IU7ZeZCA5BhwROT0dqcTvKNpIdeF9MLLzvkko34QGK6OwJP0Kmu/ff+v05XyJukJJWXgoa8
 mkQsAgzrS82UPvwBCALiPOsPr9Zlsuz3JLZqfktXcIpHXyxtd9x4FnlWozsddWTORX3+ygfETDa
 KpMN2Bw5D5mjIkXrH74JEUvNnlN3oROLGIZMPniawwFyKpiGLsADQ2xW0/AY9pK+x2rDVowj/NR
 bxYxHVJAFRvjPu1P2eGcAKNeByhRu3kIAx7lJblxmfE5YQdOEf7YwVvGrAMVuXcTMVqPolEPPD4
 U+zzTjKQqfZLxfvHtL7+W5lu6V3WMjrU3rRAmZNDB89Ths1efCW1BVFRnUGdCjEi1E6OJ/ByxZk
 /Uz1HuKlXIEBq+ynrC1w4oEt5+uCgvCrrt+DzGBNUALxvi0pKXWpJs/PrDU4MjRLmXPeriO0Wj8
 FK0tpD0mo4u1X6SLS/A==
X-Proofpoint-GUID: mNlXwV_HZ7AKewnmP0uJ0Xozxy0ZtsZE
X-Authority-Analysis: v=2.4 cv=Ap/jHe9P c=1 sm=1 tr=0 ts=69ce474c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=JxoTkb2ISLZPhhTfFPgA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020095

This patch series introduces initial support for Bluetooth Channel Sounding
(CS) using the raw HCI interface.
This series lays the groundwork for CS support by adding commonly
required protocol definitions, configuration parsing, and event handling
for the reflector role.

The changes include:

  1) Introduction of raw HCI support structures and callbacks for Channel
     Sounding procedures and events. This provides the foundational data
     definitions and HCI subevent handling needed by higher-level profiles.

  2) Addition of Channel Sounding configuration parsing from the BlueZ
     configuration file.This patch also updates the systemd
     service capability bounding set to include CAP_NET_RAW, which is
     required for bluetoothd to receive and process LE Channel Sounding
     events when running under a constrained systemd environment.

  3) Implementation of HCI LE Channel Sounding event handling in the Ranging
     profile for the reflector role. This includes opening a raw HCI channel,
     parsing relevant CS LE events, routing them to the RAP profile

Patch overview:
 1/3 shared: rap: introduce Channel Sounding HCI raw interface support
 2/3 bluetooth: add Channel Sounding config parsing support
 3/3 profiles: ranging: add HCI LE Channel Sounding event handling (reflector)

Naga Bhavani Akella (3):
  shared: rap: Introduce Channel Sounding HCI raw  interface support
  bluetooth: Add Channel Sounding config parsing  support
  profiles: ranging: Add HCI LE Event Handling in  Reflector role

 Makefile.plugins           |    3 +-
 profiles/ranging/rap.c     |   27 +
 profiles/ranging/rap_hci.c | 1296 ++++++++++++++++++++++++++++++++++++
 src/bluetooth.service.in   |    2 +-
 src/btd.h                  |    7 +
 src/main.c                 |  129 ++++
 src/main.conf              |   24 +
 src/shared/rap.c           |   46 ++
 src/shared/rap.h           |  168 +++++
 9 files changed, 1700 insertions(+), 2 deletions(-)
 create mode 100644 profiles/ranging/rap_hci.c

-- 

