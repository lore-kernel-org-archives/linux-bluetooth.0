Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFFD3BD22C
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784292162; cv=none; b=ORC4ni47IGXOG2crnZWB+U9kRZf7tn9qtk3eRNbaM9V94bVP0ki0xTBTsmmVUWjN8FHWOsnNJ1Km7kX5dhFbNR9VWE6EzN38/nmE2S16kgNVX1hi4QyI6XZWaOfPXHyKF9fazoYclhu1twZjJqzU1fF7+ZA7UV5mijQvbA+dJCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784292162; c=relaxed/simple;
	bh=RjPW6zOzfDEqfPrqbx0oXzzpoEARjkvt7DbIFVg5tDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMFyogts47sjdv2y+dNh4N2+JRkCUny0eo5Fp8kdoXDClzIMFaT5cMkSyVNwN7AMQ2TlG0qjLr/E+CxOxP19c4DFs7gkACiOUEfWNwzSTUSQnwQafIOdJDd8/X7UgLsWclNnmRmPjU+WcUUlfR+KQ2+E1eFvh+7kfMpv0J7qWqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E2/lU+Lo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b9H/FIqL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E2/lU+Lo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b9H/FIqL"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HCStEB1900987
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 12:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NI3S/eGRPbhJy8X2oBVyMHo2H5uQPxmOWCUfyQV9hqM=; b=E2/lU+LonMLT6Key
	1o+Db0ifJY1GayhygCJ8HKLiOgFFBLBD1gUkY5suhn/jWEBtVwTz2WxZk1tCfEpd
	7k7hrJOr0R1snAj4TeHGk2zvFHMQaoCANxdaz8UaAYb7q0BKb4TM85OMq9P41pSt
	6IiY2lKCVNSys0MOIJlnQXM2bE43SkESCfiSGsdEI9NIqTMKbQP6pLAs9NTEkz5/
	Rz1P3G4w1e6B3rgFQS/2hOZvhkvUtQ+OIVFQo3P632IEU8VjTiU4G0Vo+gYe4/J0
	d+QwdbjkKNCoi16C75Slh1hYfmismGK4l7YGpsoaaGfDGK/FWiHliHiiAUeo0Bg1
	XBRLDA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffe0usnd3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 12:42:39 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8423f1fe39eso8284255b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 05:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784292158; x=1784896958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NI3S/eGRPbhJy8X2oBVyMHo2H5uQPxmOWCUfyQV9hqM=;
        b=b9H/FIqL3tyj62N/jfNzkAgArYLogCcoG35Fa83VuYCx2tmwIue9ZuwCpQU3GKGURl
         PzPeviilKMbwG7UYtr9HsvjUyIj3C9GfIPnEyTtyXJX+23spGCxcXu2yLdtoAH33eIA0
         nCChW+I0RvnBoRc641I0FgnwZRpj9XXmke3912yUXXCUF8esBRXg0PU1P3vyFLkqzmIM
         IgGoOmrVWvKge7h8+uLX8C52DrA3U6rfuYjWlxz65d+Qa1vbAGVbp0h9f4wqoujc87E+
         qKa5BeccHqsmPI84JntnrBqwiU8lCQxzCEEHoc+iP9kY1WUafccW/lgSFM2sapcDzxj0
         224A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784292158; x=1784896958;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NI3S/eGRPbhJy8X2oBVyMHo2H5uQPxmOWCUfyQV9hqM=;
        b=rX8gscRkI8bKmXADbmsyp6zrB855fSAvA1guuM7hS1XqgR0im/CNK8DwkS8G98pP3q
         7GKvaDN95/JU2505dwiGCCgZlPy+ZkAjeqtmKxRcAEpSEKojGk0QywWwLfy6rAJnh1IK
         i40B7lH8f2iNpwi52uk1C/pAiyniIg9C66+oqIOnnkSdVziq9u+Ze/7bRbhmznJZflQU
         5Vcmow2wqzWPuxMl9nY8AQ6yYERzurujn6Z5WuXvhfkQg3x43mJrFXsryBNUxJZLPsWY
         vaeMcUfOO0Q37jQqzE/ug2vcy80b3VOm35gdgoUhl5UY4jpu7AY0XxbjAVmYx4cUD7ze
         1x9w==
