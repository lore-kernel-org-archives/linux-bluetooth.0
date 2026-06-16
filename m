Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3440372EDD
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 07:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781594579; cv=none; b=s6Vh9FdjhfOyA6YTeYtzTgLtT7Aqc8pMxa1Se9Xj6kT5Kj5/aglIXoIdtLs0iVDswrAOdkDXPkR8XGUdLyr0VXk6ZkRm994QIuAALKt/zWFtl0l+1XA5WRnIfnoa44CWcWi2zYCwMmEpEEP6lCnDPDU9tA8KRnwyyE5hlo+mApE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781594579; c=relaxed/simple;
	bh=Y/AVEWTukCKk1atqO7jTKxRjoKIvVkTH+AX+yoawsHM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KoFSycREMFBZGcc/989WSveoIWrmR03AvksrI/hD71iz7kEeQySWEm42c7OrCkkwrj4+Dt8uy0YsiMzNnkL1kvEBHVy8rRp1KJ0ASY4G310Z+hoEncYRv0kdXwTKn/+vcBQV/tAB1qfFh3AO6xl9y7e59U90vxeru/XI4k0UPDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YXjKpR5+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RX43YXql; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YXjKpR5+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RX43YXql"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G7I11j2832536
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 07:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=qbjaVejNMnUphJ6fT0U6HwlwUOV4F+bhuGi
	fsilPQsI=; b=YXjKpR5+80gbec6055+yJVKG5IpKdhZUW8IHMFWyZQ/22gddCTF
	Axl61LN92UxMR32F1HC/qrbSz5BeBNeeS8sDSH2O9Bb6fvH/PQL7nrjABwmxJ/Hx
	AHvTcnd9Dryj0DHaXuAjHw9Qi9o18ynHrSG7JNeY2EA0njFPc+XDg42OUkFZS/fF
	i8iAYiyhqbQmBtKigZ4HVTSYkTfQ6J/C+cTaM6ycSR+kN6qQLEaqTGj77a/YFxWl
	jyCoFbZiJ5q7eOQJYophgpH7wEA0ST2G9o+h+ZMJb2CU0NusqJ7STinpYPHw4bq6
	AsyD0bJFXYgq3beDmiluz5BgGeyWrfs5ChA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1ysr0mj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 07:22:56 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8423f1fe39eso5078943b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 00:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781594576; x=1782199376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qbjaVejNMnUphJ6fT0U6HwlwUOV4F+bhuGifsilPQsI=;
        b=RX43YXqlYAdZuGPDkCNGvqRms+txxfnvrAvxKYHp/WrneIIxdJ2mhq+cx+kkHZf5Bh
         e8sSlHf+BsYNqFHA4/0bwB9HKkqf5GY9lRRjvj3NqwOECLzFMc/+hQXJ61VTUKap2eYm
         dSCZnQsfMGZbjQ0HulOhlh5BsPsJb0O+L4W1SXMWT1PUXQ9P/NHzqe5xOhyAIywBUINy
         EppVla+4P+twBDzx41s8ROaZA5QkotamjKGjUUSJodU2MnyZ93YrT8zCvwklIvMM6B+K
         BGCmGJxtelPpL5CZdMcl1r5sQuwHysd2LYHgWKav8lFCjvW2XXR6dhkt2yBndi1CNI/d
         M/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781594576; x=1782199376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbjaVejNMnUphJ6fT0U6HwlwUOV4F+bhuGifsilPQsI=;
        b=qJknj/JH1XcgFrFGT9CJQ3GJNEZ0CXfiZ3lpbVuLKzwsIPHCKHeHKIQaUJ3P8OWqO+
         ydnfcZMyQeoUtVp0m/uy4FvFRSMmoU/SA61QE3g/For32GkXDhnJk1vw7SjoUdi+J5rz
         mUzQYkniUMIdq9Xi02366CDDR4yzd3Oqr/vH/B3y44SNYe029FVnNh5v0EZ3vIeYauDf
         To3TSpgKMrEUOpvzFvMzCzIe9tKQM4OOwYd+kI1F/YSge7RHqqeSICQ/WBGL0SSbCmZr
         46LO/G1rliUgxfnuonIMHjKMHYr+z0bdm2yUClvi8HDs+ABvk3GU4RWX1XdcQjjmE0gq
         w5vw==
X-Gm-Message-State: AOJu0Yy6Y7wJA82l/zfuALOoR1pKQYkyouXLjqffT6fdmTcaby41AjOu
	l9wJcSjxjgM7IR2YfJ1C5nWraIA1o8ydFQoBpYsyLtmBkMGUAanOpCs7ofvvGk7qUTjeoemlEc/
	TzMwa7iknCYz4/iQKOqKD8MByOZTKg5eF0iSGmVv1KUn1QYjIMVCh35owwbsGbvnpChmOHrmnqB
	WrQbk=
