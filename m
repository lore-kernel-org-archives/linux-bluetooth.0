Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2723F9296
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002221; cv=none; b=aFqR0mcL0u64S8q+2GPvXq2/UwKbfbBh/q9Lk8/+VWZQFMmyOKnWS3hQSVT882U1dG2QrilB5/Df9EFCde38xsASh4aE8Db81ET5RQdcEhk7U4vnQGXABABn8nBO3UZ/HOuqDrxzhWOJD2L6NaE89/VPli4ydfvdZZAIvrlC2c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002221; c=relaxed/simple;
	bh=hpxPyhUVlOus2WRAY1d5Gel+OHqxDco9vlmKQUCpjV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VJxC4VJgvd0ywGIz8MLI2AgP3sc9tVD7hJPqGeDkT4Xqc7/zrFvNe6QkGRUVhmqLa4jY4vfB7hVKdEMCZ46BZ5Ef5q1VsHXasoP15s08y5P1lz1ft98/LsNOMjKwXu7bXtqAUYPtTukco5vyul5KTIvvKors675vMJ+VsI364xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zbz485Si; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GO419xeF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zbz485Si";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GO419xeF"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6599xSAv2287624
	for <linux-bluetooth@vger.kernel.org>; Tue, 9 Jun 2026 10:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ocn4NjStbYcw5xpmiukHd2fPVDlLy365Oyz
	+hs5/P6Y=; b=Zbz485SivRRCJUVaJmVgqTzohYAbXuxidZDHpF4RJ742yHjKvb+
	xBO5u/Lt4EqzNGK3f/hxDtKoQ0lQjrnQhsrSjR4hQ+SbMXl28Dt/qsXB5vNWolI8
	cOa6EDg7WhL99pCQ2NAd/5M7Na7+aT0DeDkhMipmGhrBJRHXYetmkZzZHL336mn1
	nOvzsShH7gyHKUYGUppn/FosjA6MwBiMpjTX+IpQok2bi2Q5VywZTHh7+FYhvl/P
	vNKBxLhqr/RIqGzyknOAPjJRo9AHuej6xyWPbJM06a8keNFijOVG9pSpRCJMu73Q
	J1fkR3EMgCl+DTarfclWrCR3WPmI6VFW7LQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epe25rwsp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 10:50:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bf08c2a24bso51790275ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 03:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781002218; x=1781607018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ocn4NjStbYcw5xpmiukHd2fPVDlLy365Oyz+hs5/P6Y=;
        b=GO419xeFzUFRVlDwmJMWvfDtrfA5Gs9j7i+Ef5WcA0O2txt+T58nNKwtuxWpAMt9eY
         t5uY6ioc0foNUWrbqek4tMP+xNKlSa9eyg/T6w0fXUlvoUg2PP5FLce9B7YujFYF2ThX
         vf/iDk1icFFhx3hAGG79V3hUkQ4BqAhTpn0S0j5ShbCvrtFAofOdG+nrkCuKvdZ3HGnq
         w54ZzT3vUhorQVYaKdubW7fhTc+8raBF8cgKBCfICLSOJ8KFqu4dF9QDX9ASyowAVxuq
         RL1pbtKbgSeHKjxG+VTRd3MWwt94HYPKhGseGS69CZCJOGGHcQd5zQlOT5mgpitrb9ub
         Dc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781002218; x=1781607018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocn4NjStbYcw5xpmiukHd2fPVDlLy365Oyz+hs5/P6Y=;
        b=Xlx6dTgapVs4h/91rsOp6NyKvBRYPktLY1O/F+42JqaR8adrWDCwkQNlEDt6VTG6RC
         Boy2nq3s+WcQHGSVQpIXY6IGPxexIIpG6AAPXVeogfni5KR4gRNYYhWV7WJ3zm78Gi3/
         IMr811X3N2eyH1eCvO7ydEUsjlftDLN9fd+FeM6gj2qmXvS0JhLJKNobCGAIprQn/Xlq
         ultDH/SODNJ66nzV1+BTySsNDkGxAlOaABxS++JSUDw3dQVZpwSkM5TloJsgHUveNgRL
         gHjac5gmwRiKz1oGzUqmPNuJRCtjmO1cM08Dc2CrWjKfXLCdIlAYhg04pi6/9FiFV03d
         5UVw==
