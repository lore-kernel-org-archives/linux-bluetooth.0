Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B674334389C
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 05:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781070562; cv=none; b=io8XzatTntszfv9mf8hwmjACT4DieVzizh81i4JPK3sU8wEYntt76ugFH/SzNiMgnOzJxD9nUeoWaNwQTNo8+PpBICEXVcUm3qnHYbGib7y4hbVO72JnYxbZknw1NrqGnzH4rWXlmL2ZMOjDcisYFWKvxf4Gf5ECWV6wGOz7rR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781070562; c=relaxed/simple;
	bh=M/+7sUnN4Qu4nr2okedlB3kcRu8o9Bs9uUb76BHARbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3nSZdYD9GhYTRfA1tAVdFqcKnXal1WhlmZWXLbsd/Q/ehB7Rd5FxsMct/I/xkMHvbLV7/J3hWHhnb00DZA81adqDFwOjC5XvWd9oP0dKCJXD8Kwk7HqYFZrSuRgRz8j/9fVjRzZ6BIU4JkU5hEQc+libn3bnWiYwg+zoI9u69M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NUVzOcUL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=judfPwXv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NUVzOcUL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="judfPwXv"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A2em6w4061188
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 05:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EMWmK5emWJGvZztDxkAIu+IFZAwY1JG7AL7lYcHzAWc=; b=NUVzOcULPyvy4DZB
	6LA+kjNReaIHS4JKoQLI3mVFc2Yswty+kLemf0cF4SFuj8BbmI2J6LsrBkdZNht8
	TVMImXcmsteuH0tkvi8ML5Ldf9PC5niIv7qysnE26JA+QEt0Bgu1sUYcqKtR4k65
	V8Q4vL7wBK5NHGW/tOMXzgAnnFcVJO2DV5BFj5TdBhV0sKZwuS2UvLYeO8a8se2G
	2GmwGZuVTxrbNGbvKTDwnwwJkdhwd8674GT/h2li+cruh2LH43eD8zSfzAIA1kjP
	yeBbo2ANdadmEPmhg50QFuy/+8F2OHuWAv3DJidRvC3vd7faTfAD3O56JoOLw+Qw
	3L1fjw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epwnh0xee-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 05:49:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-915767b341eso720901885a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 22:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781070560; x=1781675360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EMWmK5emWJGvZztDxkAIu+IFZAwY1JG7AL7lYcHzAWc=;
        b=judfPwXv4I/Y517wuAQNTZD1eGmy3wuGPmlXSHqO5ML6RUxaxWf6NZUB46rtEWcL07
         BXkFO3sPKuIV+X9lUyPK1/E411Q5rdqHqlaFAyjG4WLj83JgkHJ+4scP+YH79IsfcaCy
         03v9dwaL3lRBpl2jnh/mjeSl2GARcR1gyVGytrUTL1ePiNq21fEG/EpPnKOlbSC7msYL
         735X1YnTQ3eFX74GvDTljsFUU/mzY0f+caFLJVtbnnlbnH9JxfgWT8bsmntCeSojTPgU
         mBoGQ6j8NHN53i6x/+AaIUDwqvFr/uzmekGLDoHNlIWHjsEuy6QVcc68DN+gXZUNC64a
         5X5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781070560; x=1781675360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMWmK5emWJGvZztDxkAIu+IFZAwY1JG7AL7lYcHzAWc=;
        b=jpAi6bq6QcXt3f+c6YxU7XkE1TzLWSzwcEaXil6/qZAiHJsYQM+7a7ZmYBC0qYRLjK
         /zRvdlLT3FiHsZj92Ea9ne7eiTU9/fUZsQI7hgLJbGvfum/eVjeDwxeMWypcz3UZPeey
         kgGLqozaA7peDnFwCex4jNQheZpgoGjEUYnI8eC1K3nO/NmTHpdfVScPLytXKUKd3l/I
         +Cg/e2xaspGiMAwZ648Tg9DsLqgeG7S32ugZZB33BTiorENtQxygcfCpaWpsuIEQ0R6+
         5LID9UKe5ptWEG+j6ncyNmws42HRFHcsVuQOQVWARhCBB7tOlrLWvuLvPuGKYJhwm3WQ
         MfSg==
