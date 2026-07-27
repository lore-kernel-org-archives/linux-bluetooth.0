Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0445423EB1
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785184123; cv=none; b=L5Jp3hATLJ5Z6LZEsSzo7f2euhPw4Y7ZAxreoiOTMKglJrQ4HTQZcd2Pr6ygyTp8W4CJXnNIzcWOP/yz1BaPpNVmTlfp7MgZG9YWRdJOdAk5+eJNOFXOrodHwztA2W8i4oIzrDlAV5CC8KBJeE7JHRI68zQMacLZmMR5mPHwDH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785184123; c=relaxed/simple;
	bh=iXWnCvVZ87ZhxeHXve8z6eGPTqXNBUtx57uGAyUBYaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4kwBMACzZS/xDjYLzqNoP4kYmfV5PKvIvr8eY+nxBR/qQWgR6k5IM0tMBKIkuaR926lWqtR4f/lQIngrwhBEyYQeqCnE7xtMfmiF/PYWge7LpX5TY2+HQTE2S0uXKA+ZnbJqnoudA5covdN5smH4DPAXkvY+uBhJyyP1h2ptfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lQgu4Lr0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cKUeNf5M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lQgu4Lr0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cKUeNf5M"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RIBqjB082989
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 20:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dfnDuv+8RUeh/cKuM0y6F6+wWcdFDiaIhkznAKbe9dw=; b=lQgu4Lr0xnH06IRI
	8zn/Xfh2RSw6Y2xrKOK/boi9q03xKJDIMEu4BiJQW9kFn0BHicPZICCusB+Gu/Ua
	zblKX42Ds9JlYXKQxDxpmTzHmcSfDb6wdfmZgo0YWTq21mS23Lx5y5Vf7HHxqeVx
	c9tCCKnn8OQ2cmAJTQS4OYxhJyEPZZy3g6NVWZl5cY3tjpzqya7b199Bygab10Cj
	7/FI5S2eCF0SziDa1c1qykRbWn3PeLig5PF1+lhdws9QifCOPwJxrBIoG85tJtYU
	L5zVjtiSmajiwhbtstdcX0M/UXqenVnUEHtOOpu4qpjjboZANFpXImTNySUeVZs/
	FeaHHA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbp88tx4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 20:28:38 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so2096202a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 13:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785184118; x=1785788918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dfnDuv+8RUeh/cKuM0y6F6+wWcdFDiaIhkznAKbe9dw=;
        b=cKUeNf5MjYufietstw1tWulbv+10NjknhYNO3pcg7QsQobMgcm6bzh5/NEBkrcjsz6
         71uBlB9Y15nU/m+TFtKrxh8gUN+pCU81e6bICBBXqbPmNUgQMD2ra+woqt+TnSA0dnRz
         35KLYcRE48C79EmbS6BHd3ubzFMJj5Ubg7GwmUJrro7DCe9iv+OUfnEK1D39Z4ATm4HP
         VbBSynyC5k7MuYG3/+9cHiNNuS92Ppuk2tvonxsumcmKSjk+rbrxww2eKehg64XgHD4t
         CvI+/4zfquhupckodGAwLi8FQCU+qzGgm7J9AEWfqcxPpYayTFCFMHsHpLKj2F/LK6eA
         /Lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785184118; x=1785788918;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dfnDuv+8RUeh/cKuM0y6F6+wWcdFDiaIhkznAKbe9dw=;
        b=QGk1yHR/GpHbTR4rHv/Cnoe7ALPpcpDcHKodYyxYN0vSl0bv4A9ASgTXNVllA5BaC4
         sgo3m75n9PMUDFeIBlwXT72OLk6usYqTeqN/Y5XHTUH/1eT5ABUKglnu3ymLJbZSjc1k
         AfC8xSd+8eQqbj834eAvrX2evnpmRbdiYgu1vT1WQK4wBVqiiZ1pdiaDb4AEXgZOVTw4
         KYsnj2/gjLWCYYq1CGMlmvZV/dG9+yHLf5CLUlqWfcdwcEcH3L30RfDCkfYVYYAJ9lgF
         G8hmJV/2j8+aFhp2tCuiOLyvmc6+lDVBrFUIlJV6B/QA0TCNJiABtxp0XWj5gXTJ6W9c
         YGfg==
X-Forwarded-Encrypted: i=1; AHgh+RogIlqSLUiNG97FLItL6hgVb0O/WMC5SoumD1lTWsfds3kQ85MVC4n9JmRg8ne8bdviqP1e6aN9/yxoPo1irEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQVXmxd9HnNIZHDV51yTJHya8kQ6kBX/cTGB0mIdxNnxvWgDSe
	TSsPbZ5IBhpsNWnoC6mxsHgz7eeQrh/l+I9ITHgDddMDXd1PMZuMH2W/QuTBGHl6syrBi40kUtK
	W2yuZyuPQke+rEXgBwygqUCLbo1f/q39kF6SGY3+9XZR6ALWW+xb/nFrq8DytjPPdEekmbPg=
X-Gm-Gg: AR+sD1265mY11RwXeD4qTfdbWV6JO+AeHAvSuJzpjynH/geaINzAU3NPvisds7uB1LA
	Q+HoycAyFqjtnWEhb6ANG9LX6XCZi9tc1U73NjLfZm1cz+hXJJBMkwiqL90AAmA6reKrPj1ysFS
	3UzpUiQEdJNJaaS+LPgncyjILv9JKMUG5CGhedkttBuRyZmJnHCOcekBI+w45RFLTjQSOOwJd1I
	hwLkRKSdAvmvXrVNmxYJioxwOyvROyFsCNfZ5GnMKF7J8lwiPEIkXzx/hQwPp/hAeIQh3hXXHvU
	mEq9VtkYk+PvC4qmSZZ47LkRSGzE18wMYtgkbXE6uGFCihYvjBowrJnoV2oP27W133xpGkh+Sdp
	OnMTjyDTLEdBItdwybW8B8wl6IFNjbJuAW59K7sXRNM0XPfZYl3Q9RrM6bQ==
