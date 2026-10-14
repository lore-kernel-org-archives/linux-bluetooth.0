Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A485553ED12
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791986715; cv=none; b=XlS1w1eJHnMZWwgMpn2eXeeoXUlAG8hJ5ULomtXzukaXVsUSZMFaEkm312Sftivc+du3O9X4TfRXAH6eq6U85YXKpo7g5idj0xXCJM9IdJ75igWPVSsYQ7FHs4YkuegA8X3HHfHsMCUfWmfLGWorRNc7HucnHZsvNOs/eOVroIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791986715; c=relaxed/simple;
	bh=on2PEhB3zQq1g4jTu3KddnrV7cQSAaGoMUS/teguhck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXPGbSqdVMVWbSTcm1rbezxn95ARqr4+yl0TicLhC00P/kln79n82yPdckrcMuw9K9fuoXsoUv0pUEQb1k+yFX4zQdf1p9S+hllYPPuzqUMTGKiC3C2R6pLtv4t//Mr07TfdwhQEfL8KKNDyyKWc2XtMPVih8efV+A61JbdzZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H4YyJgJC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gqm+93QL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H4YyJgJC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gqm+93QL"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E8ognr3000886
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 14:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DXB1+owYQBBqW88XzzY6K4eceuh+GlN0C86aFl0rv78=; b=H4YyJgJCbnABl9nz
	FmZ7sqPp+0OU5N0uI4WwVsQ6BxuZtcWiYZwgKoCwW9E/5flb+LG/sKBPnUMaNxGb
	7MiUv6vxm7rrJbssZja31V8RfPFlrQZnt4pmlMul6VixjbYUpA0WzmfXSmxssXsH
	GexKlSPHb4hhG/zIxIejefUy3VlURerLDXzfPEfZFE6w+E8ycwFaDDvZSLAq7tVz
	Ph5zbELPlNS8yM7v3qB2/zxDXe08DKhDLq2hCDYVlbcyt4Cx01KAMKto9sft7DEG
	ZNjw1b90zrQdHjUPewyxunuqZJHwgsqSU4Q9iiHBK/BDfDVeL7xKFNUXBM0H/+jz
	QAPAzA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9sbeva0r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 14:05:10 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91b89618384so4977636d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 07:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791986709; x=1792591509; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DXB1+owYQBBqW88XzzY6K4eceuh+GlN0C86aFl0rv78=;
        b=Gqm+93QLsvhXkJGzpMiguhMUoOOWRp47JkJb/vPHAmMuqVmorC5sjrbFdCBfaRWp3i
         5yh6XyFHB01QIV/05mexdANyKCBPLA3hyh7kF2udnQP9kH7v94z6GEamTe+RuzwNrY59
         e7MRyGo9tjbVFHTp+LloYaLEvQAFqFbN8wvMbgUxV5I+gj8KoqFhNOZOpcS7pGKl351A
         MfroU84up89C1p8xQ13PbqfD6m5h1mSgva89+GPg+CicaxXavVZJoxQEAaR87Mq1V7B3
         QXmo6aACGyekZVhW/EBQ+2QCp/ur3XzpfVn37YrnMedZRgj6DlKE2I6m9Fa6GewkYw1Q
         5I9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791986709; x=1792591509;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DXB1+owYQBBqW88XzzY6K4eceuh+GlN0C86aFl0rv78=;
        b=W5VrhFXY5JZC3hF1ZKYKC8gvSy2pPAzhFbqyaa+eNJOJprtnjU857HcLhROU09qg62
         mEyFh13lzbuyN7Ar20c3xIPYwM4Iy3ebfjU3/X5r63T2uPID3tiR2SQVa2p5L2O9SBZP
         x9dIcoP9EGiFmR2bxKnYO7fr9FS3I3QAYzLenKOFOn5cg3fVkF9cL9HccAACs340tGAI
         PziQZl1ryJ+dmORa6arcPzU0GlZScAQdER92L4olPyEw7Ic3r6nbBO1TLIhBjJ2Z+EiD
         jeip4Z4daYBMFfKDprkzrsKvieO7tjrBXm3bsYw2SGSD9plxwaRBEXhpzjj1pv5dPD83
         MjjA==
X-Forwarded-Encrypted: i=1; AKwUvBw43lt9W8aZCN4ZYPxiyhZoapqazAUGGvLQgjou5TMl3iR2XcIMnao0rM0cYz4HmeBiAE/MBTgmcHJDxO6wIg8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJgAi+KyeXWksfW5oqaDBoWzdLhoZDU6v7JqF/ebE9NHEhPRM7
	CCjLn/u/uTKrVmlrtvP2W7QXb3mv2T9zBL2S+ZIW43aZ06Ov5eXNhXaR7Alajt2XXTEp0DO5rgv
	ukac2GSkuJkRswS7+uX7gQ+EDr1AUGScn6T2W/Wchhyq8uwskVnoqLWlTXW+zZY1NkpeNp6U=
