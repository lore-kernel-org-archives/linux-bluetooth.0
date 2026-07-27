Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6C03DBD65
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 07:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785135617; cv=none; b=K27coqH4q30FKTT3+RIALqFyjV+Xj+u4X06iDdKlsQa03uLsIHCJ/dShp/dpZHixdZSpV7G4WYUVO7OEL/IdL1LkitrTIVMExwiBchOLl0aNTwSvX5w4t7JUQvziTHqPnSIKG7BS9Z0vSa7Jm03rgB31pDUdO8owomIYffgJSUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785135617; c=relaxed/simple;
	bh=QYC0wOFO5lY3FXi6A+gm2Te0n2hRVEJDdxKDjKxoD9I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FDBb2Sm8UJb5jnkSJQiFH9GAODDFvQzifkmSsDqO5gn+fdfKaGtzxBhc0GF5pgAudQt1Z2E/XsM8t7bSMSfQHHf3IU2xRlDRBg7FjNN+aOGn7l3u05cO01zbBpnp4tRhXvt0nStwVbl8HvIGdKTakAj0WPs0Gli4n4TR+0hMJq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JPsmwG87; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LG8ztrw4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JPsmwG87";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LG8ztrw4"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R1g3rs2257312
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 07:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=p1sWSrAxHV16wNl+mTy5gRyGWXc/NF3FLiv
	t9YPqNII=; b=JPsmwG87fNsCqnF1lLMjUPwPnkoOjH9kOF/GBiQlSy9zI7AMAq6
	/U6v/vpuRALRCXS0bUTdZVYwEHeIZmi+XwkC9D3d0213FoWJliVYO04xfbLJnghd
	V871hdKEwzEr1jNkaE+BjkAdQh4B3A1v3pQ4l+eWUGTQUqueIW9GNmnIiKACzkLs
	H5pEZoFRWjuCImbLY0CcpyjI/iEyy2eLP1pEwxBiGku5JHjcQ8kn2NvGqRPF3zH0
	Wb22TyZkIfD/s/S7DlvgRGvxpuDhOj4u9IiZ7IEeiZtOBeiVfh8teMg99+hq1mIM
	bAvlfy56gJkjL84N+v8Evr1swbmZSDAganw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmmfgw0v3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 07:00:03 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb733fc5024so3334906a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 00:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785135602; x=1785740402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p1sWSrAxHV16wNl+mTy5gRyGWXc/NF3FLivt9YPqNII=;
        b=LG8ztrw44l5eeyG8L05LkfMhWW+27EpcTkiIVFnS7Bpv4ovpwIbhMpMcxUnpJTRPBU
         vGitWR+lC9S/PUKyrAfb/c61+NO5rN99yMey8kJX2Lp6TMv/RBnyuCZ4P5+7jtQVbF5W
         NbIzgs9+xUtTnaKePMr6Juc2O9myvH30FVP0Su9MY1l5RB5pgkATzrJc9Ga6bkXhqqVg
         5J3+JHSwqFXhFea+SGlX8pNH3h3J5TZYzrSQrIXNfbnCXzBDZvhPxYUyawwovQLNe0Tf
         XIXm/GWfVwpWpGIm5ujjoVp+ZDqlaGZT51oFxNbIbUrT6YGSYoL3JunWtTnOV10vobQq
         qURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785135602; x=1785740402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p1sWSrAxHV16wNl+mTy5gRyGWXc/NF3FLivt9YPqNII=;
        b=F1IckckJbCec08R73QB/5As/rcJT6zAGf/mhdi/YCuWKDi7gcgqiNDkTdjyyC+Shqm
         zYhNVc2jDIHeTNyHGGa7K73Mh2CySe97Bx6kCh73MBv9mKWExxqyDdRrqIL2RU7rFIiR
         ILB6+uk9/1yqCixIZFD6asQ3pXAK3hgRV6L2Pt9Tp/Wuh5QyEo16CNA30qyq12nCHofu
         VOrZ7x2iNXsQ5+tDQ7MNoGBa5P8nIi3LzaNiy5x+O/rXHtPer8X/gjHkL/Sn8+0vTk87
         GQML3+J5RYsoJL+4qKig4T1aXedlumCS8axe+eIHaihWaGRSdJzYrLz1AwgnVykhZzLN
         kFDA==
X-Gm-Message-State: AOJu0YxojMwFzyxEAeOhzHhPbyu+9agPYVKWBSFSEcaKfyv9N8FzIt17
	8ArNvFSco1SsccV11pFL4aBk5jzBaYyrf3bF9ebtXrXBF9OWcGVSea/ad+2QymepstNkgX3yb8D
	oxIekweB6JMddaVKF6FnGG2tbrColRezd4udZ4iVoTc41q9FwwltA6+xltZXfmvjZyCDFtoP1D7
	xq3ms=
