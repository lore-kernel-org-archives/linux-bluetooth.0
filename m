Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146DE40626F
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784552034; cv=none; b=oOjtj/u9VoAM2RxdESZnwrYpCWugy6ZPOs2ePefpTBfvSUf4MT8na3x+HSzsBcknfO56QCBBmMmVY+T8BW6x9bw9GKWHHooBuIp0iMwgPznHe+5xz/1/46kC7+F5wjMUKSua0yhCtA5O8TQP8UOITeoc/Iz5G+IUsAnJ8BB1Wm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784552034; c=relaxed/simple;
	bh=yUVLMD+08RBlWzD/06QcS0rybFb4ASemTDbcjrwLZ9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSiCorSvodi+m2+HzlhiiDrkpAYeKTIz0qBwGTjhQlEjJWRqQdrUF8Se384EUfVe6p3p3N0H39GXaJe1cZhy+ITaHeoDrM7ZIynmhHnSBkxU0nFYz0G/vmfLT0xWh1pdkXV/SEdq8NIdyZ3WSo3qqfu3EdXeG370l0/9IVWusHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YCnb0tPt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jL5vL7ec; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YCnb0tPt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jL5vL7ec"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KBi26H2450172
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 12:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6K6AGYQAFOPctQWTjgHbP6h+QVjwgh1TC6wEu667jwc=; b=YCnb0tPtxP7Jak1g
	b67LX6iFEJcOA7K3Bg+IqM9KTCH1mObY8cGhIZa1eI+x7tJKmEiEPdqz9EZPuLKu
	xhCL/t990zYGBGsZMgIF3X5GDTtQuvRUUDKbV6NRXT8+mzKCjAaBvbXwLhOk7qP6
	oiv+o4WAEWLNaFyscejs4jVb7WyEM3PnuBp6KvBIdgvnST3rdiOxRu6whPSDmhLw
	DQ6nypwI43/Q0WlBITfmweXE/AT/MtQyuiOpI3nGrU4jXeeMYYC9Wu6rJ9LljnlI
	wY6N9AkHnwKEC3GSa0T94xponCbY10kGQxWtLathxE9w/urzQlM3FFDK3xzN514v
	XZ8CWA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhk2f8833-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 12:53:51 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so15286108a91.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 05:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784552030; x=1785156830; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6K6AGYQAFOPctQWTjgHbP6h+QVjwgh1TC6wEu667jwc=;
        b=jL5vL7ecLrQaIgLCDBAn++rAn6WAfBJ3awBjUCPyciNEqDaFNv3+ISSAl8E47XLXCZ
         VaD7cSkRb87b5uX3FlaeuFWbN1S2Aocy6YJjhSUrrl1jDm3I4q9J/4IMt5M1Inq6MvXc
         nQdjs1khg3vtNXZYQsr4j6RkfWYIbT0PqkZzVDXpYiUWwAJMJ+PAO2jkxwe7YE8Lgtre
         gDPsN4r34GtBX14hk21Wnbp+79TLZNWBtYaRdm+X/wb0Y/WWwmMgY2voCTolx6DaITdy
         006L5kxNrPq4AyIHWXqBt5TW6xee6Qj478Yekshg70csEoQhsYNuZSzCtDusPMXbDDIn
         PoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784552030; x=1785156830;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6K6AGYQAFOPctQWTjgHbP6h+QVjwgh1TC6wEu667jwc=;
        b=MRGDEdEfnTz1jvwvfoVdFE+KfbA1FBtcqxLmXiEm+p9rzYkvZJeXzdU+Qi10bzyobi
         fR0DV/q1zdVJvtZZwQLGzjhLeDi3l8pfUtGLOHF4d94FG54RrLpk4eP01LInNLwOjN7v
         jUNWVTsn6Tu0pdw6S0BPP3FY/sgBAELGFUmWqrETmBFID3My8LA5syrFqvqTtfcfZUAk
         +Ds2ihkFNz8I1t1A/ULjH1gljnzycXROFAmIrOZoWdqK5mcHfiaIX5Ssn/6oVraD96r6
         IdYrHQ/evN6vmnQp6cZ2GpHNCDIPQamHNs/biLwpYxweLS7jMoqfI7e9DaWyUtjHtd95
         Cy+Q==
