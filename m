Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4BD2D9ECB
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143140; cv=none; b=Pqbt17ZKPwIk8eenpA9M+STDgW1ZHMi9ztv2HfVio6bu+ij9+d2JZrERs5U13fiurcuZxJUjBuSYzLgVi+EibCBIKIbTvrFdwB92Y8qD8/K3Kaw/J3XVLljid3yqtG8kZ6R22xQl45VW/Qs1+TrZtpHNRrYQR0kJoZEz5/VGDMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143140; c=relaxed/simple;
	bh=ti+q3Ez+5lurJibGp/Ys+prKkmqpOm9ANEMYbROgczk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VHdvihToX/KzhoFDtV7qAa4GQyWjAlrpuGyqkOhTBy+vHakDFldyLuw2Gc4MPhTXqXtTO/wvnrwxY00spZLPb0QNkH8Zj0++G8akNONnsiuIzZ7UoSg2OqXlkDXfD8s2vn3OA5KWOEXywGhv14NpNA11LHgm8Mec4kdJKI74Us8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LvPHDw8G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JVg/VqKJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LvPHDw8G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JVg/VqKJ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JA7xqp516038
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 12:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oeaL78ack5YcCyf6GgMSt/F2woxmb8WSjxxW/++9c40=; b=LvPHDw8Gmw5gi+zw
	2GOted65+0U5P8yXiBVt/EGYYo5UCVrqGmfpjzRS+xHJG3syk42AQYNvS0mLyL99
	0EEj5THHfh1/JYa6S0qbpviZ0wFyRgI6kk+cvyW++njOqC6cOVSABG8y6rj5083a
	M6ANQmAzoS+BvbaM/1P3dytcvz3oDPaAksJNqB1eHb6o56qizXiW1AqUNkWSmyWU
	TXUyiR6s4MlD8CD8Xg20mODJI7fP2FiQKEZlyYiniLZOa6avpCAkt5uez6eeL3Ld
	nNvClfQVooLqtbxZsBm2wzeoh7SXKu0JOM1iANNTySdlgSykFrHskKnhIji9VmAG
	Vzgt2A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfpu509-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 12:38:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9308eafb465so195972885a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 05:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787143131; x=1787747931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oeaL78ack5YcCyf6GgMSt/F2woxmb8WSjxxW/++9c40=;
        b=JVg/VqKJPRukgcXnmm5Hbr3EbBiWbMWqUp1SOm42aBk9VGQSKJ1D2/k86yXPaFL6Z0
         7Xf7GsdzG8b+i34oDOmT4Lmp/IL9zw0a+kagb/+yT57Af/5jTbucpselH8BWUk7SL6PP
         fGEkhjsbIjxT/EBGa2XR306MV7ik7LgMSI9mbUJIaZDS+zhJ5Cbgf2x8l1pdgUaajxmB
         zRD//pabdYicnY5WzcltxPbSwWarTcv9GBRDig/YzRRHLbWLwIpE2QMq7pq1nuLwrkRt
         RkwbBzm3qhvQB7f++CJ01nSII4BY9K9cua6ocNmEYIHu+sKhYRMi2OB73TRiLMNHaOu5
         Bpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787143131; x=1787747931;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oeaL78ack5YcCyf6GgMSt/F2woxmb8WSjxxW/++9c40=;
        b=g7L3bWPB+GmT7W9hwu3Dzns53wtqltdGDXlni96KGj7kgt2qvg9LDdiv/+7Ky+ImHT
         FioSKtvqOR+OTMz179lFBdlM3T5dfaNVHEUoTO5vtdT9u6WzBiLsWedJVns+HgcN80Tm
         6xluCvPTCEqnMUs0ITxWqBnAGCbNBKohghWRPqNJJA2aLKwnDoyFyoluTn3hrIVoXVCb
         4wSGkCxgC+n7fbuBCjT6QOsLCZKhCmKo9hgpZ7k8gvNa1eNFlxoW4bKJlptWDoW2eHuk
         KO/QpKKb5KYYSnv261QM4kg8fNx34YeLml6UEmFWilCfbU5z7wIsBY7xueqD1Z2cI2vr
         y3hg==
