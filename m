Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708993;
	b=G/IAWKlcXvOEH25Y1fgNwrGw/FhFiYAoXuGlkpfngRMxkr6joAt+prLjJhnDzbsp5yr7
	 bom27fUOqzlF1bCQ/DtBha2MZxUtCdCThO0W1I2np6mxNolNUq5k4aLIxmf1s1hoHZafy
	 fZI2e5cA2lz6E7DLjt6/5UCy/Msy4g4JTcK5vzyvXTpfSNRUvGT6BTtNXK4OuV92aEER/
	 lpCqGodUlqGTAty2j8n2b56QVL5uT3/JjS33vYu/IRwh56kDgr1LA+NvwSO6KvqzDLV7X
	 y/xCtjMDmJ9J+CzRO/tSpc16vD6lWY4v4B7WC1i2bp3fWp2XMbzdVSqjumfJdc491GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708993;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=IDI+igDoc6QkC7pgWT8Wprn1keJKc8oLjyvAr5GbucA=;
	b=Ze2JzNYluQpSIQbQpBeYSQSyfevGlBfzd0jfF4mrReS9clQjAqpugDSBAaDeWfoEIQYz
	 Vo9/UcdrWmZHFeMWRdszzL75VbIOwV2RJWK7tfRcQuUazdTSk1VuXEMoNEuIoGCzdA/Po
	 TE4Fof3pUF1IrdHvoo/sK42qk7j5TwRnK3mAL7N8UbRkfYYg2spf+vxlrYDBlHZv3hRVu
	 leCz3IgYQXCHmTye0iTezW8fzjT4SNrGG+McPDLeG2GRdzk6ZdIVvu5jUryhED99T1IEM
	 j/1XuCjRpQjWczg6+89ySHJmauFWWAdRgfb6pkmLhMqJNXo4hDsQCV2AqN312U8OL7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EDDclsUC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gugOoYN2;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284CD606A32C
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 12:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 284CD606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EDDclsUC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gugOoYN2
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3CPR1F1771852
	for <linux-bluetooth@vger.kernel.org>; Tue, 3 Nov 2026 12:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IDI+igDoc6QkC7pgWT8Wprn1keJKc8oLjyvAr5GbucA=; b=EDDclsUCxxBMMyPS
	hSRvJNY9XyOMPssJxN2bWsAG3M5QV3Mo9ybSqfB56MCR9Gvl4jcHa4oZ5CftGMW4
	vzKklfqahmA7YyvrecFKafFk/s+yDkTrZhvYlOk+YO+p/UX0Lwcnjpu9UeCDwQPj
	VAE1xx8G3frBAyWWVkaZ9qhkmBdv0L7ye/k+4iHmsz3U0kLITNPElieRfQVAJLTf
	IVbCfW/CDlXcdVNCj0rEuogCOHzRPWD2XTjz6KffviY66ir/FXJry7sgis8RnXvk
	9NYXWmso4AmHZoKPeB0cbleLnfp3F302T6DhK3FdldgdcHLyquf3Tx4gJ9eJMKow
	3nzbww==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq8u5hrxb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 12:29:46 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-98304865f02so3375169241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 04:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793708986; x=1794313786; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IDI+igDoc6QkC7pgWT8Wprn1keJKc8oLjyvAr5GbucA=;
        b=gugOoYN2/WM/kDivAuJBtXpihzzVU/JUJS14+FC7Uhqwdzb0ooMCyd7j2rBSgjpJo2
         L89FbR1PoSRMS6cqxm8NK5ZipdUOkd/ku3vUUsR6O6LM/+nBnMfmdE9Ms/YTti0kjO1d
         6Mv+HKKwzKc/21lG0ENyZQ5I5AKSzW3t1Tv7Y6z1kSggyzhETO+IcImhdmCuPcWF4ocl
         SAvtUnqKl1dpH1deZ7Tm302bganlXr1ayJYSo3GoOzXGIOtboF8lrMQEhkZgqA/Uu6rB
         LfJgEjGsfgCcd39P8fqs8aKLI7nNrLpgC1gIPEI7cY2kNwR7Fd4TGKJb6KM+0rUsSC2q
         V7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793708986; x=1794313786;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IDI+igDoc6QkC7pgWT8Wprn1keJKc8oLjyvAr5GbucA=;
        b=AXH4Yvw6+CLO+O8S/1fQgcLkxBP8LSxWIHgyjNGPaw9AqnGKjHPWwI3PVOH2zh14aY
         CrQw2g1GPzPPPJpcA7ZSc07n+2AXO/SIkSGqgys6DlVaK/6ObHAzKbDRi14kuzL0ajW+
         TkyBHqQhawDnQQhOYJ0Zs1aD0WIVdDgLxw3UUadOIjw5GdSfrtF3bxsM55VSLVzAkwUe
         jWCMUc45jkhb1cxStAGfx8+OIqNmV7uXc+yTgIhI/85EIZI78G/XAxU1fV2j2X41qZbg
         vpUMPcRz8Sz59mZnpAm7YnOIHB1LN9U/4GiPNMqSsT8/grWzJ5j+n43gR63zVriEg9Z0
         BVEg==