X-Gm-Gg: AYBFou23omgsxn13RI0ybqgJNEdMOMmfsYqy9857CANjbQKwVlDc/SD1VYARQdjrA8Z
	HZIpBrKpSwuhIwdXC6RgGDAs9EREMdCccHqZzYaqYyMtWIYRTceaRhXvDAL0yHe8fTgFWXoufFM
	8aB7fLeq77Pi96ssr2CDsqDVvg8FkC9apyEDdteEaSx5sDYueXvRQRaJ6uRRHjUlC1OvI3I6JwI
	8mqht38uD48RBNERhRU3VknfxJewEr7WHwVM24osI9S3+GlySELLJjeNmchSOuL2PpJKN5fmnaW
	iUd6PWv2/1JNpIDMAZPZNaiiaEpaDRBNHamQ6XKlE79b6XY5npPDeQ4GQzuCSE9E4Cdr46ZIP17
	6a8EesAjETM+B8DcISx6KdQ==
X-Received: by 2002:a05:620a:6498:b0:93e:e111:2771 with SMTP id af79cd13be357-93ee1112d0cmr1775882985a.2.1791986708833;
        Wed, 14 Oct 2026 07:05:08 -0700 (PDT)
X-Received: by 2002:a05:620a:6498:b0:93e:e111:2771 with SMTP id af79cd13be357-93ee1112d0cmr1775875785a.2.1791986708169;
        Wed, 14 Oct 2026 07:05:08 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a9c6805985sm38426281fa.2.2026.10.14.07.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 07:05:07 -0700 (PDT)
Message-ID: <11f513bf-fdc1-419d-8eb6-5cabb6220fbb@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 16:05:03 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/5] arm64: dts: qcom: glymur-crd: Source MAC
 addresses from a UEFI variable
To: Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20261014-b4-nvmem-efivar-v1-0-187c85f65018@oss.qualcomm.com>
 <20261014-b4-nvmem-efivar-v1-5-187c85f65018@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261014-b4-nvmem-efivar-v1-5-187c85f65018@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0NpcGk31yj3aaq265vhbgdgYnQ1x2Zhd
X-Proofpoint-GUID: 0NpcGk31yj3aaq265vhbgdgYnQ1x2Zhd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfX2WYZ5SP4Z/rp
 12XfJRdMv8r7RMGYgU/Cq6I3FkVCz5/lKGcCrEyMdYvIHh1CSFba+j7yG0Gh8HIDQZcI3GWstKd
 CFf3jpP4ZhUDTKEFdZnLXyEn7fU+N+iGUlqWha1l3aWo2Hv/u9Ctip0MW6qOnz3Bs8+mv2SN185
 tAULmKZvxJgXn/wqhMAeLltDLdJIXdb3H18/ML2sUSJ6YQ96ktxAui5IA5xkFbLNbA7H6jt9yHb
 rzMU6JWyvhTerVIOjM++zikG+GdfPIhDJtmNg+OD7R4cYTIN7aa/TYdVELQZenT59vCyad3U182
 w7sI9Mq7nPcXNBzlDfEcj9uutRKe5VPQyjTy6YCvRo4Piisy0y7FjTr7lQATntQ4KEOzQHC2dAg
 JEprdVkuZrATBGbslmblCDfGDU1j1rjPQ9Ofpu/l3xOgbopGPY1glIYUONNs0fWwyGL/iPcgT/9
 JJ1BLu9pNq49vLAb9Jw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfX/JajkYjOJPvQ
 GEQcx0Q13J4+CqZz7znQl+KSumanJ/j9MliNu5OjPqm5wRDOAp3ZmJR6gtDEIu8qR6RzjqV8Ewe
 9FMYZv4idGYfNjkBqdMp5uwxALtuNjs=
X-Authority-Analysis: v=2.4 cv=U7AHnuru c=1 sm=1 tr=0 ts=6acf8c16 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=jRqq2JA-ig1rCJpZVWcA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140056

On 10/14/26 3:02 PM, Abel Vesa wrote:
> Add an nvmem-efivar provider exposing the "MacAddresses" UEFI variable,
> carrying the Bluetooth BD_ADDR (bytes 0-5) and the WLAN MAC address
> (bytes 6-11), both MSB first. The variable is looked up by name, so no
> vendor GUID needs to be hardcoded.
> 
> Wire the bd-address cell to the Bluetooth controller and the mac-address
> cell to the WLAN endpoint (pci17cb,1107) via the standard nvmem-cells
> binding. Until the variable is provisioned the cells read as zeroes and
> the controllers keep using their default addresses.
> 
> Assisted-by: LLM
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur-crd.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
> index 58158b51fe29..2dd09ab1d550 100644
> --- a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
> +++ b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
> @@ -31,6 +31,22 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	/* BD_ADDR and WLAN MAC from the "MacAddresses" UEFI variable. */

Let's drop this comment and sort the node

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
