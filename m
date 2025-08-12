Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71FD19D065
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755002191; cv=none; b=KrZ/aZW43ShoAWXMdt/iKlxSaBo8mriuY5dDUJclTpbLWSK3bcsYnZFFtonXeJzGGYv0AgQRqmcN5N6ndODr1PhuVY4qo6kMfOf8avJ82Bpxs8L6AvtAQTp9f+k2HIrmYzcJMYmM1PNAIa6ARLCPXR6Ei/nkiPc2e2X4SCQxaw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755002191; c=relaxed/simple;
	bh=kAiDSFz0Q/d0qlDTk3TH6VnLp4xgtB+kp0UcZ28ZqIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5EBkGOh5WXVM9dbPgzKimojT8TEeW4S4pwehJRYOcF+P84WLg7iYT3Oaoe1v8O8PCKt8A1Rvkrd+9vxemMEfyGqdEdH20499fwJcKgu5xf85OL7e7JjGZborLxhqwx86BmsDMvwcaQi3dWyNiYYtFpYBTdRDLJ1HO5pulJOFGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CjhQ1dEv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CjhQ1dEv"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAvfkB012901
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 12:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1ZkubqhZgKDdhvXcg8fBI/jwb8o1/f+co4oETtSIJyU=; b=CjhQ1dEvn753boZ2
	4K5bPsyT4ip8Kax8HhX4CN4TwvBl8nZ/jFnUERgGmN75Lu7ybKGOEzIKUlHUyM/a
	Fs62qoc15+y4s5g7jZ9DxRXd2B+uohs41iuIta/1FxbxYHlUI9zpu85sLYqTFxC0
	6eaVStkYvqDO8sQnVbo4+u3OAuwg9iLRotXNFu/42l7HlCyFMY017iST5oh7WFFq
	kBUtLFI1oMsePEkxx15EczbWcE8COZ5YaZGbMwvHeyfpmuPP86v6bIucZTccbk99
	73Cu9iA4jD1FDJbus9jvsMLI9hUmLHLQT/gurFa7uTxOwuPYDyoSh3MjDRiNuiZU
	ANsBXQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fjxbb8qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 12:36:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b0adca3d85so8453991cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 05:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755002187; x=1755606987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZkubqhZgKDdhvXcg8fBI/jwb8o1/f+co4oETtSIJyU=;
        b=EgZiYawL0b3Gles5Vy7H/4528Lxq6HkgZLyQUtdBIB+4MgKLfVPcm2OrXgQYYjOSs2
         qkB8vc35w7brFAWcr8Qas9qtbEGqglIg/GuBdNG6BcKR4QuaMRvrBcs0vaTy9MLdX2Bt
         YO2GHPA6ittbgOjHgVgbwX8qNhc2DOVqhvlSLTrBXqPYIpmqnX0DNw31Qgc2W1Kc1RV2
         YmRLstfT708S864Zo3UUj5Ljt5yEC3qS2WJ+8ywfwxzX4in5t08T3x8VFxgdd9omZRHa
         z8WayvEk4UJZv138QxxCCSH1PeofeBo+og0123hSaZOs/9Co9PUblOmQzt3FXgk1JBNV
         Z4gg==
X-Forwarded-Encrypted: i=1; AJvYcCXeQ0SH8HilP70HT4se+x6CoVWOCMlY4+VNDpMl2fPkFpwAI3hJL8O2hGwcWs+Q0SY6kLoJjuomFNPN01rCwQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfGclHVxVemUFW3fmYuDMRsdNUCX1k6QBYPKOhco1wXlFIeBwg
	UMJGTRGdqKEUrZYGdwcNhg41R9Ik8mOF8O+CYofxOSbABv8hV1pBHZaXJsTPiM50kpbjE4xSZbs
	36SsCuIAItjaqfotwDcOW2DYggSZiyrMu1bHdaC0LmJc7FwPj0mwUAdMTUHxt9/5wtjfGpDJI29
	+lOpE=
