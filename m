Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA9D2D3A7C
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 07:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784877716; cv=none; b=VCjFIwoz8dwfVwsstMqN2UAAKRrRLbY5v9WjF0W2WkXmj040KlRforN12RbQow9OAGInSGN+a8ZAQywiQHSO5C5PG5XgZXS8eVgBxnyMdposkf8hs0EDgxh0XDnKmbJyrE+I86KUL5lPW4fZzHOYDFX7VBkjagEKumDozhDoFM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784877716; c=relaxed/simple;
	bh=T/mVtXFpRV/KFXPYmh4hS6FwTGtXktfC7N93Cv5SD2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QqJxFkwWGslgm/+r8R8SeWQrJTKiHuO2x9fIgx4M7Uzz0WjlTJY/ua9pQQHFwQyIWArnefwYITCqX32B/xKYk2RjQqb7k69L7MdD88Vf1FtWKlOkLkpfsPDNuXhCYBu646lCoNo3nSlI4Q8rAu6TTzzOrar/kcZZrsXCvLwfiLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mv60xMcP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aqsLLbez; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mv60xMcP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aqsLLbez"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O4lJLA1869101
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 07:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QujMsYqHj01uukt0+i1dXgGQeV+hHQ+bjAtReQvTWPY=; b=mv60xMcPc/yPiVMB
	lWzfNxLu27HTGiW6xzh5RqvZYYPcLvGF0wImFbJa/3cKvstTxr9SC2OkXlNdpSHv
	XZiPbI2Mxmejo3G0hi1PJQm12H6+OtD28pS62v58Sr7aNN1jUrwCEcWGshq45FvZ
	IC7w68FwJvY3cArxQ4uCY1+m35+trdu5qYsg/5agCuqzMBvNAgG0yKaXhEGAcpW2
	HwZ+pP1FTWpwGj2st5gU5Flflg+GIZaxANVUdtY8alSwC5sAbrOQ92e1Tk49uPfr
	LFDbGibRPvGgr6N6pBxcv9qGpZUn6npJAjl6VMqCQ//XOET5lSePLqAKjG3GpNpB
	Zu0aiw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm0pw8n4y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 07:21:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cce14a21faso2522985ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 00:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784877712; x=1785482512; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QujMsYqHj01uukt0+i1dXgGQeV+hHQ+bjAtReQvTWPY=;
        b=aqsLLbez4LnUyNHyS63CnZVOnYwluvKm/N6riqyK0CvKyQIAywLJAHdOQuUgU0/tQA
         BE/gho1cKjWGKftJSxUxCXgTOzPZ4E/y2K0oDSlCohjWx3ujgb4qlWO2JKnr4yoylOkx
         jaYuokg/tpkYXsScetO8GPCHoNbNhXNlQiRwjsaoYZymdo6pcENoMxsI071YWK+iSijk
         ncYJCxmMJuUjVSfVoZD2lszOMGjMoPfIxrdID9ozOW9mHTtZ6MvcwRNHamblmUb2kWy2
         WpAvSBWW2jMOzD2/IBxN2IlqEtJMqMZn7gSnNwTBtVznRCrIsoLrgx85sCKp1jfIcA+4
         zwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784877712; x=1785482512;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QujMsYqHj01uukt0+i1dXgGQeV+hHQ+bjAtReQvTWPY=;
        b=auta9lpWHWpAxr959/DImHZSpZ2/GZU3PEelH9CFEMYM0dlCypYH78ZFonp0gCyUZB
         qOI9IWwyMzjT3bjpHoKubxzp5dClsJ2o0exjpVI/QN3IuSqjLIQo1rzEeXuG7T+48hml
         jzxBd6kVOLzKqVE4yfM2abAUTvDApa4vrldxUu/DxePfAgm31nBnFv8Q9haY8NcAk5oL
         Joa/WmAXcs/GZpitp9wbpcynEeyc6W6vc2YfkGLq3gyDQW3eoLThThGDLRlNm7QTKd8n
         nL4ZvDqFI2/g0J7iNneencTy/nw1RR6w1+JVRrUmZ7X3PVL0wYe9HctzumI74WpLVSqz
         VVCA==
