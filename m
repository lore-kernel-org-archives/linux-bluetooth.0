Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35F03921FE
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 10:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052791; cv=none; b=b39O9C10NnaZd3YBKu5ZzsbA+Khqq3MWCHqnzxhpNUKrudBFCtKEGGkKc5NASlJrTEDpg8FORIcRbDt8/MzvAx3IqFDi6nJrzJ13UYbmBG68KTzhRVLDrdXTnjg4X1LsPDSEQtrMmTmNp2Mo+xQ423Bi7GX5bafPzR077/Fs6/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052791; c=relaxed/simple;
	bh=q+AFdq/hYL8dGB7lC0if7YT8HrQ4kZXj6Dx4mt0QteM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpfIaE+mZDboISrvRpdLMFRAfNqJVJs/c4op0t9Eb560s3VgpJjCzDR8ZoMTRXNPsXvik/+URmMGfCnL8h4ABR5Oqe95Z7Gv6TBRZyU6QNP6Pxm0jjrRrfBaYnlkHOdow0SHBcSilaQ/oas8awabhslLJFUtq68WJlrqgWLlsyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZiBHVAXy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AUoMUstA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZiBHVAXy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AUoMUstA"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629AZFOM2652539
	for <linux-bluetooth@vger.kernel.org>; Mon, 9 Mar 2026 10:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tR990Ektgi59XvziW/nVlnao0fJMBQS9iAV/sA+oClI=; b=ZiBHVAXyOxEdSouB
	NQ6zVG+vMEWDtkT5O5okIs15EKnLe2KdKFYGG4iON7veQyDshIRvMvWiw5SMxcgN
	Wx1ENc2XeuqrUmFRr92oLL5giKmgycpcFFaMzLxLlKPf1azwUBNpTbAuQY1j5Dp+
	k7c3EFs1HQ2lbNrSMbY+Lc4kQpJFQ1gQeL6G5MRbSEBq5JObsOV4/hgQlh1x8GRr
	h4pGGxx/oiMlCaWXPo8AmP1Jc+VCR/Cis6z94o5C00RtRibVLYTVzoq2roJlYD27
	sSWapjtu8Zc/UbnM0uu8NBVV1zq0fSzgtY56s64u8JY+xZ4X5E4kjibRw8jBLNx8
	ZbWHSQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4crd6fcxde-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 09 Mar 2026 10:39:49 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-506a07740bdso513724051cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Mar 2026 03:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773052788; x=1773657588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tR990Ektgi59XvziW/nVlnao0fJMBQS9iAV/sA+oClI=;
        b=AUoMUstA5Gl/J3r/mi8QELHqeoTs5I4FO1Go2+SXGtGwcNBHLJgIxa5shUL+E7bvsN
         DjpR3ugKwmy8bym+JBo15aZfMneJK27938o2BxuHQ6OsT8esNhd6rjQjMh272SxYTVJG
         vYXQxdUk3BkOkfPrAOZ1suiIsSl4km6UUGzSmn8vwZJfxiAx2VvLy6QayDd0SWaBCBNc
         TxYq8q1A6uIopq79tms311oSySPOjS41pJMjG1+TDxo7IQIOTCAYWp35LVPYPA5aFFq5
         BLwo+HQvGFyUzZ6bIxEQB3TBAS6k/28XaptcGf67s73WJtVKTYrZYsfP4wn+SfMnm/wX
         5guQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773052788; x=1773657588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tR990Ektgi59XvziW/nVlnao0fJMBQS9iAV/sA+oClI=;
        b=Yyjo9jVU0BLyJFIdGrds1Gxl3n3Wdqzi8aK+RxUYg+Kf+k6EVLTphqHyLpVZWpu52W
         V6pacHicLtB7EZOX4qWIizMeHMHmGLH7fQgMcdjw7GxUc3pkKFAZYMXlpjsfzRx4gsqg
         OX3mSjqeC9GKYRZcm3bSnAxI4juWywr51hXSyOuZ/a4tD7bZnpAs1FgvpbLlyeKJCawq
         BGKDK65dDEWxE8Pokc2t6H2P4f1DMnNZHFvnZQ8iWX//Ftdk6oRMP1zFIBQx5bVSUFts
         IdbysmNuX3eGLHuCUH7IjGkLGwnqvB9y0/zBg8r9cXELGQ42gcon+f04X56mqXGPI3fa
         fnFQ==