X-Gm-Message-State: AOJu0YwTys6VRIIpmtxKqi+Y58ITk7B2Ya0G7MZUhpIzJg1EGcTv/dQN
	+6V69AzjL/suTK1f12Ej5lTq3cTXhU5AShPKrZVkans80BieRIC2itrzkDkV4NX3HKXuU2E8O+x
	rcv/bpSScEYv+xbmuMH8Hv3a0hevNMumo7HpMThYekP+uoWxmUOZXe5dcjdRTTry5MurBFVg=
X-Gm-Gg: AR+sD13i6BGs6xh9dpGXvP8K8V5UkGvzXdsFhJneIGAoLaONhlSXcAIN7gpm9Wf37B1
	z7h4omRdwjdpLdgqEfMxg5M5t69jmNhOYnobQdrsSjJcNM2MC6cvuXEXu5wE/7oKo1Vd7ZR+TVj
	zXRoSsxL2lIrgqcY+rrVcQ/nQwqC/45Yl/fHNuMV7DNqDa4aKt2StmBzpd/hkhBpBuy0VInbEcv
	ogwCztp8+KAIjNZjNvXJDzSvBxrDUgO8hPfLHrxCJx3v66kyBu2kxheFWfpBgbLkg+eqYodlc8W
	+VG0Ky0SwA/jbFNzgISRFEWT1sY3cmAkkUw+3vxyacp7r6+jukN1OWYh1dn7GOqvyCcT1WU3uNp
	VBLTilaLEPwWBLzJX
X-Received: by 2002:a17:90b:2e83:b0:38e:7f1b:efa with SMTP id 98e67ed59e1d1-38e7f1b1457mr3768364a91.11.1784552030466;
        Mon, 20 Jul 2026 05:53:50 -0700 (PDT)
X-Received: by 2002:a17:90b:2e83:b0:38e:7f1b:efa with SMTP id 98e67ed59e1d1-38e7f1b1457mr3768343a91.11.1784552030010;
        Mon, 20 Jul 2026 05:53:50 -0700 (PDT)
Received: from [10.216.28.255] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4b0e9b9dsm5626250a91.9.2026.07.20.05.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 05:53:49 -0700 (PDT)
Message-ID: <0f313cff-d021-44ec-af88-31142f14b558@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 18:23:46 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v4 2/2] profiles: Register RAS UUID reactively
 instead of probing
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
References: <20260717124111.3296537-1-naga.akella@oss.qualcomm.com>
 <20260717124111.3296537-3-naga.akella@oss.qualcomm.com>
 <CABBYNZJuitiNCz_COYYvUEY6_TbB=d6dZet=XEmHUkh=ENrzSg@mail.gmail.com>
 <CABBYNZLpp-hMUrevPX=_qD5F6Jh2yH+mLJD03A+PSQsBErxAUA@mail.gmail.com>
Content-Language: en-US
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
In-Reply-To: <CABBYNZLpp-hMUrevPX=_qD5F6Jh2yH+mLJD03A+PSQsBErxAUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yE629fbxzttpBAEQ7SFuWIs2wWG0KTBK
X-Authority-Analysis: v=2.4 cv=X8xi7mTe c=1 sm=1 tr=0 ts=6a5e1a5f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VITI08uSeh-Y-1EGjLgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE0MiBTYWx0ZWRfX7rypaFPtfDmK
 mzJfvo8y2pFpMafgOv5FWRomFl38DKLZEZukESUC1F4D7yKl2T9HLeB5uokEpb6SDwSUUO6tdDf
 bWfVXx/9wO/sWjEyaCmyuBH9k7GBmvQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE0MiBTYWx0ZWRfX2Yay/8AgPQfY
 0V05JHPZU+3yAJtEGyc5rVzqk50t7MVMFtwgN0juh7hDY2n50TslHw50izrUEF8/1V6BuRjxGui
 Uu/jKf/vRJizUPIci5hvJV+f83SuucD42hs/+0LtqiAK3Fx/GbDP5DmT5XqZIzba+UOji8b1BDL
 01Lotfl/bA+IhMapCHvanBdJN/hnxw2LZiki+PzmT4an8kk15lWZcmB9d2MapjLz1CfH+dp0/lm
 0b9X5UzHGmBDT8HJ8CHzl0HZIdnRU0KHqfeetgFahyu0bL2KeAB87w8s/NxjaY+ThIt/WD7LmdB
 iBWtj0VyJAEd6ztklFlhtp/IkaFC1+O4zfiBvEUp4P+JYOjaHMtP0sKONR8RQZcn6bMHpS73eZl
 Fli6efU8kEKahFF20V0sLK1f0hbfr+XTPjwTwS5pUPHaGJSpm7GBXUAuILX/lbhNA57kDeJ5+pr
 TjtX/2rjxU1rIcNd40Q==
