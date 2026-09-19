Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04D302163
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 02:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789785405; cv=none; b=Pidv6o/jhIebVexxSRRzOI7YYxpILr9ySPWtJlHaVa7wf8Zj/R9+6N26vzSsSaK+HmsJyTCNuofRkYzTzMaQPK/+02JtrTCc+5ti6e066bpWAAyGn0jufe1AhGlPnnKm60o8rErLWz8JoidrqsRFCPpkLrIUcU7Z4Fz3UtUsYcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789785405; c=relaxed/simple;
	bh=waYYqn/ZAYCRPczMtifgsZjQw7RSPEM6GDPPL4OsWdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FV9PZ/NllAISI5A8KJZCt09UAcDPTFSbFvHV/E9ynTxckxtG8t3bdvBvjYZi7iYQRmZXet4d9hgfwUNbw0cfMG1wXFIldRbzPH3EnEpHUXLR9aSKqeMUEk8TEs9kKIdzcYxD2q4QYq/XXfiAzh8uglXE3OM5nlWfcUqn1ZPnuqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SbtRlwAt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i58y4uBH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SbtRlwAt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i58y4uBH"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68J2BffO2870476
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 02:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sa4Ij7LOoHHRhoCz4zyZWcLXjFXjpvT2gNuoq8dZAtE=; b=SbtRlwAt0Idk92iA
	GLIREzgbnAJGbY5Ax2at2tdMgh3Avf66WDNur1jI1NyNRFEjeZlWxAgTAbhFCi9P
	XAcvVvm4DO4hEjvUekfktUeny48AcP4auYJ9hnKCFfIQ4TtFQ0CbERlYTNez/iFF
	qXsadkkLrWZc6dqd8TYgulrMrKQN9JuElxCzn7mfM2emD7ZFtqXSkJFuhK/ihC4F
	3vtRk2DwFQCIi8UasG+oZxroUNZNT6FDnO7KewTZd5uzPWJks6QEXsU0nHCIavsd
	tWHCP5csTgJOmJP35DTVoZMBsEz3dh7VW5Ck+4bUP9t2mAqI0SADDIEA8ZO5hJ2/
	fq0P3Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gshd601gm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 02:36:43 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398d3a12589so302723a91.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 19:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789785401; x=1790390201; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sa4Ij7LOoHHRhoCz4zyZWcLXjFXjpvT2gNuoq8dZAtE=;
        b=i58y4uBH3FG1+iJ7aCGdcHz06gcoMLwyogy9PvA2d/yp47iKOzDUC/5cX3rAIEDJwO
         Pkj3/3rkdPzmlDDipA9MaYNE5trBT74gvZoZU0/KmsJ5IbG2/L24miTmKijZDH1BozZ6
         BUv/C21MV8ttrcQc9+QeRfb+ZgsGit3vYmb68GLLO4bpNVJhS1QXRT+8p45JoGuNIHCo
         /W8OxixP9YxwaDdLlg9u1YC1l1MXdXOxW2ANN3F1l6C2+qmi50TVlTwVyEcOt7XdnIov
         Ei2VKf+wcyvYnjqPxSM36OlwRYWZzZEeN8vYh94n7vlngxj2teod9fDIBXezfWz82Qvf
         EW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789785401; x=1790390201;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sa4Ij7LOoHHRhoCz4zyZWcLXjFXjpvT2gNuoq8dZAtE=;
        b=G4ydfilCyGom1Gl5dq+b5MtkA+tXOKgTeWLnKsWlAOtNwfcWRMltqNnK45+MtArejC
         6T0SHJppTEJuoACjDUPdrpjNFn5T8SO/AlE0BSLD8/iJfmhRRBrDvqgr11Lw513urTfL
         /4MCXrgO0lUICLNR5OH3ZnDV6QbFIBI9dHixY5xglaqfjUFVZU5R2Nqn4XFhXW+FfGkv
         ommRaTjny4d0KJE70p2NW5EyGre65CQjIQ+hmvOz2Y83dqM5QR2Cm7D7LOUCACIxMvC5
         GbG5P3jaqKr+HIdPuw8hA+7cxseY/WcyvNRoSm2SqWYTYRgE9KkhEb+Mk9aOygmT3Ntr
         K/NA==
X-Gm-Message-State: AFuF++nlRYp8E62JIRzNnyUQZn6fBjuerQOuWQBTpmOMWEUmXNIGZCQS
	QvJRSl6ZJVHr/HF0yvHh9tmLJpjep7gX1m/Xv03JIbCLjDfGSpY8rtYqp94Ry2FkpzkKAAWdK3H
	fhr513vd6Oour1r6ZT/pbF5r/t/7Uwqj2zDgMRHfmDMYr9t6SAHMpovUw5w0+IR6BWCN49G0=