X-Gm-Message-State: AOJu0Yy/AvHG7cxEvQUE/Sz3SIo3glFNwjoxpCLNjJTHyfhzsxeZfndM
	C+tL+TEnyI4cEUFB5GmOQsh/Zvj6/r0U6GwQoiDyPcSibUjEyPuanv0jwV24Ulq5pn3i3aay8Qf
	7tBiiLipjJXjav4vgwiY1mcPmZXygmnRFb/pW0bg6YOjFh2q3opDwSsogGVL8XHbS3DFn2WI=
X-Gm-Gg: ATEYQzyhd+Hdn7XfRWq38FbKaYPRgF7sI6P/TKAd1dOcqnXkXRJhQgsQ6ss5x0h107A
	O5n2smWUC+JmbfVfMm2agflqhQSlk0L3q5OAsi6y4FnDyeCNIwcEDkfXE1J75zGBihCuWalLuS9
	AmftGhx3yyxN8GMth9Jj5yZNHU/aYD1JxoAeUgz7U/f4StjDYKycFsE1CGmgx0sVyaAOLp+x2VU
	o4G13c8a/5flZu4lfI/836dksSTkPCJm/LcRBTal0gciHpqspOPAKoJbDTg4WhQPV3KFQjfMd6b
	kL03kpb/bNQRWm7ItnH2GRFsjEmb479f2TxpHVCh/FkMrWHZD0o7CPM9fyTJ6zoKtJk4LAJSnZ9
	R8cg3TWTzNwum6OU9r+HrzzTfuWV51/SeagFlmyd4wA==
X-Received: by 2002:ac8:7dd2:0:b0:4f4:df23:ab5d with SMTP id d75a77b69052e-508f49b56a6mr139255631cf.75.1773052787993;
        Mon, 09 Mar 2026 03:39:47 -0700 (PDT)
X-Received: by 2002:ac8:7dd2:0:b0:4f4:df23:ab5d with SMTP id d75a77b69052e-508f49b56a6mr139255371cf.75.1773052787565;
        Mon, 09 Mar 2026 03:39:47 -0700 (PDT)
Received: from [10.239.30.226] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-508f650fdeesm70720321cf.6.2026.03.09.03.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 03:39:46 -0700 (PDT)
Message-ID: <ea06aa83-bbe9-4020-afd2-e8eb243c5c4f@oss.qualcomm.com>
Date: Mon, 9 Mar 2026 18:39:39 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] transport: Fix set volume failure with invalid device
 volume
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
References: <20260305083833.369358-1-jinwang.li@oss.qualcomm.com>
 <CABBYNZKNJ4SY_E3WE5JZmUkjvdxA0f_pFMnJv_K6kOt+-JRe2A@mail.gmail.com>
Content-Language: en-US
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
In-Reply-To: <CABBYNZKNJ4SY_E3WE5JZmUkjvdxA0f_pFMnJv_K6kOt+-JRe2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: uiePb4hambVlONZmY4p_JXA8XfF4IN6y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA5OCBTYWx0ZWRfX+ppHP4zC4eOX
 FTQvFVN3CwQwur1vBw/sPtO2uREzgQJcxC23AmrXErougt3wAt3Ibo1eMnp1ee/5izmruqq3oME
 XjsJdCIcgnisfVT3YY3/Ko9scRyQF33E4XEHrR1jr4aYHHGNWzEdFcjGEhbuYzvB21gXfGPJnAS
 gA0OolQ/69HtHzgvqxA3rAjNayaRfhmU4Y8ArMszRZWWVhSjkPs9EGwYWqafzD/m8lK2gJSwPEX
 Ib4LgnErxsmQ8pmCCx5G4Usa7+4D2BrDoc2HPQi8nE31BkA18rqn8c8/waUadzwUu4vgaohq/29
 9fmUJRn4kH6OHtga6CVs3AeZPEZTbLK4mpt0wcseb4OLdmecJivXYKMbW89VtyRLE1ka8ZRH70q
 orRB6C9wrxbH3VLvmv+EqBT9FOq23Iby2zkfgQGtlR89gYzlE1eVFxpEkFjbaL7/wjsnvvUIvxM
 nV912THBbdr7c9vpF2Q==
