Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D6E2FD1DA
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780493478; cv=none; b=mZydUUGZnAAol/CMVmHbgiEYFM/7yYXO/7moqFZGHRmyn+9YDUi9LdWn1fNo12NnYy0KWeU8KfUniK7v5i68ThJVYGY4bAIYRf0h97t/4NnVlzT8rCRtfB1qvrxt+1uG8+8ZFAoQX7/HKFDLOufMj8TlDtrtPuIJAy1Ekgydmck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780493478; c=relaxed/simple;
	bh=Ko6t/nLyuESMWj5AStE8p1jMFXuENbEXwj/tmAm5NfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rPHW1VP2mqTzJ9opB6WIsl5DmkyFcsQfxzgNzK697X9R5TDEA+gi0KrNMFWWYMo3fdR6SYF6ZtyUbeNwYE1LYaT9MMdBtxze9PkcV0TnXg43eAIEVP2ZdBC1aaCDQSr84aiqE2x4A/jLk2G2MmTGeLyYjEFtr+WqbaiVg6i9h64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ilt6InWD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cpLyre2n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ilt6InWD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cpLyre2n"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653CfIcG2076119
	for <linux-bluetooth@vger.kernel.org>; Wed, 3 Jun 2026 13:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=KzCsdghRtIv
	VrMCNgAFGi13T6qH2zXLUCFyhuKFsiek=; b=Ilt6InWDIbZs77ZpjA8HczUXWqU
	Cbxco8I0cvPgfP18YQ403Rgp4zIBKGZjfb87iRcs+D33G0MXqYHUH9+X/72WuieC
	H4I4gmGAJ5ZRiDzV+H1XcqNGCcSzwtoPquzifauEdSfznx+mJHYEvliGaZDK15ep
	ZKHZw9U7pvCpw1PL6vlVd8M3CNpB9YS0r+V2/i1vNkuRmY12Rkp7RNvqGmWMjH+5
	yu4lfn2H5hOdG5MgMsg7Qb1gbCYLRxgcs7+qaDMQeqsz0sVn6ehfHOBONnPHRPg0
	CMEXlDvMzrxyzYSs0bvMH+93xqwEghOGvwKIQsthX3VBMYWS4TgAUmAcxcg==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejev19qt1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2026 13:31:15 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e60aeda837so3518774a34.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2026 06:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780493474; x=1781098274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzCsdghRtIvVrMCNgAFGi13T6qH2zXLUCFyhuKFsiek=;
        b=cpLyre2nTPSTJvOFd3yrssUnvszsdol2tzjN8hJwcnw5A3UVRtJ/kon6kUMRRd8ClS
         hZbWTxsRRkhLhlukgiWBb40QbgYSs3DinGGFsnsu+kHf2OcIyibrNOOKX4ZwjCzucn8b
         CefWvFgXo0UK3rXtOb9vtNQrhg99chA4QJPk74tQJ3mm075Dzk+7QNBAcID8Xgjm1/HI
         pAN/qhNAXIJBfRmK0jgY102rxgrEGKkHlNYoTUUE0ooEqNQi6VmOGQ9J2ja4qf38hnzZ
         BdiJOu3kmawdrpyr2o+6uBDdt6T+4cIMUpZ3cr/E1AD3Gsj4GbXo+/bG1itHx+0SX7VJ
         dyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780493474; x=1781098274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KzCsdghRtIvVrMCNgAFGi13T6qH2zXLUCFyhuKFsiek=;
        b=Oqbrj/dJH6UrpG4bkHzIRC53FJagHoxn3YMxYazJaTqW16iYW4mkBfTCR4seFT687k
         OXh9EdykI2cud3owStedLMW8PKt8D8RdIIi4oftUySWZXbsupTx7SSEfRJa4SYNs/Dse
         MKqqzvezXaVxE1+w5P8fz5T7ye+UOvcTtk02HwI1qSDmUaosKIM6KO1FacwEr/oUatCj
         cu976XtMIj9NPGGzFyaXLsCrmdAiNpPKhBIogx+qcs/xPtg/9lnKons5lnDIcdXppAr/
         QwVPB0rd+B38vSlLXXtbIq5sS3a8WmRMjC0+AIIgha4d6B9kiLL4MfgdeGatLBMgrSkC
         V3HQ==
X-Gm-Message-State: AOJu0YxOablt31HFWB+3Uq92WO3zX9mfU9cDolmPlB+DHF2nSTuexMT3
	2egJimBCGRde0aTeld2EMNc63f1tb2nexbhThBTYLdPON7x7qMF4v9s6fQSm972Gp6mn7E+cMnn
	F8YpCmBPINhxK74hdAXd501dmnaFe2jZoDVC5Q6BTSW6eHci7TSbpfFfr8KNTdT1X0WNKYak=