X-Received: by 2002:a05:6a20:6a21:b0:3b4:e4f6:4f15 with SMTP id adf61e73a8af0-3c6c7b3d0a0mr1108974637.5.1785184117720;
        Mon, 27 Jul 2026 13:28:37 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a21:b0:3b4:e4f6:4f15 with SMTP id adf61e73a8af0-3c6c7b3d0a0mr1108941637.5.1785184117159;
        Mon, 27 Jul 2026 13:28:37 -0700 (PDT)
Received: from [192.168.1.11] (15.sub-75-218-246.myvzw.com. [75.218.246.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc415eafsm35949179eec.7.2026.07.27.13.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 13:28:36 -0700 (PDT)
Message-ID: <477e6f55-d6d7-4a30-af28-dcee185cfbc2@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 13:28:33 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] power: sequencing: rename pwrseq_power_on/off() to
 pwrseq_vote_on/off()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alessio Belle <alessio.belle@imgtec.com>,
        Luigi Santivetti <luigi.santivetti@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jeff Johnson <jjohnson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Chen-Yu Tsai <wens@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, imagination@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-pci@vger.kernel.org
References: <20260727-pwrseq-vote-rename-v1-1-a2029aeeac65@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260727-pwrseq-vote-rename-v1-1-a2029aeeac65@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE4MyBTYWx0ZWRfX2ktHvDtt69io
 kdqByIjPnjp6WUveDL+mZWhwlSkSfVvoISa/QVqWAacv0upy7sDDW3U1JIk6XuJpJmZoMwK/pvD
 jbF2MRlHMqvULW+yKNt1fj6kwJGpXn8=
X-Proofpoint-GUID: mAFn4SmvDz1Iem74W8Li_9TRa8Ip9ny2
X-Proofpoint-ORIG-GUID: mAFn4SmvDz1Iem74W8Li_9TRa8Ip9ny2
X-Authority-Analysis: v=2.4 cv=KLJqylFo c=1 sm=1 tr=0 ts=6a67bf76 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=6VQYfvmiyQ8t40WkS/mQdw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=u4B4c_klvyXDgThYlB4A:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE4MyBTYWx0ZWRfXzEXSRAuJM75h
 ZqM54ZT1A+qaUFnZqrRgoVhpklID+dosYi7W8Bp/vKSaU0mayeyEFrXlUc7sLVXiapL9OQoFkMX
 rBDArWmYhrsANYflwegL8E6V3rU9S/oUKiEEJYTRV3TiqXEohLBoD1GGEd9P+VWFb5iHR36a1Fc
 1rBCiPVpUmycWg0B1Ldu2Bfo9hLybXDHmmvVw+YKyodveVclgja8me1ITSm/Am/YAIqnraVgB+/
 qajYmXwijEosEGObJCNCFUTBllseVuFbtt98PFdeuizcTL7PXAqqujYUUNwofnvH9QV0ZuIELEU
 OCSyWcXr6wgfwwifT6QpAvLIxkezvbGTy3NKZ4KZCez1PnpexemzxTCipad5ntDZyPH2d4ePMAM
 HCbn+L5CCpBB73AgztzMjGeWM+vVDKgwoqpScJp2JZw7qExyVxfpStQ5eJpDWVcwMqWOXb2RLlY
 0uIp/LO57cjRGZh8OpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_05,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270183

On 7/27/2026 2:57 AM, Bartosz Golaszewski wrote:
> The way power sequencing works means that a call to pwrseq_power_on()
> does not necessarily result in the pwrseq target being powered-on at
> that time: it may have already been powered on before. Similarly: a call
> to pwrseq_power_off() does not have to result in an actual powering off
> of resources: there may still be other users that requested a power-on
> before.
> 
> We will also introduce the concept of "non-controllable" pwrseq targets
> soon which further increases the disconnect between the naming
> convention and the actual semantics.
> 
> What consumers of pwrseq descriptors actually do is: they *vote* for a
> powering on of a given target or retract that vote. These operations
> could be called get/put in line with runtime PM but this could become
> confusing since we already provide pwrseq_get/put() for a different
> purpose.
> 
> Change the name of the two functions to pwrseq_vote_on/off() which
> better reflects their purpose and semantics. No functional change
> intended.
> 
> If at any point users need to know *when* the exact power event happens,
> we can provide that information in the form of a notifier.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> I've floated the idea to rename the two pwrseq functions from "power
> on/off" to "vote on/off". Here's a concrete proposal.
> 
> I'm sending it as an RFC but if there's agreement, I can queue it as is.
> 
> I'm doing it in a single commit that should go through the pwrseq tree
> with Acks from subsystem maintainers.
> 
> [1] https://lore.kernel.org/all/CAMRc=Mefxn81d0VUwmQgwFtffkL1=Er_1VQZCbC1Sa-Qph4t1w@mail.gmail.com/
> ---
>  Documentation/driver-api/pwrseq.rst      |  4 ++--
>  drivers/bluetooth/hci_qca.c              |  4 ++--
>  drivers/gpu/drm/imagination/pvr_power.c  |  4 ++--
>  drivers/net/wireless/ath/ath10k/snoc.c   |  6 +++---

I approve of the concept but am not tied to any specific naming.
So whatever names you end up with...

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com> # ath10k

