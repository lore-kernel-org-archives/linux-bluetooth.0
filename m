Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B9A3126D0
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 02:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776221391; cv=none; b=YexpxoNQkfnAAj4l+r1TCFhhRwjldY8Z3C+1Dhel+Os+ciSMIjptmhSmDTSxYqArkimyRg2MV1pHdV5JqCLmJ2WeRRUMpKY96E3HkkjG1MedVqEZ5ujeyWi4BjJPlGe1Rm/HJWgvSon1+1kzgGY+oOqVbxuRo/STjjVMfJ+zG08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776221391; c=relaxed/simple;
	bh=JFEi0VD48StKC6owki25ycmNF/t8sTADQ78yU90b22o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fm8iqQqETfa1U7SzC7rHkKTbyE2ko5m3Yfo7YFuuw11BvFE5HmQcLxyzQXFAaNqJj4qH22YS6vHExgi8gyUWk9FdcOkHERu/hPolI7tbqTDSA3C6VPvw9OGhPdoswOCg/b+CM68Frl14DI9xjSS2zSrOT16vrSnDRYstF+CTso0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mCWrYkCT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hUFS0Xl5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mCWrYkCT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hUFS0Xl5"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EG9jJL731460
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 02:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4r/cAuIiAsQKjwiHb55odcavxKshbzULhKnHQ931Y8w=; b=mCWrYkCT8qk1NUkB
	bewW2VfbzffXXXquDehlKK6/SDL7mFZQH55DugkuLnFg64kT7XJoqxrYi0TYOrRE
	76GVArR9Cia4n1O+qSKmEzNhloTNDVRTfsj098jmpXPWiVWdVgqtjkiUzriPnBpd
	Eg5x24Sov0BJH/NQI0NHKv/j3VoDN8YQegEu4aNW+ZlJ+cnpdAViPlOcS0sSThyU
	H3io9liQVlYG4UCkDFpr2q6/oSDUGXTtmg5PdTpzx8hjK8XNnhNGOV164jkOdS9S
	YV/ZQLHttedaP03ZYkx2ECXAHvrkcy7lqlTlQpkO42nHddx0fY7wkcFC20UeA0r7
	WIGUWQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhruu9sk3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 02:49:48 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2cc75e79b97so23828742eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 19:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776221388; x=1776826188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4r/cAuIiAsQKjwiHb55odcavxKshbzULhKnHQ931Y8w=;
        b=hUFS0Xl5KD9YsELGNZrZuGnZ/mPAZHp7ENOtXFS+qPjgkS2zobuNoF7g/LaXAZOIDv
         lmAjkIaJ7SBdC7HLAedJIIYSfOiZ8t3CSugMLO1rYvADN3U1GebApnhXe/PxvL3/o7KQ
         ULS0bEuK8N1XFECRobhxcNqQQcTeuE9Od5pUVq8Pl76wyO+h5b82llXB+MJT/WTT3IbM
         KHdw5WSb0FxCWQXJigpOzXNhMBSYiuXTJiKJ4bABtaBRbqwggIrsYa8U/UquaTJpLgG8
         I6p46G3UxUb2TXVOFLofhoUiGBJqiGYs/Aspo8UUkK8pmvKrleBzzxXdoOd2GR8H/1So
         hE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776221388; x=1776826188;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4r/cAuIiAsQKjwiHb55odcavxKshbzULhKnHQ931Y8w=;
        b=XId5blZ59p4OlaMIt2eL3S3hnGSwJuydrFew7pzIcmnZneLryRHcOk7jGPVU/GzNI8
         In30NsvjuffIlzMnFiBhcNIcFY/GpqLVfs29YWJjiO7UC2D8o+XZCVphxzJRVPi1v7gH
         YTFS5z7Djp59Q2ySEWKbrSoeEuGrozryvWF79vwSr0CXiWq28EV0+8mD6WurMIIWU1sq
         OlqOX/rlN5U+G2a3I2iS4pN9kIbTpmfrjZCRsFvqwN+UMbrqjEFrWq9QlKv74EnoVJIb
         6uAO0UEK4KDe7GwArGYY5dsTp72st0A1aFgkXGuFSMkn19//fX8nbxtmc1wStZ6pbXOD
         lkiw==