X-Gm-Gg: AR+sD101hx+D9VK6Zn0r7sRC46q+/EJFWUyo5FtE9gN4RU7BzF3vsLlVAKzXf7MHofK
	ONo/oUTIH8KVKcfJX2Im086T5ESf9JSaSkmKu5LD9K/MXqQdJXK2YW2HtV//qd/CdqF64H+5Alb
	pzkxnf3SC4n/4bvdJ8/lvNb+ilA3p4No6YcBT6ajGnpN/cZxE/hYedL6b4ht2COFLg84TNiieUo
	7TX/nc+o3b3yACoLOVmnPiOA5JQnaHymMF2FTB84j81qOhGtlMNuoKWibMxYtA3uoYoMuCf/4Ph
	5aekdBjNLAGBWRXO3cVY7shmu1/n7W2fjTC35pIhkgEbdfM4axi4laA36DcDU9lUYMjO5FzuciO
	1f9pNqpUq50QcnnQN4gsAfecupOzEZw==
X-Received: by 2002:a05:6a20:ce43:b0:3a0:bc61:62e6 with SMTP id adf61e73a8af0-3c67dab468fmr7652615637.8.1785135602132;
        Mon, 27 Jul 2026 00:00:02 -0700 (PDT)
X-Received: by 2002:a05:6a20:ce43:b0:3a0:bc61:62e6 with SMTP id adf61e73a8af0-3c67dab468fmr7652601637.8.1785135601728;
        Mon, 27 Jul 2026 00:00:01 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e1255sm43432530eec.4.2026.07.26.23.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:00:01 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v6 0/2] RAP: streamline session handling, reflector setup
Date: Mon, 27 Jul 2026 12:29:52 +0530
Message-Id: <20260727065954.1053484-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: o7R2kHfL3DaymbHXsqXcFNmo8mH6wo8F
X-Proofpoint-ORIG-GUID: o7R2kHfL3DaymbHXsqXcFNmo8mH6wo8F
X-Authority-Analysis: v=2.4 cv=GdYnWwXL c=1 sm=1 tr=0 ts=6a6701f3 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=q7oXoo1SAt_vtFeS_wgA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA2NyBTYWx0ZWRfX8sRpZ7qgNJoD
 78RkT+8p5FcZ/J46HaEFeg8Tmq6SQu0zEIr/X4Og/vJn8nQG7idVpSdZTcvjZeblSCcEMlJTXm3
 fwIQDN0OaH+u5/V0tWOrBUQ+4g/LTeE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA2NyBTYWx0ZWRfXxWInH7/pm6bG
 lpJgu+zMkWONRyGJfbSNMQGpG/DfoxeByjcdrtRBwaCwNO1Q7/uqHyhvDu8JOfX9E2giozxtk+y
 a/ij2z2AHX3cFC7vNTaYWF6aTyww6aMedv4Lzj1WC/7OERFPIdsM6Uv8gmGRciA//Iv7TJj2QbP
 Fe9g33rpcVp0TPP3RHo1tNi4ODqn+j9s/FDx+ww/Tl4Kjl530oJDoNjugwWC+zUsOUqI1HVq0bH
 ZUPFUPonPI4uvorAunNjQSWYwtkcMPwBH3ni3RM5fDu2h4VJQpl5vMmvZCkq0Jr0MAzJpp43ZbB
 ykVyTCdXBn1wiIDx+pClP5Jm/Uxacn+MK1t+QCBlMV5zjW0+Xos9/aSQOSut2sH9upPXHdWfC1s
 w0wxYSF/xqiQqi9Fz2yVnSj1boWNgeFmWUmbRUTWLd5LWgxnItGiAl6YHkJ3Gk2x/z5M3wngJug
 1Xd26YyAvUEtMG41KhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270067

This series adds RAP users to the direct session lookup functionality.

The first patch refactors the shared RAP layer by introducing explicit
attachment/disconnection helpers, adding bt_rap_get_session(), and
using session lookup directly from the RAS GATT server callbacks.

The second patch updates the ranging RAP profile accordingly.
Reflector setup is consolidated into a dedicated helper, D-Bus registration
state is tracked explicitly, cleanup is centralized in rap_data_free()


Naga Bhavani Akella (2):
  rap: use session lookup for RAS operations
  profiles: centralize reflector setup

 profiles/ranging/rap.c | 209 ++++++++++++++++++++++++++++-------------
 src/shared/rap.c       | 143 +++++++++++++++++++++++++++-
 src/shared/rap.h       |   2 +
 3 files changed, 285 insertions(+), 69 deletions(-)

-- 