X-Forwarded-Encrypted: i=1; AFNElJ9aNmnXbiGW9O2Hk6HJmBOg2sKdYuapEw+vPvUByQxBZedexzQuDUtvXWE1yMaZ/ZYWMS5ipc8FtCBFEOuK41Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyggghgEQZ/7WJd2lvWsw4bQJmVBpH1NileLnffIXDW19iNewi
	cddYVRYHC6H4HPqxcHT84g2FGKLMqdqinHL5UNSCkLZJRMoxYeW8eJHzZliDmCbxysydLND5Gef
	bRrY+ebMzrOWcHUYGzqGfEJrehkJn75OqbT73jUYThaLeWn5UcKA++4GnaQ5m3d3kLB3MAN8=
X-Gm-Gg: Acq92OFRh9E0lGFWs4m/DRYHYBci8BS3FgUgTZotCVBnO3qGO62BFLCxLifCMkcVmOv
	xI0cn24YxaC6y41VpInjP32piKr9S4nSogf3Jo8e1crSxLt5b9EOM68IrGwJbGjxHmd7TKIfRQK
	8FlwzP6O+SC7I9D/OoWmh/qWGtkMmmTmLvqTboaYZbN/XFLpZ4JJhXxLrN//WD78BLT2lCUsIbv
	PpepCKFMxzmS6SOkEE17/N6UVUFEqjm9bVTUpce+FNkigbtId+e5RYaH26F8g3kQKu5Ep1drSuo
	NlwLVXOrQJytQbFsCd5BzXwRBjuq8vPtRbHyVUHfiRTs0fIj/M2QRIzmu4Qz74W57UMU6mI1V4H
	3RkfXfg5Z40ZMnQ3vOHAYdXlPewmZu1sl3SD7Hx/JKHEyWmdJ+/ZMZ5E2Zpk=
X-Received: by 2002:a05:620a:6310:20b0:915:b852:435a with SMTP id af79cd13be357-915b8524853mr2168176885a.21.1781070559952;
        Tue, 09 Jun 2026 22:49:19 -0700 (PDT)
X-Received: by 2002:a05:620a:6310:20b0:915:b852:435a with SMTP id af79cd13be357-915b8524853mr2168174585a.21.1781070559455;
        Tue, 09 Jun 2026 22:49:19 -0700 (PDT)
Received: from [10.239.31.31] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3d3a0esm2372244485a.40.2026.06.09.22.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 22:49:18 -0700 (PDT)
Message-ID: <a54b1605-0468-495d-81a6-471a73a29848@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 13:49:12 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: qca: Add BT FW build version log
To: Paul Menzel <pmenzel@molgen.mpg.de>, Bartosz Golaszewski <brgl@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com
References: <20260609075417.1160702-1-xiuzhuo.shang@oss.qualcomm.com>
 <CAMRc=Met_U-1gDmGFM9hSWFc5vvs4SuRQOa3hZcfUo190rh59w@mail.gmail.com>
 <8697f148-5e21-44b4-a949-9d348e39c2ea@molgen.mpg.de>
