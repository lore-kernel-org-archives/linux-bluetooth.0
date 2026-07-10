Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C283E0092
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783675439; cv=none; b=B9uWPvbgvNI/Nl/FlaQ1zBFCBQxuIllji8xs2f73dESQ+csMkuYNt4IGxQCXCIZ1vqeMmN0+hLrYyxS0f9cPqXMLYJf5oHvExoZYgcjpIbdLUU8rq30f5yvhOAsEDylMGCITIwywMiGmR2jn6H5elYLh9TTDK3L9DS+n5wthpW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783675439; c=relaxed/simple;
	bh=YoVUDj0VmVAC2jmbVX6pbD6bZIFZCdW/Q0ywRUHMsJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvmak6wYAXyOJPmx6dNpVMoc1AOtqsv4qTa0ytbXm0RsIn4yebDqKC0lC+6B7bi1u36WG5AfxSsyibmAt+6vnksm0/DBCARJDOmI/V1ghOhV+FL4o32Np3aU3MwOJqiMANq6ovycysDIwPM0EzO9o0jJ+tnX3MxrQyRw4b2DGX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uh5zxbbw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AvPYxgXH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uh5zxbbw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AvPYxgXH"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dabE140894
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	66CNho0zRKeJhcUQz19hKeeEOAaD98LvwCXadn+4LsM=; b=Uh5zxbbwI1VKccuM
	b93P9bjn0BjqDmDT9Pj3cSoLHYNPkJEjf8fhIM0AyitIMR7cDabw7zPz3djCM6cx
	9X6KO3cT2D9jFVoSzRCLBnXSOVHeed/YyMjobcCqR9nptteX79LsvnNXeJN6lNn5
	Crz+8J8Jl72+ByJR/ZD3qvPwAEinjoYmKdzMvAOWROWmtuGxyiH9gXA5Bw3fHl5b
	n9vMkMKe6MGRThvPsgKj5yUbsL6GqRZt+dOl9EfOiktolWLY5O6Bw8txwiyUtGcM
	mSZ4QpoulhBQE8emu0KfDJUI5HhQIoW1LK82sZUkEPcIZpGBS4nfQU1ms7mrmO6s
	93PCqw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4facqpmb8t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:23:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e57e56ce9so21860185a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 02:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783675435; x=1784280235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=66CNho0zRKeJhcUQz19hKeeEOAaD98LvwCXadn+4LsM=;
        b=AvPYxgXHH7HIZre96xpaZPYA5DMHZCO9jvagOmyOv3TP5rUZKdjNC3qVHTjNFxiTzM
         3cmhWxxCF1O9zSINRJtfXPbu7vNpSIxrrkCpfO5qW/mXV8u3HwNbpLL012Fn8R+6EVNG
         VA7rSMcoiNuJlojTUzAkltJMNXEaFQwrXdA4cf+ZL4SIy/qfMJOy+Qc64foxsG7p8Scf
         H1fi9J7GQGmckaXJBmWTyGPQBX10eslUunArus0Lk7KC9sHh6rh41E2jFREBsXEwgiY/
         dgNbWleqFM8aMYxbBgQWQZpiNemo7W0zzNKO1ZlbxSfg2pTALF2ZIwOLXMBpACHiL7F5
         mxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783675435; x=1784280235;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=66CNho0zRKeJhcUQz19hKeeEOAaD98LvwCXadn+4LsM=;
        b=Av2vDyNzBlGbTiJq2whP7vHjIyw5N6pJ9b071VvXODPKOLCENztAm+Bej39WiIJkm7
         on6PkV1X9IBJxFmX6Jv0RkZPb9ho0zp/mJSKXjwoafH/o1wW36Ye4kBbFK+9Bz2Aw1S/
         yPoWyqLJcp5+XPRxe+YqD56kqIlQDEOVS3yCeMKMoNQe/hxauo4fkhpBAIV/pXxKkH6U
         4EzoPlUwGaqYmyCn4D4Ql6BQUNtH75tchV6kT6sifH+hnIUBIEHPBOFepBdKP3jU2aIQ
         4STMfyWcdux1eAmdqAlEAgZ+wZqnode+Yy8XClyqMrKRVt79NiWU0Jid9nfyQC5xjLde
         eKtA==
