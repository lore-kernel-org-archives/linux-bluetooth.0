Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B483B6C14
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307454; cv=none; b=CVbNti3hToVSgjz4kmINXc0faZNT0XJR8N4WXI6xqHzPDiH7cIciz22ft9XNjw8BbOvCry14L0igZsuAZHYtVJTnPtckXR4ANvbSxya74MRMstoW7TrXWHuPnZDI7IPrUu10O+wvPeqmAXkDCg+iAVYfOtzIz3DHfCeCRSUZcUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307454; c=relaxed/simple;
	bh=y7oG361cnrAOUGIaOzqs9WRTvUjEFp0UpF9nd514dNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5H6Jnrz+6DyGdMmo6tJ2AHw/F1Xch/1QSHV6j0sBRVotqhPYs2Fs7bWkz3leBiJRTCmpABA7pjj+SzdOuysfy4GYqYZVJEMKRPSodBtPNEM28krlY478cDtCFdI44aM2pOOq7UtRZ9jMqbRLdou6E/FMCjYf4ZH/FzuqRyOFRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EewOw9lF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KmncuIxy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EewOw9lF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KmncuIxy"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518dkSW4110276
	for <linux-bluetooth@vger.kernel.org>; Mon, 1 Jun 2026 09:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Injc9GSyk0d/ubCqtOO0wzd8
	tZgOEDPzWZR/T+eO3+4=; b=EewOw9lFT8P09FoXuoricIp8zbdK1c7kKc16WL5y
	1BvitMe/f0IX4zrCOVpFVW+l5KZPfHoQFIGhLKw+OQFLlrlpnb9pGQvZ92r12Y20
	FitS0+tXwF6VcV/kNgcEAulCU+QpUhMGye+XnytLC45ZA3XLHArYH39VEPJpLQ7o
	irx3uIAeKD4HPQXB6SAkw7TSp3YRXHVA6uiACn1XSSND2on/WyzsufahKYV7y5Jp
	mRR1+obM1glemC/O9+RSDxOKN72JgCohnRe5FnKihmwLq9iQZ74Dg2+S+s5u/hwj
	hMfki4oIhK1M8mUAeiNl7HrVGgrWVNAiYhUDbj1RJPXQBw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6s3r9ks-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 09:50:41 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5174e8642f5so23304151cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 02:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780307440; x=1780912240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Injc9GSyk0d/ubCqtOO0wzd8tZgOEDPzWZR/T+eO3+4=;
        b=KmncuIxyTvvnRYu3zcpTUff9BhDMgfHLSd/ndTJI4qegu8NHTppuIfFo6xDPv3qjYG
         /E/gwyCSBzP24H8QVJVDqceXNpR/XHyBxadk/7zl4eR8uU/dAIZ7ADN1O+qsFEiTnLly
         J0j99Q4mbHlQpG4nmN+EUdmQSwreSaf/UzffCTuCWIIhBUQ3H3vwGKylidEHXyXXjlEJ
         60r9TVH+DeFJl9Y3Fo8JLwM81GvvyrQqNjzwzHo/5PHMBc8mY6nK6Tpsw0YuuE6xLM8o
         rw64ujmnLZ6rKhCuYRPlkDnDqWEOoUNzrsmiNr9qJpNU2aRB8sTZ9BTfHbZrBdHtqjq/
         96gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307440; x=1780912240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Injc9GSyk0d/ubCqtOO0wzd8tZgOEDPzWZR/T+eO3+4=;
        b=oLe320H58OwHRFuAsN47kVsQ1oqJ/bzliAZ/V7rcqP2upSwYpOQyOAY6QA6UPa2AvH
         0gvlzSovVZP/s1ICpjnKhROd7Un9Cn8YhMhmS10QwNbYgu4bttIsfnmfs1S8DwctWID6
         ys4e8FKmlHqrR3uvhPxVMDtnj8EE6I9dDkPaqjK1C9rw4levjk9cfY6VQeCZcRmxdrvq
         0oBlso+zUS6bGwEafOaWuBkC9XbTdVrXMG0pF/Env50SuGo+OC1euMUI0Zkter1He+lO
         X4x8BuCFCJe37se6UGeGI7bULkbUquyR27lD0O83Kn3r6YdMEQitUV6nIpCHkJl8qFpv
         ky7g==
X-Forwarded-Encrypted: i=1; AFNElJ/JXdXgRL6tkbG3/t2QbUSAvl27BUw+l66hVxh+KIPwYimIGT55uYb7PLPvD8X/LUPl39mQAqi4wXCYknxxaLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXt55+Vhr7L3EyS0cpNI7TLJzO3EN4UsFTExwbFQCjw3EuRSQk
	A90/iSpHe5mezHOxn7LKK20X+xwFWIF4xW81Ij1vVsb1SuqXRAOrzUJnkt/wDDWpVlz60LXxhEn
	AvY0hjsROkmSLrTVVfR1g46cCT1OWU2iw98NR+pzxc5/OyyAJkTXN5TD+PI1XYRZ3R0KL20o=
