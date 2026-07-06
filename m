Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4797B42F6F4
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354577; cv=none; b=MBhHGUh1HW9KC7TGuiGWhjVscpFSrqU3QsXp94QJF9UgE8467AiG//ciK0batwXMdRPXtFHqsH+rlCzyECrFOzCXVbn5EDhRACp1X0ezMkmA6yB9bb0K++iMD/wDUx/lQ5KpH/Br2wZ9kS2xg9Qs5hpvxyPDRSqCkhvqzrvV2sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354577; c=relaxed/simple;
	bh=RWcu/zz6DhCoGid4XfMACBhUTwy8xOrZOuyw5Xbgq6w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qXCfP39N1/BmEc61BeUscJLkz4YwvEVZesm3IyKOANb4wfAprWd/eJCDQKPheqJcIEw5BbYjIF9FrgUgPHGnCFQmN1eHcnxFBPQqf+NqEc/A9TimQgJpTm0HSUkAFbTos1A82DyH1yiTyWoUfJnaEBSO7hSNK6PoiT6YSSHuTm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h4KAkYoK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FVJY6SNt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h4KAkYoK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FVJY6SNt"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF6t5982432
	for <linux-bluetooth@vger.kernel.org>; Mon, 6 Jul 2026 16:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=DsqWaPsX9r9dP3/4tLaiWegR3aS6JSQDFDM
	lRvprfKA=; b=h4KAkYoKAgh0VeUZXmOC6dySBcJ0JlmlcqEgHu5/MgVs7lxAQhe
	M93ggssCYpPvhX3OVCYD5Ot+v2ksOj4rCBS0H8cSbvcvNA96gfGebYfogRi2ZGj3
	wCWuOmf+xgByC0PJgsJH4HRl3qPvmpfRKbM+tQ8UldA9hvyhFfwCQKPVSUN+CB5O
	6IcJdW0V3GGTzgKo6BxRKGM+KwDsewYGT9oNnQN9RIoDQFQHRWGec/MZLH4xgCHW
	NfPbu9qIf7tdgh49zQr1Z3zT51mo4ElOXC3EtPindKfSyTWpniC/2RlWIoF4eR3I
	Vib28NTbxKtD1GWAhq2NKwbv+1kctY9xedg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qphu4v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 16:16:12 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-381e93bfcacso6692977a91.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 09:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783354572; x=1783959372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DsqWaPsX9r9dP3/4tLaiWegR3aS6JSQDFDMlRvprfKA=;
        b=FVJY6SNtmh/knOkA3JP9+7wjRAlbAhxzgnYZaVXtLG8TsN1Ctn8/Cy4EfI0o+XnuoN
         tgoSZsypCNRzJDdhtmjsGgM5mpMwkLzlk+7c4dm01gHwtnNo3LMUJ/DsERHQQCaVsqUG
         p+3Ch3UaNu9Usl+zkDznmT7xyBYN4H4IiQ209bibKU5hmszw4ob8iSV4wojYmld9NhpH
         qEGkMyzYQHX/eJ6RqyQVFmlT3uOKX5/haqwp0d8Zm0imx/u5ZqgVYMID52XeytrSFfJs
         dzJlU50C6qmKi7eOjUgA219enloN2C7y/5o4qkkesYGxklWBtkcU+9OmNTZgxTWT6g2r
         km1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783354572; x=1783959372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DsqWaPsX9r9dP3/4tLaiWegR3aS6JSQDFDMlRvprfKA=;
        b=saTqggjDPz1TCU9VNWN2wKJR04wB8bqGj3EZ4VyifSuwmIFh82E8mOrD7WkLR2ArRV
         cW+dxxJ8k6xh1TvKrKTyOJCTgtgErzX+UWlLs4nxnE9o+Q1D1KseUaWQtn0i5kU1ff5R
         1w6dHerjwiv0KaNTTHHpJcuRMy4jLzScyFEp5WNGzOvw94nVUSioWclyfgKSLpvHtrdj
         JT7NMF6YmxDjFRDTqMRGtjf2dCp661t6lo3Qp3GynT/Z7hEnEMDKbZfj88mAR0N/i6t2
         0G4CAP4/Sx0XBfrSc4sThWptMDgUo5rKXV9jFT0SHhaQvwsGak1AmSiwDIAzoUeFhFEp
         uyCg==
X-Gm-Message-State: AOJu0Yw4KIn6QofphvmXQESqCZUggvGIZHzCaLHC4IUIRjCLbgj7Iv7T
	Dx2y/souU+x5SshseIzLLhT7knH5UlY+CwOECUiCHicdDS/LwnOeklKGAO26ewD+f2vCc9ewaCF
	MAWhO7eJNKszE+MFhYQ3QPkKB727LQa4odAB6gb1lMxjyLedsoHxufT5CAmZRqzm16XxoDevrP7
	/rfGY=
X-Gm-Gg: AfdE7cnvBXavDqvFS2PZkNFcFemUxEUwXjM9KLMh1A51/BaqCFGhNtP9uV+hqdC0b70
	D9hUyxyZAZhQV8yAhcUSn4mDHgbcAZVbJSFwQ9fVdWqi0Flhc5c1IHK0Z/P51uZ0yABRMj/XYvD
	W+SSxu2ldIz56yfbXYIgDbwnsyCUHs8DGkur2cqoarxch365YyTIV4T9JQgsClNm4xJkAfoHqX5
	B+H7W5lY6VPk4YHvtPmNiAyDC+Wz7m47FlF2IU5MU+pGZfosnqbPXX/Qw0yTTuLKdw0dHOsOpMz
	IAjka8wMEAyet9497vxs/W/MM6iGg0zWUvRle5vhZGkBB7q+qqzBEJVrZ9+iiMpu9Vyp6NyQVIZ
	RXe3/qEdbKLOt69MJeuSn8luVO2ZQciVoKfiDTacB