X-Forwarded-Encrypted: i=1; AFNElJ/hYJVF0rPYCR3KuoobLKe3xNtt6PzR007p55WeBukLPCgXdF+aGO9a2Bp0bi7OfZDpZu7GzRaE9lQWfoVP98M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMkY6Zg5yNNqDWAop8dTk9VH3DOskCiquo1GJtDLh7FevSx6Pt
	LjakvkgXXJ+BbYQgaMOm+7GNxEcVgS33dpCiWHBTVPaE/01X9X2VtpQ9mxzjHWI+w29wpf2qFpy
	60UH+mylvMh4nJ/d0qcPT4pXwUr68j3v8/EVjEEA9h3G8HzKiYv4Jym2Ckog6JzBfiAqX8Cg=
X-Gm-Gg: AeBDietEYVI/QnrEecuOybaf9QvYUyzcN/ittBPCe+AGbwvRrwm9+HJGiZboZCAWG/y
	rveg9doCtDqZSZt9udkkjk98JDILAPMDiLI/4XOFa1LeiHkF4Aa7wfZePr/73hMShk4vimjEXGO
	4kLcj6PBZFE6B3aurKkRqMNqYGcdbPFEbzA7qHXgukjFuZITUwcSExuXPi67Gj6tjimLJeCjFwG
	FYAOd5IcjpAOFtZoxLg8GGCmgtz/RznsC6+UYHuLp/px2p74SWU8DNCc1pGgc9dR3A68V11bo6R
	vrNVer/xW3gNz9X/1P5Z4FjU7DAKwAFusR2IK3YylrDgmyFnqF7JTydXYeoPGlYcY545Txq5gzU
	YAsyjAvo088RNgx8FTT7rLXWjVQ/COyXu82j+HEEN9+lW+WY6
X-Received: by 2002:a05:7301:1017:b0:2c9:1943:e7ff with SMTP id 5a478bee46e88-2d587d80ee9mr13078016eec.10.1776221387999;
        Tue, 14 Apr 2026 19:49:47 -0700 (PDT)
X-Received: by 2002:a05:7301:1017:b0:2c9:1943:e7ff with SMTP id 5a478bee46e88-2d587d80ee9mr13078000eec.10.1776221387489;
        Tue, 14 Apr 2026 19:49:47 -0700 (PDT)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c605883sm710270eec.10.2026.04.14.19.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 19:49:46 -0700 (PDT)
Message-ID: <e41ee37c-c93a-44c0-9168-79bf59550859@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 10:49:39 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Bluetooth: hci_qca: Convert timeout from jiffies to ms
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, stable@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>
References: <20260327082941.1396521-1-shuai.zhang@oss.qualcomm.com>
 <CABBYNZKY_-QgsenfU4hpyQ1+87rXDS13wFueN2nX6Wojy4BgHQ@mail.gmail.com>
 <f6a9419d-5e63-4c36-a7e9-aab6ac798703@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f6a9419d-5e63-4c36-a7e9-aab6ac798703@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xiJ7F75a2qWxRuQ63Ol82UPrI4pZ88Cw
