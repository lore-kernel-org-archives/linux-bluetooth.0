Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05711F4C8E
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670656; cv=none; b=X/l6mB7+37YpGlY4oAIPCc1hQwXGVLv5S6d3ST76rwnxe+88jyToTiWFbnu37cHPjoYlv1b1F5Ot2k0B5M7EkfK3iJEtZ/ONo8yHMkaGOBbeXZ//RN1bXNCeui69guOiwiNSPJq7fbb0sfwCNatvP8R3dHu3Sz+lmKiMETpRSZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670656; c=relaxed/simple;
	bh=sQcuamK2+awSRDESFFKbrhanPd1dWv8v0lyezG99h1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKAi2SnxMFQcXTFNbpeVa5wobedoLeBDNkSx4AixEXZ8s1ArGEPed5lyTiz+ZL124wbA013tx/cK48egV15H5osKAmLP3+G8DMg7MAWZcLQOUQtFG3p4WLH6okWWV8Koy9xUKngee+GwEjVaZl7X7fqP32HNfgHmt9llNW1jnek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SAqpgwYU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZnuR0Ek5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SAqpgwYU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZnuR0Ek5"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SEnccH1865808
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 16:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YYkj+iJzcJ7SpBqMq32UWLhN
	k8gutYq0DL5v9oW2oqQ=; b=SAqpgwYUc3zjk6u1uEABqy520OWkq1amsKuYoNmI
	XVSyCNxdU1M8GtOVGQTRxNEZwUxOE6vZujneS9LxSILX0hota84oGtqJ/nION0y7
	sEw5mgdh+N4Z0N20kBDmltrlhZhNBI+lTiOZTTmiuBOvfB8ZkPDkw8UA/Y5c6OZb
	V9eNhJ6FsI3dU7yVZ6bdFwKstDFYbKE6/0N0q315ycOHhE6RXMbiwyLrkH7VfHDS
	s4k905+HQnUAqNz9BQYdcw7qTrQ+3hdgKZ87tMujOQml3COJi+yg0CbQpj+GGBoc
	HRu3MqIIP/ZplpWT559hdN5E88ugOlx1Y2wF5L4jk7ffew==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2wsprw31-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 16:57:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4eceefa36d0so98861571cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761670653; x=1762275453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YYkj+iJzcJ7SpBqMq32UWLhNk8gutYq0DL5v9oW2oqQ=;
        b=ZnuR0Ek5KWeOfPibw0tbaLpfFkTS/j0YbaIdwd0Qt2no4z+osXxkDL1sm2QGGE7z1W
         nS+blK2VzzAey3viBPS4xjByikLiPdQll9KsDx/SPYBZj2BRdw5gnEFeFnGnvu6eGq+O
         PT+wtlR/pN0JKhBRJe1FivUy+O69fD2zFGLb1fo2NB6UFbmqhr/LesYez0gbc/flI0RT
         mCdNdjjgOwaDRzG9cpevu16GljBWyLGzAm541NeHqxKy8gG5GE/eToiOkUV2XvRGCr/T
         j6d5zWzR9f9Kw1wTj4enemEI1dUMkZc24Io0eaZQQdKBgvNMa1VDbca9pKGpBP5P5gXP
         NtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761670653; x=1762275453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYkj+iJzcJ7SpBqMq32UWLhNk8gutYq0DL5v9oW2oqQ=;
        b=U/IlnFdNvyd/MAS4MYR8oMx+YnZdpei4APQ7A2u+8+tsjTcHj15UzO+I9uFvgrV2LY
         IZ3H6dpi3Q0IcSImAwApslMA9pXtxfi8e8CoJ/S1Tms3YcDrpnPob3Rb7WzumMEZwOLM
         dK5p4FuYy+fJg7Ubn3hYdnaWrCv0bORltorflD1RERQEPUke5v3vaTpSNklLazTrXbdJ
         RS82VKMYc8mOv73whB5rkUNQ7L8BEEBAyoIQ+83YuT0XT6mIMgHyHq/NFsmP8AvBdztC
         oLEUK+3JMHPXMu7od4Vl5BVC8zCIZGwzB8hpP225R+gsoulR014wn2EP6tbsDyOkqcw6
         lnMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKsTBDBfNPXqfydfxLhTfY4kTbxi4S/lqtywd9VXJPTDanH0xG81qLqh4iViGz1Z0YPbVfij/4jwjmEFxTW9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyxWfKjQ8qNyMqwOvPTDV5oXjL0qTYAm5FYulsm02hrj36JhwO
	4smUjQle1Lk3SWCX6Ma8j9kclwH0HQt8bhjrcZ96TBPoyPlW1A+Kvc+yCjLfQb1TiZMzO1TMoeh
	KYjfohXwZEWSwGRAZBiSGcgf1F+8JYrnsFIgYcBKuV8IYo/PNilVeSMjLSsvJUXh6nqUz/js=