X-Forwarded-Encrypted: i=1; AHgh+RpurDOWT12ZFvP7HNhHLMM74+n+rHK5VfjwsM9g3b/ofGG9+rhAbNli5Y+sZU1ATDgSwSWVM4ZaSdD1cQitvrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMweepa1aaOSToWfgVAHsjdL0hE4qs35WZ9lHwtQFEjNBIgb+L
	WPTkBllSzhZIl7Gc0Z+F+7GjL1kFn2GfH1yqR5mWCelEMzpuBb1e4txrVAWKwu9cS96mX0kKy+q
	ZF+qDKNHmuJVRsye9uge8qU/gVwTrXvDur938Dvl1PAR2HE6YXZMKOvlZs5oAqcPO5rK6z/c=
X-Gm-Gg: AfdE7clSVrt8k9CF6X1hOT1I8L0w5alyO/BduzcKh9aI4VuMxCJtJH/DbhYHgcMxIao
	Bw6wp/q2N+QxjqnTAbnyVUB9GlnhbYKkou7PpN244R0ulvcCcghgPKoBcBi5ne1iAVJWwiEaYiD
	pEV4YiX59wWDDZzr9yGgmChPsMlr+Pe8j7MFeDPyQWj0QsrW5ejp2oFBWUROp06nUdT0/3yYwG8
	NwwK6D2Je9xiJQNOsPlct5engAEiekx0kIC73q70ogIm8/QSS+CCoQDuwPe+3r4q3xB84ETy/JC
	Lwa9tSug0xTwlLAo3OsTcGQNrlcbjBUq5Ry/eM/iKO4FtC3vhs5I6uS1AsGQyguFmUjm3Xq+kB2
	Lr8VS/JUWN7m0AR8a0RoimcQcOr8YQKCCFu4=
X-Received: by 2002:a05:620a:444a:b0:92e:72a4:f283 with SMTP id af79cd13be357-92ed7a3d1fdmr672201585a.8.1783675435397;
        Fri, 10 Jul 2026 02:23:55 -0700 (PDT)
X-Received: by 2002:a05:620a:444a:b0:92e:72a4:f283 with SMTP id af79cd13be357-92ed7a3d1fdmr672199285a.8.1783675434826;
        Fri, 10 Jul 2026 02:23:54 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15c38c164asm436634766b.3.2026.07.10.02.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 02:23:53 -0700 (PDT)