X-Proofpoint-GUID: uiePb4hambVlONZmY4p_JXA8XfF4IN6y
X-Authority-Analysis: v=2.4 cv=RP++3oi+ c=1 sm=1 tr=0 ts=69aea375 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ifOE2PtvpMKf1LOD56IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090098

Hi Luiz,

On 3/6/2026 11:00 PM, Luiz Augusto von Dentz wrote:
> Hi Jinwang,
> 
> On Thu, Mar 5, 2026 at 3:38 AM Jinwang Li <jinwang.li@oss.qualcomm.com> wrote:
>>
>> When AVRCP is connected earlier than AVDTP, this invalid device volume
>> causes the A2DP sink to reject the peer's registration for the
>> EVENT_VOLUME_CHANGED notification. As a result, subsequent attempts to
>> set the volume fail.
>>
>> Fix this by ensuring a valid device volume is returned when the device
>> volume is invalid, allowing volume registration to succeed.
>>
>> Fixes: fa7828bddd21 ("transport: Fix not being able to initialize volume properly")
>> Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
>> ---
>>   profiles/audio/transport.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> Changes from v1:
>>   - Return the max volume from media_transport_get_a2dp_volume()
>>     when there is no A2DP transport and the device volume is invalid.
>>   - Restore the default device volume in device_new().
>>   - Update the commit subject name.
>>   - Link to v1
>>     https://lore.kernel.org/all/20260122063640.310090-1-jinwang.li@oss.qualcomm.com/
>>
>> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
>> index d9feef768..41d8d0a75 100644
>> --- a/profiles/audio/transport.c
>> +++ b/profiles/audio/transport.c
>> @@ -2767,6 +2767,7 @@ static void media_transport_emit_volume(struct media_transport *transport)
>>   int media_transport_get_a2dp_volume(struct btd_device *dev)
>>   {
>>          GSList *l;
>> +       int volume;
>>
>>          if (dev == NULL)
>>                  return -1;
>> @@ -2793,7 +2794,11 @@ int media_transport_get_a2dp_volume(struct btd_device *dev)
>>           * of ordering between AVRCP and A2DP session start. (Note BAP+VCP do
>>           * not have this issue.)
>>           */
>> -       return btd_device_get_volume(dev);
>> +       volume = btd_device_get_volume(dev);
>> +       if (volume < 0)
>> +               volume = 127;
> 
> This doesn't work because the behavior differs depending on the role,
> as a source we need to return -1, so I suggest doing this instead:
> 
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 724b46c592ff..326dfdab7e3d 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -4296,9 +4296,16 @@ static void target_init(struct avrcp *session)
>          if (target->version < 0x0104)
>                  return;
> 
> -       if (avrcp_volume_supported(target))
> +       if (avrcp_volume_supported(target)) {
>                  session->supported_events |=
>                                  (1 << AVRCP_EVENT_VOLUME_CHANGED);
> +               /* Check if transport volume hasn't been initialized then set it
> +                * to max so it works properly if the controller attempts to
> +                * subscribe to AVRCP_EVENT_VOLUME_CHANGED.
> +                */
> +               if (media_transport_get_a2dp_volume(session->dev) < 0)
> +                       media_transport_set_a2dp_volume(session->dev, 127);
> +       }
> 
>          session->supported_events |=
>                                  (1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
> 

I agree this is the correct approach, and I’ve verified that it resolves 
the volume registration issue. I’ll send a follow-up patch and include 
the credit.

>> +       return volume;
>>   }
>>
>>   void media_transport_set_a2dp_volume(struct btd_device *dev, int volume)
>> --
>> 2.34.1
>>
> 
> 

