Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36933BD22C
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784292083; cv=none; b=SUlZ335xjPXbx8eu/RlSYIjVMe/stQQqxvdAbjZQraEkfqn/o4KHivRCx1RmJlW5xTuG8EvYaqICRVj16h3VaFzWUUfefGFe9fbW8noClkL6QvAbQc/6BC32Jsj6NyOWH3Zeak31qzcnDzfjQTdP2rPltEydrNHLc40IyksEwfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784292083; c=relaxed/simple;
	bh=Vb4mFvZVPD8y231bYu5Ovn+ioKhaCSgaKxmtPXced90=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZA5E+y4e4Of65MxSt7WF80U+/d5riLHMDak18WrG635mZqNSKMaRemP7BeiAMFCL/2QwkTDFKjyrYW9dkbJzbFCi38lamsLMUHSgGbgxz9LNTK4l1feOv225ltyKh5LshZtAkEpwzPUm37c+4MtKq78DebPqReZ9uHzy8n0oZPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=glvhVaot; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DUlFaa55; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="glvhVaot";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DUlFaa55"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HCT77N2903127
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 12:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=eMQMft5b8zflB/XgDScihXEN6eO8N8QtUA7
	eRyDClac=; b=glvhVaotw2HAXCCd5D+KJnYQ+E4PIAJtAHEDLQmZNLx6DYP5kWS
	5Se/pPaKxD9wNunQQDWVmTYkuHkFnG9PMzoBLmaYzTeWZIrpFUJ4bwohHP7FKm01
	GVyBl854G/0lxbxZ2mwkhB2Zg85S1+7Q1RUxpTg7mkxA/+oQXap7sqgCRD/CW0FH
	2/cO1hA9fFfow0gtTpY9zUySvagks+R8TdUbuqtGUQ2cjLKIAkLcD0sbXWZqX407
	74oi3P1EImMpFMANVlt4+927oLPWUk/tytaQ94S1ch4u2rWmUlQoll6gf45h3uZn
	l7zgr36XZFyBvYBlKG0OWKOSe606k1rwcKw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u6kqnn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 12:41:21 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso97348655ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 05:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784292081; x=1784896881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eMQMft5b8zflB/XgDScihXEN6eO8N8QtUA7eRyDClac=;
        b=DUlFaa55xoQl/aIfi7/g/uqSVpPGDzO1BSmqyOtuJoPqaNfl50is4BTk4bll9pXaZJ
         qVUByZocCBb82pqHPtN1JbH3VT5RRDZZ8CXMiQVbHvGXM7vDB4+X4yNiRgS0/8sQPNpl
         +iePI8uZDPyNk5PNFauNOUhy9pKTphRbpYpm6TmhcCCogbiw8KBF3etGUTIqMMFMcq03
         Vkabd6r1eac+QkpUYzl9ckKPd0+kWgeq0AJo9HDGn0dgxdEwwLV3DXKLgB53U8onpcxa
         RXojv20tLxTFwHtlyhtjWJRv4afaEs5S92B70cypjOYKEOGRfA57qJoCCxA4Hne4UKKZ
         Zz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784292081; x=1784896881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eMQMft5b8zflB/XgDScihXEN6eO8N8QtUA7eRyDClac=;
        b=Q5ChgxIC+mPWwxZDABRruQJR6yRZV2eiuzeHNxwgcaRPvihN3HtH/lXlcU4xoaQ0Xq
         CJq28KWK7/e88QVCWaMUikWS1vo7pmNsuuDnhFhg84POet9ZRrFMhXWTRDETY0ym3Mtp
         XYZOaXu7xJI0mOlet32m2BCDGQ5tVewQ2M4y/zkB8QXfNYcZ6FaRpXDk88qOH2qD4NxL
         kFOVVt33Q3x8YvnBZIcDuWr2qI497SKL92yDYm+KMWM/Tgtgt4s1fHa19v+fwN06Szp8
         9G1wyA+/qWekhwwaDOveNbo+Y16H+A1M3vKZ1b/5uItOOkhuDkneO3MZZFHk5BCKv7uq
         lDBg==
X-Gm-Message-State: AOJu0Yy0sx2nORgQ3lWOtkn2tYQVseSRP57hrZD6SV+xP4ALlCce+8AZ
	6oxraYKDxgYGd3UNmLQ/v9ut6iqKPE/tnjgTSgqb8xQRfSsHKr5k++AyUemj+vantH/rvul4oIB
	6jcpogtf4EeNGy5M3GiaF8zWSZsXGlRPXZeCgjtaPdLDEJopNJOOtXKqG51cDOL7Kl4TCShrViP
	pgAZY=