X-Gm-Gg: AYBFou38K705phMOSYwkKFxJiB95SI0lpH3DpW6BZAIecNwN2haP4i3uF8krJ3f2a6n
	tI93y8x/yuEqC3hlU45VRGpix4aXGuYda3VRMgFtRzW3poKvteAeGXchc5hfrXKxH71o7RZom8V
	tt56k8nGgUovHyI26napJK3NVNPHB7IBDDzeoFQ5Ca1x9aUOxJOYM8RTgkasAXZsLi7Zy9uBVJc
	yvCPQ7ArcVP5TdC1A4VAf3V2FXdajygPeshbiUOKaOuGLnnmK8Pco/sCtvqR6cnrKkdyD5zVo4U
	oRJKrfUZhoWJrt5bXPnahoYEWhirydzyTvw2X4eIrdp5ob41+HZwDM2G/YytUMHbj8T4G9RRnCt
	fIpb7o7R/mpFWjcUPKdTYMinMJyT/C0eQMAzzfIH4Fe+x00baNGV/Ig/lk2Gen9YA
X-Received: by 2002:a17:90b:3844:b0:39e:345b:3333 with SMTP id 98e67ed59e1d1-39e5942a1d9mr6925413a91.2.1789785401271;
        Fri, 18 Sep 2026 19:36:41 -0700 (PDT)
X-Received: by 2002:a17:90b:3844:b0:39e:345b:3333 with SMTP id 98e67ed59e1d1-39e5942a1d9mr6925390a91.2.1789785400822;
        Fri, 18 Sep 2026 19:36:40 -0700 (PDT)
Received: from [10.249.30.24] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c3145e5sm2113066a91.5.2026.09.18.19.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 19:36:39 -0700 (PDT)
Message-ID: <74e197ab-7bb7-46c8-9485-70ba64b4b552@oss.qualcomm.com>
Date: Sat, 19 Sep 2026 10:36:37 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] Bluetooth: btusb: Add support for Qualcomm
 multi-subsystem QCC2072
To: Dan Carpenter <error27@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <aqw8ShHyjdZhPc4U@stanley.mountain>
 <aqw8zNc6tXeaNPNV@stanley.mountain>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <aqw8zNc6tXeaNPNV@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDAzMyBTYWx0ZWRfXzL7km21+Udb+
 IaZOHeyk350HrPV1F0lc7WLMTODqKH0bkAPVniuXGsyR404uEKnhxVQQCUp3oo4cvnwNRdSskuP
 dBAxmERjcYrYp+cRYZuXx0CiqOLFIqvaLc9rozcsydnknFIoiAdp6jEASw2JL7qBWlReoPGcKL0
 UNLnc0PyARlUrigvoW8gix1ZRmk0qinVMoBY9Ao2sfAiyq3AcAVBOddULTKxRqxHpuxmK54t3TY
 ltEp3bllpLNeZw2qfcOwHkcjGgFuym1VF5f7eBRcJ8opk3WWXaD4w0dYBh5gGbDUYhchwN2DzMB
 HB3HL0CYU2xhHO4JIOgEUdifCnlv/EIrrjBjBjAC/JAunOzc367IAE4TE5ErcoME9FwGt0UbcNh
 DlC3AEKvrnaLWQS9DDHuCBtYblplaW3ooBk1eF75JrddLi9JFy9u0/4Pw+/QrRZ7GwAIKDb24Ds
 iXfs3yQ3L4zCg7hm8CA==
X-Authority-Analysis: v=2.4 cv=RMQmjIi+ c=1 sm=1 tr=0 ts=6aadf53b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=o3YbW0QyzKRLgYSYwW0A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 8yYMVsHq8WyfaB8x-gamMZUcyDrkmRbn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDAzMyBTYWx0ZWRfX0LXujyYFRzkv
 IZM2U0M197DdjsE1ILlbE/OvfGCdwQe0I3rcz+y5LTmMBtNladanYDmpShZ1WJkOYvItXy9SpeZ
 T2iAxRYoPcak8rZ5NQS/iOPfjnwNTek=
X-Proofpoint-GUID: 8yYMVsHq8WyfaB8x-gamMZUcyDrkmRbn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_07,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609190033

On 9/18/2026 3:17 AM, Dan Carpenter wrote:
> See also:
> 
> drivers/bluetooth/btusb_qcom.c:2931 btusb_qcom_shutdown_unified() warn: passing positive error code '(-4095)-(-62),(-60)-(-1),1-255' to 'ERR_PTR'
> drivers/bluetooth/btusb_qcom.c:2947 btusb_qcom_shutdown_unified() warn: passing positive error code '(-4095)-(-62),(-60)-(-1),1-255' to 'ERR_PTR'
> drivers/bluetooth/btusb_qcom.c:3562 btusb_post_download_unified_bt() warn: passing positive error code '(-4095)-(-62),(-60)-(-1),1-255' to 'ERR_PTR'
> drivers/bluetooth/btusb_qcom.c:3977 btusb_qcom_setup_unified() warn: passing positive error code '(-4095)-(-62),(-60)-(-1),1-255' to 'ERR_PTR'

Thanks for the report.

But All reported cases are false positives: __hci_reset_sync() always returns
0 or a negative errno, *never* a positive value.
