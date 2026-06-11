Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D353EF66B
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781179254; cv=none; b=rGp8Hf2Vj20JLxasEltXQgfaWSdaNJl5AOkTsB8Qyn9rMIu1AfQuScCIK8UxCrOPNoNxcBIpC7v9ip1f4nyiJExjCcOzirmBP3BtkDDobA/G8f+BLShuYl4qXqFYmwv0FEuG/iMUVTgo72Iv9OZY4+AYnxhSJ7oyBS/G53Ct85A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781179254; c=relaxed/simple;
	bh=aIGBqMaF4m8weI9Zk31bXZtNsJFirpF0KUt1kvdAcm0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RkbodD6wGxJU5KjWtAqF48GQ4f47SzT7jm/81Mh8rVVtLxNAy+iDM+HBKmxIbGCrGJb+GbYqGCSZz14sfB9UOQw89TbHZxS4f6roIToKX0CLFnD6zqB4v9eZzFw9xkIuFl1xwhXQ65PGiEIpcAKdyEPbv1fd/S1l8cxBgvIftO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fko7wp/k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CkiXxyy+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fko7wp/k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CkiXxyy+"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B9xSqY174165
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 12:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=UmkNEjuudCpY40Cq+SJSSwt+/XQ5D/g4ZC1
	6HOmYgvo=; b=Fko7wp/kvUmLS7aI1+zyj3udQWYxfOoDE3lqFhiIToI0Te7bjOE
	rUkJfxKnsd6Sbx8j5T9AXKxRfo934dyK9aKj844SUG4ZbwqriiAS0/jNWDgIEZvZ
	GDzgw+mt/TX3CEeV7s5AkRhklhGWyyoOr81dJufp5kfEe2Uao2OqltseCRiygvkH
	KeyHJGeLn7WCpQS815yXNBlPD5YLZmHdxJ8ZuIj3AS86kS4S4inmyTjWHrNqhnpH
	h1r9PzeqAY9RBfFNSk1Df1qTY+SYy67ZkKQWmnkF8M7Mr8ydbtOWDLXJcFoVtTKF
	T8zCQnSn2nXVc1KT/n6U3tE/YtDQqKAQwBQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6vb6q9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 12:00:52 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36d99629fd6so12703958a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 05:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781179252; x=1781784052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UmkNEjuudCpY40Cq+SJSSwt+/XQ5D/g4ZC16HOmYgvo=;
        b=CkiXxyy+1TTwEXklC4bsV8tp2NGyEAiZX7/XYJpUxVP8ppMxkWp/igz0fNodxqIDg3
         D+QXTluVJg7A7iKsAA+XGrugZvX9bEhWdf9QPNhyriCsaLyXwueRVNaIMDzoyicgCC11
         kfNt+3B9c8MKNWm2ognw8rA8QrN3CG5CnGarAr5jucDxysCCvSr3vrfPmUnTKpX9Ghy9
         7jN0Vu0IznhNRjKhFmWTyCnekrXGUyuM2be/rxnZSEN/cUNKesdhhRNSRPgDx5ixIkiu
         8r0rtlO6yqi+wy9MTY+Ji78W+kOAVL49Zuu+4q27IFrbylxqWbScH3xdTElgi3BbxyIE
         1lPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781179252; x=1781784052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmkNEjuudCpY40Cq+SJSSwt+/XQ5D/g4ZC16HOmYgvo=;
        b=qn7ExFH1BLSifpCd7IUwBXKviGmxG6NW29Vl1QTJL4zvlBjDDx01VCsYgiwGIIIaue
         QhBsqmrfCx36fI7r1SQoyBWX5VgI6TfzVBF50xYILgUPe5qYctON07zArDWg9V8lWsjA
         lTSwq0YRDTQH17+huK87wwsrmNJsIODY5oJ4JWJabvaJgj70qKq7+q3LqgYt8SCrOTMW
         46hwONmRP7k4ONFxnrvP0nu5bYzyOlX/V2Jx5esMny3BvwbwrnV9nF8TjlnEZCWH718q
         CG3eZ1xBHFfM8Kfv5NH/R0Dam4fhj2cg+0B4rLtoPG59Fm7us5ulT28fzVd8o6O4KHaN
         XUng==