X-Received: by 2002:a17:90b:2745:b0:381:939e:adf0 with SMTP id 98e67ed59e1d1-387597e5012mr1283449a91.31.1783354571697;
        Mon, 06 Jul 2026 09:16:11 -0700 (PDT)
X-Received: by 2002:a17:90b:2745:b0:381:939e:adf0 with SMTP id 98e67ed59e1d1-387597e5012mr1283364a91.31.1783354570754;
        Mon, 06 Jul 2026 09:16:10 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f31e7a2a8sm40022434eec.25.2026.07.06.09.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:16:10 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 0/5] Add D-Bus and bluetoothctl support for Channel Sounding control
Date: Mon,  6 Jul 2026 21:45:58 +0530
Message-Id: <20260706161603.2744459-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4bd4cc cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=l6qRilKLkFxIVpw7Fc4A:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: szG-cE0UGaOmcg-Ap1de5rbCl9AK5EAk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2NSBTYWx0ZWRfXwLorLS3UGQQU
 W/U8eBIaG2uSEd5svpvkOIC415T7KaWFM4m1ZY7S6/p90DqaG3lmFtTZHJ0rwodXIrl2cc9RNZZ
 08x7xPui48nrKSEg1l9vPwp8J1qGt0tKoh81jZVq8p61x2LY1KxKCpPB879iA1SGVN9WMBrOFam
 a5FP3dCrwtaHW+egLyDcPavgXYpHpHvYhb0NyWS5lZ/5iDaq6jLFHbP+a9R1PdL+NSYTHkbQwEI
 X5NuZJmSJYgt+QpNaPpH3o586xImYQpRhP8g03v3FSOdo8ArGp4NAO032rz6Z/lqr395zHmMlmJ
 tSSZjlGRi2uXwiq+9OSZP42Q7mCcoIvmdViMQJw1h9voncANTJ9eTtGfelrxgOjs/4GTELqgh34
 EIsywP6UyA/bqqDmWyph81Zp1MuUoZHrwnlrggtBQ1y780u3Tzp7bvW8AwsXpQj3oZHKME4yHg9
 Q3STUqr4qHr98Emkp0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2NSBTYWx0ZWRfX7Tuv9sHbLywO
 U8QkyIfUFC/fAvcMkAv0sWObFYJVISgs26/D16v3H0Tcftu5PRtxDmR80Yx4Q5HwpYk7ZXaPYic
 1iys66lK8x4cnqIDSlZmv5s0BfTYP7Y=
X-Proofpoint-GUID: szG-cE0UGaOmcg-Ap1de5rbCl9AK5EAk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060165

This series adds user-facing control and configuration support for
Bluetooth LE Channel Sounding (CS) through a new D-Bus interface and
bluetoothctl integration.

The RAP profile is extended to expose an
org.bluez.ChannelSounding1 interface, allowing external applications
to configure default Channel Sounding settings and start or stop
measurement procedures. CS configuration, frequency, and default
settings are moved from hardcoded values into shared parameter
structures and accessor APIs, enabling runtime configuration from the
D-Bus layer.

To make the new functionality accessible from the command line,
bluetoothctl gains a dedicated "cs" submenu for configuring parameters,
starting and stopping measurements, and monitoring active sessions.

The series also ensures the Channel Sounding interface is available on
reflector devices by registering relevant GATT profiles even when GATT
client discovery is skipped, and updates the D-Bus documentation with
usage examples and bluetoothctl references.

Patch summary:
  1. rap: Add Channel Sounding parameter types and APIs
  2. profiles: Add D-Bus Channel Sounding control API
  3. src: Register GATT profiles for Channel Sounding reflector
  4. doc/org.bluez.ChannelSounding1: Add Used by reference and examples
  5. client: Add Channel Sounding shell submenu

This enables end-to-end Channel Sounding control through both D-Bus
clients and bluetoothctl while keeping measurement state synchronized
with controller procedure status


Naga Bhavani Akella (5):
  rap: Add Channel Sounding parameter types and APIs
  src: Register GATT profiles for Channel Sounding reflector
  doc/org.bluez.ChannelSounding1: Add Used by reference and Examples
  profiles: Add D-Bus Channel Sounding control API
  client: Add Channel Sounding shell submenu

 Makefile.am                        |   2 +-
 Makefile.tools                     |   3 +-
 client/cs.c                        | 981 +++++++++++++++++++++++++++++
 client/cs.h                        |  18 +
 client/main.c                      |  73 ++-
 doc/bluetoothctl-cs.rst            | 278 ++++++++
 doc/org.bluez.ChannelSounding1.rst | 302 +++++++++
 profiles/ranging/rap.c             | 405 +++++++++++-
 profiles/ranging/rap_hci.c         | 454 +++++++++----
 src/device.c                       |  28 +-
 src/shared/cs-types.h              |  55 ++
 src/shared/rap.h                   |  47 +-
 12 files changed, 2478 insertions(+), 168 deletions(-)
 create mode 100644 client/cs.c
 create mode 100644 client/cs.h
 create mode 100644 doc/bluetoothctl-cs.rst
 create mode 100644 doc/org.bluez.ChannelSounding1.rst
 create mode 100644 src/shared/cs-types.h

-- 

