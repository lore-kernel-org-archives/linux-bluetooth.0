Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BC03B7742
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731771; cv=none; b=oIHhEAHxjvNqFg8Hnx4L+GTiTAdvHFPJPX5dyDaew9juaKABLiSZM9nrDf0K1OC100FeT2OGBlqPf4XbAMp9nsOp/wEJeOP5mF2d2Sczm+KrsKqkh1DEWBAZStuIcl+kMeY2WbxeMQLeisKuiwS0S5Zv+b3nkIamMyCKdGxxf1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731771; c=relaxed/simple;
	bh=rEbNkFigjp0FGDCJsty0si0XKQ+e9anzsk0sFIsDhoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tN0d2Ac0Gi9z/uQHyn2ykA7cxtmbbyJ/nWpIHVjKwzYF2T7Mod61P2tJHE8d1x22H9T45RF67usIU3EEmUQ3QWdhyTOrHCnk/7F6SbdjkO1ppOO2o/vmUhbYK5GexFOGjY10Y1+sEhxf+FvKtj3Q66uyEpPqNxCOhWwkZqmvfuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YuQ1hN9N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XNemTaBF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YuQ1hN9N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XNemTaBF"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q6RnQO683748
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 08:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OJXQT0c6OYFN2aHcq1lc8qaGVj0md3a70HDIO/2Fy+0=; b=YuQ1hN9NkB+j/f2K
	jM4IdS4G+UxnMIRU84VU68/00IK/Or+kzo4uaBrPFYs+NqjhdZ3MONsOrl1mXxAV
	Dwj/k1yXeXte7091lspDKCgublXsw+jOBMltcaZFLiUxA+xJ9cghEBkD6925xiAw
	N01RVw4hEZlasO1juIDloEqq5SAL1aC0P2DqultRwCzLNHDq0UH+IKYpsxjfgT2L
	BHGYYkD58l2QL0GpcEDWFPz0giEt7t4wAXs23Ej/tn6kfPB2Y7Ngp+Volbb1PHl4
	bI0WpaxoBUjUO4+HrOIgYSZKTC9LERCexEGDfXVwjKm4JelbNEFSrSYxdjkaFRzM
	HmuAjg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9fgxjv9w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 08:09:27 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52ee59064d2so236691cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 01:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787731767; x=1788336567; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OJXQT0c6OYFN2aHcq1lc8qaGVj0md3a70HDIO/2Fy+0=;
        b=XNemTaBFz6tvgbF1NxNQzWeGGA5XGj+W6wL1pLKf1Eu6nAUf29O7k3Qjw7lbzkBFFn
         wksrNhAShkUKEUsPj9Y35JVmRc8QU8z8PEZQnnqddpFKRZ5mzEi1rUhTFJkkQ4+VPXHO
         L0anou4pBLZ1rVXKW1X/uAMk4thzkysjFOqZsCMS8rbD3xpCbTo5ZR+afU77p9Ceax56
         1cRUweVAOX64X3NP74nVT65CToBQJlN5WL3INDRejJMyobXCzj0ndrJwCn/YS9LIWPQc
         5vD6j2YKuEPYyafAv0j3hk6I+tDt+PEJI0tV/67Elc/ETmzT+FAyMrlLN8nNrXfh2Z76
         06Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731767; x=1788336567;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OJXQT0c6OYFN2aHcq1lc8qaGVj0md3a70HDIO/2Fy+0=;
        b=ldxecdtPrQ7mWQ10fA4Dzoi99L43539yBzf8umAc7qepmcvCX7yiLEl5aOqfYXD1Nd
         aZL7jUyWzFkpAMm/n+YAOSUs5F3uh+2lXg8jW0xYNkw0QIIaycB3JqbbmwyWERKAm16/
         /nuBzmh9TQXy3bogaNlLlqGTedxipL6vRRau2Q77L3hqAkJRtVxW2VHdFKLelzXMp3Vr
         ysDrEG0sOg8rKm21kV2HC8X8HjI9hbVmd/8b6sIfq+RMyyO7gp5cv0b4La3erLcK6fZP
         upJKydnz5w6Pe18SqxZmmf2VDIW1GRQXbCb9DYY/lq+2crap1HEqrM258d4B+Rd/256h
         tuYQ==
X-Forwarded-Encrypted: i=1; AHgh+RrrcLctM5HQY197B+Bna2ciLZY3Q8NLIGJvuu5fXQ1RBSsAuu/GHbG27fYswGyoWRiOD0JMgAQrZFzDF3wEBpw=@vger.kernel.org
X-Gm-Message-State: AFuF++nRYVcfBUeNrUyePjsihm+7FiseFn2eDMlrV4MYz0zI+2bJ/6DZ
	aXstpTf+xc9VmVnIu44xA/CgyZnVKKV+35Oot8kTUzTzm+4qehjoJAnowVbhy1WaPvtqpEdKmvv
	SnepfpC4hXtKOla4nRbv9OpIHQ7jUfruJJQFXBZvoLv/xeKJMwQv9WzXvOAnJzXhmmnJm1IQ=
