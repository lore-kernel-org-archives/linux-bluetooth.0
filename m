Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF033C09EF
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783667312; cv=none; b=M9JcE0F3TOsN50/EgOTV9svOapE04lRTBp29nAyGjsdYRomWG21Q5AiNn43S/tneVW6yrkJx9C8dFDgGJu4SLyqnpBR5m+XWpbUmsLesMZDOmEchJgNd8EYDwet0eJsZHGitShoijSResptHXRIXXjo1run7fpNRM+aMFNPrhnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783667312; c=relaxed/simple;
	bh=g1xLXTLvFf4h8zL3lT8cfSgIq/mnGc9AOzovZ68DJK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hfZRjAouLte+roAPCKV+LI8nHpUlBZbwBpZXI+O32k2MQGRQlJj6vyv/Nf5qPyXOn31tzBeWvKpPj9njSiIhVb6I4iXUUa8iqIGRlqVNUw7+rgIzenqwqRlYMypj8RNEWbU23ePIzTcyx9ahGNXCDAIGyHaaxBQiqvmy2SXi3IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DnSh5DHv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kOn+ggAb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DnSh5DHv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kOn+ggAb"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A3mo8H3629735
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 07:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=d2nP8HYpqqneV2RBZhDKkPPghmQ27SqA+Dh
	ZxE1Eb8Y=; b=DnSh5DHvNh8JVC4yEugjzVhZJU+IZ03reE1Y6b1uqaBie2P59tX
	bSz1O7UOEBab+M1Smpk49tBPIolgiR6znEF+8PMilcSArT0Npzv+9ViArD3Rdv/y
	gHqeB0bo0eZfF2qUryNxoCLNKQULa1es1J4nBn6pWsbgmq6sBMhkf/rjeXj1qto+
	0pBfZ3TfcBl54LmSBLhnvApJ1TvhJcbRWJE2grgA6EF7UKTLISPt3iA0eZHOcdeL
	LupCII87vKV946IJTxinjJAAIL+0lGvTV9u32CG5zZpSoRr5kQRWCeemyB2v5pOz
	0oxfcGiAwX3L7NcPcoNpcuU0sryBWXYnwJw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fahv8j3jh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 07:08:30 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88da04b719so706055a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 00:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783667310; x=1784272110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d2nP8HYpqqneV2RBZhDKkPPghmQ27SqA+DhZxE1Eb8Y=;
        b=kOn+ggAbrYf/FYtgqPC1YDFBeS0QeA0aq9pMq0cLUbvAShBPcziF1nRCCYQJwIsfDR
         +c3ZDaEd/hyE4ZMD+63JgNOTbraVDkVe+cmT4bdLcJSoDFGO754kNWv5/KU0Kl4Q8GXA
         goY2e+10a6+EYmJ8QKnHE+PhURMYN2u29J10ELv6ugd3fBnUGpJvnnAbLL9mRWXOsojc
         7muClNy6yO14DCD1yjae00S44NBuycZCVH2Vx2tAelvASQdHotPNtJn0Sf/97/Cl5YDr
         stJhnKYpn44Qk2Vvf5u8+zGJljizUAvXaECwGce1uH4b1mfB2hCBS1revNCWhgWMEIkv
         Q45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783667310; x=1784272110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d2nP8HYpqqneV2RBZhDKkPPghmQ27SqA+DhZxE1Eb8Y=;
        b=U4nsOqQ6UmIMURipwPuj4iFOagWPPYg+vkN+8GCUL2Z+eBK23obE0T7GWB6CXFt0yv
         GQnspGJkb1dNEa82/uY5CpTKrARoVhs7KX+rU6skmsV/NEyocX4xUbGteApGbIqoDJ9X
         vHe9TrvEmEtUkk/poFSxej6nXQR28tHZt1fwLOBTuL5etzJyhsPNmi1d8ckN8P0Qmz+K
         n3TQstrGafNVuAApkvNQeAfgUBDwqk0oRMs5fMcDGKbQJdiDwL8hD0mAAQLfcKbbyWoJ
         8pk3d6uhHbgH3bV/5fvplrvxu+J7f6WAITaYOjXiVlmYQWhoxxGL1ZHMcOBGJOyguEbL
         dPWg==
X-Gm-Message-State: AOJu0Ywg137J3szFgnjtb46TEIScI8FkXIOFAu9QmXAA2X2s5o4DwupO
	f5/CGJnNewGAnxeSRS5Q8be/cIUA+425lN6cqQpLh3jTHYAilfrkJjgnBoT3ko9kiu9DVqGKk8V
	6CLf4AuSU6g7iVhgNICGfrgK7a/F4XVd1dOJqnOIWTfKSKE0zceL/tcSLOQ5/Mxc2dcKW6f7buf
	0ZtXc=