X-Gm-Message-State: AOJu0YwaFgM8LleG5XXNg6at5WLP+PjPAzQEbWqCqEZvbrE1phRMezqZ
	vv1KtSDRZVe1FN61UNiWNaIdXOkV1FpD6zKOUDafuXL/HGjphr7Ce0x3eTxXu25Qc5gHYOOMB8f
	E7j3F0uD7nXoKBnOm20rsMwN8Qp2yBPPA3qHfN/0V2EWodd7lLV9VjY8HbBJ/jQ+ejnUgXwB26D
	9ED9c=
X-Gm-Gg: Acq92OFzKvJRw0eLzrFjI/1HsQps3AE0w4MVsUaTL6CEsvLhYhduBvme5sfdgo9gqXK
	mnGGbm7SuIEY7IWgIwIBh0DrhR4NrgypIwzv+iIUj+yNy50t5kDWetPr1gPK9+jAPu1FJjOTgnN
	5x8yU13le0ZrV4jRE4xJBFsvTz1TNUUPIPqgrsGwUh70SLbHfpRuhfC1lYkPorUcl6963SYaS8B
	UP8psPp0KtL4RohRMrpg2sh1+gozlLlHicpG7OEmYxa8qHsi4lOfZjjd7ViIpZfg3NqEiMD3leP
	hCRTjxBspnORqLXpDvVAYZJJUS7X0nL9YOg2qNsjlBXHQct55s8TXUNpYBe9nOKesAZXX2uBMSG
	DHdNKkFpam7kv5nh54YhkarKEPzHOj4byfARhi/XFxymFKffNlyIdtijSCB16Aw==
X-Received: by 2002:a17:90b:570d:b0:36a:f612:e695 with SMTP id 98e67ed59e1d1-375211ae4c4mr2529931a91.17.1781002217920;
        Tue, 09 Jun 2026 03:50:17 -0700 (PDT)
X-Received: by 2002:a17:90b:570d:b0:36a:f612:e695 with SMTP id 98e67ed59e1d1-375211ae4c4mr2529871a91.17.1781002217344;
        Tue, 09 Jun 2026 03:50:17 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-371341170c7sm8864573a91.1.2026.06.09.03.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:50:16 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 0/2] Initial Channel Sounding Support for
Date: Tue,  9 Jun 2026 16:19:51 +0530
Message-Id: <20260609104953.3122718-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SUfKKTMYLW0tDV5kZ1CeUTHsf_2ZhFAC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEwMSBTYWx0ZWRfX+uOwrCJAwf4s
 iCs4uXvwdcw2CiW1hFu/7QS+DAmgdAkdyZPX+CM2UZ013wdMptfi4QaONj9FHXFP1VnMlbRz7E4
 C8935Rha+cjKQflCKopS72E1C2wJuF9m0Md2J/hhuiRnyn0A8N2CgnTTUOixWFqwElkExHYc2CC
 tAFF9xP8XuSqdHYbCSqrYnEmUYjZP3CmYAM09paGDxvaGl/Uwgt5TSOGGVmrikCqgHErNhtDntn
 oHhP31nWHwc2Yy5npb1os6jGX4EAbU41oDIO2f27J8EWc7eZKqlinxKL2uNr/HvyI6/Mrub6o7Y
 2m8YnWYky9jY14Bfnuk7bsJ6iI1sXNH5VwsJRDyAwPEcfFSapt0qOLEkz8ltCVDSWawwzrQhZKY
 KZ9aTlQnIxdAuCzpkU6GRN1HULttyWfzslQ5KIQoeMqqiDuzmDpOwy4Pc/SFDmS/hJfn2FN9N+7
 wCZm0vB/b9mPycnRiDw==
X-Proofpoint-GUID: SUfKKTMYLW0tDV5kZ1CeUTHsf_2ZhFAC
X-Authority-Analysis: v=2.4 cv=LoqiDHdc c=1 sm=1 tr=0 ts=6a27efea cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=Iyn9nFpizRfGCuZxap4A:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090101

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
The CS init pipeline is not yet wired to D-Bus APIs,
so bt_rap_read_local_supported_capabilities()
is currently marked __maybe_unused.


Naga Bhavani Akella (2):
  shared: rap: Add the is_central parameter to verify whether the local
    role is central before sending the HCI CS Security Enable command.
  profiles: ranging: Add command flow and event support     for CS
    Initiator

 profiles/ranging/rap.c     |   3 +-
 profiles/ranging/rap_hci.c | 876 +++++++++++++++++++++++++++++++++----
 src/shared/rap.h           |   3 +-
 3 files changed, 785 insertions(+), 97 deletions(-)

-- 