X-Forwarded-Encrypted: i=1; AHgh+Rr6ApvKwl6U/MAnGUcW8zWOS8WtQx4uF6Ig066h0VFQu/8PUzLxOCGsUTT2XmyccTNRalal14cD063OFADFw/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMBDQfvQ+Uo5I9p0ZCsJUFBHY4PNh3iY54h8ouRj/4LQw7jTEW
	OlW60qZ7YMuzjZJ2WsrxPcL5ASpUucsNcaW9E1JuDY51IJiceRsxRyBX/FuOGFV+lggQRlrISry
	GdUXFUugYYmN7pL5i9e4OEBCxVF1a8FmdwuRX71zPYWKh5so3RpnT66wL5IfspqUSsF2PQbXCzP
	8WM0g=
X-Gm-Gg: AR+sD134yzE3NRH0Prj7AT0qBiuFjjyBIM6esLLOc6ZnsE1M6+JKHkCeJ+ludcI+QZF
	8s7pBXloiLyEFuOPfTIVIdLk8lluQ73zdxkyNcjNm/kJI2K+eSgarFaC9kuNXAqZYoscmSQOluz
	3+N7l8JinKvp5r47ual+qh4jYONOSIhTyEMjA9VvZZ5zAQgvPF2bq1nnyWKQSlTUs0C2mc80rO+
	MOZyv/HYXJ8uxSVzFjxQPFmxkM0kjyjetIQGNdOltIU6IyiQ7/mXpg1AKgFVWhWNWjU/O/USvXq
	Qk9n6yyNHeG5AGE1xxZiDoIOv8VmFqWtkaaC5dcD7cl1kmqHna8hZohF1c+xqTYOyQwpNQ2TGO9
	aovIEHSVg+GMIWyfN/e+RdsOq4s4Nf0+DCltiYiMYk0LY/nCiHbmGMrb6BXXxuZKbO+pqP29IiA
	jmTUR07NkqVcvFRitXMcEDzAq6lD9sdCfMXWng3KdL0+W8lXfUxm1a7Mw+MUDs7E6PYaI=
X-Received: by 2002:a05:620a:8803:b0:936:adc5:6a8e with SMTP id af79cd13be357-9371e21876fmr433032185a.13.1787143129694;
        Wed, 19 Aug 2026 05:38:49 -0700 (PDT)
X-Received: by 2002:a05:620a:8803:b0:936:adc5:6a8e with SMTP id af79cd13be357-9371e21876fmr433020685a.13.1787143128642;
        Wed, 19 Aug 2026 05:38:48 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feec9d52sm896446a12.2.2026.08.19.05.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 05:38:47 -0700 (PDT)
Message-ID: <73afb7ba-53c8-423e-81a2-7e923896c995@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 14:38:47 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] Bluetooth: hci_core: Handle skb_clone() failure in
 hci_send_cmd_sync()
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org
References: <20260817205017.56524-1-johannes.goede@oss.qualcomm.com>
 <20260817205017.56524-2-johannes.goede@oss.qualcomm.com>
 <CABBYNZ+Bhhx3rtq8i_FGu2a_oFyWquo_gTRcmPyM6HcFC3pkVg@mail.gmail.com>
Content-Language: en-US, nl
In-Reply-To: <CABBYNZ+Bhhx3rtq8i_FGu2a_oFyWquo_gTRcmPyM6HcFC3pkVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bfDKZdFaTX3GECU0M47Gk7pFHmSH8azl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA5OCBTYWx0ZWRfXz2IE5mhbPxfB
 eaWNoHA6wAUJGmZ30mvIT9uTj0+wpPcjF9J6j/5L6N0fmsCU2+ZEmZpv/YdyObYKPUoPOXOtIZr
 DzMdjpKN6v86U+uXJ/8oaGt76DBDcFfUEjlOXsmjfa8t7IUXX6oSPGRzvBYae61yqe6HgEWsQhF
 FQqA/Q1ZvlkU1QlS1YdGKBXLA3HxGXPzNBsWo4odWuEoxXcaADmYYd1AfYh1uQezofl2LeYL+G6
 gaCVrbhgjHRuY9bZrzCk3eICA4pfa0oEDKJ2Moqa4kRTpVeIm4Q5iBRWynn64hVPhtxR/ZhcuHH
 jOGh91ZAGQ1EKQQzF0deZyJNCIBpc1ZHX3AggepRwPQWEVVfDPO4bvG7u4mTaE3XE9MOMljC9ib
 lCNjhF2Elj+x3dE/PLUU8smEcpA0CUOFzBjCoJMNibsCxt1Zu5y7TMVUSpRNrvuIA55JY1LXF2R
 sqQz4UFL2jL1HiWeSJg==
