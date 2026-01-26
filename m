Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286242DB7A0
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769444427; cv=none; b=qyI7ZZaLWE2WbIxXpiXoQGwWJOGuZOE+GUk+E4qnwqaofAQ/kQNqf6Bq3nVNgTDOIJeaCDjEVZ1EKGbOle+E2C/MQdq0+8aebXyC4n1v8QCBWFNlPqZslkDA5shjKHHQ0h5qGpkHz15CVXIPPsjbfk+hAtm6zr69kJHF5AKlr7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769444427; c=relaxed/simple;
	bh=/smmK47PbQdFJDsC3KMabDwT9Chn1G7CNVgPaLL8ero=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RNcV/dguDIvh9Fk4SW8IXVIv0Q58J1P/2DL1YhfeIJEfQIf8uGREfhM2661bIkaZ5YbXWDHsj57cqKYkfuIeN2jUdShQ3fXBoR7VbhxqwqOSD4NxDqP60kqO/1C/N4TzTw3ayDjXzTTpwBRW7Id7dKKTLaf4cf1js2YW4s/1PxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UqPBRpPW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tu0Bdt9E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UqPBRpPW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tu0Bdt9E"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q870L33858096
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 16:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R9oU0cU0iS8ibF/AIo3DwOSofwYBcrbGsmjI9pc38KA=; b=UqPBRpPW8XGQt49x
	4nIs/1BBmM+U2ngGKmcePq9aSkKRk7VPXclXdEol5IVW+gvLlx7uXFBOHS8wyBTR
	QZ+2qCboj50YCXLxLzfxnlEGQO03jeO+x5cNC5FAIcPmdMcX5/kASXmXwL337y2h
	FxjsxU83dNqB9bskqKoBLHHrn85AwjhZlDzGCXRHCXaX58afrKwnY3GjUUZXfmN/
	uNBbukNw4AqOhU6wpyVE9PjXgJudtHmWPUnotKyu6yZGYxjMGUHMZMITdCQtdtJD
	Q6lwAxgCLfcIhZR88iM7qx578wcGtkW4SC8tzI7KYnEs0tMPLU1WL8U2s/8WFH3h
	9buUSg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvq6xw30r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 16:20:25 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b704019c98so4709600eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 08:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769444424; x=1770049224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R9oU0cU0iS8ibF/AIo3DwOSofwYBcrbGsmjI9pc38KA=;
        b=Tu0Bdt9E6yKeT87v5arFoTDV9+E8bKKJIfsOf5FAIycu01MqXyvgtq/6LyweYkQTH9
         TO/ysLkdliNEslpSxbJN0G/RDyhVpq5A8baQEOfMlJWU644+Id597YFIHGWhENkXrjxv
         GU9GGEKbsMKjfc33I8cs+TwgUwWb01kXbYkog8MduhA3VX5RdlcEIODdIQoQn1sb+qfA
         fGIvCETeMXhGU6E/ymqgk8KTwAfbkVBS7OsV/I6Ugo85ZeJOqJWBMRApBD+Q5nknoOJP
         bL3pBCto7Kq/kAimllYnQdWgOTBcZKczGaUGRRU3x3crbpgxmd2ZVw97jBhxxbg+0/1M
         4Mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769444424; x=1770049224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R9oU0cU0iS8ibF/AIo3DwOSofwYBcrbGsmjI9pc38KA=;
        b=ehGusAesktW/nDp0uZpA6tqaX07FOjMTFn9IPqVKdECI4OMjjt4CjXeK/k2DZ3Upyr
         tWp7nCHQfRFtFxtGI25xAbvDt6HJV/YpyFuz2y3xBfQ3tEu1wKdbNPfUH0tP8nKseoAD
         FRnkRhyFXJeNcMmqCZGMzB8sBAdW7/doPcVli4ZpCfAbV1hqMl5hjjAevC4YEHQXJ6ev
         9XyXhHunAnPvAejuiLiR46wTti4+/cHcKZjk4J4FMf3OZZBGcOQ8dcA+SZaomlbdNhuo
         50rEKjI2Z8uEhMdgODM7rYLtNx4r0u2q3mUwJK9Z5NnxMxj37IY/VbxzvwlaNf0iiRmr
         XwRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMmJ0lMONfAF8WxapVPBem3UiffvUbxnDMQxnNwospOWX0FYKeOm+bJkrEeog3SVgdQcp1tJXKWo+ZPO8NFRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFBbA00GnHVUgv1qMdczPTcZtjmQn13WiPgLZGM1I0s1kSBpU3
	DQ1o6QaRYxtphS491qyn5tVK2Mem1zbpZpdPy/titXROpM4+5VRzrJ0wCWzyi9en3fHwF4+lV9v
	dVqsd2J7Xh8v/SRQYy8+XM9rNJiPxCbTtF66NTQyjuhWeZtuiN2+mesJ/p8uU/gjmx8Zf6qU=
