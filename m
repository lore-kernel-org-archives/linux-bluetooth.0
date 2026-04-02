Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D37A19EED3
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 02:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775096765; cv=none; b=QbaDTDE3duhATFlnVHFjvmEIyt08QHJtVYxIjLuqyL9gmlymHuSiK22sIz5mJosGQ484DAnnr6LapTXTcppDC5Z6ISTp4nwpeAv1O+cfBrh72kcYH8QItwJVKz32C6zHfbz4lPxeZkzwJ2BSwHyJyApEhw49WwqNOqMH6pt0ibY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775096765; c=relaxed/simple;
	bh=+hdin/cabmUnkeHYjAQY+h3l/3itYJtI+V7QeMIgFB4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EnL6Qy3h+OHaDEQ0vSvwf1VAtI8S6pqsAUkolk0fBzubTxUYG/2GyRkiDBO6udqjoFZzGAzmOtJkzNqLUuZZAdbdOKmvz1kLNuL/W0ynavOMyt6dY7bTz4y5SgD2YcBqvI+Oe1s5Do4j0ZMYGcELvI15lL2wtgSJTvk7tmQEbdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lKvz3NRj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SkgBFstD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lKvz3NRj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SkgBFstD"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631M4CPK2798898
	for <linux-bluetooth@vger.kernel.org>; Thu, 2 Apr 2026 02:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YoETeGfnx+ul1+cJim1t3718pgueffgoi0/3qr5B0f0=; b=lKvz3NRjg/wwN+ja
	SnR04LOM5HUkSFyYAkyyiQhkVdNaU+j0X+wDeH/p4AzZhlkTi3tfBJ3X8IfRNuN6
	MarWuJjXT5sBidS367kxwxNe7hP0i6JKJr9HSKEG0SHBvf0ZprmKfGgQJVGGkDqG
	NCGJ3ly6HopmWx6s/ymMOHrXyFC/7HgSVJKp+BS4rv4ldHeDxWbS4lTeoC3KpM+P
	uIZ+ldj4kcv5pgxCvccXqms8IYnP4mLPXHqlUT6y7+3f5A3Y7slufIIF/P72mEyK
	3+g27DPqRP49FJ73PEcnfBjIyC9D+bWVY2p9DGZWVfsZcba5ICjlgnYqoy1kV/mn
	hKnmhg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d96hk1usq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 02:26:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b249975139so9901505ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2026 19:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775096761; x=1775701561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YoETeGfnx+ul1+cJim1t3718pgueffgoi0/3qr5B0f0=;
        b=SkgBFstDEmAh/g/EMWfgYK3NHeYbTImbigC55ongYiNwVA/a3ubjRf6prYIAYqhRWm
         ku1K0UF+64uuDs+xqW8O6GPjJ/2yvb8YzqVSyOfA8NQCXeF6QNsoDGYOVlFlLqmbYAWn
         EQlYkRZMGUzYLoP7QL78EEaai19ZnJcaZDpXjd37NDvg4HPZbpbEl1H4qaDafq02BEFQ
         ZeBWBqk6Gqxs+qkSHi+xkQmmHbeA5KmHcF52DzdalH38SMr0KI614lZ+2TEUryEh0NR7
         7PCKhP1iC0Ot2IXWvWKAu+QL0D+O2usPVZGLrgODxc+jhA/p/isXsu1o8AXNo5uexGIb
         KdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775096761; x=1775701561;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YoETeGfnx+ul1+cJim1t3718pgueffgoi0/3qr5B0f0=;
        b=cKtDfGAmD8yUWgzfYJfRySvbGp2vCRXmje1B++EMGgJJIJ1cIF3c5p82R3mXLtKtkU
         cl5X6ONj4/NPobismhVKIbR+P60oJOQMYmNKlC/P88llElER924RkaqLLWDic8PPTmKm
         VzzydV8c+t+D6yzk67LWpSXjg95F7p3BqiM2ADkEahSnri7ZsquSGCLtXYzBH7a8eeG/
         goXspWJW1rlC4jCg46GIDbuxWmAHdZSkXkNCtc+Pue4phve69rfcXrBscd+VF+wWPDH/
         /EYqHbehzavDsgtLqxPnkoD1ELwJ+8gu0QdCKRclHgH5bQkCz9W5R3N7fc0cbu+zqI2G
         CEgw==
X-Forwarded-Encrypted: i=1; AJvYcCVykl39nmcfQ4GuInA7xIyC0NyaLmEXBcc05L/MMOMW1CU66bk9dsxBvHzPx1k6nJro3SsSjHRxyvh1S56c25M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsmnbvasIN031ujPjY3k0ACfAW7yBuHJjy8l6T3TpD3TWi0xB4
	yGf4wyIW5I6wthO0rmC+8qbhP5Ww67COkyoRf+HZ52ueZYICwv+bhdbUlRBamcZveGue8nAKh0v
	7UBXL5XWBmx/vwfMC/T6yXpImnfDb7rInIKAllkPHB3pMOdNdd6uq4f3faseWgKCwv3TeP+I=
X-Gm-Gg: ATEYQzxawo/jfgfH9higydVv9tCvp5fqMpHzOYJIjcJwPMxFaM8fGtjtDR5zYAMvzIR
	mehjNjDnPMLPcJQ9Sbatj38hSgFGXDXgH9UWa8KhFul73Q7jkD0RQF7Oz03MQUYzPWJTc3LACfa
	HYmFxKmUZ3xLVvtrNcDjfnQvQw6VYd+f68cYtPiQ8r6W5TCkKPEvFJzKwcdfLSaF2Njla/jTSr7
	fzBX3gQNrRzvDSuM8s2r1ClGuDq40Gjz+m06uFsQ7+apkjGHeeg6L2WSBKa2fTv87JnB5HFnsd7
	mZM7NdDcWMO3NC9vB+6qjkd4HXxk0MNcfEhsRFNABU2neCeMLEfIXeB5GSGIHIgW1wnARXdH/E+
	6DLSaUJkNWCCAf8fBRD7asSBIS2s4IZ2mERsdh0wVLrh+XMau
