Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7963439A06F
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780906487; cv=none; b=OCNPRoneX4kT+CU5aRkrqn+PcAG6FnU6BGIfpyrfuAChd8hhVvjpbCTQpJSPyvhntJTUTSjxB5HxJsHpzSpKbmGTBOkQxyUN7EEcLGZsfWEoER6FoyW7EXBWlUhWFekWttQwfsPdKzvjFKvK2bJ+fjr2oNotUNLRHmyiwdlec84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780906487; c=relaxed/simple;
	bh=cTz+CEmaNf4eHDQpnwOU3c1JCvIbyzwOrTtHWyDNG/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ke58Fd4kA2SINHTwVo8HkK95gG31yMr+NqkOqbpiRqEM66yswII01vSkeEBfWj/YrCXyi8fQ2KPICW+ldmE0zNeLIGWf5l9NfzJUs4y9g9gSZQWVJe+Wwxnz6Shx1Ur+VdrTTAoRbmHhjoJ9/0HYvYvbA/8udWkMlziU3Y0G5aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AhzRjdpm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZCdm78Bz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AhzRjdpm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZCdm78Bz"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586Ot7B2384581
	for <linux-bluetooth@vger.kernel.org>; Mon, 8 Jun 2026 08:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lRRLoMyY3I4u7nHJezOej3HGDZ30vhH6pQAsB8UUioc=; b=AhzRjdpmxx6GwFrr
	gzvq2hVtpTAsgTqU90UZ3SdOn7IJaz7+BEa0Yt51bE+aTxSvoBT0PlUOYJ+PKS7c
	LdDQo2a9q9FmQHtbYDHPc54Qh1WQG8VTsxUjaoILeR3fp+0X7f4Ed92RjOMcfU+D
	VtKWA9cNcolPPHRORcwOfR/QEU8NFCHDIQ/UrZ/VmZlPug3bwrJjf7qoo1dWYOsj
	7eCglthF/uvJkbhPwiNgyR5yYEHy8XYcQaSfAoaNGByZ6g48HS5Yn3suX7LADWEO
	GIiGLpVfQRknKwG7T8Deokxbctks52CAwQHYShFF03TeMwa1veyGsXDokqyndG9E
	3vrdaw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embs1ema3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 08:14:45 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5178ae66ff3so67979241cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 01:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780906485; x=1781511285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRRLoMyY3I4u7nHJezOej3HGDZ30vhH6pQAsB8UUioc=;
        b=ZCdm78BzWLcv4+ToYGLypi1GBdWEQDbkP7SVmRyyMsLYBvgdXyo+9xcIrxZB/7w0ZE
         cXRmePiiknzwneNo4LyrUOTXSZgLnPpUDXQupjjkFYkc5Oy6tP0UEZ98j9Yq7lxiy9d+
         m2P6ItJWlXBDp/IDL7xrSskS5JoK60ifcGZ+wUa7HOOZjnsDT6DhzXaRcUYtTyDsgQCI
         cHi7Y3TAC+LgiSgqdIc335Gx6+Uo6elqECnE+mbkPqiSKJ0CPpuLyDtr8YNaxz2pANy8
         2HZgHrF1X56iYFwv2kgUM7qpPSS12l3vmcXkYaQ9SAnwBtOMz+Oa8ibV7G+beRhaGMY2
         3YJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780906485; x=1781511285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lRRLoMyY3I4u7nHJezOej3HGDZ30vhH6pQAsB8UUioc=;
        b=de9HjMvdCok1bsRyeO+spOhQZ3b7ljvVcwUh77LHZiM5OIN3Q+g4X+4uQOCFHCaXKY
         QaPPUDDCchC/IstDbBrlOyQKKymF1uV8AC5e+tv/MBhtnW7TzKMTyxOGB//jm/xPqX39
         Eii8CJMt5QMM3zVkldnolsTcBW0s1MzYynIP7VRnmlXIAkQkn65I7AmOKozllGgSyu6p
         6bbEZyIZLPvFfgDyBugurxQ6R3RJW2Upv0sqA7qGbq1p2l/zsYn/6yTOv6L97kyieVg9
         ldHyYLXsPbcQLQVvdHaLP/s9qzndVDT9yeN8XzfSDxOFMAV4pOqj5WrVIQ+F/q/EA7sc
         ZOAw==
X-Forwarded-Encrypted: i=1; AFNElJ/8e/CSXv3Z0z6iEsBOtAYLBzVs44pTyLd+sdD7Z2Sk9Hu3kD7fDkdmL/34jxHiRrLhONiSrUuRImufv3qyI9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU/WZBldUBfDfU4dTnpzVksghl+rmdE40DXe+uXuHHfC8XOyNw
	X6DLPkpsc4vcw5gOQEKfMDuBaA+pJ2G2O45DJrio1o8zCcMGes3yUomm3IuAwqrWyP4GuyBLHZS
	hILMEXSj+NDcV0cpC0X9v9/tlSPBLLDLPc9fAggLXNyshcXiZXwArEjA/6G6AAd/aNiDEQG0=