X-Gm-Gg: Acq92OFM7aMhe/79+h9P+l+YfplGssjvop48fVWWTOsWrePIKf00ZLDj3v98llpW/ZA
	SMNRsIA19PowWUSXHIhbNSXxSXNVQpru4EDIRS5qjoTgM2jPfsytUMb08EvsTBKZCvgunZUE5XX
	FclW0IwyylWFNAkrrKqVKlP7txgaGQKnhPiGFxPsJjaCR3g4yvaQLXHhGkvFEWqY9VwFxwyzcDr
	8QfcTZ+9ZPPsq5lzRlsSbe9oUpoPpLmLcAyhiu71DXxtSI0erWF2xnz1xQDZstUNseqcUFG0Vfl
	DUUxBM8NITOGZVStRdZAp9QYsMLmSrzyQJ8ybinNXRCu2gdvNnubE4pWDmRysUsBdp4KfcuZU+w
	frcd6OJueYWMpanR3E89D/zonl7DDf67UC6RcHpg5DGuZqgkmrrl1nxwsHEyHmfMMfSv3mLk5ZK
	thZiup4P4ADSORjMOgtNVA+9VeWP9FKWZUO6zAA/zwsW/MyA==
X-Received: by 2002:a05:622a:5888:b0:516:dd5f:ed2c with SMTP id d75a77b69052e-5173a628dadmr144080411cf.22.1780307440349;
        Mon, 01 Jun 2026 02:50:40 -0700 (PDT)
X-Received: by 2002:a05:622a:5888:b0:516:dd5f:ed2c with SMTP id d75a77b69052e-5173a628dadmr144080111cf.22.1780307439848;
        Mon, 01 Jun 2026 02:50:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3966a2b0c00sm16706001fa.12.2026.06.01.02.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:50:38 -0700 (PDT)
Date: Mon, 1 Jun 2026 12:50:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, rahul.samana@oss.qualcomm.com,
        harshitha.reddy@oss.qualcomm.com, dishank.garg@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] Bluetooth: qca: combine NVM and calibration data for
 QCC2072
Message-ID: <ungiyrkfjmykhm65ttfchad7oxgx3d5mf6frj2xnq7mdudq6tw@hqwq5ms3553w>
References: <20260529180431.3373856-1-yepuri.siddu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529180431.3373856-1-yepuri.siddu@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=AP3YypGC c=1 sm=1 tr=0 ts=6a1d55f1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=a5bjN7CP83JjU-aXAVEA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA5OCBTYWx0ZWRfX3RQjo95mIWER
 D0DPk3kXpOSyh3bTOrp6TMUsk7a4IxtL77d0q+RwPvNby2x6iExvGRmQDAxZZl8zT8umJ6cwhuV
 KUMO4h7BHe089TvJUwLnADHz9vXv+iCdxYSuG1uud+KyUrsPNu8zF4Gi/f6SyPaHrCKTmoKHRkh
 wVbg8WBuz4dAkMvMgvPAV7DhRN0FzcvmTy39px0F6stRuUK6Z+zAGyQ8W5mGhxvR0t2Keeu+zVn
 KPUuIpVfn2imNKNbKt0DhRKschy1ve/KhsxKQLWfp1mZMt6dNMQTaAw07261g8lV/PJli39mUrS
 Lt2shW0OXfDifNnJlxy+DQm3MfYwKxD18nbttClLP8hYdoPb0t/0iC/+atM2EU7ek+KA96hjUyt
 Gl6CPQqw9Bx3FoSMOGY+6X8pMY57Z9BWYtuAS32ojpcDb/SHpqSIjeVh0XjIeHszjhAtns4+/43
 K0VD06s6+2Gk6UBObcQ==
X-Proofpoint-GUID: FFFrPy3wzxPY_Zp-UWiL0kB9Z7_E9Prt
X-Proofpoint-ORIG-GUID: FFFrPy3wzxPY_Zp-UWiL0kB9Z7_E9Prt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010098

On Fri, May 29, 2026 at 11:34:31PM +0530, Yepuri Siddu wrote:
> QCC2072 requires the NVM and calibration data to be delivered to the
> controller bundled together in an outer TLV of type 4. After loading
> the NVM file, load the calibration file (qca/ornbcscal<ver>.bin) and
> combine both into a single buffer with the outer TLV header before
> passing it to qca_tlv_check_data().
> 
> The outer TLV header encodes the combined payload length in the high
> 24 bits and type 4 in the low 8 bits of the type_len field.
> 
> If the calibration file is unavailable, fall back to downloading the
> NVM alone.
> 
> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c | 47 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)

This is only patch 4/4. For the future submissions please make sure that
you submit the whole set of patches as a single thread. Or, if it was
really supposed to be a single patch, make sure that you generate your
patches correctly. The general suggestion now is to use the b4 tool to
maintain your patches as it significantly automates and simplifies the
workflow.


-- 
With best wishes
Dmitry
