Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47E93264EA
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994313; cv=none; b=i71GD4h+WfEr1qapY5SrtRcppXW8APye71VDM5Yrh1nbTCc55YBb2WP06Li/9MKAFs9tOIcIkLLd4pu/34HtWylUwVV+wPuLntdtnVuK92gIxURZJoJv6O57gi9Oj0XyfFH02aqZHd+g6CHHRYxDuDOg9oTEV9UY3N9edTJjfJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994313; c=relaxed/simple;
	bh=YxuXzWHDam+cuHCgh8Iwx9qoxWf2tukZ52/V+Oq8Xf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+mOMb+nNXYslePpOlTIYOQ0o2kb4tFMgudQPF2HDlhVVoo6a1yqXstTULT9T0Ffm15tRkpHbrNmqnhvUkSIOGWdJlatq80uCr1KEHCg+4JMH6u/Ou0na581IfGYWlq0xlSV7yoJiH1KDXyOn8eMayhnP2yvSpPfvSK7TM68Rn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MbQcBQ3L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V4MN3o3g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MbQcBQ3L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V4MN3o3g"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAe9BB419349
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 12:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PvIZxmuE15GlVG+Q4wvYNTHDEd1Gz/i8y/bSrvtg4rU=; b=MbQcBQ3L8hl7v/O+
	yGvXJuRxZUpZs2h1b20swVmcTg4Gc5tI5e0nhcU3E0Gniwp3V4fkMXqnVlTdMx7g
	KtpofB0o4MtfGBUrYn+rHcg2elUz5K1uYCz2MnRTM43KUQlVqHDubT2ikKZegKrA
	jhiqJherUM3LMTYHCM0teQzFBIMCtJ+mo4+kIXJW3BLB4cmEGKgBhsss692lw1QG
	vTQBYVxgTo0l4UquoWWHXBvaWehJUIiPqbN8uoJjHrf0R8KSssZL/3wScCeCBnrs
	dIGg6xfLDQhRGlnXUb7MFIsBBQRQEoo/8+CKSr/sI4LvDoe02ILNoGmgGExNISD8
	lEwNuQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtyxq98qa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 12:38:31 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-530db5af1dcso5774801cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 05:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789994310; x=1790599110; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PvIZxmuE15GlVG+Q4wvYNTHDEd1Gz/i8y/bSrvtg4rU=;
        b=V4MN3o3g8DgDm6y5UxVXvq4r/xmnAKbzK7P6CGCTkQxV/iXZMFaKqvVKN3e+9uKjRp
         WIesl9wDN6HxVH2hnmNxuRzRaSgcCOKYc1pvd2Me/Qd2/P6FKulSoPEJviMETAG3wy8+
         33jsSfru13TIHMYXj2UjA13RyOnnoCxt12L3nYMlOSiAJuQR00xm7CrBsL+qJg7mF9U8
         CC4U1xz63ugulng0eFitiGSCenRZkLKGhEJlQAEmoNvZ7oZlveV+gJAzNtutsuFdaxdd
         +LWA4dWeZsVOEGu4fSd08bwB5O84MqI3Tlklkr/T4UFCuXsaOwygK++ZXxeOvA9pfH0y
         xS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789994310; x=1790599110;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PvIZxmuE15GlVG+Q4wvYNTHDEd1Gz/i8y/bSrvtg4rU=;
        b=pxWcmxZmytTgvYBs5W0nGLiAgmD8X9CViQhbrEb1myQRDzbb2cgkRe5JhVNRtiL+ee
         MMAkWU9q2idWpPrOs67xcifZ7291oJPtAtsvqSTJWBJ8LETc+RXIhf/wzzS4Jw0NzJyS
         iUcoANQFbQGCW8Px1BUGSlXSv0aqG+A+n06jhtFarB0JQkN/rapdVdXJ0z9aCUlgI8y1
         hrOEI/Rwyl5Viryl+UFkq7WSvJv09V3a2fN86+1DTL87a23qdpYB+alL9OX0po1HH1Qg
         NkTC+5ArC2HbmWvl2f2yTUdJxUFztk1oB+cgb4hKhc7YvItKA0EDlVxxq4FWKOK9bA9V
         Lfww==