X-Received: by 2002:a17:903:458d:b0:2b0:5923:5194 with SMTP id d9443c01a7336-2b269d000a0mr51326595ad.27.1775096760981;
        Wed, 01 Apr 2026 19:26:00 -0700 (PDT)
X-Received: by 2002:a17:903:458d:b0:2b0:5923:5194 with SMTP id d9443c01a7336-2b269d000a0mr51326315ad.27.1775096760454;
        Wed, 01 Apr 2026 19:26:00 -0700 (PDT)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbd85sm10116345ad.74.2026.04.01.19.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 19:25:59 -0700 (PDT)
Message-ID: <e6753ccc-ed47-4543-8447-b616b8a42be4@oss.qualcomm.com>
Date: Thu, 2 Apr 2026 10:25:53 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btusb: Allow firmware re-download when
 version matches
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
References: <20260108074353.1027877-1-shuai.zhang@oss.qualcomm.com>
 <zcn4iagkp4wtcg24obdhlv6pj6xyakcbezuzz6so3nvwneuybo@5bg3qjsuajqd>
 <4f0c351a-4268-4cbd-92dc-a5cc9845fb85@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <4f0c351a-4268-4cbd-92dc-a5cc9845fb85@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAyMSBTYWx0ZWRfX8h7fJSfvzau4
 v6Ow0Mzwtw7UyfoRam/aERJYW6SuFZ8BsJj1YywX/cWhwlVDy7DjUFFVzLq0D3YHtZ6wZDvHha8
 DpkaN4KVciXqbyyj1Sc0gNpm9QlRAevLEeK9cuNdtS+eV2ZamzSq/gL+LJ0geoGH73vZRZp4wnc
 J2E5wv2vWpvetFlJq3P6XjqzHl19WuRzNC/7eY18TEqzteaMIrWGLHhwURdzkRnyoyTasDJ3I2t
 3FXhfMqYKzMzHYwShfQn6n8CB88Fr6P1kNTAvZK5nHBwdv58ZA2jLRJ9Rxmkmj42+3Vc8kGm0x+
 Lq3b7jTuPKHt4cV99jRs2bVOI/BMZlQFapSQcsjcgGoNeHXtIdktD1vqJ8aUUBm56kzcAHlY2tW
 ToQVML7k5ierb1hXM+jAN8SFhT7IzLT8twLlxtAPpk4x2XBFGDtIwcP0c0U2IsX7aT2QkF9IFUX
 Y9sWuntH+Gdl4ig5VyQ==
X-Proofpoint-GUID: uL11np437RqJAUJ1Ws-hqKIO2tdgSgU5
X-Proofpoint-ORIG-GUID: uL11np437RqJAUJ1Ws-hqKIO2tdgSgU5
X-Authority-Analysis: v=2.4 cv=e9ULiKp/ c=1 sm=1 tr=0 ts=69cdd3ba cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=F5nhctsNCyJB_H0xsZgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_05,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020021

Hi  Dmitry

just checking if there are any updates on this patch.
Please let me know if any further information is needed.

On 3/18/2026 10:32 AM, Shuai Zhang wrote:
> Hi Dmitry
>
> Thanks for the review.
>
> On 3/14/2026 12:06 AM, Dmitry Baryshkov wrote:
>> On Thu, Jan 08, 2026 at 03:43:53PM +0800, Shuai Zhang wrote:
>>> Since USB can disconnect at any time, if it disconnects during
>>> the BT firmware download, the BT controller firmware version may still
>>> be updated even without completing the download.
>> Does it not have any check for not completing firmware update if the
>> download was not successful / complete?
>
> Because of RAM limitations, the controller updates the firmware 
> version during
>
> the download process,even if the download does not complete.
>
> Since btusb cannot power-cycle the controller, the only recovery after
>
> an interrupted download is to retry the firmware download.
>
>>
>>> When USB reconnects, the BT host detects the same version as in the
>>> firmware file, which prevents the firmware from being downloaded again.
>>>
>>> Therefore, remove the equality check to ensure that after
>>> USB reconnection, the BT host can still download the firmware.
>>>
>>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>>> ---
>>>   drivers/bluetooth/btusb.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>> index 646de80c7..991064a25 100644
>>> --- a/drivers/bluetooth/btusb.c
>>> +++ b/drivers/bluetooth/btusb.c
>>> @@ -3503,7 +3503,10 @@ static int 
>>> btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
>>>               "firmware rome 0x%x build 0x%x",
>>>               rver_rom, rver_patch, ver_rom, ver_patch);
>>>   -    if (rver_rom != ver_rom || rver_patch <= ver_patch) {
>>> +    /* Allow rampatch if version is greater than or equal to 
>>> firmware version.
>>> +     * Equal versions are acceptable for re-flashing or recovery 
>>> scenarios.
>>> +     */
>>> +    if (rver_rom != ver_rom || rver_patch < ver_patch) {
>>>           bt_dev_err(hdev, "rampatch file version did not match with 
>>> firmware");
>>>           err = -EINVAL;
>>>           goto done;
>>> -- 
>>> 2.34.1
>>>
> Thanks,
> Shuai
>
>
>