X-Forwarded-Encrypted: i=1; AHgh+Ro8/bN/LEYsMVmCib0pyIY9C9nvh4gB1/fzSX4+h0MAVkf8tU8kW9Mh2PHJIHHilX6IHNYsEmYbrZOJIhu4iEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYDGYmtCTSgS5RbwFfP+k9dBNr25YIiS6HIvyc44tPhs6v1by7
	6u4PKnzx+AS6hrSmvJxdndfCJIyvm5BZ/zjyoFsHE3S5/hzByLe7IuUK4Np8/1IvUGNixtyKhns
	FI6kGDgSPeXJSDJ7WJc5xovNeRmPR0nYWIT+B9lHBdolzscrXJeB/EqvE3LwcV48VHLapbuM=
X-Gm-Gg: AR+sD104OWli74MToR3c52P3uoUelb5W8706zHU8LyiFwnmeRZLXDNHdh15pZGbFZ+P
	dYOasdRgvpAQg+PvuWlsv6jsDyI1gIJ3FskFq7Xa31eag7Ajwx++/0DBQ/ZhG7/oZV6fBKdytna
	PKNv6oLAa1biXpEltB7u7WTf++ymXNvxbudS/tA0mDq+HoGYfWHfQIdOTJyieG3AE8lX6Dnv706
	z5bwAQq9A9NqamvOa5ImkKFy3VIEx7grKcr2GIKElMXvCrNCRTBvBUSuBOAzI032xn5KHTATqMa
	069y5LcV3xRvFtCJl80D/pPPdAVWvJBnibarM60UKbINeoNN5xQBssgID7qyaD1751UNXHY/jB8
	K9aNfpKW6/c6i//Bm/mbOfV16pzzSphU=
X-Received: by 2002:a17:903:2987:b0:2ca:53f7:3c69 with SMTP id d9443c01a7336-2cfa9452b51mr64444915ad.9.1784877712479;
        Fri, 24 Jul 2026 00:21:52 -0700 (PDT)
X-Received: by 2002:a17:903:2987:b0:2ca:53f7:3c69 with SMTP id d9443c01a7336-2cfa9452b51mr64444505ad.9.1784877711665;
        Fri, 24 Jul 2026 00:21:51 -0700 (PDT)
Received: from [10.217.252.136] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f39064bsm47642475ad.76.2026.07.24.00.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 00:21:51 -0700 (PDT)
Message-ID: <dffd2ba5-f02b-4d8d-9b6d-03acf1f6f205@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 12:51:23 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Bluetooth: qca: add QCC2072 support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Bartosz Golaszewski
 <brgl@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_hbandi@quicinc.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_anubhavg@quicinc.com,
        quic_mohamull@quicinc.com
References: <20260723-rb3-industrial-bt-uart-v1-0-3c8e580c09d1@oss.qualcomm.com>
 <20260723-rb3-industrial-bt-uart-v1-1-3c8e580c09d1@oss.qualcomm.com>
 <vxyc3lgvofl3yrodrzgxh7dtw3aegdcy4bwn7nf6eivhz3ld64@i7romsdep7e7>
Content-Language: en-US
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
In-Reply-To: <vxyc3lgvofl3yrodrzgxh7dtw3aegdcy4bwn7nf6eivhz3ld64@i7romsdep7e7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA2NSBTYWx0ZWRfX8aS5CvL2suh8
 CLifausZKLrten0UEC/JICkSBSLc2nK/xyehYwH/T/zZ9tfPaOtx3+EoUhho/i8fF0nCnnn7vb6
 AF0Haie4dtO6OnGl3DpD5k7aUhtJOlgt6mnRay9DRB3zN3fF5SsAk+xo2mq2Y6hVmTBqvl6E3ph
 GFWFO14RwsCm43NEWFTX4rx0ceq53AKJA/OThl9A+pi6IxRu3Qvlfmhf2iRP9IkI6pQDq2nvwD0
 sZTdJrx8gB95yyTGJVXSxRqNFj2xUicyW/wtZeT9JsG8iUpROA05LvxdSQWCfgLuWDHSHq0wzre
 MC/mLZwLOSnhh7U9A1q0MWcnuaXSao+C35GoEIoRFqL3xQa5Gf4OKmBPxVbO6w/lg6ja9pWGDZG
 HcRuXKHHTaGv5SE9AnNzThpuRT92mI4dIpmPB4yrGkrXoPM2QYj09rAUkriTsFq5JyvHflXy003
 9fefHGBHTVfbhLxEHOQ==
