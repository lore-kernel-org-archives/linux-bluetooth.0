Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B072EAD1B
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144360; cv=none; b=g9gE7vRyTy0W0baUqKhAPeZa7bytdtYIHI4dbrsPCkrBCjyiDZmPy3ts49Qn/4qQAJMuI2+O9XBDu2qzbxpYXmVRxpmEWeC3yoiks7kC9LBAiM1BJejCbCMPHehLHmMtBe3XNKPXCP3PEB1moWpiiqVwBIsUP8M95NpTlzJLYBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144360; c=relaxed/simple;
	bh=CuTKmQnaSx5nkqFsu5L1bo9ZzMMDup2P89U7vLFzymw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UfzS5TU/vMFgu4LO94R+aSNH9a9dE4aAzblQjvx22UR2i26pHZmW038sxWYRDfvkhS4nJsuPF1490soxu9s6Vg4Kbw9fxLxAnkPYy2q7YyHqFYInohu778Y3kxx0I1EeMuUQy/2wBqrRmZxdSmX+ko7oTbC2p/VwueW6xMNm4zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kMs+gCue; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AqbS7/HY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kMs+gCue";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AqbS7/HY"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JClCrE321482
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 12:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IzHa8M93DFFWzI1AxZRwzNbo7KrgJCHbFTJdy8UnY5M=; b=kMs+gCueZuPksMkV
	GRNfnszoLPsoko2GRZQaH+61rUJOkjCZsTtw/Azr5yoYIEh+uwoIdVGhVMz2+bLB
	FtRc/yPez17VPlTnyWnPgv1RouhbnHz8ZZQsRdsOdKUL5yVIiZ6Q+FnBAVPE2GDJ
	KwgXXxAAu4oyNQaKIlWb+zmisC20r2hiziosnLNPwaLS0VXC3fitIFb7Ql26T1Go
	t30V2qHtTTcxgBJZ5fvlvMInXJh51gDyoi+HWnsD78/G6MLuuEG5+c+4+rwPPhte
	xTJy7I+wro7RGyORe4p1mFLcy2mskUc9k4tlIppF8AoOji/3XF85ZNasC2b8a3yx
	c0m1lA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yftuav0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 12:59:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-930dda91cbdso190302985a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 05:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787144357; x=1787749157; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IzHa8M93DFFWzI1AxZRwzNbo7KrgJCHbFTJdy8UnY5M=;
        b=AqbS7/HYvKsLyx/Kenh3qgmjBoX2/rYIScg4521maH0ezo5AvTFFoWEQ4S8fRI8S/O
         eWE4fMHbiJFxNuN74r2oeV5NzXHdXnerUQ4JLgaKoig2fLGvAvRuLpKq3yCZN1tOFqiF
         iE9fJFHFpCx44uDMk+2v2NaPuh28bgFSoLJzbDa/0kyqSIududdlSIO9eTQSqgEexbct
         BER09yEr3VN5TU902JRLAmgxjJ07JCMoUmvK4618jcw8EWoaRFY0yJDTxUxOh1mEsR5d
         4bcniViE3VSKoXyTPM1U+XlJvOPDKe81Rc8NBx/veuIs+ZRsgIiZ4E4/no3pkCODMbwN
         Khiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787144357; x=1787749157;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IzHa8M93DFFWzI1AxZRwzNbo7KrgJCHbFTJdy8UnY5M=;
        b=HIUTPXrSajnleaucEc8WDqRcJJLGdlcsXOIJEE6zIRKiv+1HeR/m2e9R2umaBXBtJA
         PimgZwjYC8rkPC+nRvY1Z0pZj1CVgbCXZOYwVjBpCck+48G4Rxp9SDVU64JOsx6ktjmr
         nCqB5jjw7fH1z2WD8sXYygHQTH/ZGaGCKl/Sxg1u0agpmn5Usj6JiBIhCmZRaRR2KLIL
         BuBJyksxPLTFZesagDMdCA80pOqYKOuGJVMVoxCcyvdIFn2hIiyjCyAlTvwmXnGZjwFW
         DfJl2bYXxAVv08d04YRpBdJAWkBk4b0uoNsUgtxyU4aVK9/SMIAvVVKWnAoW7oDc53QE
         IreQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp/rDoUz/mW1hiBGKj0TPIdWlNSawS0xUjAw7mDqetTra7i8caktRKk7aTlN8ysQm1jQfVT7TExzHHeZp2Trb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU5TC1cdTCy7sJZFM+eCstY/Zlu3/OvXIuICidu+A8PwXJJr0+
	otJ+Dt/tXDd43JDZ/lntATNpw6KMS++YaL8MCm/eWUQLWzslokMHGz46oNm8JhSeNydg985RbIG
	6GL7vGiC2SICVYXGEtNXBtaN33KXNiPhn79ci2986A5wROH5h9/aFUNKpyTrWiKB87DwWFI0fFo
	CZujY=