Content-Language: en-US
From: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
In-Reply-To: <8697f148-5e21-44b4-a949-9d348e39c2ea@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA1MiBTYWx0ZWRfX9ckFz562U+ZS
 eRqNKmezox0bTB6SJJoVi485U6FFbat9e3N53/8qTijKGEWCaamEoxhLBxT84sLX94cE9D5eIdL
 7r9jh7/pVVx0may4+WGVDZ0+nCT/3U2KTfmcr1DDggRYCop5WV+LFVRQ6dJOsRy+K2cz0t97PnV
 jG6C9lWV6Z2dxLJ88sL/d3Hns//qm9EQsgJspieAnxduT/ze0GSTkR039VH33MZilTZwYpZMWaE
 rkomAQJAXOnirTAHyKfsZh+Y37zJQSTMbi4AISfzw8ldcNXuNNL4urFFa4BxMzfyt2oJlNe8O4R
 vNvm0hW77LNZ9Z6xLLtMfk7PttEfB5Vhgl3jhke60bRxk5HvEnadztEn15oCgE9W4LZ+YiS1TKW
 AYNTs52EzujawM/tHKk+wRKs65rBC4TUQNhCcj9f0JkNNDwwMKpd+/CGKHGiML6H8NehJYHyZlH
 LUnejaqciopk4Nd1ppg==
X-Authority-Analysis: v=2.4 cv=Xce5Co55 c=1 sm=1 tr=0 ts=6a28fae1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=YkWQNLFlkgeSvEFMcyIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: qbNjH5aY-myFW-nAdxq5wlMvxch8E9lZ
X-Proofpoint-GUID: qbNjH5aY-myFW-nAdxq5wlMvxch8E9lZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100052


Hi，Paul，

On 6/9/2026 6:29 PM, Paul Menzel wrote:
> Dear Xiuzhuo, dear Bartosz
> 
> 
> Am 09.06.26 um 11:39 schrieb Bartosz Golaszewski:
>> On Tue, 9 Jun 2026 09:54:17 +0200, Xiuzhuo Shang said:
>>> Printf BT FW build version log after BT FW downloaded.
> 
> Please paste the new lines, so reviewers see how it is going to look like. Please also document a motivation (answering Why?).
Thanks for your suggestion, I will send PATCH v2.

> 
>>> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
>>> ---
>>>   drivers/bluetooth/btqca.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>>> index dda76365726f..04ebe290bc78 100644
>>> --- a/drivers/bluetooth/btqca.c
>>> +++ b/drivers/bluetooth/btqca.c
>>> @@ -143,6 +143,8 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
>>>
>>>       hci_set_fw_info(hdev, "%s", build_label);
>>>
>>> +    bt_dev_info(hdev, "QCA FW build version: %s", build_label);
>>> +
>>>       kfree(build_label);
>>>   out:
>>>       kfree_skb(skb);
>>
>> This string can be read from debugfs, do we need an additional message in the
>> kernel log?
> 
> In my opinion the firmware version should be part of the Linux logs, as that is what users share with bug reports, and you do not want to have several cycles collecting information. For example, currently for QCA6174 it’s currently:
> 
>     Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> PS:
> 
> ```
> $ sudo dmesg | grep -e ath10k -e Bluetooth
> [   17.880668] ath10k_pci 0000:3a:00.0: enabling device (0000 -> 0002)
> [   17.883428] ath10k_pci 0000:3a:00.0: pci irq msi oper_irq_mode 2 irq_mode 0 reset_mode 0
> [   18.138972] ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1a56:1535
> [   18.138977] ath10k_pci 0000:3a:00.0: kconfig debug 1 debugfs 1 tracing 1 dfs 0 testmode 0
> [   18.139068] ath10k_pci 0000:3a:00.0: firmware ver WLAN.RM.4.4.1-00309- api 6 features wowlan,ignore-otp,mfp crc32 0793bcf2
> [   18.206593] ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A crc32 d2863f91
> [   18.221145] Bluetooth: Core ver 2.22
> [   18.221802] Bluetooth: HCI device and connection manager initialized
> [   18.221807] Bluetooth: HCI socket layer initialized
> [   18.221808] Bluetooth: L2CAP socket layer initialized
> [   18.221813] Bluetooth: SCO socket layer initialized
> [   18.258187] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
> [   18.258192] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
> [   18.301557] ath10k_pci 0000:3a:00.0: htt-ver 3.87 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
> [   18.381567] ath10k_pci 0000:3a:00.0 wlp58s0: renamed from wlan0
> [   18.619003] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [   18.643646] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> ```