X-Gm-Gg: Acq92OG0bg9R/SlC+arG/fbrPTA+ARzzlLumtbzJs5s+9D+GUTUuXNi0C8CaGocT0Lx
	NWrue7mIPVIwn5ZWO8ztnIg30AEzPRpXVVFDA9Ubzs9tSKmMaKoiu0wqiRrNamZXsrejuSf/Yoe
	LAEd1SxoTbl90susftsEUZzHvmbKqGDE5JtvLHb9h95NoVbnVTOj4KF7I5IAuPWugKcb7xYY2eZ
	v3bQH70XF/DYBwm9JSanFBVV77STrRr6hB5+Z7VVchNdIL/O5y7QXkvnVx+HvIEYWNkyrUbdPL2
	1kHHahpddNijALVBX6oEZI5ZFcECpf8kSas2Q4nF4jmNf7TtzIDiEXFLMr7foK2y6Smw8BM7GtQ
	WQSZfigyMNTWdMb4QPE+lLXR+GFYSJEL5BhKwT+0OepyfEs0HqiMl84xwp/VwMR/D6bzmTcjayU
	OPPfh46sA=
X-Received: by 2002:a05:6830:6ad5:b0:7e3:f809:7984 with SMTP id 46e09a7af769-7e6e616078amr1389661a34.1.1780493474482;
        Wed, 03 Jun 2026 06:31:14 -0700 (PDT)
X-Received: by 2002:a05:6830:6ad5:b0:7e3:f809:7984 with SMTP id 46e09a7af769-7e6e616078amr1389637a34.1.1780493473849;
        Wed, 03 Jun 2026 06:31:13 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e78e14acsm1744711a34.14.2026.06.03.06.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:31:13 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com,
        cheng.jiang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com
Subject: Re: [PATCH v2] profile: Set L2CAP IMTU for external profile listeners
Date: Wed,  3 Jun 2026 19:01:08 +0530
Message-Id: <20260603133108.2607981-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABBYNZKZhamDmBjpKW3GjtF3jrNfLXUTzYaNyz1vbdrgM_Lu4A@mail.gmail.com>
References: <20260602031719.679979-1-wei.deng@oss.qualcomm.com> <CABBYNZ+vSQWjJyajPxoBs3endFOkU2JGOFoBKvePu8YvZSMEXQ@mail.gmail.com> <CABBYNZKZhamDmBjpKW3GjtF3jrNfLXUTzYaNyz1vbdrgM_Lu4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Th6-v6JWm3TPXSo549ZeDo0qynnGmtG5
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a202ca3 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8
 a=GXHleoNMpaRgz9xUpwkA:9 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-GUID: Th6-v6JWm3TPXSo549ZeDo0qynnGmtG5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzMCBTYWx0ZWRfX7oBOJ5vDFhAM
 Ts4hOU7njlHtNHKFwvupX3qHBtZhT7VCYxwEMvGBkx7AnCjgQaAlspv8orT/glRZdE4eRFveNtS
 NNcq9hkdEy1vIVwakxL54nS+06wAWstrL73UV5zr6q7DKNpxYjW8SMakjImBipuv1KslTo7zv4p
 hwPrIUC7fnKR7/3cGayhdZXBmqcVCyGA9EU2GNZGlrOP5o1v7doXMrLkGNIcto0ITLqCdagkQey
 GEwFRinvJiM6nc6L36r/jlecWK6ZfO4kbh6Psp2VV3mwC/tKlGbqerT/i55IR4QBEw2uOenOYz0
 FygCR+OVrEjEaKl73gHuUH9WRUlZqpZau+4dEocqryEHeJ/7aKgHgHlvtSkM1TS8NHFzbD8TQn8
 7KKFsw+JqW+XbNVK0m/82sWTl8r6gnzkJnPd14+vXM7yo7GpardF4ySKafLeLaMk72U3fke+vXd
 9cImVtL/ualgrmoKzww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030130

Hi Luiz,

On Tue, Jun 2, 2026 at 10:42 AM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>
> Actually there are no options, it's built from `default_setting`,
> which doesn't set any MTU for some reason. For the OBEX profiles it
> probably makes sense to add an MTU field so it gets properly set.

Thanks for the clarification. Agreed -- I'll add an imtu field to
default_settings and populate it only for the OBEX profiles (OPP, FTP,
PSE, MAS, MNS), then have ext_start_servers() apply it via bt_io_set()
only when the field is set, so non-OBEX listeners keep their current
behavior.

I'll send V3 with that approach shortly.

-- 
Best Regards,
Wei Deng