X-Forwarded-Encrypted: i=1; AKwUvBwPHqmhtTU0DyEzrSc6gtXjVAXXQh+sdaO8IJGLcOUBlnV7s8z1f5lt4y01tenL31c6WD0+EGc6JBe0NlKriaM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sXK2KulTeXUxUZ1TA3faighDyKOiR9Qa6vk12mwMnl9wx838L
	TZnPoTj9M1NGAsfKnBmpVu+WJyXVglnoRiUMTkL/9f4oUP+XVzJfBl0VB43uNKHL0cAMHsupZRt
	3fQnDVo/WW9IFJsJoySdPRTyBPSGFJOisd+gPiytlrStPR13xZkQynDmXRS2sK+08XXohtxM=
X-Gm-Gg: AYBFou3XQxtq3zq28mGPXtRB8ZeRnKR39SqrRFEbJohLHaWL4pqmmf+/JK5hcRlp8Dz
	yPTMBRsZDhyO5xHgOQTA92b5L0wjdRI9F4WAiA7Sai0PlvAijqvcs7NYimvuvXNs4+fD7eTKdib
	JVjzhwMRAeocwBC1fGFHPEBz9n6DkkFrlX8cg0Ue7qW/K+fum7vt7b7dhmiQ/KIy34HdiK3kaRM
	DuOMv8GP4fERw498XN4ExTgaEGb3Rgep0J8ibqDumY4dqDwnlSd5hLCdf2ey+wArKYZ+Mb04aFH
	14Kx9EnaCUmD84ovoXu7u0+YqIM59ClsGjLGLPZmxCQ7zM5iLRRO8/EXnrXgI3w3KDBgqTjH27R
	8WIcjA3ZzbpfJm5JYXg015mBGmkzwu5G2xOVwAtxqnbHAfCpiuAI9ctw4Yl6olsdQyFtDCIfDI7
	9D
X-Received: by 2002:a05:6102:6881:b0:7a8:1837:9eb9 with SMTP id ada2fe7eead31-7d07273b428mr4586996137.27.1793708986044;
        Tue, 03 Nov 2026 04:29:46 -0800 (PST)
X-Received: by 2002:a05:6102:6881:b0:7a8:1837:9eb9 with SMTP id ada2fe7eead31-7d07273b428mr4586987137.27.1793708985574;
        Tue, 03 Nov 2026 04:29:45 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d5dfsm28910586f8f.3.2026.11.03.04.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 04:29:44 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        chejiang@qti.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, stable@vger.kernel.org,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: Re: [PATCH v1] power: sequencing: qcom-wcn: increase WCN7850 power-up delay
Date: Tue,  3 Nov 2026 13:29:42 +0100
Message-ID: <179370897915.27908.8240780682152468371.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102094800.3225454-1-shuai.zhang@oss.qualcomm.com>
References: <20261102094800.3225454-1-shuai.zhang@oss.qualcomm.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uvKrOLRYBNHIDGpOUrYJy2Q_syPrAg8P
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0OSBTYWx0ZWRfX1IMyLo1+pnUP
 msemmRbcVu4ssSxY/j3uvYZr5ZzRxsqss01GJkOPy39mvPfUfDkavjGt4lgNreDy3dqMknsbik7
 ICQ2oVGlabvL/7TK2Jk9iuXOw+iI1gs=
X-Authority-Analysis: v=2.4 cv=RZ0FmFtv c=1 sm=1 tr=0 ts=6ae9d3ba cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KLQxzaQ-LYvYA5eWPjEA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: uvKrOLRYBNHIDGpOUrYJy2Q_syPrAg8P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0OSBTYWx0ZWRfX5RDTx84ZOxzC
 xd7ZddfUJL2/ZGmIzDV/4CsntOy8IqYy7utvWujbrjaSSlRnAGQNG8cIzwvOyuIRiezFDzRZHpK
 NMUAiez7DmEstwlslB5j4ZA9PXn/nY2zD90fRdSDK0QSHD3jZMznQ7CCTWQ9zc/+GQuQNgKNLEC
 LSM3nYzD7NDJyLF4GaLNbEAK+0W4ndZwtsD3zyquQr2LXAUiMuHgnNF4mtESgzHrjwOuqVGAGDa
 ZawW6tZjdMPkq1HY1vyHYd4rHo8qHA9XimJpFNYYjkgqMBFJRtIj447C7dJosTpcbQRdTzxr2px
 dQurG7ymgzeTrmu+ZW5yx4Lpga0NCEs8uahgatqiejzAblDJga+VCGzUqgl3dNK/3tw3b5jqCFW
 dN5EW8z7eQg0WZvR/2kcGOX2wY1Zfz34ZMYVn7lfTr0sCNpPUQyBTn6hWLmkBd1jRJIaVHjhweq
 f2mXzGD/6cONjAp/xdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030049


On Mon, 02 Nov 2026 17:48:00 +0800, Shuai Zhang wrote:
> When the WCN7850 is powered up from the Bluetooth side first, i.e.
> BT_EN is asserted while WLAN_EN is still low, the chip starts from a
> cold state and is not ready to accept the first HCI command 50 ms after
> BT_EN goes high. The first command (0xfc00, read QCA version) is lost,
> hci_qca does not resend it and fails after the 2 s command timeout:
> 
>   Bluetooth: hci0: Reading QCA version information failed (-110)
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: qcom-wcn: increase WCN7850 power-up delay
      https://git.kernel.org/brgl/c/bd60a639b621453fe37b780df4b6d3a13f981f13

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