X-Gm-Gg: AR+sD12yanvKAO00sj/1yLVlUp9lJGpTA+5mClveMF8pPCtzVISFfWjtPqzlMUbXQVk
	BdmrA3h3JH7dJaXfyDGPCaEdgwQQgxFtblxY62XKK0a9uEVW1aGT9MaKeS20BMRVtnRs5JUnrdh
	dqiRiXfGNWHFbe8tUtPdylIh4jYXesv4dC5wvDs+tA/qRyRBGISUSIA6q43xcDgjkutJ8vu4mHK
	oOzQ7HaLVKqxo/9ewm4OYTXhJU7gBjOV0uDIt+rlUucZVALWgDq0c/HDLAKMBT7a+0IocUhLHRs
	BtwRyiNY1a2fa+df93RRNbz7DjKptz5tV4PRxd+1DPXSdBzTVtzOBrXkYuekDZ7CD+pcvtq3NM3
	/RJ3y962PyKklOeQEKM6bd2IUmMQvrwmPk2k52AWTVjOTsJqUd9Fj9tJZ7FrkzmvYjyXMixdK1Z
	61Ej6jT9Z4i8UpL12Azyuk0Y685x0PnsWDth6n/htbvBpcThbr/qy2zakomO/nAx0A3mU=
X-Received: by 2002:a05:620a:1792:b0:92e:5d44:73fc with SMTP id af79cd13be357-9371e23b130mr395729185a.12.1787144357019;
        Wed, 19 Aug 2026 05:59:17 -0700 (PDT)
X-Received: by 2002:a05:620a:1792:b0:92e:5d44:73fc with SMTP id af79cd13be357-9371e23b130mr395726285a.12.1787144356650;
        Wed, 19 Aug 2026 05:59:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c243c8e4482sm67698466b.1.2026.08.19.05.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 05:59:15 -0700 (PDT)
Message-ID: <340c1443-9e2b-4224-9029-f1defc644494@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 14:59:15 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH] Bluetooth: hci_qca: Do not write to the serial port after
 it is closed
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org
References: <20260819125425.192316-1-johannes.goede@oss.qualcomm.com>
Content-Language: en-US, nl
In-Reply-To: <20260819125425.192316-1-johannes.goede@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FIorAeos c=1 sm=1 tr=0 ts=6a85a8a6 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=dlFzzRy74kIF9YYi:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Je4mtRru6RPz1SsRR2UA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwMCBTYWx0ZWRfX3nu+YfN9/1Bo
 P7DMsV1qALvItAEopH6Ywg1vOMb9kRrClXUPF/Np98RHs3Fnc9RdTpsgUvzaSlVxV2A4Je2K+uP
 yK0hF5JGsQpBAF/wwJ7DsQijGsX3W28=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwMCBTYWx0ZWRfXxb43iKHEnL3K
 qOSe9FjmzibW6T/e9cEyBockwNBaCUAMEdbPVD1vcbH2DGnNKLdpjrZChnyGkhzvVwSVEMFbdr6
 p4RVv8m0Vs4rRon3xDVww17MnwrAHZ70ZcwPsntjvnncSZN4V6s0LSZ3WnbpVjDR/EKfAHc2k9p
 5kfhTbgIZN3uYXzvfoWPvc1PQ5J1XrYat6K2aOHVnHX+9wvY6nleZ5Vc6J75S3qUsbtsI1qVv76
 lzShzxZ1JiuyG7L8GokOn/J6mDiW9dQFPffo61xY8EMSwOZh4UGU4ZdCug2ZbMl+SQSVn6PPDo2
 R1lopf5PrCsi1Fprs1mJmoTpXk7fY0mP/EU42LEsuiH8E0fva9/YBA6vdP0X6UauAPliPZeraq2
 W5a8FxJG7hVm1AMHglKBUzpBh15qRZFeuqafv2tr9xXC5PyJCw84ikAjzyY1FGy2kQQDAlQL8Td
 pCj0jfoKEb9b/b39T5Q==
X-Proofpoint-GUID: PRnqXNl7MT8c-R1CaeZ7aQnEiQhaGBsV
X-Proofpoint-ORIG-GUID: PRnqXNl7MT8c-R1CaeZ7aQnEiQhaGBsV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190100

Hi All,

On 19-Aug-26 14:54, Hans de Goede wrote:
> From: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
> 
> hci_uart_close() closes the serdev port if HCI_QUIRK_NON_PERSISTENT_SETUP
> is set (for example, for the WCN399x family). A failed hci_dev_open_sync()
> following a successful qca_setup() calls hdev->close() but not
> hdev->shutdown(), so the port is closed while power->vregs_on is left true.
> qca_serdev_remove() then passes its power->vregs_on test and calls
> qca_power_off(), which writes to the closed port unconditionally.
> 
> Seen on a WCN3988 by unbinding the driver after a controller failure. The
> trace below is from a 7.0.0 based kernel, where qca_power_off() was still
> named qca_power_shutdown():
> 
>   Unable to handle kernel NULL pointer dereference at virtual address
>   0000000000000038
>   Call trace:
>    tty_set_termios+0x50/0x238 (P)
>    ttyport_set_baudrate+0x84/0xc0
>    serdev_device_set_baudrate+0x24/0x40
>    qca_power_shutdown+0x158/0x1fc [hci_uart]
>    qca_serdev_remove+0x54/0x68 [hci_uart]
>    serdev_drv_remove+0x1c/0x2c
>    device_remove+0x4c/0x80
>    device_release_driver_internal+0x1cc/0x224
>    device_driver_detach+0x18/0x24
>    unbind_store+0xb4/0xc0
> 
> Check HCI_UART_PROTO_READY, which hci_uart_close() clears in the same place
> it closes the port, before writing to it. The regulator disable is left
> unconditional so the controller is still powered down.
> 
> The dangling serport->tty that turns this into a use-after-free is
> addressed in a separate patch.

That separate patch can be found here:

https://lore.kernel.org/linux-bluetooth/20260819125748.194377-1-johannes.goede@oss.qualcomm.com/

Regards,

Hans



