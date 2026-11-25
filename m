Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603428;
	b=PhE1lISPZiK1OEg44hStmur2Iff8BcOW+BAAOL72bddXieECK9MiiEAtnhbvovSG1FTd
	 SaUQkLoiydADGoazr/mYUKegbUSp+ELrXhGwvCnzRRk9hcfPybr/GA4qKHSS+a+yvpGdW
	 mra/+pqCDg/rFBWbefeYbssL3ZLNw4Dngzo96Niin4kc9Pz1svAiWhdgVfq37ODtxWsFU
	 YOCkwiQUVwdjbgyP2ELnPVC+LIu76WCtDQl6OTAZ3kJUUgw7O27Y6aDmY9J7eDGgrvQbi
	 WMqj2AjrersoXpu2NQLccQq6777s0gj78OJJB58UHofSDevKFGanaxvxqoH1aW1F8ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603428;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=S6p+xv4KR9duJby1c3DkePRKEQg0rlIALVctLizrL9k=;
	b=lrmtXbnBWvsq0bv9TS3ooYv/z2SoHoSgmpQ9mRaJUh8C1+Cklv2obf+7s3ZNuZZMf+Wn
	 kyvlLVNpUqkUmf7780dVhqKS1PILUhbfiH7QeXuQkeVIlfkdXMiXk+jD0yTFOISPzBekv
	 UuFdVMdAUU+5T/hjijSjNPzSigAco6R3m4RzvKQYER+iOSSLdEJ40UBmhk5agSQtDlvRC
	 MBbnfLJl1vwOsmzZiJpxE2RFYc02LOgWBXQU/xRHC2ogFP7OwdAgeF3xjaM6OIstIQfqD
	 CmUx3yNRFvrc511ePK3uKplDu59EVQykchICgmd2JC6qEcjKRbIvA4WXvgV22uWbtIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T8x2SRPN;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="O8ae/b3x";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50757606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 10:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50757606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T8x2SRPN;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O8ae/b3x
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9maMP4131875
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 10:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=S6p+xv4KR9d
	uJby1c3DkePRKEQg0rlIALVctLizrL9k=; b=T8x2SRPNuts1QUV39ql8oQaZFGL
	8ktcgVrPLD/nLwVcqRV5Haf65bKhErSpMbbyr88d37em64J7pAbVfmKMLkmSyuzT
	YJ3YXF09ccUka+g46mAiZMn+jJ8B3s6bWlT4EiZ8zoRV1a/XcIoLkLM0U9LyIVuv
	sc44vmppEb2uBB3I8+Xdo/xmyVwF3UgKiw8gWLGMJJiov2ar6ZaQxLnREeYYy9Ts
	YiiDxrG6TjfAOBuAUs16quynEOw+6XmEkCP+iecLMd1epwFZ3C01J+GEYdghMN86
	niW+9Qg3FCdM3ANUSsDsJX57KYNm1ckq/bhPpLvvu40GrkXk/gEShyPphew==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vuhref6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 10:43:47 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-57e5918fb57so172072b6e.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 02:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795603426; x=1796208226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S6p+xv4KR9duJby1c3DkePRKEQg0rlIALVctLizrL9k=;
        b=O8ae/b3x/s2AlbtsLPpYMXQyZ1i1J+dllCqSwnFdwFqRBibIOuN0HGkjj0MNMX9hjt
         ryGenyX8/BNs68u8qUEWa43u3746Kr2JBBa8oqn3nxN/M9gA/z1kdKYYcBYVUV5n3yCT
         YJLfslPL3K8iZ92wrjEINgPnNatqBy8K+h7tPJFwlvSrKcs8R13tkoDHeA0gpDT0M+zG
         CmwaAuQVpzLD14OYrQ2BaV+8kbQQjdWA/M02UcG5gPCC8tsFXOEtsiAi+CQMKUw5uIyJ
         jIj3LJDwW+bctuAYflTOGLwjCahYGctRjiwUVerUrwdvNVIvezbpT6FJrPPhgr14eOKA
         YYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795603426; x=1796208226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S6p+xv4KR9duJby1c3DkePRKEQg0rlIALVctLizrL9k=;
        b=Z4FbTcWJszd350jDSTReV4cDpVMlH6Gt57zRYebo1ewz/0s1fHzHitO0W23ipMp0Fx
         mvWFZmtAsdBAO8tZjxR4H9X/MBfulCo3X7yYIHSRPmUPcU5ofENA9hOPvI3r0QKtr6HW
         oexV15Gs0GYwUFHAbo3yz9vqVFcHwXbRxkHKvKumK0Ns4wOeTyatfMH0xZScrEHH+mdP
         hTp+dB2R7STCbihZo+OIako9dmNFiheiriWzLxy0wjVvHf7KRlN85KyB/y3F9Ch54vNw
         y20JslsLToKQ8kojfFwQ+CHLfDLJqJpE3PYXdu3BkEmJ8KOaT3qR8PexdvJGL5WYEWxR
         IFUg==
