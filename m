Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CA43112DA
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142308; cv=none; b=swljOvUE63vf8P7pgp99V22qEF1o8FGMcIeY7BlikaoioVYaJap2gj9/tqnpa4ULStjzNFUbVZb3BoualE2xoYRrZbWnrUTwETWMYRGy7pbIysAbLNvs03sfepBMyVeih0Poxk659Ftemh9fEHZyUbIyEjmQ1ECxGHJ4yJnsACk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142308; c=relaxed/simple;
	bh=DsG56KuCF+8rZPfW6d2OwKPV9DW1K6FxzmsaZ/p9eug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBXh7TWM4Z61HzkSf7hVledfT9rsEvyPHQamtoqqY6d5tb4xeksq1HVGo2l6CtX2HRCRicYq65PeRCDSWOwDdHK06EoshR/jo/mGGERzLmRLUR8d++25aMaq+yvVCx+Zj5lmgZS/WPpk8B8M/c8SpCHjtCGkoR/pZWQhkC5khCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h1TNIA+I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dsAxrBMc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h1TNIA+I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dsAxrBMc"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MFViQx1022812
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 15:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7QuK+5aZsqwRVEgpLCto2tCT
	l0del0IEC1+QguMy7NQ=; b=h1TNIA+IigVJaUvOYJor2rBhbSkSyXqQKCu7W7sy
	6XYWBMKqR6nTPvDf7L7hTTKh4LukxoTjxcOVAtZUTg/kE+wq1r6Z7bu/muqdr62F
	mSWSZI+OU8avux7+OMG+uuCvHIUUDGBndFW0JVRm/g1iKr8FEVNwJ0yFl3Xbe8dZ
	mzuIpLYv5dljLCuig2x/WzRzO+SNErVIf5RcWtVUb5yp1Q5WOe7c4NuUML8vV4sS
	4TXbLw1qlycM7C8JjmCrL3fU055jzoHGR750Zs8YkBOxzCLf2ANZaz4wimpQLDde
	j16RnGuPtSiEGEzRSqZ1NtCGO/5IQL5G1gfql9aWwSh50w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey729r6es-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 15:31:46 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c7403e80b0so37564275ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 08:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782142306; x=1782747106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7QuK+5aZsqwRVEgpLCto2tCTl0del0IEC1+QguMy7NQ=;
        b=dsAxrBMcgOPVucR5reeIMDvhTe3X/51PVv/qFu1eS0RA3f96dmpEpgKcd5I9EG+QLw
         cOS5LUnCa1wgbWoohTPOsEAEiKZUOWjO+B/OIZc+YCak7Qd5mRykkfDtA6zNOeiyQtY7
         jZwwpPMpheXpo9/Ga5dmIwdM+7ZwTycrt4k6WCFbO7vLBfjEBKPNLu+DuM+lnam9RNP7
         vA0MLJ7ElPJs6+3i8MjlkFEB2QAIta08CJYsixIu7dTRy0/D1cSX4oyvdXEQswDv38se
         hDlEuehbUcWs/qwhHTPnYHIvXyHajuxs8M82MX17SFpaU6Pp9BC7vxN3TpRqkpyqPrxO
         LKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782142306; x=1782747106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QuK+5aZsqwRVEgpLCto2tCTl0del0IEC1+QguMy7NQ=;
        b=kgn+kixOclDBy4ZKlYpTkiaVkaWSnlDf4CpbTKM9gYv3vfElcnmQmEUwCT2BLPg+nk
         5E8U0Jmd10rl539Clfgpah7ps8awLPYllXHHD1DnMcjYdUsDzDTgYkj2Htf5S3BI+Ayy
         IkdDKPrwwCk2vWkkJWKRNYCmY0lPYWCC6uwpblGp9uxlWJAbinKoQ3c6wDhlSlC9T5hA
         HL9JP/pbx39TZhZgnqzxyHafaNX//pbVJ0QikgWMpe4/0ihY2DacRX74PO0WOPvgfo2k
         kEmB4CR03gmzM4LCgjSHBsz4S8P39EvVBMXivFQMXOCXXEeppeVCAfC47A99a4LHLg3K
         LJBw==
X-Forwarded-Encrypted: i=1; AHgh+RpZelPPkG1zHZDuTKWAHvcsai0q1Ouw0X8Ygj7SETatxe6pIzJTAb78y1SaBz278xIFhf3BurZXvx43R9SY4CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOYZYfpduafG2yBATiCBOEiHc96VC9cIjw/4iNto5KQp50Bq6b
	PeroBjkP0CIS/XeXBCmtXLRr1wl7P2t3zzKKhWEYBYRpzMdNiTbI3EuYrIxIYifZV+7Kt9iv+ZL
	9UiXS9vTZmz75J8LjK0yitoJ//YhRtO4Azk+ego+T4cVcdBYraa3wVI8HEf/DSSeqXcztkks=
