Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872DF34C990
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511852; cv=none; b=bLyeszYjcxoUgKBl/uRcLIsad1d30lgByqCzqwPhqiRjY08CNdYQZhgGqvPVoT8qXce3tkJfq76L+7M9VoZ4YPJleghqMJ2shYsJc1VXNEAs8k4SaAVx3ET/HFV/Y4fIy3tW2w5SGWBXYF3kdGeSX9zCUpPFA6Zm/U2GD0hp4Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511852; c=relaxed/simple;
	bh=fz4msogSnakmeQKSqrQ7d4iwY+ZxUx3s4/WKfGlla1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5eYlPpiaBA0AR2P/Ib42dIo2Uz9CwrZLhPi5/28tzd5FQoWhoEjehHsSNx5abMkZMkrTXrRGRp0qAOO0rIbvwVXM8pd8VCFSKQOigRtRydjusRK2pzmh99rh8sEFgGoWMxEl0BjxwnaXYBo0BFw5Dupyu15L/mmoWIapH+KATI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jTcCk3nW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Li7OhnMx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jTcCk3nW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Li7OhnMx"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFOOK7701798
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 15:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xNunTRXsqpTsk4gUldkupbFQmBRLlsHQmR+eXlL+D8U=; b=jTcCk3nWFwj3zqCZ
	HXK2aGTGQfkjUJiQhdjXPIe4d8GKmzHhhMX9mzSyJHH/gwHNQ9/pnZx8s/5SMTt5
	v/fwpQArD7ZzOpRSEV+3KbksS87eaAWLemhnGSiarKI2b2lkr5+QDNkIIJsEaGt+
	jexTIEMx29ZbZFc6mVKnfkTBRncsD/OhOWtJuTs5Y55rkMn/o2yyTtNYzCWzJiuz
	NcnUtqDOrISRhOIAMssv8VQ0x62QtNkRO6YbL+vnNVNUsZLBXJ6w1fImEzO8VrSS
	ies22v2lCBSzxA+YTfZ7zvaGx1u+Xi9H80HfgpcmtaoljJ08RzGO1cm+H1xOfHwd
	m6mQAQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru1u0yur-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 15:30:45 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so786747a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 08:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785511845; x=1786116645; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xNunTRXsqpTsk4gUldkupbFQmBRLlsHQmR+eXlL+D8U=;
        b=Li7OhnMxg/+t0TD4C5BpWzcoCBJaRVhX9hhcRhmfe9lYEKHynraFxXyJnRXXskG8Uw
         mQxC4XyzpZkEZamfSlgK7So1s7Z+LXcyx6IDcriuKnJ/ND1UbXM3naPRk7T163FAOdHc
         SK8B4sADaigDZt2AVG3BqceklBG0nH/X+1r0ISYF+L47eyY2tKMGv5YT1uS+vUHNabmb
         +IiXYBqIse6fz1lmK3/9rxmMVgxHz7X83pnVq3cSKKKhhUB6zHdqzgMfwaDORTFMwOXJ
         AWxVVqlY4uSI70m20b4ltU8ruZnEXSpFIBQAZcw/4i+qqOdqKOuGkIsX1V/nbtiVap9H
         vLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511845; x=1786116645;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xNunTRXsqpTsk4gUldkupbFQmBRLlsHQmR+eXlL+D8U=;
        b=UPhtrcPriREBdj8Sz2tM6bOAXuN9JlywdrYkyzhUt4pNwHrC3ReuHW+EayFNS7TlgR
         EplB3ATRduoRnUxlmBl3FAuhbT0kIMu/c3CSFKWqO90WymBvzpWUzmX6EuPjh5/r/C9/
         CfPWJ0MUQxeUyH777e8G1WvT/LS16TP6r7QyrkgzBq61Xoos77tHyUP1Od5j2hvnBSgM
         E9u4Q30QpivzvB+yHK/ylHuTtn/otTjQnuK7dXVOHdbosT0K2tPFj88SavbpwAry4LQA
         a/R9ipfE9kxPhhYqroO3ZzWsfgOZr75khepyQyIMrnDoFOom+2aw3Zyiqv846x4B4Z+r
         CIug==
X-Forwarded-Encrypted: i=1; AHgh+RpSDF27ArB07alJVDT3h6aoJuGi/a0cAM/M2W08FhJSMkvED9manQz1K0Eplex4wd7UVw4Ex7ShQS9Q5BZRNlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKkCS1qWsevzDsLITOSDbGxej8yiJyAJtrTDJE/CDmmrfCDD1H
	wONI2Pnq42KbqRgEgDcsZexhNNvKvnw3XmF4Asog2WCHViiReDu0NIZCihtrDcHvg8BRRuejrQI
	ZQdFJXo5wrEUdUPGqXRvKbP1MSh9KeTn+7Ukcbm5GWG1HKtsud39XKOAU5fvWT+KHJxov2Gg=