X-Gm-Message-State: AOJu0YzNitAqKbv7UglXF5O0XsV4NJi+U5Lm9ErugRdlN+05DyjZ6Qmu
	1sIbhv/Svyp2UvJvarVn3DDzwWw+0hFurk/TuU5m/yL1LkzWB/84RM55DVnraW1PMfSTCM43/K1
	xfQJISAfXbaU3LaC38yJT6qaIXbcG+S9TJHkhPwGMHXfGzYeZj/vzRgyMeLyorFHTV5Vdi8Y=
X-Gm-Gg: AfdE7cnQovJUMGmEeEa2W7m+Rbyz46/zWZc73IRxxJdTDV/vshXZ+2UuUQii0VsXRrv
	2qAZl0w20I4aY6FIye5QvQz5bOJYMQ0NMsC5304eUJprGuF05SCk7Oou3cc8y9XIfHPbRGpYSqh
	2+fVxONCghtU/Rc5e8V1JFxr/zQ0SBFBm2yySsk/IKMRy0Bk//Z9ogaP5Lx0QIbnsKrtPJFnWT3
	AB+Z3lo5hdwKCwzsSB6aoTx+6YX1pSDvX8vDGHrqfIdVdImx+P7HSEtb9B5hpm4D1IR9kKLxPoD
	d4dDLwkLuRIAaLCwQZAEQr5N1sNEBFSU391TNVGMLq/Ga+rObseFWKDqZK/KelIRCSnB2N9x0RA
	g7sk2DRo8WwITVLVTYqfvz0b4iJSX
X-Received: by 2002:a05:6a00:12e4:b0:848:63f4:b4bf with SMTP id d2e1a72fcca58-84c2954a79cmr2498213b3a.74.1784292158313;
        Fri, 17 Jul 2026 05:42:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:12e4:b0:848:63f4:b4bf with SMTP id d2e1a72fcca58-84c2954a79cmr2498177b3a.74.1784292157808;
        Fri, 17 Jul 2026 05:42:37 -0700 (PDT)
Received: from [10.216.31.190] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6e3f6sm1015274b3a.44.2026.07.17.05.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 05:42:37 -0700 (PDT)
Message-ID: <617c63ec-a4cd-4ca7-8cff-a3c64aa78bd8@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 18:12:33 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v3 2/4] src: Register GATT profiles for Channel
 Sounding reflector
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
References: <20260712121743.2842547-1-naga.akella@oss.qualcomm.com>
 <20260712121743.2842547-3-naga.akella@oss.qualcomm.com>
 <CABBYNZJF7ucGh-CLT0YVkgZkU-bVzY_t2-D9Luvodx4dpzDEug@mail.gmail.com>
Content-Language: en-US
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
In-Reply-To: <CABBYNZJF7ucGh-CLT0YVkgZkU-bVzY_t2-D9Luvodx4dpzDEug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=deWwG3Xe c=1 sm=1 tr=0 ts=6a5a233f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=_2_NuRsJEGNGsCXwGWsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEyOSBTYWx0ZWRfX6CCHZEUPOLxP
 eZMCQqJexCjOz402jWlptwG5GW1kVS9e3gWaPPHtQ1VkdShWb/es1pL9jKQGgUgPAjEl7RwNOTO
 usz9EEWGnjlwX2N5zUG9idVnU6GXbxOyFCGlspkqeE+0DCqwSC4sefsIcDVufmHk2g09wTpsUP2
 ouqPjv9ztD6e0Dpanp545WDAvY6jKA6Y6h2bQ9zqAP+DrP+nkQKz5ZAF7zZ+R97DBD7epTZ4SMg
 pev5M/ABneJfK/0+/GPVNAlxftz598iauV6jrfJOZ+ldJzJ14IeIrBPG+sEHUpfNmIHYItB3uoI
 DNLjqF1q3FbZ2dBRbwgjuU+abd1RG/o8hce2sRGGJ7dYDDk+ak6gihLs/Vn32amu9q17n6KHHt8
 3E0Q7RiMaz8Z+9Di/0VI9H4LHUOKc0CkMlA1H4VphJzsiV8QPK3xQ0D2COfHhfTzUGCaiw8+6ig
 W+Jo2FLKwJ4kfnkXneA==