X-Gm-Gg: Acq92OHx9v+fEhrq+RBXWnFCxbccmodgEEI8V91lorCvGacUIG9j7ao5phnX23HF/Np
	hQj70jz8jGickD9ax2pKAZhzdfhKNMIRhs9QPSNGUGCqIrMQV/b1oL7Bl5brff7HWxoBBjtxcvr
	ShytkMSdNa1E+WX+/G7B5RKMkOVVrEq2d6sm50WRQagEDZ9x58ZzLbPHij8ohpQbUY7CDKlWxXx
	MFHSBldUXaGOFDvN8TpctrjBD80cgcTaF2J8u8hAzWfQCs0GLREmgeaQ+9bqqoDrxLRFYVmcRNe
	gpJHu02E2RzUZDb7uhLUtouKqaWuuU0zfRNh3h6viMSPb4r/EkaUOleCp3c+U00026jYTy0vvLn
	cUTGjee9tzhpszwCfKwAiWDoR3HNA/4jDH7eFpD+5WxockLwVIiRk8yPc9E4=
X-Received: by 2002:a05:622a:1b10:b0:517:760d:48d5 with SMTP id d75a77b69052e-51795b1545emr206567601cf.23.1780906484775;
        Mon, 08 Jun 2026 01:14:44 -0700 (PDT)
X-Received: by 2002:a05:622a:1b10:b0:517:760d:48d5 with SMTP id d75a77b69052e-51795b1545emr206567321cf.23.1780906484402;
        Mon, 08 Jun 2026 01:14:44 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:4904:8660:26f:8b6a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3446aesm54904623f8f.24.2026.06.08.01.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:14:43 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, Wei Deng <wei.deng@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v3 0/9] Fixes/improvements for the PCI M.2 power sequencing driver
Date: Mon,  8 Jun 2026 10:14:42 +0200
Message-ID: <178090645194.42922.8536349476896784920.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519-pwrseq-m2-bt-v3-0-b39dc2ae3966@oss.qualcomm.com>
References: <20260519-pwrseq-m2-bt-v3-0-b39dc2ae3966@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NCBTYWx0ZWRfX80cRCj3xtYLw
 xKhsu6N7wcrvahL5lvo3MwIbgXsfrulKrxHCP5KPpsynL+r/v9qj5hPJx8YDtzK+3+wd+2fJCpo
 VGiBjDhdtY6Qn/wpTe6fvCjZaGHdxknzk2RV7azxgYX1l9P7LvUoj+H0AVRdmnhFh9ZUPRh4dak
 H72flKqLTV9EqkJVnJfLiMLCY5yIRdF03hVthULPbjeSnsAfqPQV+k0mopaygWQCG8sc4lzvffZ
 nRFWlJYxu6gMGIku4sKQvq8d6edrgvzghsHqtu79BHGYWlOLwMb5UGSMI6xM2Su3ERS7LwNvf56
 yVrJ/0ILn8wEw6pe6zWACmq4JRBK32UONsO+k2a3+OIgmQXe7HgnSqczhTTfk4t3m4qG7XpIFqU
 InmpowjWVbbqrR5KfVJIUTK0AgpWkxZtqTcbr/0Fyp+ezPiaSaKbIro5ue3Th4fkBBrU7Q00g1G
 Uv4tBrihMaYAiwzsHSw==
X-Authority-Analysis: v=2.4 cv=CeY4Irrl c=1 sm=1 tr=0 ts=6a2679f5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=vezmLmUXWD6nqp7YAy0A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: VuZtOJNT6rrdVetPYx9BzCdT-MDs8zYW
X-Proofpoint-GUID: VuZtOJNT6rrdVetPYx9BzCdT-MDs8zYW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080074


On Tue, 19 May 2026 14:25:55 +0530, Manivannan Sadhasivam wrote:
> This series has several key improvements and fixes to the M.2 power sequencing
> driver and also the BT HCI_QCA driver. Notably, this series allows the M.2 power
> sequencing driver to work with more M.2 cards, not just WCN7850. It also allows
> the BT HCI_QCA driver to detect whether it can control BT_EN (or W_DISABLE2#)
> signal on the connector and set the HCI_QUIRK_NON_PERSISTENT_SETUP quirk.
> 
> Testing
> =======
> 
> [...]

To make Mani's work easier next cycle, I'm queuing the power sequencing changes
for v7.2 now.

[1/9] power: sequencing: pcie-m2: Fix inconsistent function prefixes
      https://git.kernel.org/brgl/c/da35b212f8cfd2fb2b7beaf46f4ae758f29c4ea7
[2/9] power: sequencing: pcie-m2: Allow creating serdev for multiple PCI devices
      https://git.kernel.org/brgl/c/0822425512762d492d7d1500a38d8d519a2b96fe
[3/9] power: sequencing: pcie-m2: Improve PCI device ID check
      https://git.kernel.org/brgl/c/8ababf888685c3167f49c77bcfae6f82bf661be6
[4/9] power: sequencing: pcie-m2: Create serdev for PCI devices present before probe
      https://git.kernel.org/brgl/c/c4be520907a42981fd32736b6eec18aaaee738c8
[5/9] power: sequencing: pcie-m2: Create BT node based on the pci_device_id[] table
      https://git.kernel.org/brgl/c/f2aeaa6d47d3e94285b6ff648b929f3eeb5ce600
[6/9] power: sequencing: Add an API to return the pwrseq device's 'dev' pointer
      https://git.kernel.org/brgl/c/9085f71285375485c86c06071a13111606b404d7

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