Message-ID: <c75c88bc-3aba-44cb-a530-1d994bcd8954@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:23:51 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] arm64: dts: qcom: ipq5018: add node required for
 Bluetooth support
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        George Moussalem <george.moussalem@outlook.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20260709-ipq5018-bluetooth-v5-0-e476c41f03b8@outlook.com>
 <20260709-ipq5018-bluetooth-v5-5-e476c41f03b8@outlook.com>
 <11796dd7-11c8-45e3-8f9e-1dc27da0b229@oss.qualcomm.com>
 <SN7PR19MB673648D6C15A8E15D35F1E5E9DFE2@SN7PR19MB6736.namprd19.prod.outlook.com>
 <fab734fd-adfe-45b6-a10f-a8a25f7affb1@oss.qualcomm.com>
 <CAMRc=MccvtBxJaddbX0PjjMpV+6iwZeYf2ebq953msbMeVN=Aw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAMRc=MccvtBxJaddbX0PjjMpV+6iwZeYf2ebq953msbMeVN=Aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5MSBTYWx0ZWRfX2iTDwiNgeIYZ
 Pcr1WdHiuzrJ3Gv1Vs/svmUkgwUSzSnz28IDM872HKxKsecQ2WUFm/v+a1vrqIjEt6Inka9Yb8t
 9LfsUBbukHM8MauOFjSCAGPE/phuQGhMAtLvgi6rEl5VE7nJ8hmgvDlt+Oahbdg74EbQDW2RvUM
 59f6YVeU6F1CJqUnxA+maNc10aFYwitGt7G1nUQlbiEW05oI/zH4BcZq8NdG3sfDuPkN4sovzDX
 jGpFIsw7DRjK0smB/+QI6N2j21QvfGjHziKek9cDwd5e6tQWUxnsUZtGOVDriOMU1AYd+40sPld
 qFNzYGLF4w0Bie1ogglUHd01yvbfN5lS7rtohIqGsqpJAj1JunqbBjUU4WM0rTa1JOxBbUHpZ2/
 hpfdMifmiTa8RDXTcIM0jaUNOJb1eqE66FupvpDCH6ibLEvLtPxkXGH9i0Twf+tyUI1SLxYyuZX
 +rOj4KqzkG9qruTitBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5MSBTYWx0ZWRfXwGvWAm5QEWNd
 SjcGVZbaBMTjzSfD6MMc/OqxqGTfnTFb+rsRbYxDAXC5AgrghB/ZYvWB3HoefLzEbD0Il9Ak4u0
 Yw09+1zDoElvCCxgvmNToC6F306PCBM=
X-Proofpoint-GUID: ScLwQ2VSs35LJih_C5t4fnz3ipG2D1kO
X-Proofpoint-ORIG-GUID: ScLwQ2VSs35LJih_C5t4fnz3ipG2D1kO
X-Authority-Analysis: v=2.4 cv=GJ441ONK c=1 sm=1 tr=0 ts=6a50ba2c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UqCG9HQmAAAA:8 a=0aS1VzSqY7UWMrxkMG8A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100091

On 7/10/26 11:14 AM, Bartosz Golaszewski wrote:
> On Thu, 9 Jul 2026 20:40:04 +0200, Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> said:
>> On 7/9/26 8:25 PM, George Moussalem wrote:
>>> On 7/9/26 22:17, Konrad Dybcio wrote:
>>>> On 7/9/26 11:18 AM, George Moussalem via B4 Relay wrote:
>>>>> From: George Moussalem <george.moussalem@outlook.com>
>>>>>
>>>>> Add node to enable Bluetooth support on the IPQ5018 platform.
>>>>>
>>>>> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>>>>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>>>>> ---
>>>>>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 16 ++++++++++++++++
>>>>>  1 file changed, 16 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>>>> index 6f8004a22a1f..8c252fa3ff5b 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>>>> @@ -453,6 +453,22 @@ tcsr: syscon@1937000 {
>>>>>  			reg = <0x01937000 0x21000>;
>>>>>  		};
>>>>>
>>>>> +		bluetooth: bluetooth@7000000 {
>>>>> +			compatible = "qcom,ipq5018-bt";
>>>>> +			reg = <0x07000000 0x58000>;
>>>>> +
>>>>> +			firmware-name = "qca/bt_fw_patch.mbn";
>>>>
>>>> Hm, rethinking this, it must have ipq5018 somewhere in the name
>>>
>>> I agree but all QCA BT firmware and rampatches are published in the
>>> /lib/firmware/qca directory, see:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git/tree/qca
>>
>> +Jeff, Bartosz?
>>
> 
> I'm not sure what the question is. This particular blob doesn't seem to exist
> anywhere in linux-firmware yet. I agree, ideally the platform name should be in
> the firmware name so let's upstream it to linux-firmware as such? Am I missing
> something?

That's what I'd like to happen - just wanted to make sure you're in the
loop, so that a platform-specific MBN doesn't end up with such a generic
name in case that was the plan.

Konrad