X-Gm-Gg: AR+sD13IfjVlYzYKu5FOkaWu9uAIa2B0yo14QnxrkeO41QoKuNvhHCtz4THNO6acbpH
	h/BJ6Yz7lxcTgnFvynbXL22i+2t+m+Yf+I426FsgTYwfRWiNktC/+IUHnYOqTINvV0wFiR9mGOk
	/ATf7sAjpximn4NxWp9Uv+YV9aTQ4eQluYVPXARwvkoQkQ4Zkm6n/xWIpX4rDJVOCLR5MWov6nz
	MDYFgoZEYii1FFQQv3kzowCfKLSguF2jia8U2wdf236WvLqhiROg97zVkki+ZjFklrDFxnNmJQz
	cmgimEJyX3ww80OwW1uRNST4+IKuadZZUmcHl/tso3hLlc0Ls2Rx2eUOOT4+S9tv25XqvI/yQiJ
	ybcQRfsgdmZiXYDFgazBvAAZgHlHs
X-Received: by 2002:a05:622a:cc:b0:516:82e2:7788 with SMTP id d75a77b69052e-52e2ec1e3c5mr116721351cf.1.1787731766281;
        Wed, 26 Aug 2026 01:09:26 -0700 (PDT)
X-Received: by 2002:a05:622a:cc:b0:516:82e2:7788 with SMTP id d75a77b69052e-52e2ec1e3c5mr116721221cf.1.1787731765865;
        Wed, 26 Aug 2026 01:09:25 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:dfd4:a0a3:2df2:7724])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dc96bff9sm18773245e9.5.2026.08.26.01.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 01:09:24 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marcel Holtmann <marcel@holtmann.org>,
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, imagination@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-pci@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v3] power: sequencing: rename pwrseq_power_on/off() to pwrseq_enable/disable()
Date: Wed, 26 Aug 2026 10:09:22 +0200
Message-ID: <178773176015.26343.5524450275043262993.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260731-pwrseq-vote-rename-v3-1-44e60b8be053@oss.qualcomm.com>
References: <20260731-pwrseq-vote-rename-v3-1-44e60b8be053@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=MqZiLWae c=1 sm=1 tr=0 ts=6a8e9f38 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=_EivlD1RsPJwtJxW0JgA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: FgzqgW8QJa0oWV3kBk2GGMavQ5L1QLo9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2NiBTYWx0ZWRfX8STN1iRmDC8+
 I/0TKnmHBi1goVlAv31CD6NRCsNhdA+UuwCDiOTMSrSrqumygLxR2N/RzhRBGowtaasnjHi52Nj
 rWCM7jCCTy2b4vr20CgJIKyeK5yf6kMafGcMz+66YbDfm9VXNj+XPYayTJZt8nwr2v01WhW8mJe
 Yvwi4eSNVW2P6fQ1y0ec51soMUN7eYH9zYwk77Jo/QsuEO+3AAehwassUbiZ7GNb0sLoqDxM7Dv
 cXZe1D7u5TaBII3AgASVduOVOLkjrj6kdz6OBxTQ0/lB7kVzf0od6ePYRRWac3lJ+H+emKLgTCQ
 SY0wCpN+cRwy6TPMDR9p2dDOn2HTudFjCKDSkne/EJCIT3Z2Rxbijrk18XOBi2/NUT3TD6MmlrP
 KrxDEGgaOMQUOwKlfl3qGl6G/g8TEFSWgiS4NAq9af5136+iVfhN9DKAvPvDigUHQzbj2cuww4D
 h0ux2AeHgCr5voZYxcQ==
X-Proofpoint-GUID: FgzqgW8QJa0oWV3kBk2GGMavQ5L1QLo9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2NiBTYWx0ZWRfX0wZD41Rfdxo5
 9FysLHlk/hxcaXGB7wuIhAPowuoi06NCHHWytF89WX/uPUSFSl8dFZJB3PJZPX+jxLrOdmVvCNH
 665Y0i6PDDAorfZtAlfsIxf7kBlZWLw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260066


On Fri, 31 Jul 2026 15:42:18 +0200, Bartosz Golaszewski wrote:
> The way power sequencing works means that a call to pwrseq_power_on()
> does not necessarily result in the pwrseq target being powered-on at
> that time: it may have already been powered on before. Similarly: a call
> to pwrseq_power_off() does not have to result in an actual powering off
> of resources: there may still be other users that requested a power-on
> before.
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: rename pwrseq_power_on/off() to pwrseq_enable/disable()
      https://git.kernel.org/brgl/c/d51fc9d4cd6eb18ac82913d83ecf7bd8c85f71ee

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