X-Proofpoint-ORIG-GUID: LfEP18I7_saXZE-F84C2OqIEkvw0EmFg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEyOSBTYWx0ZWRfX2ogDhgZrE+ko
 4Gg5RdgEcvasUQkKVA7RfBKvL+LLszZNF7BkghRA81PXokunSCUOw6Es+QMm1jLr+0dJc0RsugF
 Tmjgb8iJaH+xd2wHTavqOnSvBvN5BEw=
X-Proofpoint-GUID: LfEP18I7_saXZE-F84C2OqIEkvw0EmFg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170129

Hi Luiz,

Thanks for the comment

On 7/16/2026 9:45 PM, Luiz Augusto von Dentz wrote:
> Hi Naga,
> 
> On Sun, Jul 12, 2026 at 8:18 AM Naga Bhavani Akella
> <naga.akella@oss.qualcomm.com> wrote:
>>
>> Probe and accept GATT_UUID profiles on non-initiator (reflector)
>> devices before gatt_client discovery checks,
>> ensuring RAP's org.bluez.ChannelSounding1 DBus interface is registered
>> even when GATT client discovery is skipped.
> 
> This is not how it should be done, what you do is to detect that if
> the remote side discover/read any of RAS attributes then you add its
> UUID via btd_device_add_uuid.

Addressed the comment in patch set v4> 
>> ---
>>  src/device.c | 28 +++++++++++++++++++++-------
>>  1 file changed, 21 insertions(+), 7 deletions(-)
>>
>> diff --git a/src/device.c b/src/device.c
>> index 65d84be56..cedfe3a20 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -6301,17 +6301,31 @@ static void gatt_debug(const char *str, void *user_data)
>>  static void gatt_client_init(struct btd_device *device)
>>  {
>>         uint8_t features;
>> +       GSList *uuid_list;
>>
>>         gatt_client_cleanup(device);
>>
>> -       if (!btd_device_is_initiator(device) && !btd_opts.reverse_discovery) {
>> -               DBG("Reverse service discovery disabled: skipping GATT client");
>> -               return;
>> -       }
>> +       if (!btd_device_is_initiator(device)) {
>> +               /*
>> +                * For the reflector role GATT client discovery is skipped, but
>> +                * profiles that match GATT_UUID still need to be probed and
>> +                * accepted so they can register their D-Bus interfaces (e.g.
>> +                * org.bluez.ChannelSounding1).
>> +                */
>> +               uuid_list = g_slist_append(NULL, (char *)GATT_UUID);
>> +               device_probe_profiles(device, uuid_list);
>> +               g_slist_free(uuid_list);
>> +               device_accept_gatt_profiles(device);
>>
>> -       if (!btd_device_is_initiator(device) && !btd_opts.gatt_client) {
>> -               DBG("GATT client disabled: skipping GATT client");
>> -               return;
>> +               if (!btd_opts.reverse_discovery) {
>> +                       DBG("Reverse srvc disc disabled: skip GATT client");
>> +                       return;
>> +               }
>> +
>> +               if (!btd_opts.gatt_client) {
>> +                       DBG("GATT client disabled: skipping GATT client");
>> +                       return;
>> +               }
>>         }
>>
>>         features =  BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING
>> --
>>
> 
> 

