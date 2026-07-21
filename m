Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAE73BBFDB
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 08:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623292; cv=none; b=uq30kR3NsIgowal+74uOs8e1AwuB7iX+qQM5cvTFuP1yZfxM7d2YCHqu5Pty9YB0trHxWFWC8KOA8M8WthDF2evcwNPwH1zvT+UDeqyL8OcQLOZEJqEPxHo64FTDdu7XN2Z1+aSAHmzrvXYB60iRtZt3QEvYpAc+oEStC1oCvMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623292; c=relaxed/simple;
	bh=iWL7k7nq+xKvNzFGZWcW+jCfyjUbJd79CDz7p/CppRs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qcupw0FPhqXGoyCznvswLmjQJIH9gaVj9FzOBNSsiSxW6x0qnhX+HpmhTlhApJCVvbCGC3kdzt4jApSJkL7u4ZKTe9kB9Mm8qK6cJRtq8v7lsjhvYTqvLl8oWjOqU6OToks88uwv5J3c8blISrrjLyL3OHFNtyDXgeHtVGaTnaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XfTsv5eO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y7vce0X1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XfTsv5eO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y7vce0X1"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L80v8K043258
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 08:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=0aV1tE7qIdc7iEELCg/VpR4KyM6CxY2QRix
	pWkd9XXo=; b=XfTsv5eOn3adhtX4ygW1plnTs17ociE1dcnZayzQzTCj3V5aOtN
	kNMDOOC3Re10PLGT7Sbv/79jJgfoUF2+rfZTpR7DkbqBITrbf+CwaR1Iw4be/BnF
	XdUHCPw8MCXBPSOYYJoDR9BHvCl3lGINnTZcFW/nPSTD+CXQZF3sC+q0uFBrS4xe
	lQ4LwFDcIQVH+st77PKsoKugKhU+4/+aOou49MG/zcWylwDviPQ9qNUd3KyNkydc
	Q+T3nQKrIn/yTBcRe2PHMoaPBfWF1+YhYpfhT57jPLLbbs7tek1I+7FIBJj+mXXG
	t+A7nW1QfltXTsiNQkYgAZWVfr+HHxfc5vQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj0as1geq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 08:41:30 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca8aee88725so16875029a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 01:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784623289; x=1785228089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0aV1tE7qIdc7iEELCg/VpR4KyM6CxY2QRixpWkd9XXo=;
        b=Y7vce0X1mByzcfBNWdYdyoaHeX1xr6CHDhxzPi9Ijy3q5eqDmZrydxYQSKIeja+ED6
         TG6hbQmt40gh1Cid21d1Io/xQPQdK4rPumsBeZV3MnwY6wzLxYZLB5rS0zfVwBe0qTNW
         GIq2EAh8UZDhjX0v9h+7FZCTJYcHLpxU+rM87omuKrzePQmPm2AKtYmTwXPGp8/mypjR
         1Cip9C51xcJ31AQ377g7c2RJmFgDNtW8ufJeybU3dNXK9K0HU2IMqZHM6OHO57EqGIF1
         Y9DDOcy1O7/VNSsRZ5XZF/Uhk2LygSdNn0hQt9Q0F41SlBqVmYVCsYlwzs5PyAk+jM28
         v94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784623289; x=1785228089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0aV1tE7qIdc7iEELCg/VpR4KyM6CxY2QRixpWkd9XXo=;
        b=jNaDLnag+VXX2LH0hW/A8YZpGoYXfVqzVtGO96P98AXMgU7/EF2Vk2EvmIFgRe6TBM
         Odfe+uweDwMOew+vN4nMiU6H2mmN0n3SaSlQnikCrEqcdE3GtlFj56zDLwXXVhFJvFyU
         dqUTpRab2YQPAot9tU7sy0+Abe38oUITLQ7ZQmh/2GU6z5nnewfeMLXeTJ5nH72vK23b
         VJY79sqP3lYkaESd0FeB3q7792v7hgbBXFNQZkFAC0ITR/gDKSIq95U1l7vunH5UteWC
         dgdAgW/zMOzKU3fqv0Ivd13dHON1RcLxJzBkPlMQRMyHeIfO+Bavp8mFsMAfkP6fD4cu
         KZQQ==
X-Gm-Message-State: AOJu0Yw0knk4aGG5EPt5OCpN7E/HwTl5pU+UXM2w4+RB8kGTz7QHqmce
	SzTd+2J2yE9R2/IM5G1g4nxWvW8/QbzZB/rRkR1I3G45esM5/p7Qy98ucMG6LZtyIb93DQhCgqt
	nrTnNC5OjRufSIXiSC8fMMr2iwLk0QN7bToXjkKSxixDHf0dDQcxKKxxgpzkWZ6bRsxwAfYeajF
	IdQXs=