X-Gm-Gg: ASbGnctYpPV23oTclbuCvztOt4A6kRwmhckxJwaUewqISq8Ip93js4Y2L7U0Q+aa1yi
	YH+yQF9yyMf9MotlrxAyx+cygRhqw+PoAi803A3gjl+TK/kDF/jvh+HOSTNIRiqWeJi4nZRzG/V
	X15NMCGTYQdfquSY5SMdXrflq6XL4+nwJQLPDiBhqWz8zLVZoo8ttdhjkIwYBFjOKeKffV0h/Lt
	Oqd99G64DayWkQjoy6cLIjCqgP9hKYOUIY77Lltkt4DuMVAnrHIFO4DiV9czwIlm5vNy0fVT+JE
	Aew1bzzCZxFZ6EQsv26xJkKlnkGE6/EedR0JQ0noDwhWFZLlHyodQMxr0MobtrHgE38Z9ApMVHn
	nQZ3/4rtVe2wnQh0XLA==
X-Received: by 2002:a05:622a:4cd:b0:4ae:d762:c070 with SMTP id d75a77b69052e-4b0f4944fd2mr6895961cf.2.1755002187510;
        Tue, 12 Aug 2025 05:36:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr9ZC1n117TOHBtxiWTNR1pyodPwWUGh0sBoao/x2KAU+BBH3o3vDCMHVPAmEmwyOPtd3opA==
X-Received: by 2002:a05:622a:4cd:b0:4ae:d762:c070 with SMTP id d75a77b69052e-4b0f4944fd2mr6895791cf.2.1755002187028;
        Tue, 12 Aug 2025 05:36:27 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a37a8sm2207820166b.40.2025.08.12.05.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 05:36:26 -0700 (PDT)
Message-ID: <4ac0db96-8107-4809-8b13-580d75948ef9@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 14:36:24 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] driver: bluetooth: hci_qca: fix ssr fail when BT_EN
 is pulled up by hw
To: Shuai Zhang <quic_shuaz@quicinc.com>, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: quic_bt@quicinc.com
References: <20250812113620.3135226-1-quic_shuaz@quicinc.com>
 <20250812113620.3135226-2-quic_shuaz@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250812113620.3135226-2-quic_shuaz@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G6EcE8k5 c=1 sm=1 tr=0 ts=689b354d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=Ok9mJCcS3AzO1ZkSq8AA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfXxnKVYVy0mUzS
 51qkC1H+JsbQR4Zn+0MtXGcXNafGu9qV7Jm7jjQ6eFAf9e3Me6s87Og0EsjL54yXN3vQJDrcIo7
 yvGWB1jZf9yxib0wGv4zgQGZaw6K3pn6VVx1HJ/EbgOQElXz0P/MeKgKgBDGp1hbUA62q3Px5wg
 JkSQVSnV4Ti/aKulCmiWk/VnmDo+7gtVS0w6qCeVQdnyma5oDhFVUDRUNWMfI2Jec2l5l0LOOKF
 ci2J2th60uNPGKdsVLR/2LRM2ECDSgazNnbJr9znfrN7vKc0aywNTYgXPl383Z5sVHTKqhSnRky
 95bMg6z0IFkB/zD1CRLVmZpL1eIepUMvsC1PVZDS+eJdfGAm2sMJV6yMb+c/gAeDLbUwCKlL3HL
 vhjTRt/L
X-Proofpoint-ORIG-GUID: 4LdSD_rrREH0pKLjm1t8j5f1jEGd-WTg
X-Proofpoint-GUID: 4LdSD_rrREH0pKLjm1t8j5f1jEGd-WTg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_06,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110097

On 8/12/25 1:36 PM, Shuai Zhang wrote:
> When the host actively triggers SSR and collects coredump data,
> the Bluetooth stack sends a reset command to the controller. However,due
> to the inability to clear the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits,
> the reset command times out.
> 
> For the purpose of HCI_QUIRK_NON_PERSISTENT_SETUP, please refer to
> commit: 740011cfe94859df8d05f5400d589a8693b095e7.
> 
> The change is placed under if (!HCI_QUIRK_NON_PERSISTENT_SETUP)
> because this quirk is associated with BT_EN, and can be used to
> determine whether BT_EN is present in the device tree (DTS).
> 
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---

I have received this series two times, you didn't add a version
prefix (make the next one v3 so as not to confuse the tooling), there
is no changelog and you still haven't added the relevant people to CC.

Please read the internal guidelines at go/upstream and switch to using
the b4 tool.

Konrad
