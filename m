Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB962853E0
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787169677; cv=none; b=IV0Bv/3VKPHdc1FSLSf4hg08jvyvzaoorv2cLlYK3KYWRWuneKgyrSXi+MjHtHOiPC4ZGCHstuaQvy9YlLwZ/yhbcamEkx8vwv4wnO6nstbIZkSwMSwTDYvfP8vWQE70iQ6UCyktBkpcobuWzFAmJWcrAUmXtcthQkZFNGM+FRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787169677; c=relaxed/simple;
	bh=bZq5ZcH/fW6m7Eu4oDlKkeiEGJ/mM3aqzsUp69XY2cM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sn2h0RAupqIHpg8X22CFQ+IeQJGcwZA0jIjctk1X/YT2O33Yu70DHgBByYXsiDTygZik2T7Qu15nWxnx48bCtZrxuNnir+haebsmOcCS6D66x6z2cnNPbGqcil1s/m7LWGG9t8XiKdjrPC4Be2J2GtpmLnhPtpf80mDTZLy9z2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hnaknzbG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=isVJDz16; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hnaknzbG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="isVJDz16"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JHpnAR2061998
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 20:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LnNtRkW6ywP+UGkiJuiejeqtLP3y4FyEqStN/dizZpo=; b=hnaknzbG96+8k3HY
	0y0I/03yzpJhIB/1es0vZ/m1+AhMihbTWMc7hjx7N5OOyBdKnLtTCRLfCUTpCCC1
	sPWXKZUbLvXO+Us2NnN8Ai2WOyGTm915jhEHy5AM82moSuy64fBAsVmscEfG0NzY
	ZUDHRY9CMnhUIlmkGz0Kn1U/hbq2GyJHBZyGlztKnk1NkSw4gkmaZHjp5AfH/rWq
	XCbvaYHqRy6qjSso82rqjZdTNR/iZlJf4VVRqGNM9RCCTe/sg/AMdBibxb0ahaMA
	lKBoDFtaakuBtOFeOiGaUDIrLc/orblX0OKWwj9vPV7RCyXxNMHHUPEuhqXqZiKR
	lrZlBQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5e83sjm0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 20:01:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52d7b3adda4so15758801cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 13:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787169668; x=1787774468; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LnNtRkW6ywP+UGkiJuiejeqtLP3y4FyEqStN/dizZpo=;
        b=isVJDz16qFo4c91dJTXaG3XQYwPxdXCFBt94aXMWqJVZn+rO64yCvQ7SsNfTJQ9X83
         NkfbQydjJYh37jPECQza+T4QMB7M98bpGng+0nhkWDSYpki4FduK53jLCASuBJPeXe1O
         XYD/RXd+u6Cga5LaEmERCiRy7hArnC6qCN4fVIBnclG0ac5q93ozStNlp8ibetRhrLEo
         6U7HbxmEDSMr5VuRarxDFsCybk6VFSTXw3PyzXgb8II5anWPCeUBF49ua9K4kntDWZRF
         XmXeLsIDIJGBmeZ9nh3W7NrgtFTaF58CBNVMKRZIPpUl6fbsuZvnE9oBeLZQyNOOkLw3
         9xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787169668; x=1787774468;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LnNtRkW6ywP+UGkiJuiejeqtLP3y4FyEqStN/dizZpo=;
        b=Q7kY52eIIQZaeMxAUf+g8XdpmyxSL3TIkUAAJ4tnYZ2Lq7jOzXkAuCqp3yylH2+gDZ
         bQk5P9JsFTqaZbhV3JE9hDceGIkRN1wmIuauilAFAuafUwdC7EYZmczi6wMfHofFN4hO
         b9nztYZ07rov2qyf697mdAwAU2LDeGn5e6V2sxIjZkOIDc3kcoHQOYl7avbo8CRZkqXV
         rDAZgb3S1stihBMOoonSN3ZpkVDMsuAaPyntEtXax/I+uFgUfhnthlOx8Kxyuu1zrySm
         9uNLZ+pcKzgjF9nCGIaLru8pK6teSInUtm5C+Fvuo7170TzF28GKczc1YPAUd6mHU+qy
         o7bg==