X-Gm-Gg: ASbGncvx48BL3gY20hwuXIVdDtYslS88mfFB1aPHsGY+OzKtXGjxbtJSw0202bW7ooa
	CmIEdLZkrIJNuOJ/s6AA/VfOyHltfcLsIrBSBUmUWqwj8Cge4nVJ0YcYbULWSmCu9Zy1yyvlR0g
	AplJ0ihDKWDdMzebP6tRvqTPNIYwhDcGgn2hSjLoSlO+Czje3olABFFooW2m5JvRY4X96b59FzM
	lQZHTjlxQhM5Y9AkZ3BmJNKuicQWSp4XsU4UiGz39p7kLEDLBWhDxnujz4gSIM1FbW8Gzuvqclb
	E3xHst/7XztnouqNfAvtYD/yQdCcddjdzM2FNbWQQ5wJthkaQspSuYu7EtoQ9oPZ69ahFameaaW
	CT9pdbD1Pk6sX79qL4rA0lldTwVMsw1/F820BR81x6lIwfmg4nJkdDvSFPsw4Vy48nTcEXl0Sam
	sJk61GyzoRv1v7
X-Received: by 2002:a05:622a:5c9b:b0:4e8:afdb:6f56 with SMTP id d75a77b69052e-4ed1509426emr4337551cf.74.1761670653077;
        Tue, 28 Oct 2025 09:57:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFjwC9xxcgo4Q0PgTNGfYV9nhPktWWK4tZNjpIa3klhG4u7NhRCwCj9sGWBrtzYDgjAEemnQ==
X-Received: by 2002:a05:622a:5c9b:b0:4e8:afdb:6f56 with SMTP id d75a77b69052e-4ed1509426emr4337191cf.74.1761670652636;
        Tue, 28 Oct 2025 09:57:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f482fdsm3125844e87.31.2025.10.28.09.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:57:31 -0700 (PDT)
Date: Tue, 28 Oct 2025 18:57:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
        stable@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chejiang@quicinc.com
Subject: Re: [PATCH v1] Bluetooth: btusb: add default nvm file
Message-ID: <3fluuwp2gxkc7ev5ddd2y5niga3tn77bxb6ojbpaoblbufepek@owcrah4exoky>
References: <20251028120550.2225434-1-quic_shuaz@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028120550.2225434-1-quic_shuaz@quicinc.com>
X-Proofpoint-GUID: pr_VONzpP0EUC6z_bljEtwg2xZ02Azyh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE0MyBTYWx0ZWRfXyXlFJ35E3lKx
 be+3WvdR5SoBa+eLojnS6yF4e5ZzXMjmIT9iWoZimzy45PWH7x+6/DFKyNyJROLuwQcCI3FD1+X
 VkmapnYAGebym4xX//JfAlqkKucJRAtsGRUChg5ds0IzYGW8ByNctSLy4AfcWAcD+KvUXZMTrkW
 hsJ0NTnXBRz2SaDG2q8K0EMlTGEqWHXeOvT9Eg1i+ggPOFO7WempSojIQQmV1DgF2azdoNZL3iw
 2hWMSmEe6HvztB41XmXvs4AoWxAejl5vTxJUVaAHLrWibWGii+qoC0wS3zV0fMU/7ZCcVGNsJKl
 ez70Ly61Rq10NNi5P2ZwJdeGGXGJe53oqhVNHjRDEzprx25dYMPomSSGSJ4qWAovsxZbObvNpKT
 e3keFn956VCMdiGL3qDOKKSV1r8LJQ==
X-Authority-Analysis: v=2.4 cv=aIj9aL9m c=1 sm=1 tr=0 ts=6900f5fd cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=_esQDi1y6y9LiqYhBzgA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: pr_VONzpP0EUC6z_bljEtwg2xZ02Azyh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280143

On Tue, Oct 28, 2025 at 08:05:50PM +0800, Shuai Zhang wrote:
> If no NVM file matches the board_id, load the default NVM file.
> 
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  drivers/bluetooth/btusb.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index dcbff7641..998dfd455 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3482,15 +3482,14 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
>  }
>  
>  static void btusb_generate_qca_nvm_name(char *fwname, size_t max_size,
> -					const struct qca_version *ver)
> +					const struct qca_version *ver,
> +					u16 board_id)
>  {
>  	u32 rom_version = le32_to_cpu(ver->rom_version);
>  	const char *variant, *fw_subdir;
>  	int len;
> -	u16 board_id;
>  
>  	fw_subdir = qca_get_fw_subdirectory(ver);
> -	board_id = qca_extract_board_id(ver);
>  
>  	switch (le32_to_cpu(ver->ram_version)) {
>  	case WCN6855_2_0_RAM_VERSION_GF:
> @@ -3522,13 +3521,25 @@ static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
>  	const struct firmware *fw;
>  	char fwname[80];
>  	int err;
> +	u16 board_id = 0;
>  
> -	btusb_generate_qca_nvm_name(fwname, sizeof(fwname), ver);
> +	board_id = qca_extract_board_id(ver);
>  
> +retry:
> +	btusb_generate_qca_nvm_name(fwname, sizeof(fwname), ver, board_id);
>  	err = request_firmware(&fw, fwname, &hdev->dev);
>  	if (err) {
> +		if (err == -EINVAL) {
> +			bt_dev_err(hdev, "QCOM BT firmware file request failed (%d)", err);
> +			return err;
> +		}
> +
>  		bt_dev_err(hdev, "failed to request NVM file: %s (%d)",
>  			   fwname, err);
> +		if (err == -ENOENT && board_id != 0) {
> +			board_id = 0;
> +			goto retry;
> +		}

I'd rather see here:

  } else {
	bt_dev_err(hdev, "QCOM BT firmware file request failed (%d)", err);
	return err;
  }

>  		return err;
>  	}
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