X-Forwarded-Encrypted: i=1; AKwUvBy3RX/xUCkxc9YVTihtkYVytLy8ch7yMJ8YFjzC2x2vdGbjjzt7bgfClUEXVhARWeVMIBvtQgcYM78xRXcsOoE=@vger.kernel.org
X-Gm-Message-State: AFuF++kziLrB7/irN0kF3uIlZzPA8B3I6IHFfz70YunbZ7vd8/RYtghD
	Ab/a5nqMLy3BrBuH+TGjEa00qt28J6wuhhmYCxDNLYkAmp8VofBIxHwqHeigo05GCyXslSXJOSZ
	HQnGPNr/R3GFeUFzWVm/HJTPJvFZ4lL0muMIkdyHIgPGecUnC8oUbmqyy8JMNBup18NFFz1U=
X-Gm-Gg: AYBFou2OH/OC1nY2ibaH0Bfr89Gwz51kA1vax02cFqHElpEFeY5pvtbYhjYD4LGoZB+
	3BrdyxKODQ87rDg7as4vINauQbdMLH07mN7QEgNxhIXz3vJAfDyYsxQFiqlaR37zGqvKLfPZwFN
	wCIkGvZJRlYMnRwX5VOvy2NfU8Q4Tb6XaHDn6m55Xc3anczrJ6aCEGHU6zeHQzOVsB2c30I70mR
	ZxAuAH2WVgd7XwRf/2fiB2Ri3IrI7z6H6ZXwFN99PX1q4b1yXboZY/b+2hZdsngubi2ozGRvxqo
	oMiNVlwhn+FrApEtUuHY6ArVop6FMqpCT9aacQv3CEG4r9skNYCUSeFl5W5VnzfFk1sgNI7qRs+
	PMpwPChxZthSsiNdW3L6+AA==
X-Received: by 2002:a05:622a:50a:b0:531:c5bd:3014 with SMTP id d75a77b69052e-532d8f46a54mr3898901cf.5.1789994310241;
        Mon, 21 Sep 2026 05:38:30 -0700 (PDT)
X-Received: by 2002:a05:622a:50a:b0:531:c5bd:3014 with SMTP id d75a77b69052e-532d8f46a54mr3898381cf.5.1789994309616;
        Mon, 21 Sep 2026 05:38:29 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a60762de03sm21616271fa.31.2026.09.21.05.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 05:38:28 -0700 (PDT)
Message-ID: <83b67ab2-ab68-427a-94aa-881454f457ba@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:38:25 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: monaco-evk: Describe the PCIe M.2
 Key E connector
To: Manivannan Sadhasivam <mani@kernel.org>,
        Wei Deng <wei.deng@oss.qualcomm.com>
Cc: loic.poulain@oss.qualcomm.com, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
References: <0303224f-4c2c-46ec-9866-5ea1fd0fb4a3@oss.qualcomm.com>
 <20260825092715.5794-1-wei.deng@oss.qualcomm.com>
 <isbrpaztfrgwfcleujrn4w26cshbi2mgn57tbh5bubvsegn6lc@jh3ab6htvd24>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <isbrpaztfrgwfcleujrn4w26cshbi2mgn57tbh5bubvsegn6lc@jh3ab6htvd24>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wTRieDzzfcq3A7m7cfPcj-3xVnozPhB_