X-Forwarded-Encrypted: i=1; AHgh+RrsFFkx4qjCFxyX6WMqrPEnmAHUkfkpveyD3Jz3S1BXAgI4QJY+OKP90lBmPOcEcHOJvfB42Ruz6bd/QjrFQpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqAt1kBPQxSIeXgCIAgAyZSSd46Tgt3Nlglr9gO/KV9uPtigkF
	IcBPhU28yllgDzixnlq7UsOTQoRrzcs+323k7Ie9rRbH6JJ/Q7jBL9QBihxoGaYgz706+y2WOrh
	YOH8P0dDvWwiyx4ozhPBWjcJhtoMOF2Vu4f6RmV9DDujE0tnJwFNqucRrWsR82EarGhAP2mKIJe
	12Zns=
X-Gm-Gg: AR+sD135HA2lEVIk7+fYKC8wmoZVIgVA/8dyhr0mrtiB2d6vOukxp4bXPm3JgdlAUIc
	wWKMON51Rs6QtFjGG7DkNFvP1bd+7tgme9kdU9g1R88M4yysZrpcFKGLv6y6CAmkuQPHvilJg/w
	Vapxlm5r3Ub624MiTeSiUKFa504ewblGkBc9wjs08/hk/Wg3TRfPQ6B5DLNPDstjeElh+khmmB+
	6wf1RetddG7R1eDwcfrJh9pSKeVAT8nYNcXJXjMvTgC/P5TS60FKyEa8hRkmY+Ak8haQ6qhKJAI
	9LLskiPuZ0X0PcaIOzzQC+jWKv0NNpl3/a8JN5BgVhdqOeYqgDHuc/0hHMvkxhzS2iArKxnqsFM
	KKJDsZqelZt7drCnlmWlzs0lQs2e2DKjWkmML3x91mNu643xtXLK5dIbDD5jTddfXfOhXgAfEAa
	/UqkCgLI7ic3qhN6W17NVywYwwxFrsXTzQLyqe1udpYWCl68mdEslqNpN8VeWBcJ8Nm04=
X-Received: by 2002:a05:622a:22a2:b0:51b:fde4:cd4f with SMTP id d75a77b69052e-52dd5cd6e94mr74141121cf.30.1787169668343;
        Wed, 19 Aug 2026 13:01:08 -0700 (PDT)
X-Received: by 2002:a05:622a:22a2:b0:51b:fde4:cd4f with SMTP id d75a77b69052e-52dd5cd6e94mr74139461cf.30.1787169667556;
        Wed, 19 Aug 2026 13:01:07 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c243c8ddf0bsm117296766b.4.2026.08.19.13.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 13:01:06 -0700 (PDT)
Message-ID: <0f0ba112-f096-47f7-aefc-755bb56a854b@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 22:01:05 +0200
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
 <73afb7ba-53c8-423e-81a2-7e923896c995@oss.qualcomm.com>
 <CABBYNZJrTSPya+-vwLTpC8iMYj_bygRwZm-Nzk_Fv-WH+FRo-A@mail.gmail.com>
Content-Language: en-US, nl
In-Reply-To: <CABBYNZJrTSPya+-vwLTpC8iMYj_bygRwZm-Nzk_Fv-WH+FRo-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDE1NCBTYWx0ZWRfX1Sd/fFOYiOyT
 0WzuOCPwX/VvxXjA+ENSHQePMlcSaHztILdHeQRL+5SHuVBDDdxwrrD3S1DD4HTZ1hdAhOURnfH
 CVRG/TSrw8HTUMbAYewO2+6U9Fco8VM=
X-Proofpoint-GUID: GHT_kgILM3e5UAL5FzNdE3wp0Dd0DOUD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDE1NCBTYWx0ZWRfX8Fg+wyeT2UHs
 CON/1Y84DrCKKDfUKdk3PCU1jJ0+7YuI+/H8VdcvGY3xKwacx1ADlnkflSCxKgYYpugD0nG3ord
 Qcj9yPngS0nyQwFTDQstvD5MhMETj45GWqcJy2uOPJpI+FM+X/gUSbAuDFR8N08u6txFXrOq+fo
 W6jHwQBRHYQwutkKK/QRj5mUlDRHBmlG5JVGxRa4S8zPq58yRqIxob4FZmcZ0mMz+Pfix6PTv6d
 xA4J5AYR2jc8rlmjHp8o/cSjQ4prEhpgx0bMF2dV4GatSE1V70/QimdXhvzZ8lUcjzMrgXc9oyM
 8Y7PgmF9NkNZmNg6WxgtfPiL7s8enp7fimjpzx1aCSmugcRm1z2pgBttWRsqcjNXN0/a/7jhb+S
 7mij629cM+VOC4f/7HbIi6TKzZIZXdH8sY8iEK8RfI7vxZ2ojMui+kUuE1EjEYmeOvd8TgKKdlM
 QZ1Tgqfi+ZhFIxtWPJw==