X-Proofpoint-GUID: yE629fbxzttpBAEQ7SFuWIs2wWG0KTBK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200142

Hi Luiz,

On 7/17/2026 7:36 PM, Luiz Augusto von Dentz wrote:
> Hi Naga,
> 
> On Fri, Jul 17, 2026 at 10:02 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> Hi Naga,
>>
>> On Fri, Jul 17, 2026 at 8:41 AM Naga Bhavani Akella
>> <naga.akella@oss.qualcomm.com> wrote:
>>>
>>> Replace the unconditional reflector-role GATT_UUID probe in
>>> gatt_client_init() with a reactive registration driven by actual
>>> remote RAS access, using the notification API added in shared/rap.
>>
>> It seems you already have something like that in bt_rap_register
>> attached callback, it is just never used, which explains why
>> rap_attached is never called and you need the likes of probe in order
>> to create rap_data_new.
> 
> In case I wasn't clear, I meant shared/bap.c needs to call
> rap->attached callback whenever a session is connected, just follow
> what was done in the likes of shared/bap.c which does bt_bap_attach ->
> bap->attached, so bt_rap_attach shall probably call rap->attached.
> 
Understood. I will include the requested changes in the next revision.>>
>>> ---
>>>  profiles/ranging/rap.c | 25 +++++++++++++++++++++++++
>>>  1 file changed, 25 insertions(+)
>>>
>>> diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
>>> index 3ffc0da76..4f6d7f2db 100644
>>> --- a/profiles/ranging/rap.c
>>> +++ b/profiles/ranging/rap.c
>>> @@ -308,6 +308,27 @@ static void rap_attached(struct bt_rap *rap, void *user_data)
>>>         rap_data_add(data);
>>>  }
>>>
>>> +static void rap_ras_accessed(struct bt_att *att, void *user_data)
>>> +{
>>> +       struct btd_device *device;
>>> +       struct btd_service *service;
>>> +
>>> +       device = btd_adapter_find_device_by_fd(bt_att_get_fd(att));
>>> +       if (!device) {
>>> +               error("unable to find device for RAS access");
>>> +               return;
>>> +       }
>>> +
>>> +       service = btd_device_get_service(device, GATT_UUID);
>>> +       if (!service) {
>>> +               btd_device_add_uuid(device, GATT_UUID);
>>> +               service = btd_device_get_service(device, GATT_UUID);
>>> +       }
>>> +
>>> +       if (service)
>>> +               service_accept(service, btd_device_is_initiator(device));
>>> +}
>>> +
>>>  enum cs_dict_target {
>>>         CS_TARGET_SETTINGS,
>>>         CS_TARGET_CFG,
>>> @@ -830,6 +851,7 @@ static struct btd_profile rap_profile = {
>>>  };
>>>
>>>  static unsigned int rap_id;
>>> +static unsigned int rap_ras_accessed_id;
>>>
>>>  static int rap_init(void)
>>>  {
>>> @@ -840,6 +862,8 @@ static int rap_init(void)
>>>                 return err;
>>>
>>>         rap_id = bt_rap_register(rap_attached, rap_detached, NULL);
>>> +       rap_ras_accessed_id = bt_rap_ras_accessed_register(rap_ras_accessed,
>>> +                                                                       NULL);
>>>
>>>         return 0;
>>>  }
>>> @@ -848,6 +872,7 @@ static void rap_exit(void)
>>>  {
>>>         btd_profile_unregister(&rap_profile);
>>>         bt_rap_unregister(rap_id);
>>> +       bt_rap_ras_accessed_unregister(rap_ras_accessed_id);
>>>  }
>>>
>>>  BLUETOOTH_PLUGIN_DEFINE(rap, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
>>> --
>>>
>>
>>
>> --
>> Luiz Augusto von Dentz
> 
> 
>
Thanks,
Bhavani 