X-Authority-Analysis: v=2.4 cv=aMrAb79m c=1 sm=1 tr=0 ts=6a85a3db cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=HAoXxi4WUqF9RrtjM_8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: bfDKZdFaTX3GECU0M47Gk7pFHmSH8azl
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA5OCBTYWx0ZWRfX98gHeqcdntka
 cIrMzJ1VfQnbuWHwWr9aHYNo30Pj+65Q9ckQ1KKO4BXnc7sRaChOoHgPFT0JVZLLAOaNNnNAmFr
 Go7R5RqyoM03AAT9bSr0iHaEbIi1u2E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190098

Hi Luiz,

On 18-Aug-26 20:01, Luiz Augusto von Dentz wrote:
> Hi Hans, Ibrahim,
> 
> On Mon, Aug 17, 2026 at 4:50 PM Hans de Goede
> <johannes.goede@oss.qualcomm.com> wrote:
>>
>> From: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
>>
>> hci_send_cmd_sync() does not handle the second skb_clone() failure as it
>> does the first one. At that point the command has already been sent and
>> HCI_CMD_PENDING is set, so an allocation failure leaves the flag set with
>> req_skb NULL. The response then matches nothing and the caller blocks for
>> HCI_INIT_TIMEOUT before getting -ETIMEDOUT, reporting a memory shortage as
>> a controller timeout.
>>
>> Clear the flag, cancel the pending request with -ENOMEM so the caller fails
>> immediately instead of waiting out the timeout, and return -ENOMEM so
>> hci_cmd_work() does not arm cmd_timer for a request that no longer exists.
>>
>> Clearing HCI_CMD_PENDING here is safe: all code touching that flag runs
>> from hdev->workqueue, which is an ordered workqueue, so those paths are
>> serialised and cannot race. The one exception is the cleanup added by
>> commit ed516e3f1aa6 ("Bluetooth: hci_sync: Clear HCI_CMD_PENDING when
>> dropping the last request"), which runs on hci_dev_open_sync() failure and
>> from hci_dev_close_sync(), and the workqueue is stopped before that runs.
>>
>> Fixes: 2615fd9a7c25 ("Bluetooth: hci_sync: Fix overwriting request callback")
>> Signed-off-by: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
>> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
>> ---
>>  net/bluetooth/hci_core.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 8aeb3024428b..9585b42e7970 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -4092,6 +4092,11 @@ static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
>>             !hci_dev_test_and_set_flag(hdev, HCI_CMD_PENDING)) {
>>                 kfree_skb(hdev->req_skb);
>>                 hdev->req_skb = skb_clone(hdev->sent_cmd, GFP_KERNEL);
>> +               if (!hdev->req_skb) {
>> +                       hci_dev_clear_flag(hdev, HCI_CMD_PENDING);
>> +                       hci_cmd_sync_cancel_sync(hdev, ENOMEM);
>> +                       err = -ENOMEM;
>> +               }
> 
> Sashiko flagged a problem with this change:
> 
> https://sashiko.dev/#/patchset/20260817205017.56524-1-johannes.goede%40oss.qualcomm.com
> 
> Im with the opinion that this shouldn't cancel the request, because at
> this point it may already been sent to the hardware so maybe we should
> flag it somehow that req_skb wasn't able to be allocated, or something
> like that, but the command is still outstanding.

Ok, so maybe we should move the hdev->req_skb = skb_clone(hdev->sent_cmd, ...);
to above hci_send_frame() ?  I don't really see a reason why that cannot
be done first.

And then the hdev->req_skb = skb_clone(hdev->sent_cmd, ...) and
hci_send_frame() error handling could share a common err path both
calling hci_cmd_sync_cancel_sync() ?


Also while looking at this I noticed that hci_send_cmd_sync() exits with
ENODATA when hci_skb_opcode(skb) == HCI_OP_NOP, but at this point it
has already set hdev->sent_cmd and will also still set hdev->req_skb
if the conditions for that are met.

I wonder if this is the right thing to do, or if the hci_skb_opcode(skb) ==
HCI_OP_NOP check should be moved higher up in the function followed by
an immediate kfree_skb(skb) + return -ENODATA ?

Regards,

Hans

