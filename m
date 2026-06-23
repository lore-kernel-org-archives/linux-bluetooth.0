Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5C02E5B2A
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 10:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782211691; cv=none; b=r8zLZuT18gqJlUR2fIreDt7PdRXjb/3/ldXe+fnTsZW8LvJjcWLjm1bwtwEkQeZLAe2c/TIJbuu+rzyRqCQ2BLVS0t7d22YGBgGygatA2yhuBpUrIeH8TCFDuadlZWrXfyZxvhkZaVg+j/wAJm9xgQqtlq+2nd5FHQGLetaB2tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782211691; c=relaxed/simple;
	bh=xnN/8QvLP1X1MElPCkZ3aT/2ZO7xrDZDOTBoqCPC+i0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPizbHMkhZjPe+tpS8gl7gg9BwhAm9o6vQ6v1XmcOJUQl196L2vvQxVeTZlLnAOmdnwQ89PzQPuuZkJsNlBC3liz4NBZbdgi8Ria9RyKHjQs/q7DCRD0BlQTCKuNotXUMGUkiNxgA+pRGxn+yBX7+ybH64uskHm6+Lu1uUgxKz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gv4VSbVm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fh1a215M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gv4VSbVm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fh1a215M"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6cfiK2992374
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 10:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yfHADPd3YbiMqVZVRTQ1yGUj997dVMkKh6uX5LLNvXg=; b=gv4VSbVmzNDFWkv6
	H/dTQVYHNbaH7RvBatgF1nK8W5YuN486esIJWfXFWZ9sWx+Gw35rv+l8YFNEQRz6
	gWpnmpmmmYUzq/xY5vODecFvdVHRMt7uPhSW3aIoWmhn6gPWg0vdNT0LnWY0gVDf
	/0GJME8xeG2XWf8XtRx2H8IwNxnwR7OUD3u9+TRJV3OF8kiojxQTza9ZTtP3+tWh
	5ca49x78i07Et1irFhXQ87zmp1CAgaed+ZW4DwP5KsK+W4Dj7gh5k9SiTwxRG9oL
	syBRCA3Ex72U7Wgw7HyZhJokwes1OGmYWwlRqWMtRsr3qQmHQc8p490jbjLAJf6S
	5NK1OA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey729v1sw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 10:48:08 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36b862b27cfso777567a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 03:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782211687; x=1782816487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yfHADPd3YbiMqVZVRTQ1yGUj997dVMkKh6uX5LLNvXg=;
        b=fh1a215MWT7RBItuf5QKl2AMpraXlpFfEGyyAZXM27I3E9os+kGSCHxbxHB+R52pfX
         eil2HlE+KlloFvs9HO6ptR1NoTGbf4allSWKh+1AB5HVnC3HwFrg12NPdjWVPq8CnBsI
         KXzk8igdkfq0SVf9Ch9xRUQQu64fnvFYxHMrxIWJOjyqrDY/KIOUrHdKk0V/Qtbk5hB9
         RU5i1ZaZ2oTXTBBaGtYdkzI0ePem5vIHBcaC/nQSam3xjaBLuayAu6QKSdCuDuyyBINq
         4vh7IwCFTg4WTyxzX5T3hpbeIE1WNBSt/4GVD/WbJgDjm3Ex28rUG08OyYgBzwkZzHMh
         j74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782211687; x=1782816487;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yfHADPd3YbiMqVZVRTQ1yGUj997dVMkKh6uX5LLNvXg=;
        b=ob0Ez93p9d6hJuHKxt82q25lIr3mCeSm12iDtPhu04/oAjflY/WdASi3+tPEgZdfG2
         hkimwgks8HCMHfs29HIcsLH9diVkNz+TND4/QyPXiVsokuLMTCk8VqUGCr5LPqYTWaG/
         Dh6rIMt2LOfR0SuVK78FjwG7tEUthJeZYZlnZj9hm/cHNzaHBAkzf88e8pOBvfkduPjO
         Tm3Ouufs2TwwYYNIrMvWGo/hr7vJmn7CY5MAbwfw+DNv/2xem008h20i/npcM17RD6Wt
         x5hvyKFmJ4bWnAbyV2JU+dTgksSc/4N58GZWaQluKkHu7qmWyVeF/1KjksssyvYVI1BA
         dtNQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp7WT9sak3X/16FnhnhVZh6s5YmmFo9uAze8CkigHlMygqJJGBtX+c/aBjgq4Ihqd9v83INOzNfUMUQA9PTh4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk98LsZGhoEZoBQ9WQwkossPdQNUgStKI7QaNRzqyl3BBj2+yM
	ppRpRaXsvqEZ1hfwf1HqnPD0ZAZ6Co90YzshgZBl2Ws9n1PlT4VKO4HbV3HXsB8R8Q0OjzX6fpO
	xqpFCfbZyfcqdQXc3Y0YwV1yPq1jUxUdwCc0/MN5sQ9obVcBCaRPWCYjSYA+eRIdqo1zsy4M=
