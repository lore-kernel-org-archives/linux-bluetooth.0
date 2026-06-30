Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA44B3ECBE5
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814331; cv=none; b=f0nC4YadySQHLyFJdNJmmPy+UWZlPEmwYaYIhps7PpmUiQUeuYl/6sICdj/qJ4fCl0J2FGkTok8X4EazfMM7C9Ou0jLlxK0FPdqTRzSv/cvpM6ADn8RsW1Pv/GOgt1s2Ry4MFYI7U6zi1xGDGXuLO8nWur1/uUneo9H2tPWiyds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814331; c=relaxed/simple;
	bh=ywdYKM/XQeT5XgRozUgOFfVfD7s724cQnOovGtUmEdU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RG22BpZjIVjoaM8YYY/cSgHZNTUv9QfzwrvPQrabBVFrelBG+u5eT77cHxZFnaOgHEkQkMtLWWlqXKcTlHGQeeWI6/uhMS8hieJNZCj2NZ8c2+P9fdvcWX/tuNp20MVISdvZ7CXDXSsvTrj7p3y0buAsopotCyGgUyC/Ezvlb+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=prcEC5OV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jkIBPvha; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="prcEC5OV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jkIBPvha"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mth91604503
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 10:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=MPHtfxxAepf4BuRQukdbemBRkH8YEBCMThY
	Jbec30U4=; b=prcEC5OVsdASfcaBr6Wz1uOpLojPDTRiJo3pqGzWS43P2y54ipQ
	e45IXUQaDAeCXI9XgXtOFCv5C3fZTQv2vdQVvuR5RHfJ/uY0ylIRHIqRG/YvHpKz
	ufHLEbh7W1DYruU3DaKlCsK5nmcZDBmd+xgMPRQJMSP/aNdWm++36tVZj3nEBU10
	tUxnQ9fpm9J+TZeZXPHT/UBA7dE6iArQfuxHIlDhx5Lg7AJp/Ore/7SnRiddWacO
	e1op8FaLM4jUgoTCZHPFZ53t84gzUKSnoB67S7bm/YPqKlxhIoGcR07UdDXKQx0c
	6qDyeteJ9BsrycJY8yGTpSpNjjFxXjMGQnQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f462fhmam-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 10:12:09 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30ec59471a3so532167eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 03:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782814329; x=1783419129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MPHtfxxAepf4BuRQukdbemBRkH8YEBCMThYJbec30U4=;
        b=jkIBPvha/Eh/osYNfs1tkKzohkNGw4eVkkmuCza+VWZG+26BeEh54B936znu9zVJzU
         tGUIcxL6h6IV73uxidkW7y5LsEtMd46TaYYS2/t3vBa0GOQ6gcjM78/oX7yfkM14g+AL
         1lXdKjo0Otlh6A4hgNocljckWURus9welNjxTi9OApz+KbOecx77FjdQp4+YBjrcBSDI
         UuoCSIuK1I3Qjw4qxxibHZWWtQiqhvemyiyRR35PqolG9FWk976cENgtyqLk2RoK2/Ak
         UZ5Yi/1W0bCn7YQ2XFVG++hP0IZP8JqOTvf08O3dEicBYepXiNI5C70bD/fsFbZvBmTH
         4tXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814329; x=1783419129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPHtfxxAepf4BuRQukdbemBRkH8YEBCMThYJbec30U4=;
        b=CGuYXFMD1glU9rXok2kzMYfE2Y3WyxLSKWEAHw6DByGiLO+kgi2l6H0/7w3alc4Fa8
         AYYV+n20sxxOQS8UjR9U5sVeTHXo0oz2qBllMUo6IE6dDKZFeDtd4vuV6tyBS+M1xdfd
         zgT3+bVnzJg4jVP3771qUevMX/+94ph2LMbWbvtYEwz0UIo/CNrEL1Wykg5ZpKGXirSc
         Si46IOvLAdzuhPzk1Q8nGjKlzXTTSbU7bWYK+SgCgBAeIebriuS/lkuhxGgvOwDKmVYV
         aHLHfQOMc0kmC39Gx3TWYb05YtXzVTJBtYzjO+YmDW0h35CN2g9+98osi19r00MNzjLT
         CT7w==
X-Gm-Message-State: AOJu0Yz8qybCM2CjGDBtLAdCRiGBHwH1f8cfhaAC4TF9ExpaUsrNqbgd
	ux1/xFJJH2ivKi7QnE+e2LpwrwlrZM6iMHPb7Uq+P9erG5qQ1zaVABx51JhIb8CwD7c3n40XpHt
	uIWWXGgrc3fXOe9O5s+NBMeO3tnlcOWywIZa5y2AK89UlbJO2ALWW5vWXVkEowuf5dMg8Kw4HkG
	gXDj4=