X-Gm-Message-State: AOJu0Yz/4lgr/GaK8ZzsgUGxMis1jv+lj+1vwBM5nVJ7pu2Eo4cC9yrR
	R3n7ZRguPLphVvGMpAcG2XO4XErxAD9IHdq9BPMr+2r4o3xmx//Tv6PtSidhWxKbpoQvLXCeM8w
	9hfFmcSVk4ts2qwb/dZWUgDlpg5DiBS67MqdrWoxnTqF1FdNJhEF3oRLdYgEALuUYKCoXMIjiW6
	F2r28=
X-Gm-Gg: Acq92OHAgUwI4K81zG2HCWZd92RGDg1TE8VfKbypK3yh98oi0oqWLrXiNv7BetXuOGC
	dWoJbcBH0PoSMFbFMYl0VcbqjfMtnxneKXurZ3QWkJLymkdzRcVPlP6CoMgwdsMplzMxLezvFQN
	/XfBi7Wq6DVtPSYUT3PVCpoTc4ERZxNZwCKwOBikhBsOaxgl85OQq9MHte1Xocu3ZZkaYoJ1FgR
	fqn6RIpeFF44fwlbQzGqkKdivyH/6Y5PRPunPUdQXph1JhhuA+LywEd6pAZ+sRR35RrtYoeNuwl
	rszGIT5IrjgqMra/SG84sV0wK0BFwdAvANpgGeaPryEJgwCR1mFZ0hu2tfub9bgUntW+AH5JAn5
	bLNTD9nGfN5OAMopFDOFMYh7MYbOxDblhTWQBpd3RhmLxxHCqX3R94zNsxjWYBA==
X-Received: by 2002:a17:90b:510a:b0:36d:ae6a:22f4 with SMTP id 98e67ed59e1d1-377a5916a09mr3055865a91.15.1781179251921;
        Thu, 11 Jun 2026 05:00:51 -0700 (PDT)
X-Received: by 2002:a17:90b:510a:b0:36d:ae6a:22f4 with SMTP id 98e67ed59e1d1-377a5916a09mr3055832a91.15.1781179251438;
        Thu, 11 Jun 2026 05:00:51 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37755e5c283sm2437402a91.15.2026.06.11.05.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 05:00:50 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 0/3] Initial Channel Sounding Support for
Date: Thu, 11 Jun 2026 17:30:41 +0530
Message-Id: <20260611120044.1641009-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: EjRQvZKbdVvmpN7Yh3lu-Z4ibDRDU2uw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyMCBTYWx0ZWRfX5kQI+9N0ht4t
 xbMKO+T2aYmODDsQ+nsaxcHXu4gdtua5ycV/j+mJEtM+MyFM/oJSkp+yHhkJxEQcLqTVCG9/xNO
 +GGVjdDKUXY0SCNJ7yr4YgB8vkg7gEc=
X-Proofpoint-GUID: EjRQvZKbdVvmpN7Yh3lu-Z4ibDRDU2uw
X-Authority-Analysis: v=2.4 cv=UsRT8ewB c=1 sm=1 tr=0 ts=6a2aa374 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=CzZSiBo0_B3LjhG6Nv4A:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyMCBTYWx0ZWRfX4t94ybCFHc+n
 GrWohThS0rOWa8IB07LHS91ClXMN1lLfTTkCH0mjoGZRtDLRLf5Gb0AT5HCiocjgYNCIbKyNBlp
 Bg5r96uWzYYayv0iKHaAC2zwNNex8MLS1aucfx5rB7pTOmisoBq1izCPlRSIkZi/RKAFApbN1w+
 VpX0GQoby3Y/mODy9xYyVzWllJXPhn5Q7mbfqYIFgmHej/mStobVpYs6263nWr5mIxqfef6ZyFQ
 oWdEK5lQjGbTFuNOcWsNZrqm/Ll+dmwZM/4hYeElMXOlNapVNxuBEWADdr21kd7GbZfLSQjv4M9
 D7HVlj0ptHvDjUl0HASMTmrx6PC8L15bq+38OQC0GpfeZWVNPwo6NnX6k6DeEX+te+NQLDEcd5B
 xKzq8L5ZekyfKy2bnRJcA7HXTdaCJVtTajyOJOoZa4/s0kJiqXalLy6LRZRoOcYERS2LMpUFzFe
 Ji1vXLf6AsgR3L8VgSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110120

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
 profiles/ranging/rap_hci.c | 763 ++++++++++++++++++++++++++++++++-----
 src/shared/rap.h           |  11 +-
 3 files changed, 682 insertions(+), 101 deletions(-)

-- 

