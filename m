Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFC12EB87E
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Mar 2026 08:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772700081; cv=none; b=s/FarLLrTP0D6ehFO1XBHE543WSMzGjywxmhE4D54QdxvhG73UK/0oEXdc/3Om4HRVrV9Zn22+Cydg3wqInmDSUIiw7IOiPnZ8kU3e61sFodQ/9mWhG5Mob04zAAbzk1wfQUXaG/5nXQ8+JnsWWvIeYzzU0kGD40tr+wOhnIqeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772700081; c=relaxed/simple;
	bh=1AoAxlOF3WUPKwxhStZnc+k/n7HhelcsdYkxK1oTFo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/mqjKSlXhJnYwJ5HdHBciMo4y8DZYgEW4Sdo7wOypVn0w35mPBj8BpqMbjl33hPNNW427mu2CcZ/+NaGMIRpkuaSEbN+9mGw+8NwwdbLYqHFKnDXp5D96G5ZJMuOUb5SbBTyibSKhHaJm4q9zq5PxORbP23EeYumSlpBemQCco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oH90CNAc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E9d+fmfn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oH90CNAc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E9d+fmfn"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6254taw3218456
	for <linux-bluetooth@vger.kernel.org>; Thu, 5 Mar 2026 08:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2brkRnHzMznO1hv+f5Ek0COaAvlC/mLoS5PuzJa2N+s=; b=oH90CNAcoJuZeWPk
	P3VRzgGInX96H2l/N5qTwOkPvvlDRcsoOj9CxP9FQeduoQ3fVXRrfMvxbeBFkIjZ
	8GRtG80PYpFQNgGD7NzTZ2qxt+FMD7qGZ90lKN/FrIjiRPBLB4asqk6QMRqhjWeG
	K86WNMbZfuLlH+hFXsJZ+BZjs0PaPIw4MYBlHmqCk63sZ7LbriN9VxA4I63Maw7D
	eiy51pU6RuZwCfxPESZExRHefJ0zmZco8ZJ7BbUW0vGr8FpIWtN3dSqZqGWxSL1w
	fMHanip12ddUXfp74cn2s/Tx6Avntd6FgJKLWY7FxRmtQ6KZ/YtTfR8Cj/tAvQSq
	Xx4A5A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq380rq01-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 05 Mar 2026 08:41:18 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-899fead92c6so268716746d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Mar 2026 00:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772700078; x=1773304878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2brkRnHzMznO1hv+f5Ek0COaAvlC/mLoS5PuzJa2N+s=;
        b=E9d+fmfnvrqWR0AEGfx9DioTNmnt2W2jvIWRReTkhrGdMlljty6iwI9cB2xHcrrGVj
         lSzpZyt/VTgyYGJPg3+ph6dicgoqwEnNSPgD6V3ZvAKjP/I8dmKliM7HROKonWg9PMpv
         saWoxPYNSpOkDSZc35Dd1QFxHUyKDRG/rkOgtnbyjWWQwciv4RiFKDOTucfbwdFDesU0
         M9U1upMGAirCmGBXVf6d/3Z+6dVDPoOXmGCbB98ghvp4t6uCLg5zOwsKG9/CHvfYtKvY
         iqZ3gExFyGBBCRlehNIvEgHloitvdUW/AF6GjOrnZOItwbeqSd2sLxoWUkcWwDMDmNQ+
         OKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772700078; x=1773304878;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2brkRnHzMznO1hv+f5Ek0COaAvlC/mLoS5PuzJa2N+s=;
        b=ApmNUlI5u5HFNnXKXbDW5BlymBS2drHvNYUfplVcy0hmzvmk/ChJ394w2mF1l7g3wV
         i6/O9buDsV0xVq7lVaA/bCeN+ZKMCmU3Ph2KMdRfSux0gLeWgrQPA6fLGEa6md101+Qn
         CyIkEmiLllbCFvasLJDdDcPcLeJmya93oO3mMUCgTI+UivlZwhXFBOIKkttOqjyf8m/s
         xtO7gY7z9ENFr5vj0KQowGYs4z7fjn5plh6yYEagk94u3uaKhpXVc1IaV1sVgkZxxsiN
         uK7l4pLh3Rn7/mKng8UlNPUaJ2Gm/ebjk7xbQszgoUyd4flrOuDH4+oDtw6GQou8WZwj
         4Uvg==
X-Gm-Message-State: AOJu0YxQcFwfDq/aeN4POi7IUICFxrlUIVKplHnXGsY8jwRI2PlttdLX
	a1+tjzFaqtRx08sm+rrlPv/oyJIebQ6MQaH0Y8iQQ8NBAa+lVb+LfAs3QcbKSnWqHo2Wu1kmsQV
	au4TwvXacZChPh4ix3Uh8WxK3T0E5fDVGlry+2gOUl+eMxNz3Rp2HXS1UJRHoqO5HVp4mTOs=