X-Proofpoint-ORIG-GUID: wTRieDzzfcq3A7m7cfPcj-3xVnozPhB_
X-Authority-Analysis: v=2.4 cv=OtraWC/t c=1 sm=1 tr=0 ts=6ab12547 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Me9BlI2ErCU43xmxp9EA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE4MiBTYWx0ZWRfX3rxl15xBnP8h
 Zhj6HxPJefuKU/ghkQJZpoh9GvutdrfiZ1O5HUJsyyiDUIRgt2rVmQwO+zGE1XUQ3E+V59jcqvJ
 lWnga6NGxyAJyCSJFX9QOxRZ4NtoOVWcSs383D+EFxkgo5DAQMuOrur1h+jHfmvQIbncSMzrESU
 XwYKIFBFlRSfLUltbG1VgFiFlFBPdQ2wWtNMw5Ld9uPS3ss0SZ90TACz95y2Invf8YpbVadES8g
 WfjkNxP5h79qKDlgT/s0BQ3LiOtfYFbfnjGmgEMGmGFsH9M82OtTeHCwFnAnceYGHbcXcDwe4Qx
 WYmJ7U903zBgf0ZA6w9l1q/EPwKdLmRXjbSScMKPwXlS36QqL7OoAJQsq33D0DKtpon/EgdFQqI
 5HTW/+VUoxZBMCcArH1x7AbweMHhmT3QiMUO0L7wvRAVaYfvuauO9AoMSrOKfctyDjzyqab2PFv
 u2URLXnAmufg7szBxGg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE4MiBTYWx0ZWRfXxldbxMP5Pqiq
 IVvZK3loUW7RJix4hY1LcKGT+dx0V0EctxpAfxKnunSB1tMplujCzYOaj4KRrEultWMRQjIerQI
 ezNrzJHmxaxs3hlUINLf+JPuhOllKbc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210182

On 9/2/26 3:48 PM, Manivannan Sadhasivam wrote:
> On Tue, Aug 25, 2026 at 02:57:15PM +0530, Wei Deng wrote:
>> Hi Konrad,
>>
>> On Wed, 19 Aug 2026 16:24:35 +0200, Konrad Dybcio wrote:
>>> On 8/19/26 4:13 PM, Wei Deng wrote:
>>>> On Wed, 29 Jul 2026 08:06:54 +0530, Wei Deng wrote:
>>>>> Fair point. I will move the port/endpoint anchors to monaco.dtsi in v2.
>>>>
>>>> After testing v2 on qcs8300-ride-sx, BT init broke. qcs8300-ride-sx has a
>>>> soldered WCN6855 and no M.2 Key E connector, but the pending series [1]
>>>> uses of_graph_is_present() to detect whether an M.2 connector is present.
>>>> Since of_graph_is_present() only checks for a 'port' child node, the empty
>>>> anchors in monaco.dtsi caused hci_qca to incorrectly enter the M.2 pwrseq
>>>> path on all monaco boards.
>>>>
>>>> v3 moves the port/endpoint nodes back to monaco-evk.dts. Please review.
>>>>
>>>> [1] https://lore.kernel.org/all/20260720-monza-wireless-v5-1-69ec6743543c@oss.qualcomm.com/
>>>
>>> The series should test of_graph_get_remote_endpoint() instead
>>>
>>> Konrad
>>
>> Hi Konrad,
>>
>> Tested: replacing of_graph_is_present() with of_graph_get_remote_endpoint()
>> in hci_qca.c works correctly. The M.2 pwrseq path is only entered when a
>> remote-endpoint is actually populated, so boards like qcs8300-ride (soldered
>> WCN6855, no M.2 connector) are no longer affected.
>>
>> Hi Mani, Loic,
>>
>> We are adding M.2 Key E connector support for monaco-evk [2]. Konrad
>> suggested moving the port/endpoint anchor nodes to the SoC DTSI
>> (monaco.dtsi) for clean DTS layering, so that board files only need to
>> fill in remote-endpoint for boards that actually have an M.2 connector.
>>
> 
> This means, the dummy port/endpoint node will always be present even when the
> M.2 connector is not used. I don't see a compelling reason to do so.

I don't really see a compelling reason to defer re-defining them to each
device DT either..

Konrad