X-Gm-Gg: AfdE7cnmhujvu71fwBrDPBWmEH3EJfbVcYabmfjUmLzgXnG2Nm1HGrczbskeJKd0Lns
	ZQKiWavy3Nmh5vxoLPyatmpfwLl88nq3MosTwkeWtlLD/1i9E6bORehp1tVr3gdnevNKmCAz2mj
	cdVofpRoVb1iW64ZCtiBZtrY8vRCf7YMAJA//MyDr51emB1IrTE40Qan+dgRD6KznlPIiu4gGxm
	wrRw52dnOzsbxIUiWh47FyMRF2VnzoDhy8RLZauKrrJWPG/Nm5Jjp3ObV0D37lbn+CJK+Vc+WqQ
	kL/RlHTYiRmIgk3wdxREufwKV8IFfa81OZO5KzGm6kGeHuMUh/Kjr4uGAFZqGH60CvdUlcnrRLI
	HBiHRuQx/2Fx7UxQ2FpT80b2EtsrtGQ==
X-Received: by 2002:a05:6300:228a:b0:3bf:d1f9:b1df with SMTP id adf61e73a8af0-3c3ad9d5c91mr2925975637.54.1784292081143;
        Fri, 17 Jul 2026 05:41:21 -0700 (PDT)
X-Received: by 2002:a05:6300:228a:b0:3bf:d1f9:b1df with SMTP id adf61e73a8af0-3c3ad9d5c91mr2925938637.54.1784292080668;
        Fri, 17 Jul 2026 05:41:20 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cd6e6esm5262562c88.13.2026.07.17.05.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 05:41:20 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v4 0/2] ranging: Reactive RAS UUID
Date: Fri, 17 Jul 2026 18:11:09 +0530
Message-Id: <20260717124111.3296537-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEyOSBTYWx0ZWRfX4XSEMxWhPEtF
 UprZlCfBI0OblDyQcwL+nr7WDs4+m3UTTeQc0fxy8skPjKV8lxzzPErVt6ICqFIHkykWRa8SXow
 KYJYmZVl6NPtNxDP6bJdYym8Bzg5MJBpIy1jcP8RWcg2Y02CDdiXA1Mu6af77lxQuWZ28diFrFl
 G9NoU5ndByegbOA3cKcEeki11ljuVhOp4Jk5Awz9yVj9lh23k//ySPsUvQvOdSSJ/MvGvqMetkh
 JIrdW/RN2f/etKIm6qjp/2hi2+6p7UV6nYfUYINpJdcNODE3q4uFqBtQOUz/xREwx2SOCi8GXIQ
 l80AX0nlfuQrGoOQjvKfX/H1tzaLe9luIbRWMFQJbWlD3VIvZddOFm7VvxnNWZ9w9z2UX43W/U9
 hqqh/j+7eqBiKw6Xd1xhkULYAdcoUDiQxpDattdNSnljLOPzUf8ZL1W+c65fPItCoItRtpw4TTA
 EeTjnleZPrmDBewEKdA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEyOSBTYWx0ZWRfX7D9i+6I8Q0xV
 QMEbBo/D2y9mOsAhnQg3yG67qNxZqXVSm6Kj5rylp0DIUvaKqdIbQyU2MwNoyB3PsRAvF5og8aF
 m7KhPfkikIb91Xg74WkmUM58EOxvmmE=
X-Authority-Analysis: v=2.4 cv=DYMnbPtW c=1 sm=1 tr=0 ts=6a5a22f1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=0FEzsms0Sdq5PWYzyrAA:9
 a=zZCYzV9kfG8A:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: qvjIldpfroQiWWWfhxCBRqNEcqVBV_6d
X-Proofpoint-ORIG-GUID: qvjIldpfroQiWWWfhxCBRqNEcqVBV_6d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170129

This series replaces the probe with a reactive mechanism.
GATT_UUID is only added and the RAP profile only probed
/accepted once the remote peer actually discovers or accesses
a RAS GATT attribute (Features, Ondemand Data,
Control Point, Data Ready, Data Overwritten, or subscribes via the
Ranging Data CCC).

Patch 1 adds a generic RAS-access notification callback API to
shared/rap.

Patch 2 consumes that API in profiles/ranging/rap.c to bridge the
notification to btd_device_add_uuid()/service_accept(), and reverts
the probe in gatt_client_init()


Naga Bhavani Akella (2):
  rap: Add RAS attribute access notification API
  profiles: Register RAS UUID reactively instead of probing

 profiles/ranging/rap.c | 25 +++++++++++
 src/shared/rap.c       | 98 ++++++++++++++++++++++++++++++++++++++++++
 src/shared/rap.h       |  6 +++
 3 files changed, 129 insertions(+)

-- 