X-Authority-Analysis: v=2.4 cv=cvmrVV4i c=1 sm=1 tr=0 ts=6a860b8a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=EIXI2P5-5ktP_Jc0aAEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: GHT_kgILM3e5UAL5FzNdE3wp0Dd0DOUD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_05,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190154

Hi,

On 19-Aug-26 18:42, Luiz Augusto von Dentz wrote:
> Hi Hans,
> 
> On Wed, Aug 19, 2026 at 8:38 AM Hans de Goede
> <johannes.goede@oss.qualcomm.com> wrote:
>>
>> Hi Luiz,
>>
>> On 18-Aug-26 20:01, Luiz Augusto von Dentz wrote:
>>> Hi Hans, Ibrahim,
>>>
>>> On Mon, Aug 17, 2026 at 4:50 PM Hans de Goede
>>> <johannes.goede@oss.qualcomm.com> wrote:
>>>>
>>>> From: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
>>>>
>>>> hci_send_cmd_sync() does not handle the second skb_clone() failure as it
>>>> does the first one. At that point the command has already been sent and
>>>> HCI_CMD_PENDING is set, so an allocation failure leaves the flag set with
>>>> req_skb NULL. The response then matches nothing and the caller blocks for
>>>> HCI_INIT_TIMEOUT before getting -ETIMEDOUT, reporting a memory shortage as
>>>> a controller timeout.
>>>>
>>>> Clear the flag, cancel the pending request with -ENOMEM so the caller fails
>>>> immediately instead of waiting out the timeout, and return -ENOMEM so
>>>> hci_cmd_work() does not arm cmd_timer for a request that no longer exists.
>>>>
>>>> Clearing HCI_CMD_PENDING here is safe: all code touching that flag runs
>>>> from hdev->workqueue, which is an ordered workqueue, so those paths are
>>>> serialised and cannot race. The one exception is the cleanup added by
>>>> commit ed516e3f1aa6 ("Bluetooth: hci_sync: Clear HCI_CMD_PENDING when
>>>> dropping the last request"), which runs on hci_dev_open_sync() failure and
>>>> from hci_dev_close_sync(), and the workqueue is stopped before that runs.
>>>>
>>>> Fixes: 2615fd9a7c25 ("Bluetooth: hci_sync: Fix overwriting request callback")
>>>> Signed-off-by: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
>>>> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
>>>> ---
>>>>  net/bluetooth/hci_core.c | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>>>> index 8aeb3024428b..9585b42e7970 100644
>>>> --- a/net/bluetooth/hci_core.c
>>>> +++ b/net/bluetooth/hci_core.c
>>>> @@ -4092,6 +4092,11 @@ static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
>>>>             !hci_dev_test_and_set_flag(hdev, HCI_CMD_PENDING)) {
>>>>                 kfree_skb(hdev->req_skb);
>>>>                 hdev->req_skb = skb_clone(hdev->sent_cmd, GFP_KERNEL);
>>>> +               if (!hdev->req_skb) {
>>>> +                       hci_dev_clear_flag(hdev, HCI_CMD_PENDING);
>>>> +                       hci_cmd_sync_cancel_sync(hdev, ENOMEM);
>>>> +                       err = -ENOMEM;
>>>> +               }
>>>
>>> Sashiko flagged a problem with this change:
>>>
>>> https://sashiko.dev/#/patchset/20260817205017.56524-1-johannes.goede%40oss.qualcomm.com
>>>
>>> Im with the opinion that this shouldn't cancel the request, because at
>>> this point it may already been sent to the hardware so maybe we should
>>> flag it somehow that req_skb wasn't able to be allocated, or something
>>> like that, but the command is still outstanding.
>>
>> Ok, so maybe we should move the hdev->req_skb = skb_clone(hdev->sent_cmd, ...);
>> to above hci_send_frame() ?  I don't really see a reason why that cannot
>> be done first.
>>
>> And then the hdev->req_skb = skb_clone(hdev->sent_cmd, ...) and
>> hci_send_frame() error handling could share a common err path both
>> calling hci_cmd_sync_cancel_sync() ?
> 
> Looks like we found a much better alternative which is to use skb_get
> rather then skb_clone for req_skb:
> 
> https://patchwork.kernel.org/project/bluetooth/patch/20260819135321.1444185-1-xin.chen2@oss.qualcomm.com/

Nice, ok this patch can be dropped from the queue then.

Regards,

Hans