X-Gm-Gg: AZuq6aIbmmkS+yw88HMRBuZtOuXYTu4I6WC4GO+7thiS7iZGeWT429Vi6+k+1dkM+Ww
	8G1eCh6hzMAfeTm7uob3bH7W6R5WQJfhYjldZTU1OB4fQx+Vouo9qjWoeUPkysNOG+SBxLraNDM
	gadFo87ixry5TLy5StmStmvhHuZtehtxcM42mmlHPegIaZpiKQRNbL5Rnd8kkrWWpsXOu83d7HC
	+cGDhu/9Sj04UXQ8iHwM5AQTPt1NTtozOtyMdcJSKb/u+dLTpyb4szXyFcNkQg518BEaacNhZAM
	LfFbRZc4OplX7uNnwFnooRDHuu0xujVKuN+m5QF6r3UcVWVgDt0swDqnsBNB/BCrFvN8biyU3JD
	Ep4jHUypL+UvPKxhhvaP3UHyCMoA0PgSTCv/7/xZsfuerHaq6hKz2pC+4DNRHDLM=
X-Received: by 2002:a05:7301:3d0a:b0:2ae:55f0:f2be with SMTP id 5a478bee46e88-2b764525c08mr2618047eec.31.1769444424177;
        Mon, 26 Jan 2026 08:20:24 -0800 (PST)
X-Received: by 2002:a05:7301:3d0a:b0:2ae:55f0:f2be with SMTP id 5a478bee46e88-2b764525c08mr2618024eec.31.1769444423478;
        Mon, 26 Jan 2026 08:20:23 -0800 (PST)
Received: from [10.110.37.82] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa08964sm13801267eec.28.2026.01.26.08.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 08:20:22 -0800 (PST)
Message-ID: <5b62b672-d6fe-42e1-bf31-15ec16ed7d3d@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 00:20:15 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Bluetooth: hci_qca: Refactor HFP hardware offload
 capability handling
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuai.zhang@oss.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com,
        wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com
References: <20260123055243.2634107-1-mengshi.wu@oss.qualcomm.com>
 <20260123055243.2634107-2-mengshi.wu@oss.qualcomm.com>
 <mt4j2cxliqkwbeprt7ye2kt2cgi2bjfnz2knfgxvy7fy6wda3p@jadb7x7ocagi>
Content-Language: en-US
From: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
In-Reply-To: <mt4j2cxliqkwbeprt7ye2kt2cgi2bjfnz2knfgxvy7fy6wda3p@jadb7x7ocagi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kiUCnJU8WkNGfjnnpg7KifLjQS-tOiqO
X-Proofpoint-ORIG-GUID: kiUCnJU8WkNGfjnnpg7KifLjQS-tOiqO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDEzNiBTYWx0ZWRfX3FgxAsmx7cRe
 lw07slUXbro6/dTuOfXcsob1TTMLEqhpnfv9E5xZ9ypQfnVpFndRoYieTD8LmpdwBwceTYnPXWi
 8B2+xQV4wVtB3vvi7fiXKHTuRCWV11x8NJBiy2tf/tKmPMPOJA2PmyXG9ZWNxR9zPMHOvIbdW20
 H86BTHCANRO70f+sonSMXEKVbX2zfeZQpdxFlFbuCNgV3N1WkmgDMB1SAhBaeC9/S0+jNLAhhIr
 mn9AylHWXLHR3yyKqR9ujh++IHVNW3o9WePVuTdqpf6i34Bvcg8rIljRF3lYoZGZ8Iwq6rCLQju
 dZgN90cXtq/WhAJTEh/ee7gbpG/Rx2hpgVC4YF6ezfg5rz1NMuw7c7yyCxhfDYGSmmQ9wnd9Ipm
 oWxBafNEgsyZx8zNJO0XK54qSBlz9Ji4Vze6WsbmvLsZsn3z3C8KvS1Qf7Qt163IQcNlgmrun8n
 prhq7yuzhdSu/Yv97Ew==
X-Authority-Analysis: v=2.4 cv=Htd72kTS c=1 sm=1 tr=0 ts=69779449 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=lmeFXj1VSAwbam4jTmcA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_03,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260136

Hi,

On 1/24/2026 3:26 AM, Dmitry Baryshkov wrote:
> On Fri, Jan 23, 2026 at 01:52:42PM +0800, Mengshi Wu wrote:
>> Replace SoC-specific check with capability-based approach for HFP
>> hardware offload configuration. Add QCA_CAP_HFP_HW_OFFLOAD capability
>> flag and support_hfp_hw_offload field to qca_serdev structure.
>>
>> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
>> ---
>>  drivers/bluetooth/hci_qca.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> @@ -2033,7 +2034,7 @@ static int qca_setup(struct hci_uart *hu)
>>  	else
>>  		hu->hdev->set_bdaddr = qca_set_bdaddr;
>>  
>> -	if (soc_type == QCA_QCA2066)
>> +	if (qcadev->support_hfp_hw_offload)
> 
> At this point QCA2066 becomes broken until the next commit. This is not
> a proper way to do things. At the very least, squash the first chunk of
> your next commit into this patch.

Thanks for comments. I will fix this.

> 
>>  		qca_configure_hfp_offload(hdev);
>>  
>>  	qca->fw_version = le16_to_cpu(ver.patch_ver);
>> @@ -2502,6 +2503,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>  
>>  		if (!(data->capabilities & QCA_CAP_VALID_LE_STATES))
>>  			hci_set_quirk(hdev, HCI_QUIRK_BROKEN_LE_STATES);
>> +
>> +		if (data->capabilities & QCA_CAP_HFP_HW_OFFLOAD)
>> +			qcadev->support_hfp_hw_offload = true;
>>  	}
>>  
>>  	return 0;
>> -- 
>> 2.34.1
>>
> 

--
Best regards,
Mengshi Wu