X-Gm-Gg: ATEYQzxbfz9a+K3sOitvLgwwQDTX6taleowboO+C/bzOMzyFFhO+PnhdAlnWF8XGOcv
	GCAtCHxJwERECrRna0QgB2Kauds3TTf1Pu2SjPTWs56gEF6phD/WotR+CSCYVfI/XKRzelwWJQT
	s6nxFOwS4R2Uq4amJP0M0jqlpAb0ubYSvNpTRd0V7sYX7BhLhXRGA3Y390g48tK5ILpQHSfeQe4
	G441UwGYKgfwnhHzQsXqHLSFO+dfmiSInVnPbuwlg2ju4kX+OhRgLVTo/pYDE6aeLJc3QUy3Sid
	iLOhtmKIIxeIcpVT4XEyS2RlEnY2HmYuEyPFRTZHX5mEsCyZFtisn1ZZkDuFHFx+meS8HIkwXhh
	OYaWkSN4DvV3235qHqjcw2IZdWvxNiw4/AigR4Ml0/g==
X-Received: by 2002:a05:6214:f62:b0:894:6b9e:253e with SMTP id 6a1803df08f44-89a19e3c7demr69440396d6.52.1772700078424;
        Thu, 05 Mar 2026 00:41:18 -0800 (PST)
X-Received: by 2002:a05:6214:f62:b0:894:6b9e:253e with SMTP id 6a1803df08f44-89a19e3c7demr69440246d6.52.1772700078044;
        Thu, 05 Mar 2026 00:41:18 -0800 (PST)
Received: from [10.239.30.226] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899ebb09772sm111915746d6.12.2026.03.05.00.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 00:41:17 -0800 (PST)
Message-ID: <16605d1b-7e48-4e3a-803d-1c72f22a5544@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 16:41:11 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] device: Initialize device volume with a valid value
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
References: <20260122063640.310090-1-jinwang.li@oss.qualcomm.com>
 <CABBYNZKuA3pK4rrsN0UxuyqR=Xc+ELBHz4fZpX7ckpDAS5qYTA@mail.gmail.com>
Content-Language: en-US
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
In-Reply-To: <CABBYNZKuA3pK4rrsN0UxuyqR=Xc+ELBHz4fZpX7ckpDAS5qYTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I5Johdgg c=1 sm=1 tr=0 ts=69a941ae cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=3_4mlT7yu4Bjum-qJAAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: fY23UXaEPJo3Gz1RcK6npzF5mHUBXTGw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA2OCBTYWx0ZWRfXxkd6k/GqI/52
 SmRXECK3xRM4jPOjGLW2FNyxYggmriktCoHWJnzW/namEprO6ofzyHtey1PfkOlbfyv3S0AjW6F
 kKZlpgb64RWGcAn7OkFA9kllzU9Xi8mPZlqrWD9Xos0arRh1++tEQArXKV6R4aIAn0qVki2/7VK
 1KrKxuSm5PIR2CcCjzjJWpaYHu3H798GqDSCpvqcSD38lbct/QKfJkObcC1FCZ8angJpRjxPdWn
 NjMe2A621hgJl24yVZ4/hL4wC4MDi0HBlcJHZHVV1MH43cxJOP5wsh0LVSCj9g7+zozz5MDa+/j
 LnhFguPQ1btXrG6l8qSREaHQHo8R1t+YUBjuIttSpvqvpWitLDjrH2bviwGMajZdEdbzsqM73kY
 NIe74Yc2Q7zjuKb6ahhf7FJDJwpckSvC4/AoTY2ZMJqoEP4YHduh+DeTbHIO4/C2tlltxiAaQB2
 XvS9QxqujSmi8vNnG2A==
X-Proofpoint-GUID: fY23UXaEPJo3Gz1RcK6npzF5mHUBXTGw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050068

Hi Luiz,

On 2/25/2026 10:52 PM, Luiz Augusto von Dentz wrote:
> Hi Jinwang,
> 
> On Thu, Jan 22, 2026 at 1:44 AM Jinwang Li <jinwang.li@oss.qualcomm.com> wrote:
>>
>> When AVRCP is connected earlier than AVDTP, this invalid device volume
>> causes the A2DP sink to reject the peer's registration for the
>> EVENT_VOLUME_CHANGED notification. As a result, subsequent attempts to
>> set the volume fail.
>>
>> Fixes: fa7828bddd21 ("transport: Fix not being able to initialize volume properly")
>> Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
>> ---
>>   src/device.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/src/device.c b/src/device.c
>> index af8df5f29..cd0b8802e 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -4948,7 +4948,7 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
>>                  return NULL;
>>
>>          device->tx_power = 127;
>> -       device->volume = -1;
>> +       device->volume = 127;
> 
> This represents the volume of the remote end. Why would we initialize
> with max volume if we don't know its volume? I guess this depends on
> the role though since transport_a2dp_src_init and
> transport_a2dp_snk_init do initialize the volume with -1 and 127
> respectively, so as a sink perhaps it would be correct to initialize
> with max volume so we may need to replicate the same behavior.
> 
>>          device->wake_id = -1U;
>>
>>          device->db = gatt_db_new();
>> --
>> 2.34.1
>>
>>
> 
> 
When AVRCP is established before A2DP, the role is not yet known, so it 
is unclear which volume should be used. However, rejecting the Volume 
Changed RegisterNotification prevents any later volume synchronization.

Returning a valid volume from media_transport_get_a2dp_volume() when
there is no A2DP transport and the device volume is -1 seems reasonable.
Would using the maximum volume make sense?

I have updated the change to
"[PATCH v2] transport: Fix set volume failure with invalid device volume".


Thanks,
Jinwang