X-Gm-Gg: AfdE7clKG4nayJtTq/xyzyX9i9wNjU72fTRQmU2xeaMEtzs/j3+WipVYNo4eTziOAAT
	RbQ8lpaal+KevglOmlh/ne2iOKGNmBH32ZzQQQ0U1v1UAZn2/NiJEgn3JAHplpmdB0uIHozpa0P
	qPTO7iNrFEodvaxLtNA7WIowHrdxao0rpKxQi3APswktWLQCYnglUDJcI+XPvuTENxQrXRtPGoT
	xcjbm5Wm/9JbxMBO/AAOq0JV+Co6O2slTDgevPuPagpBWpXGEFo9MSWR7M7PwG+iEzJ4IVtjmYx
	mk3Q+ofl53Bgja7guFQohqeoaD61hPhBTvYkLAS+joP/Qsl98LnLi/o/QAFXyBfZ5jJGRq1p0b7
	TlvzZncDtllOs13W6gG0TBxhrRoIImn6J9oyKBkn2oNBoTlI8sjLUr7Gjw4aOisKHFdUel0rwew
	a15Q==
X-Received: by 2002:a17:902:c946:b0:2c0:ccdb:e027 with SMTP id d9443c01a7336-2c7bf1ea3e0mr23824445ad.5.1782211687429;
        Tue, 23 Jun 2026 03:48:07 -0700 (PDT)
X-Received: by 2002:a17:902:c946:b0:2c0:ccdb:e027 with SMTP id d9443c01a7336-2c7bf1ea3e0mr23824235ad.5.1782211686935;
        Tue, 23 Jun 2026 03:48:06 -0700 (PDT)
Received: from [10.133.33.161] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436f6395sm107070095ad.28.2026.06.23.03.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 03:48:06 -0700 (PDT)
Message-ID: <4d764907-a3b6-4fd1-8954-8f9b8779c31a@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 18:48:02 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] Bluetooth: hci_sync: Fix return value of
 hci_reset_sync()
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, Zijun Hu <zijun_hu@icloud.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org
References: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com>
 <20260622-bt_bugfix-v1-8-11f936d84e72@oss.qualcomm.com>
 <CABBYNZ+z6XcZXejs18fbX-MSFBmaGC0Reoqn549N-8sn==z2Ug@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <CABBYNZ+z6XcZXejs18fbX-MSFBmaGC0Reoqn549N-8sn==z2Ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA4OCBTYWx0ZWRfXx24x0Zm5WV1d
 OdlTf5PrpjHhR2tg5p4lOCNn1XXlF6Q4dfl26X6VpJ/VEdCJXE+3ysbA9yR+F3DXrM04qcgnRCa
 9YjWXI6d7mpogHIx2fELutJz8hxCA1o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA4OCBTYWx0ZWRfX1dDpRLBHkJC/
 Ts1r2RExE4hlbGYPPVFrCANVMkYRdvGzg/4OSyvrrdY3/Bu5hxlnC6P1vyIGmspahWtSHeLED/l
 LC78r6Zov2TANtQ9o1orrdJaILMvfKvFHfWO3Yqu/BpEvb0+P1TmPVsvvjL/VwvS8BXPaMws2Jl
 n4GSr6+jjH/aQxzkMvIrzU5uGlMmU5vyHRehZJNx6QkB95Pgk6CMSW0+TSDwMXZU6M/WqAT7ZWa
 QjB1hy11AGZpXq0bT7B7ikMcb8/MW0jP+uNG+wPEzkwGE6iYWMKpTXfFsV/A+FIQ37GxVHDiB4r
 +IH5kS7w7L2Ir9Dq8OnQVHjFJpcZ9j0HdJnxi9Ng2tIqC2a6TcaH/5LY4sc55OIgCKb/E3c79E1
 QGmDOQPjo82cCx1+ILGKWlVkOf8vVp/3rOJMScS//tfxt5GVviUZjkjPWxTNkZst7kewOEAC1DZ
 LG8kTYJ4fLtklYq1OmQ==
X-Proofpoint-ORIG-GUID: SEi9XceaerEco0qgNsgkQ7Leru8TISAK
X-Proofpoint-GUID: SEi9XceaerEco0qgNsgkQ7Leru8TISAK
X-Authority-Analysis: v=2.4 cv=eN0jSnp1 c=1 sm=1 tr=0 ts=6a3a6468 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=gI2jydi3O7-V3eHH3HoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230088

On 6/22/2026 11:35 PM, Luiz Augusto von Dentz wrote:
>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>> index fce9f9526cb5..601d44ef975f 100644
>> --- a/net/bluetooth/hci_sync.c
>> +++ b/net/bluetooth/hci_sync.c
>> @@ -3678,8 +3678,10 @@ int hci_reset_sync(struct hci_dev *hdev)
>>
>>         err = __hci_cmd_sync_status(hdev, HCI_OP_RESET, 0, NULL,
>>                                     HCI_CMD_TIMEOUT);
>> +       if (err < 0)
>> +               return err;
>>
>> -       return err;
>> +       return -bt_to_errno(err);
>>  }
> There seem to be 2 consecutive changes to hci_reset_sync that conflict
> with each other, also the expectation should be that positive errors
> are HCI errors and negative errors are stack generated ones, so the
> callers should really check `err` and not `err < 0`.

  Hi Luiz,

  Checking the full call chains:

  - hci_reset_sync() → hci_init0_sync() [if (err)] → hci_unconf_init_sync() [if (err < 0)]
  - hci_reset_sync() → hci_init1_sync() [if (err)] → hci_init_sync() [if (err < 0)]

  A positive HCI status from hci_reset_sync() propagates through
  hci_init0_sync()/hci_init1_sync() but is then silently ignored by
  hci_unconf_init_sync()/hci_init_sync() due to their if (err < 0)
  checks.

  Will not change hci_reset_sync(). Any suggestion on how to fix it?