X-Gm-Gg: AfdE7cnZMEsXcsPMiQjfUIeeJKlEQmFbV5s99ImYTgfVYH6YKEsK9Gi60uukccPpOuh
	VUIGiCwxt8EJoG/8BIyp2UAscaIzTgAtlVLZrbTuznGFoeR5QMo8Ehh+0xF0v/qJHCL6TBfxuaC
	vZvW795Cu9kCE0H+YmlHX0pHnGhZfNFcRdUGNFqBkq7m6bQt27J2Az3sVF/Y/vl/pvBK+Oicy8p
	FVxr2l/QKWiAflr03jEO5ZPSF00YJ+H1D3GygdfTJbgti/++FKlalOrtH7BPsvT1Cv5Uyrhe6pK
	GT5BinQxqwY5YkfL0zJAiTPHmScLR9PtZPLFjYmJY6/D7I6eBkDRiZoGBW0OR73Se/UdJZ6TIPq
	RIca04i0ZFkfEDkxBJxVvlLMjV6/rXQ==
X-Received: by 2002:a05:6a21:7111:b0:3bf:b8d8:8296 with SMTP id adf61e73a8af0-3c3ad7a3db2mr19499392637.26.1784623289338;
        Tue, 21 Jul 2026 01:41:29 -0700 (PDT)
X-Received: by 2002:a05:6a21:7111:b0:3bf:b8d8:8296 with SMTP id adf61e73a8af0-3c3ad7a3db2mr19499374637.26.1784623288962;
        Tue, 21 Jul 2026 01:41:28 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cbb7c5sm38063131c88.10.2026.07.21.01.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 01:41:28 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v5 0/2] RAP: streamline session handling, reflector setup
Date: Tue, 21 Jul 2026 14:11:19 +0530
Message-Id: <20260721084121.688467-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA5MCBTYWx0ZWRfXz1tu4SaNbi3v
 10gzkrYtwFpi5V6LNAGZntMWBeYWyJej049RlhDihn61Lkf9l89RGtOYDZgsIO/WA4NBmGE5NOJ
 cPbIkxfwERQtVcim4vTpd/HWHaUZQQ1ZvECvjgS3rc2flvv5MGJqzrVD8x0MsO6NhnWF9kCHDGR
 MM/K/MD4iLJlhb2gJX40VTdcWqC2O4r32x+YipuGBhR7s31EleMrsRX3TLvnNk93ttOLkx3TfHF
 IFg7LoyMYigN6oBJtVE/KCNwMozqe0MOih3IRo77SInOKkoY3AsCZO/7L/pk1RZ7H644MPN1bkI
 xMaNmd2jdRzSXOzIU/m9Sgnh6VimEoP5lyQys2u1jqFs4Y+RIFp0TNRt8Pvllnob1YMg3SeRIhj
 fvuKG5kLqGfuP87Nn57rfhFWFI6CYjaOqva/ZUz/xvnHkThn0Dl07OtdCDhDu/tlsc8ovZJQ8t/
 RqbMOEjr0xu6NJHFZ5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA5MCBTYWx0ZWRfX5YlI4HulRbpx
 PKnQ/Rqvcu7lPJ2KzziM/pn0gdBDNxR7w1m1MJINsUIjfOKmpYTRf+YWRLr/uIh0GodnmOY4dq1
 GYG5xOSlpjcuj6UgCa/6oongwGIBzEs=
X-Authority-Analysis: v=2.4 cv=DoFmPm/+ c=1 sm=1 tr=0 ts=6a5f30ba cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=_c9e5DeZVSX-bzmOpfYA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: mSht6sKjXxlfeKlLBtJYPFlQd5FCH7Es
X-Proofpoint-ORIG-GUID: mSht6sKjXxlfeKlLBtJYPFlQd5FCH7Es
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210090

This series removes RAS accessed callback bridge and
switches RAP users to direct session lookup.

The first patch refactors the shared RAP layer by introducing explicit
attachment/disconnection helpers, adding bt_rap_get_session(), and
using session lookup directly from the RAS GATT server callbacks.
With all users migrated, the accessed-notification bridge and its public
registration APIs are removed.

The second patch updates the ranging RAP profile accordingly.
Reflector setup is consolidated into a dedicated helper, D-Bus registration
state is tracked explicitly, cleanup is centralized in rap_data_free(), and
RAS accessed callback handling is dropped.


Naga Bhavani Akella (2):
  rap: use session lookup for RAS operations
  profiles: centralize reflector setup

 profiles/ranging/rap.c | 137 +++++++++++++++++++++++++----------------
 src/shared/rap.c       | 107 ++++++++++++++++++++++++++++++--
 src/shared/rap.h       |   2 +
 3 files changed, 189 insertions(+), 57 deletions(-)

-- 