X-Gm-Gg: AfdE7cnmrNzS9b2iW+6qv3Z6orRi2sfMfa6xWzcE4mhn7nq7FCVe7eHrAImfPzc+P4L
	JVUQZNWDMENM5ivECMoleAHe9jAIl3Tit9mosMrpl2qdqYM6+JQs0fM1c78HEFgadMSmjKfheoE
	aesUWZ7JPpkEq+O6YTuokzjoVfmpkgB+ZTUOAMweXJEMn/eLKKWKSlhKn91hBbHz/gOENhIEjAn
	FXJFFj8w9eVCql3aF28Y/Ce9PkZkdVoT8B3CojTsok0MkCwv+adKLDcnxWqhHALssWDLawZPaWQ
	1C+IMP8YnEF5L6KyxjvSKND6C4p0zkkLs7VLVaiErMHxGCw7estCgNYhKXGBa+B57Ykn+Gqg7gm
	TsMFqr3tn1YHeA+xNAyrJ8hhG+L1X1R/ONpJc8slF
X-Received: by 2002:a05:701a:c94e:b0:132:c944:9ec7 with SMTP id a92af1059eb24-13b2e29857cmr878016c88.1.1782814328549;
        Tue, 30 Jun 2026 03:12:08 -0700 (PDT)
X-Received: by 2002:a05:701a:c94e:b0:132:c944:9ec7 with SMTP id a92af1059eb24-13b2e29857cmr877999c88.1.1782814328005;
        Tue, 30 Jun 2026 03:12:08 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2aba6fe2sm5670060c88.9.2026.06.30.03.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:12:07 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 0/6] RAP: Move CS default settings
Date: Tue, 30 Jun 2026 15:41:52 +0530
Message-Id: <20260630101158.2239682-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MSBTYWx0ZWRfXwBBuQLnNTyPZ
 xjmWt68POrBMpXzwOnsn+N9DAs/wwtgSFpILh/UiwawufTtdrIesZ8E49cPvV3FQoTe7UF1Yt5G
 k9eMNRfOP0r9RpNHC9xIE/I8EXQINo4ukfwPSE2+5YJ+3dSF39EGCkNtK1hEwb3ysFObDTxDxtq
 +SJOjefW2m5Ze/JZ2QBagEKtU7xEHSgEbpQdBcE4cyaZII1RLJGjllShNSzq2TIKoAK4NTGKzwu
 rBvV6RVmE/hCDqTukMOgwtWlpiH/SHwDJFTz/HvzOk52wuuGPlsUJAzIkmZ7p4ImkSfjgjVPkOX
 1S3gxX0THg/G/ybNApaeLXfd2r+PBqIQdvYiObmr7pXkVbbZ7bzjyfKWVExHnmjKGppQxXD8End
 3gfOn2+pJAOASNLoqp12u00sB2uIsBohZY/AO5fieUdO6g63ZACMEe6lOMOP3zsyY61rb+WOOMo
 /H4gUqHsIbZZ4R8pK4g==
X-Proofpoint-ORIG-GUID: 0UqIza3MR3PdVmjvyIMclOSOHwpTuC3K
X-Authority-Analysis: v=2.4 cv=JqbBas4C c=1 sm=1 tr=0 ts=6a439679 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VyqxGoTrGix46t9oEBEA:9
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 0UqIza3MR3PdVmjvyIMclOSOHwpTuC3K
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MSBTYWx0ZWRfX9uJ4qtWp8zR1
 UGZcZWsNIb7AnHhIUHUtOc4KNf5tANZ4p1smrS2HXOtLIWASuApeG3B+gDRDztVGQ4jVbwdbvqq
 8tBkSO1WfbJQ031nuAscYRXyRRW4f5c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300091

This series removes CS default settings (role, cs_sync_ant_sel, and
max_tx_power) from RAP initialization and configuration paths where they
do not logically belong.

These parameters are measurement-session specific and are already supplied
through StartMeasurement. Keeping them in main.conf and passing them during
HCI attachment introduces unnecessary duplication and mixes per-session
configuration with device initialization.

The changes in this series:

  1. Remove CS default settings from main.conf parsing and configuration.
  2. Update bt_rap_attach_hci() callers to stop passing these parameters.
  3. Simplify bt_rap_attach_hci() by removing the corresponding arguments.
  4. Remove wrapper API

Naga Bhavani Akella (6):
  shared: remove default settings params from bt_rap_attach_hci
  profiles: update bt_rap_attach_hci call to drop default settings args
  rap: remove CS default settings from main.conf
  shared: replace the wrapper API
  profiles: replace wrapper API
  shared: remove wrapper API

 profiles/ranging/rap.c     |   5 +-
 profiles/ranging/rap_hci.c |  27 +++-----
 src/btd.h                  |   7 --
 src/main.c                 | 127 +------------------------------------
 src/main.conf              |  24 -------
 src/shared/rap.h           |   4 +-
 6 files changed, 13 insertions(+), 181 deletions(-)

-- 