X-Gm-Gg: AfdE7cn1jOUTraoooNVkf+cPqbfHzm3Vg3D578/zO+9sod4kdx1CeRTrzVi39l0Zwnx
	I9Qqbabu+A+jGGgVS+iTI5L2exY5chZRhVEqSznMM7YD+QXLJ3oyp7Fu/orHjaZM8SYcvS95N3g
	ZNpYjZF0sQeIv4pV1yWf3XVkRDkWAGxmzHbpRLZxgGxfAolrKejfIWNnSemFDV1HNf1Wwingvqw
	glXGer3lQYcDJSxAx1uHy+p49ruDG++1KmTbdPd8q0la8eNqmjI472Oc33vJlAuch9jd8UBbKbM
	vgNpTgDJONH4SMxy113R71n7JtRT9YILbdLZRcpT2WeD+AFoU9cTVIxSVkAK0psP21hkDyF/kQ/
	gW5XfeX5Ix9O9se7D+E4npM0U88z3P4QXLum7Ey9nteRizfnOAg2ddTIHyHbNyp+Q49jqSsuxCL
	n7GVJ4drBImNxY50IhG+sZMWKM
X-Received: by 2002:a17:903:182:b0:2c6:c9de:cd0e with SMTP id d9443c01a7336-2c718f02edcmr152997095ad.23.1782142305343;
        Mon, 22 Jun 2026 08:31:45 -0700 (PDT)
X-Received: by 2002:a17:903:182:b0:2c6:c9de:cd0e with SMTP id d9443c01a7336-2c718f02edcmr152996555ad.23.1782142304799;
        Mon, 22 Jun 2026 08:31:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3999af9f3b4sm20591231fa.8.2026.06.22.08.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 08:31:43 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:31:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, Zijun Hu <zijun_hu@icloud.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 04/13] Bluetooth: btusb: QCA: Do not populate devcoredump
 fields on ATH3012 or QCA_ROME
Message-ID: <l2ri4yxwtxv3r2upconhgsblespvushzeaqcvwvqulracmvfr4@qsmzp36emi7x>
References: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com>
 <20260622-bt_bugfix-v1-4-11f936d84e72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-bt_bugfix-v1-4-11f936d84e72@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE1NCBTYWx0ZWRfX1sDZ064g/lBa
 roQpBSn3/jovsgcD5kSd7BeDM24MolPczPb5NiY5mk3xFBt6iCy15f8ZmUsppGlsMajl3UHuIIk
 sB7vNaYNXTtmn5VNOoGBW2BHUTIk+dQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE1NCBTYWx0ZWRfX1mUZtIjQymT4
 UNv13DWpuvIreyTOOEP0PR+BaxXp9Rv0pnTlYdpC1lT0owNxX6oOvZYj/qZT0BJ7D/FWsHjHVoL
 iUnVOn1gZMJUL5eKvOf+/LMMh62jsEVEqzJ4URYm5VOdP0euej8Qv1FLrCunc3Yq/iMD7wY15qj
 uSot4/fkiEo6kRDlBgghdyJ1U4NQWIK2in7fUR3oLJzw8lITXZkV/Xn1x1ZaAtsIavO12BOgSk2
 gLdntAzt5+sc7YpRjUj1OtFZtrlKE+iduYA9xJyduEoFHbMOo0/vEFK3M2SwOkQdEkhwtlhl82W
 XiXdwpVpLEpYb+ddwh0td5BY25GB1IADH5i+4XMDpbNLbvSdsqMO1oDfKeQR2p8Vh0aTbB56mWh
 sqyCnFzf9d6319E3EuaNi2OKGLcq3a3qfkjzOyF94AOgca5RF7E5WLjTkuLquyo3vARrkZKx3pJ
 hy7M1LpixcasdstCQpg==
X-Proofpoint-ORIG-GUID: fFg0Z-DpxZvQp7b8ykQLO3G1qA65ldp1
X-Proofpoint-GUID: fFg0Z-DpxZvQp7b8ykQLO3G1qA65ldp1
X-Authority-Analysis: v=2.4 cv=eN0jSnp1 c=1 sm=1 tr=0 ts=6a395562 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=wyfC6KHAHlGcR0WZ_jkA:9 a=CjuIK1q_8ugA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220154

On Mon, Jun 22, 2026 at 07:52:17AM -0700, Zijun Hu wrote:
> Devcoredump is disabled on ATH3012 or QCA_ROME, but btusb_setup_qca()
> used by both unconditionally populates those two devcoredump fields.
> 
> Fix by populating devcoredump fields only for BTUSB_QCA_WCN6855 devices,
> which are the only ones that enable devcoredump.

Why? Wouldn't it be better to enable devcoredump for all platforms?

> 
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btusb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 6a90f012b226..184a87d1234c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3708,8 +3708,10 @@ static int btusb_setup_qca(struct hci_dev *hdev)
>  	if (err < 0)
>  		return err;
>  
> -	btdata->qca_dump.fw_version = le32_to_cpu(ver.patch_version);
> -	btdata->qca_dump.controller_id = le32_to_cpu(ver.rom_version);
> +	if (btdata->match_id->driver_info & BTUSB_QCA_WCN6855) {
> +		btdata->qca_dump.fw_version = le32_to_cpu(ver.patch_version);
> +		btdata->qca_dump.controller_id = le32_to_cpu(ver.rom_version);
> +	}
>  
>  	if (!(status & QCA_SYSCFG_UPDATED)) {
>  		err = btusb_setup_qca_load_nvm(hdev, &ver, info);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