X-Gm-Gg: AfdE7cmVikXCH71CtyOKt+33y7YTzUyCtL31+OVcBNuP6VqviMg/DTsD+g/gMKBINX2
	eeorhp+T52Kw0Kc5VWuQ/s58Lk3cRAQpWspFVlwNTBKK8GrFsoJnyMiZABDDUZzHcCIZs6IbTHn
	722DJMplTtpfJGdinfdyDHXPtyu8rBElV/h3BhLsemh53Ri65hr5s/h9dr3PFEqmBOdzQn+g5V+
	wwNjBsHI8PMQJ9tRZCbDuDi1FLqd0msB4PYC+7f5MuFjt+nMGmoFi5veC3nKAPmyTk2qYyo7gfP
	JocqWLqz9+p1bdbNpYtNsd1TDjLjCOUJaMHaMSsJGAN5SbzmWuu5q/hmm20RXKxfUWvxlWXJ/o7
	g+r0L6BfI7wwL29UYb4iVLhsoextFy+zQ2BoBSsnE
X-Received: by 2002:a05:6a21:670b:b0:3c0:9c19:b279 with SMTP id adf61e73a8af0-3c0bccacfa4mr13236692637.71.1783667310006;
        Fri, 10 Jul 2026 00:08:30 -0700 (PDT)
X-Received: by 2002:a05:6a21:670b:b0:3c0:9c19:b279 with SMTP id adf61e73a8af0-3c0bccacfa4mr13236653637.71.1783667309550;
        Fri, 10 Jul 2026 00:08:29 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f72a6sm43082332eec.1.2026.07.10.00.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 00:08:29 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 0/2] Channel Sounding reflector GATT registration and
Date: Fri, 10 Jul 2026 12:38:18 +0530
Message-Id: <20260710070820.3793624-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZvDv3W6fY8TDVQDy9PCYdbx1jzJuVKMs
X-Proofpoint-ORIG-GUID: ZvDv3W6fY8TDVQDy9PCYdbx1jzJuVKMs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2NyBTYWx0ZWRfX2poKmnXmvDkf
 8/6oBAmwHMZ9387Ltz2+jRF/blPFeGybkYiVzszF4/T1Fm6Qd4jCLdc4Q8ch+61ESgf+pdGlCh9
 3dLc1R8AAlp8XSdCjvtflBO/af58U9g=
X-Authority-Analysis: v=2.4 cv=funsol4f c=1 sm=1 tr=0 ts=6a509a6e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=yT2ZRxcxLwADH6shGa0A:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2NyBTYWx0ZWRfXz1M4SqrEFSy2
 GccIEeluNCfA0j6Dw8uPr2woqu2RoiVhGVkV1MNp74G50chh7zI0P7yoaZhZkaPZ8fpKLm5cux5
 meyhRmgGXjkfLRfVGnme/tOB0UyfmiyOps6hpuV8UtUGYMEltFfVEuTmv0lw8WaouyLi3jZH6g7
 wT/slZJ6PfhmjtrsJrEXj5UAGpW5yhiiI55qxpA/5F4h3KOYAFgluhv9ARQqSRoxSJHbw9y/gGq
 uE3c6BPm99AGKLL670jRYgn1SP5bE2vq6iKCSy3/i3zU8/nzNKLAktBZSvRwRZNhGcbGNg0/Caz
 0IRr+S9sKVpAjqzmA3lYFSEjWVqC/sSFlTHqbv+ZJMKH3fipPkLRnhqeOva1Z5Wa0xZ2Z795Wkq
 DNqZRsFJSRp/0CEBwH7vcm27PutKRMdZyIsBTkNqyAunRcAZbOjrjbl4iYqvDetFAOXbmb9RQxz
 qhCEBKywGaqEuLjO4/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100067

This series adds the initial plumbing required for Channel Sounding
reflector support and RAP-side management of CS configuration parameters.

The first patch registers Channel Sounding GATT profiles on reflector
devices before GATT client discovery checks, ensuring
org.bluez.ChannelSounding1 interface is available
when discovery is skipped.

The second patch adds shared CS parameter structures and
getter/setter APIs for exchanging configuration, frequency,
default settings  and measurement-related data
between RAP and the HCI state machine.


Naga Bhavani Akella (2):
  rap: Add Channel Sounding parameter types and APIs
  src: Register GATT profiles for Channel Sounding reflector

 Makefile.am           |  2 +-
 src/device.c          | 28 ++++++++++++++++++------
 src/shared/cs-types.h | 50 +++++++++++++++++++++++++++++++++++++++++++
 src/shared/rap.h      | 27 ++++++++++++++++++++++-
 4 files changed, 98 insertions(+), 9 deletions(-)
 create mode 100644 src/shared/cs-types.h

-- 