X-Authority-Analysis: v=2.4 cv=dpfrzVg4 c=1 sm=1 tr=0 ts=69defccc cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=PU9PaiTs9atMpjuS6XkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22 a=GvGzcOZaWPEFPQC_NcjD:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDAyNCBTYWx0ZWRfX8j9Ig7Ma42An
 4wxJ+V1FQ5utM2caMmt1YZp+UbLparVYOdb8yjv4ueDvSQnW/Lt2GS43NTjKJo1GsDJEKiC1TLL
 Uphv6el6MKGwNKiRqr5ZDznEr/zz2X4jhVe2aqDGw04JmbLtRf/PCY58rb1SETFfn0vQqO70sTl
 LMfTlDgrm8NU0BZDHQ6eS+uWEnKlBsp6LLFxjGcb1NWk4OLeGRd7HgCuejB25m8GSwoAe4VMhhj
 csRHDKLBlTF4iSgDx7Um03M1Hagwi1PKh5zLh1LndPy30hZIqD/m68XpjCQYx4w+amQIdvIW6T9
 8u/9OiRkhKgb5/zDckXt9BIY6UZQxHq3snCVlVtBsHjLPMbk7DUHYNC29uysxf5rH1TIowyvu8v
 jLR6Utrh3nQP0i7QKKRutygX2NmwToGm3ZpLsGJuFS/OAjITWGUu38uwPFSA9ziEXTjUpQnwkag
 GTatUls0RGQOkdQWwyQ==
X-Proofpoint-GUID: xiJ7F75a2qWxRuQ63Ol82UPrI4pZ88Cw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150024

Hi Luiz

On 4/10/2026 4:56 PM, Shuai Zhang wrote:
> Hi Luiz
>
> On 3/28/2026 1:53 AM, Luiz Augusto von Dentz wrote:
>> Hi Shuai,
>>
>> On Fri, Mar 27, 2026 at 4:30 AM Shuai Zhang
>> <shuai.zhang@oss.qualcomm.com> wrote:
>>> From: Shuai Zhang <quic_shuaz@quicinc.com>
>>>
>>> Since the timer uses jiffies as its unit rather than ms, the timeout 
>>> value
>>> must be converted from ms to jiffies when configuring the timer. 
>>> Otherwise,
>>> the intended 8s timeout is incorrectly set to approximately 33s.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: d841502c79e3 ("Bluetooth: hci_qca: Collect controller memory 
>>> dump during SSR")
>>> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
>>> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> ---
>>> Changes v4:
>>> - add review-by signoff
>>> - Link to v3
>>> https://lore.kernel.org/all/20251107033924.3707495-1-quic_shuaz@quicinc.com/
>>>
>>> Changes v3:
>>> - add Fixes tag
>>> - Link to v2
>>> https://lore.kernel.org/all/20251106140103.1406081-1-quic_shuaz@quicinc.com/
>>>
>>> Changes v2:
>>> - Split timeout conversion into a separate patch.
>>> - Clarified commit messages and added test case description.
>>> - Link to v1
>>> https://lore.kernel.org/all/20251104112601.2670019-1-quic_shuaz@quicinc.com/
>>> ---
>>>
>>>   drivers/bluetooth/hci_qca.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>> index 228a754a9..d66af13ab 100644
>>> --- a/drivers/bluetooth/hci_qca.c
>>> +++ b/drivers/bluetooth/hci_qca.c
>>> @@ -1607,7 +1607,7 @@ static void 
>>> qca_wait_for_dump_collection(struct hci_dev *hdev)
>>>          struct qca_data *qca = hu->priv;
>>>
>>>          wait_on_bit_timeout(&qca->flags, QCA_MEMDUMP_COLLECTION,
>>> -                           TASK_UNINTERRUPTIBLE, MEMDUMP_TIMEOUT_MS);
>>> +                           TASK_UNINTERRUPTIBLE, 
>>> msecs_to_jiffies(MEMDUMP_TIMEOUT_MS));
>>>
>>>          clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
>>>   }
>>> -- 
>>> 2.34.1
>>>
>> https://sashiko.dev/#/patchset/20260327082941.1396521-1-shuai.zhang%40oss.qualcomm.com 
>>
>>
>> Comments seem valid to me.
>
>
> https://lore.kernel.org/all/20260410085202.4128000-1-shuai.zhang@oss.qualcomm.com/ 
>
>
> The wait will be woken up once the coredump collection is completed.
>
>

Please let me know if any additional information is needed.


> Thanks,
> Shuai
>