X-Gm-Gg: AR+sD12C9S0Ws04iUy0Z/mIe1B8F/t4jN34ltBHGrC51f/wCMysW4ILJHNjlgjv9K1o
	BVqEsNpSQxwRTnJj9FGiwoQT2vEAqj9dspTbGPaC6TTtq1FRBZasKkWl/ZtNmbFd+GM1v4dAcYo
	24VBmh1+Eun8iHw8RXhrwdvPgQIC+1sdOfAHEBFipk9lRZ1MdE9JvmFDrcFcyiPJPxiDJZI81KE
	ZTH5wdVUZFId1bbWFC6Je29HdQDQhZkjoiFk93LjOZQb3aBf7NiqBgjfTu5yXXHxbUstmndFuXV
	I9lrn8W8cV3Tn9yQfxbed/nJqn5FnaLtjArTMxGiDkJ8OjzfYjgyJSt3gQcLBtIewmQuQDjNbkW
	Q4mPt64NgKiGS4HvOewoc4+NYHdVV6bTm
X-Received: by 2002:a05:6a20:9f09:b0:3bf:8de9:c647 with SMTP id adf61e73a8af0-3c92a2a9efemr292243637.0.1785511844952;
        Fri, 31 Jul 2026 08:30:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:9f09:b0:3bf:8de9:c647 with SMTP id adf61e73a8af0-3c92a2a9efemr292197637.0.1785511844540;
        Fri, 31 Jul 2026 08:30:44 -0700 (PDT)
Received: from [192.168.1.10] ([122.177.247.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe3963daa7sm716655a12.5.2026.07.31.08.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 08:30:44 -0700 (PDT)
Message-ID: <acb2dfcd-f024-4a70-88dc-8d2482c1e20f@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 21:00:35 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: qcs6490-rb3gen2: label BT PMU
 and M.2 PCI node
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-4-2d100f30e202@oss.qualcomm.com>
Content-Language: en-US
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-4-2d100f30e202@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H5vrBeYi c=1 sm=1 tr=0 ts=6a6cbfa5 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=wVA5pQU3D6HtJETKl3oCcQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=B7p1tibXOPgUgj-QF2sA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDExNyBTYWx0ZWRfXxWlDLfDC0Xlo
 UzQWUKGQjatujDa4Oqe7t2qFJ8Nt+0cTbHmwDqSsOLIuTkdQtgYds7ZLw5kt5PL3i0ACX/BOui3
 VJ1ARxS7Wk2pZ70WWrUby/FnAEyNtiTjFh3rnceeWHe4HNm+aRGiLMyCSPHh3a3zdgUSxEMfusx
 N3UuDVs4d6CzjFhhUfIjWBqtmJ4CQBKweLvQB66gkfw1dvczUVALxe8fdiz/CN0IcasznGJPlUf
 wdLyqIknSx3p1y315TOh7e4V8+ve+UkP/HjAvTFyt7vDvsf7FG8bNliYMOYb86m8JaBfleElSWo
 oYN7JqsBPIwi5h6VJdSaHUz/851RtoCUmBuOK30sS+6edaZelU7nrULubEHowah27JGJIjM31C3
 3tEEfuB2tNGqhRkGy5rsNHZAYlZSrodXggySeeOGPqWKrn7+5WlgAldZrto81Tx8smioaZy6ktb
 84MGyOCfDTu6HNDs0OQ==
X-Proofpoint-GUID: hkZ37P0iEQ7LzfOL1uWJYvFcCAmsJAXS
X-Proofpoint-ORIG-GUID: hkZ37P0iEQ7LzfOL1uWJYvFcCAmsJAXS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDExNyBTYWx0ZWRfXwcauNr4tjS9r
 NWbwQY+w4hM78dbdv6IuvYY5/qaUS7m17zlHMZSmD9nAs8a4ZRKi1VpscdobndAWrq5Wu9qPF7h
 vFxqg08CWi62lITj6M5L+5WZ92oNt54=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310117



On 27-07-2026 21:15, Rahul Samana wrote:
> The reworked RB3 Gen 2 Industrial BT UART overlay needs to disable the
> on-board WCN6750 PMU and add a graph endpoint to the M.2 PCI node.
> 
> Label the exact WCN6750 PMU node and PCI child node connected to the M.2
> E-key slot so the overlay can patch them directly instead of using a full
> path or reconstructing the nested PCI hierarchy.
> 
> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 37a3b51323ce..b2b6fd29880f 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -325,7 +325,7 @@ vdd_ntn_1p8: regulator-vdd-ntn-1p8 {
>  		regulator-enable-ramp-delay = <10000>;
>  	};
>  
> -	wcn6750-pmu {
> +	wcn6750_pmu: wcn6750-pmu {
>  		compatible = "qcom,wcn6750-pmu";
>  		pinctrl-0 = <&bt_en>;
>  		pinctrl-names = "default";
> @@ -901,7 +901,7 @@ pcie1_switch0_dsp1: pcie@1,0 {
>  			bus-range = <0x3 0xff>;
>  		};
>  
> -		pcie@2,0 {
> +		pcie0_m2_e: pcie@2,0 {
>  			reg = <0x21000 0x0 0x0 0x0 0x0>;
>  			#address-cells = <3>;
>  			#size-cells = <2>;
> 

One correction for this patch:

After re-checking the composed devicetree and the device enumeration, the
QCC2072-facing PCIe path is behind the Industrial mezzanine PCIe0 switch:

    /soc@0/pcie@1c00000/pcie@0/pcie@0,0/pcie@2,0

The pcie@2,0 node labelled in qcs6490-rb3gen2.dts by this patch is under
the base RB3 PCIe1 topology, so it is not the right endpoint for the BT UART
variant.

I will fix this in v3 once the endpoint modelling approach is clarified.

Regards,
Rahul