X-Authority-Analysis: v=2.4 cv=RJeD2Yi+ c=1 sm=1 tr=0 ts=6a631291 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=LlWMOfBPVhFVXrbsjUAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: hVCWZPPWklraEqtkMmN0n3-Vxj_flx3L
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA2NSBTYWx0ZWRfXxEhIyqE30zzO
 N81VxeM502RBYleIAjH5CcckAW4jUgpfnZDdCA5VekZwZ9spqom/QlhKcrPbB6riFIAFmMDubSP
 i4IXzwBacSHWYRZXiOWJjXVobcu7rY4=
X-Proofpoint-GUID: hVCWZPPWklraEqtkMmN0n3-Vxj_flx3L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240065



On 24-07-2026 00:36, Dmitry Baryshkov wrote:
> On Thu, Jul 23, 2026 at 06:01:07PM +0530, Rahul Samana wrote:
>> Add QCC2072 as a supported Qualcomm Bluetooth controller.
>>
>> QCC2072 uses the ORN firmware and NVM naming scheme. Select the NVM file
>> and BCS calibration file using the controller board ID when available,
>> with fallback to the default files.
>>
>> Register the QCC2072 compatible with hci_qca and route it through the
>> same UART setup, speed switching and power-control paths as recent
>> Qualcomm Bluetooth controllers.
>>
>> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
>> ---
>>  drivers/bluetooth/btqca.c   | 70 ++++++++++++++++++++++++++++++++++++++++++++-
>>  drivers/bluetooth/btqca.h   |  2 ++
>>  drivers/bluetooth/hci_qca.c | 24 ++++++++++++++++
>>  3 files changed, 95 insertions(+), 1 deletion(-)
> 
> I think you are a third engineer who submits a patch with this name and
> with no mentions of the previous work. Are you working in parallel with
> no idea what other team is doing, are you ignoring the previous work and
> implementing it from scratch or are you picking up a patch made by
> somebody else and killing the authorship / SoB tags?
> 
>
Hi Dmitry,

You are right, we should have called out the prior work explicitly.

This series is intended to continue the QCC2072 enablement work previously
posted by Vivek Sahu and Yepuri Siddu, not to replace it without
attribution.

Vivek posted the initial QCC2072 binding and driver support up to v5:

  https://lore.kernel.org/all/20260218114955.3970974-1-vivek.sahu@oss.qualcomm.com/

The driver part had received review, while the binding side still had
open comments. Since Vivek was no longer available to continue the series,
the work was picked up by Siddu.

Siddu then posted a follow-up series for the reworked RB3 Gen 2 Industrial
BT-over-UART use case, adding the QCC2072 DT binding, extending the driver
support with NVM + BCS calibration handling, and adding a card-specific DT
overlay for the M.2 E-key slot populated with QCC2072:

  https://lore.kernel.org/all/20260529175342.3363935-1-yepuri.siddu@oss.qualcomm.com/
  https://lore.kernel.org/all/20260529175822.3366535-1-yepuri.siddu@oss.qualcomm.com/
  https://lore.kernel.org/all/20260529180234.3373056-1-yepuri.siddu@oss.qualcomm.com/
  https://lore.kernel.org/all/20260529180431.3373856-1-yepuri.siddu@oss.qualcomm.com/

That series used the older card-specific overlay approach and was also sent
as separate unthreaded patches. Based on the review feedback there, and
because the M.2 power sequencing work was being upstreamed, we decided to
carry the work forward as a new b4-managed series aligned with the M.2
power sequencing model.

The driver patch in this series is therefore based on the previous QCC2072
enablement work, with additional changes needed for our tested RB3 Gen 2
Industrial setup: board-id based NVM selection and combining the BCS
calibration TLV with the selected NVM before download.

I should have documented this lineage in the cover letter and preserved the
authorship / Co-developed-by / Signed-off-by tags appropriately. I will fix
that in v2 and make the provenance clear in both the cover letter and the
affected patches.

We will make sure to follow this through and address the review comments
properly in the next revisions.

Thanks for pointing this out.

Regards,
Rahul