X-Gm-Message-State: APuU4Z98NnXFyR9gfKE9Gms7r2Ndwul7WTNf+1IhGIodkyKnInowWFmo
	XFZzy5F7ulcmSsev3L2Fqi44dvoGF+7UsRgJo5l2/xwFQiVfTm5y6mMl9Dg1X/FzonaUN3L5WuU
	5pcjwCsy2gXPxd2VQAOnS+E/KaW3fbbwqdlgTww6eO9ycZHXTPGijXdkfH5hebkxprBH3kzU=
X-Gm-Gg: AZFdTZdiSO+kDMnLMoidKd1BQ1qHx5tMwTYAJwTKakZRUNqWiO9z0gOGkAciBtQ/zSK
	OkXwY53DoIVNQfoH/enxusEXnIM2dJBtmVyQDDjOyr6FD7+Yl5UDHwYx3Gh1IHBr/uB5SVRsrtV
	QX0N859/UhgJnsNqhyEzCv0nY3SQ/eEcS3/1gHQbnE/FVPVH2yCEYxf/g5Bma6w6qt98mTunDYD
	aUZ/mXk0s0+U0JGPqwZWSNcQ09EUv9/VnO8VtsoYCFock+liVITN0xaUisbHREG4HJRzljSSMhk
	DEA68w8gf0W9ZIbJsE9FoF2g57ovYPdRJNkwQPsGK0WR+zj6uJQXWzlwrzKUYpHzXDpCnrUPFuK
	MmnKCqzUTsWa/YNZsOldwc7d0qEv8rHT5/TJvx6qAGRZTKIZKwpIDXApxKStIPJ8ZUYBLlZHI57
	2JHltuqaIzzAh2ST/jYHD8
X-Received: by 2002:a05:6808:1383:b0:549:e9e3:9460 with SMTP id 5614622812f47-57a025ed532mr26283142b6e.0.1795603426329;
        Wed, 25 Nov 2026 02:43:46 -0800 (PST)
X-Received: by 2002:a05:6808:1383:b0:549:e9e3:9460 with SMTP id 5614622812f47-57a025ed532mr26283115b6e.0.1795603425870;
        Wed, 25 Nov 2026 02:43:45 -0800 (PST)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3575f5bfsm13785352b6e.14.2026.11.25.02.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:43:45 -0800 (PST)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH bluez 1/3] doc/test-runner: s/CONFIG_BT_HCIBTINTEL_PCIE/CONFIG_BT_INTEL_PCIE/
Date: Wed, 25 Nov 2026 02:43:35 -0800
Message-Id: <20261125104335.3321147-1-zijun.hu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1277316d1d687050b546a2bc006c14a1a9569b5b.camel@hadess.net>
References: <1277316d1d687050b546a2bc006c14a1a9569b5b.camel@hadess.net>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FPmOVOos c=1 sm=1 tr=0 ts=6b06bbe3 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=P-IC7800AAAA:8
 a=FB6r6CVh871vgrK9xNoA:9 a=TPnrazJqx2CeVZ-ItzZ-:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: GxVj3jUljteZtgSA4347T2dHcrj5A8NZ
X-Proofpoint-ORIG-GUID: GxVj3jUljteZtgSA4347T2dHcrj5A8NZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MiBTYWx0ZWRfX0IgB2gmNH/qd
 O/hAwHkIf3aEJIIUFN2mJ7UPh/NHfqOWQUBDI8qTNe3s30wWsSwrPIx6lPRlWHMNoOJuy33fUWt
 rHQlsRKIJu51UItcROfQHrdOWgjIM80=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MiBTYWx0ZWRfX0CIXwX5m9NB+
 MF8SPq7DC+SJN3kToKua2IX1inKLvzs7bw2I1cc5Ht/2j3DqKnDcIMB3JNGjrHBxEpk1L0r3qCY
 cfqsfTQgbwAJ+Bgd09PCfI8A6FhgO7Dj14eYzL/k7hJkv2K4sFE8egzOlbEQIpv4nSbWN+vSNqz
 0CUkVjY6ofIP1QmqPB/tnN6b7Qn7O/h0BBIbACXrqMbF7hsWJLJWTM4AgpzeYTCm874i/p957rD
 JJnISc7Ujl/eb/uLArA0VqLPjnQ//K851arG+1V6FiSz+QkECMkFm8GS2kUV3GJ0eZm8Hskz3De
 ljMVLPZeB8DMgxose8qBiRhO/UC/2xclidcDcm29dXX3iYw0dqaHla+00DhU511Z0qfrllqh4xx
 3N3w9CML4g+fd6CwZhe2cR/nf7tH/eBD9jJD9bLt/r6ElqktiB0SEvFj37pBx3oNHKuC7hUDWNx
 HCWhTJaA3tbaVA8AlhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250042

Hi Bastien,

Provided this repo also follows
https://elixir.bootlin.com/linux/v7.4-rc1/source/Documentation/process/maintainer-netdev.rst

"Netdev discourages patches which perform simple clean-ups, which are
not in the context of other work."

Thanks,
Zijun