X-Gm-Gg: Acq92OFBzBYiKesR0sYWia0oNUs6a1KmkNKwBpwm1Mh+y2gatIvCTvmmVYjIwKwZ5HH
	ZBUzssWn5CfzdTo6yoZzx+rSfJxqRqluKYX5uS5PzE6UMdHrhk4fi2/VzynhWsF5IqKY3Nz3KHR
	44Eam+cm0fX9vvtJgk/tlFZSUoOeaU0UGfljVTUE7q/sC9LL/4NczsMVzPVYoL3fZRQ6v7zJKbc
	d+h/ptAySTjwUYNvRc+FTtlB1SEMkDFDCns2NyEyEezBDGQUv1Ic6jF1LQf2WTmfF+lp9WogAZe
	5AjgUhehqdoGe2xOEdkU4fUQqhDWAAFajCBi8hmIYSwhkmzCMhcrkah3noXjfatCKZP9mxlfcaW
	N8+b+AcsFCHJJjDjcXq+yG5nw5UlyDV1hGwXLUU/mtP3wP99H79s=
X-Received: by 2002:a05:6a00:4fd5:b0:82f:9407:d167 with SMTP id d2e1a72fcca58-84515632ba4mr2578337b3a.38.1781594575960;
        Tue, 16 Jun 2026 00:22:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:4fd5:b0:82f:9407:d167 with SMTP id d2e1a72fcca58-84515632ba4mr2578309b3a.38.1781594575530;
        Tue, 16 Jun 2026 00:22:55 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b057461sm14394934b3a.58.2026.06.16.00.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 00:22:55 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v4 0/3]  Initial Channel Sounding Support for
Date: Tue, 16 Jun 2026 12:52:42 +0530
Message-Id: <20260616072245.3700010-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LfLjaM7suzlwnib8PgsE3zChubv1RhJq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA3MSBTYWx0ZWRfX4mVUz/Cpz/1v
 UMTGJD7cKcIpAUUICXSBm9YpzDOCicGmJrnzrwFn3GFLxABkExZRt9VSr0BiwtaocFjxuBwfGrc
 zrNiVHnd7amH7IsPZGC3SBbWWnBpHGc=
X-Proofpoint-ORIG-GUID: LfLjaM7suzlwnib8PgsE3zChubv1RhJq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA3MSBTYWx0ZWRfXyJz/PU+kfN+n
 5KroJyWRnVp72J1Dgu2xSlORxlB/Y2FopbkIlsRXQH0XCPgK/SVs1PfN9HpMUhaDWxyU6BvoFMv
 zBPALNJg2wtIQLEaQH2puHxn4LmHhHCsUuIWW5p6A7L3rDTi5kbg145Htf2aMnK2XDpXWtDkBAX
 xR/B3Biui22rwZdYF8k06hHNLtMZA2I3+N3ej8KK7WbzWXTqfh4B41ip3+FdcUOYDJfliLsTwQD
 ClmDt16kNSYxxrwGljEE9aIHCF0wele+JcZY9oVclJDdUcNZUxfgHZChjwBfwrSGnZAVSstcIP8
 DU11KfXHL7A2l0l4lqzYJvSHSSDtDD4dCdWqM/mntNHV1Ki90x5egLV2K9Evu4c6G9cgfxWa2PT
 lfl4wXFtIyH4meZo5B6Aw+DpXdSl2Qi23ePBPZ7Ax1FDaQQQTACmwjdOQIHt1v+2GAD1920hw9o
 +xebcMZDxiRZfejg89g==
X-Authority-Analysis: v=2.4 cv=JJcLdcKb c=1 sm=1 tr=0 ts=6a30f9d0 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=a8MP-ZpYLpGbJgK_Y5QA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160071

This series adds initial LE Channel Sounding (CS) Initiator support by
introducing the required HCI command flow and event handling for CS
procedures.

The changes include
1. Adding an is_central parameter to validate that
current local role is central before issuing
HCI_LE_CS_Security_Enable command.

2. Introduction of initial LE Channel Sounding (CS)
Initiator support by adding required HCI command flow
and event handling for CS capability discovery,
configuration management, and ranging procedures.

Changes in v4:
src/shared/rap.h :
 - remove extra blank lines before last declaration
profiles/ranging/rap_hci.c :
 - add _Static_assert after state_names array
 - initialize send_len to 0
 - remove c++ style comments
 - remove forward declarartion
 - remove dead rap variable in rap_rd_rmt_supp_cap_cmplt_evt

Changes in v3:
src/shared/rap.h :
 - add wrapper API to prevent compilation issue

Changes in v2:
profiles/ranging/rap_hci.c :
 - remove unused bt_rap_set_channel_classification
 - remove __maybe_used macro usage

Naga Bhavani Akella (3):
  shared: rap: Check role before sending CS Sec Enable cmd
  profiles: ranging: Add CS Initiator cmd and evt handling
  shared: rap: remove the old wrapper API

 profiles/ranging/rap.c     |   9 +-
 profiles/ranging/rap_hci.c | 734 ++++++++++++++++++++++++++++++++-----
 src/shared/rap.h           |   9 +-
 3 files changed, 647 insertions(+), 105 deletions(-)

-- 

