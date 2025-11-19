Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A7F32C943
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763539153; cv=none; b=WGbvYU8xnPcO9T/y5H2LGgloZFyYF87JNm+v2xTJRiyXhuY2aZe11Zkl0r8rW7h8YZmh6S6CfaTIEKHnUkEkFP8XdMwsrGnvfaEcWwB83U6exX7JWuvln31LOKreAwLQqn3MKE8tTm4X6+l9hkzzeuzPCrCLXRsnU1H5Vi5iOQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763539153; c=relaxed/simple;
	bh=dV3Q0DRa8tyN+wiG5YRkYxgt/oFeaoSIkYOJmzbNAqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHGQxhtW6DX6yuvQbA/oImlTPJeLOrd66+4DoBysauel/5GQGMX8cpWZh5IN4yqOCsCD/o0aLOF0zQaWzqoNQqf8gUVn9JpGd9IdIgZgLtoIuUgtcO8fkHqPE/iqGXd1XczpA4uOdX0NVf9uBfJB4OSJLByQsWUFeEo+OWcID9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mDAoEjFH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YbsJYjVk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mDAoEjFH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YbsJYjVk"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AINt86B2755265
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 07:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=44+KIwf2R3TeV89cdtUmgfWq
	aMXOew3MykEPItSc6d0=; b=mDAoEjFH3LiqB4Pp0QFiPTYuCZZwE81dG0ua7Ob1
	NJWts0WDIYOVWqJpJfEbBK7PoFnJXtgkr3b5vtD18AuhLowbdzUKfuA8L888/ZIP
	ycGOWRolhhocvJembD/5XDVMMFQl591yptUNorYDY61HYh1wJENS8Nxa3aOnUc5p
	aRzcdIftJ1LgIyS9sQvxtzPL1fj5YinVXdLIRe2xpIy1jqBsTteR8T8JggFq7Orm
	PWhbyVS6y9DP/7IISgiWQy10JzZxTiQZzcCz7TmUGYuo30xO7QDITlqEZqxTEDQO
	v/UWhOzI1mGJDRYLSpon6hSk6KkDqGqspBrX7+W3CPbbFA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agnkj3qb9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 07:59:08 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed6855557aso15697691cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 23:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763539148; x=1764143948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=44+KIwf2R3TeV89cdtUmgfWqaMXOew3MykEPItSc6d0=;
        b=YbsJYjVkCVz1wknKit4Dx2YmGxBY2G8PjxKoi71uOD5pOj6bMt5/h1RGhBv7rVVEMC
         6beda5x1rMtFnzTzqSLsesio5mgyWBxx6GGo54q59uIMzRbZm9CMIextZH0QnhJM+rMn
         ISxNZLnu5rFz3dcAt0fCcszmT8zxbtpN/brFFV5KWoT4dvNEzsh2zMCoaMlD/uE4wghz
         nC2sfbSdOV2EZB0z6ypeaVySK05/CzGQiyGFjyZ2344xa/SYpf1lvO+VhYHQKiZPl6zH
         34UI/dW29bMeVuf164N9OGcM2n+ZQOOxAY+7f9GBhZte16oZzNbd9WLfNbv2aSpXEblm
         wKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763539148; x=1764143948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44+KIwf2R3TeV89cdtUmgfWqaMXOew3MykEPItSc6d0=;
        b=v4llONWcowkUcl5lAYUgdRZhLhy9NnkrZDaXoeLbSHZHiLphE3u9Mcr7Z+n4XN4tV9
         43RHvM6zhMACQrxbtD0NAtTCN3tm6Y3hCA3gItWQpFyXvsV8Rj8K9hUpsJeMjkbsEaZr
         UyCwwMrvDS9Y6z3H74xLvpn8YIgakWr10urE9cVYckuKNq2RUzpLSwsjNlWHYsQPagzD
         DiMvabp59xvsLUh+kme7e6NlQ3J9oPYNaeXVQ727bTx02kTO7aGioM1a3It3h5fs+Poo
         FkhnCM95pC+LaRj8Da6ODrY7L4Zzh44t1XG3yqXwBVrnNNYsDpVjTS8HcS1h45c27Qoc
         qDZg==
X-Forwarded-Encrypted: i=1; AJvYcCWpVzg0XSLOaFeOkVl7Ti02BxxQ6FCqTO1MWhVBnUWSyemEAwxiDYL+m73C086m2WinkYR7plxsdpCJbjf1vW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmjnlMEQ3BgaLj7KSgPMQ5neqp6XjFJf0hWTD0U7hyt9nTj/In
	VTM13zcHhcs08Lj0bZNJPGzb2lgonnmWpznfNu0mw9KQMtP9YSuuvqVa32Nkuabz711aR1trOX2
	rT8bkCEt7qAfVhHPTw6nIvAtxsUZfDDUcYoAo1Uug3ugNoSG/Fs+qNaVmzSdww7cGdnoviZ0=
X-Gm-Gg: ASbGnculVk6FHtVYGmca7MkFMd0TQu5ld5CXz6y2ADIdsMqCXs3ydajtJJ8w1sJk/3z
	3WMri7RQHo6yetJ0Vlc47HgbqfHnC1r8Po77qaI1Kqg0PqYrGQZaxLPVKeJn3tisnPPUZuPZKLB
	w4ZS4SNtDnCJl1NheSmGoUsUXon0FO4LbMQuNjDs9oS5RvFqDK+6IoJrcDMLzn50JfNoIIGwX2/
	4J4FU2Fpo8Xudpzm369rO9YEiWBX4qGGP6B3hZdQOCw0lZjELmFtc7ynnPh4T076N/DqqEXm6xP
	sUVA8lD6eZQnkudwGG5/mBoK3KIAikQ1pnukFN6KefoT/zw5N91zOgGRykmcZAbM2Vqtq9oARwM
	thHE30kpvEwmIm+5NrYo2UpG3AXCi8sCZ7hYR42IDQHgo+0/SmDzHd95OmEW1hclVG4dCl4feA/
	Ckz9gSiwQcuvM9qoLYDN97qsY=
X-Received: by 2002:a05:622a:553:b0:4ee:1ec6:aeda with SMTP id d75a77b69052e-4ee3feaf8e0mr17483541cf.34.1763539148319;
        Tue, 18 Nov 2025 23:59:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQApdlupVqitt5HGqNbjJliqmLaffp2PONvxt3K6V35Eywo4YeyIe4ki3/9Q8VxUTrX7nb9Q==
X-Received: by 2002:a05:622a:553:b0:4ee:1ec6:aeda with SMTP id d75a77b69052e-4ee3feaf8e0mr17483371cf.34.1763539147874;
        Tue, 18 Nov 2025 23:59:07 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-595803ac919sm4545176e87.17.2025.11.18.23.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:59:07 -0800 (PST)
Date: Wed, 19 Nov 2025 09:59:05 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com
Subject: Re: [PATCH v3 1/1] Bluetooth: btqca: Add WCN6855 firmware priority
 selection feature
Message-ID: <mtp3qxngbnlpzk2cdp45ndtecab2h56ocwm6cp5ia7butra55a@bevidj6vdwzj>
References: <20251117021645.712753-1-shuai.zhang@oss.qualcomm.com>
 <20251117021645.712753-2-shuai.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117021645.712753-2-shuai.zhang@oss.qualcomm.com>
X-Proofpoint-GUID: Q2BNYthz3Ehg3gggxV54g0A8J9m69ATw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDA2MCBTYWx0ZWRfX4s8+WzKD7Zdp
 P4j7HUMW+FqRbHNBuXAQ9FnP81zh4aiaMV4oQ78NIm2ENpJ5k17MYUMUtXf1L/Iyk/oNKDgvac0
 MbA69mp1ugT4UFoY6DGjDwo5s/Fv+lzuhS4JDh6QC90ucMxcSUcMoQ/T+uVuVDO4MDB08WmUVZL
 NiFHF17tVR3kD6dU1Pho5qVBL6fzKpzErZvoOb9ENiV40r7b9ZyMrlUZwjYjvy1Je9HyoansF2w
 bDa8DhlfERFcfAVoe5x8DPvrtz+BCdy7U2Nj6CTBzTuWdQxLdlI9lV6DzDzsozkGGaSLmvZnMes
 xUYvgi1fFA/6ItgrOVTGWCKcoC2xJ3E/cfomVlCsQnzVyPb9RSSpM39n6AQt+bLyJdiWqhxRxN2
 AbrDyS6aNR/rbfe8LdfWtNT9EdA+Hw==
X-Authority-Analysis: v=2.4 cv=cs+WUl4i c=1 sm=1 tr=0 ts=691d78cc cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=61MPlS98zIQgpKPuyUcA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: Q2BNYthz3Ehg3gggxV54g0A8J9m69ATw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511190060

On Mon, Nov 17, 2025 at 10:16:45AM +0800, Shuai Zhang wrote:
> Historically, WCN685x and QCA2066 shared the same firmware files.
> Now, changes are planned for the firmware that will make it incompatible
> with QCA2066, so a new firmware name is required for WCN685x.
> 
> Test Steps:
>  - Boot device
>  - Check the BTFW loading status via dmesg
> 
> Sanity pass and Test Log:
> QCA Downloading qca/wcnhpbftfw21.tlv
> Direct firmware load for qca/wcnhpbftfw21.tlv failed with error -2
> QCA Downloading qca/hpbftfw21.tlv
> 
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 7c958d606..8e0004ef7 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -847,8 +847,12 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  				 "qca/msbtfw%02x.mbn", rom_ver);
>  			break;
>  		case QCA_WCN6855:
> +			/* Due to historical reasons, WCN685x chip has been using firmware
> +			 * without the "wcn" prefix. The mapping between the chip and its
> +			 * corresponding firmware has now been corrected.
> +			 */
>  			snprintf(config.fwname, sizeof(config.fwname),
> -				 "qca/hpbtfw%02x.tlv", rom_ver);
> +				 "qca/wcnhpbtfw%02x.tlv", rom_ver);
>  			break;
>  		case QCA_WCN7850:
>  			snprintf(config.fwname, sizeof(config.fwname),
> @@ -861,6 +865,13 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	}
>  
>  	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
> +
> +	if (!rampatch_name && err < 0 && soc_type == QCA_WCN6855) {
> +		snprintf(config.fwname, sizeof(config.fwname),
> +			 "qca/hpbtfw%02x.tlv", rom_ver);
> +		err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
> +	}

Is there a reason for ignoring how it was done already for other cases when
we need a similar fallback? Please extend the existing code (or rewrite
it) instead of adding a similar hook at a completely different place.

> +
>  	if (err < 0) {
>  		bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
>  		return err;
> @@ -923,7 +934,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  		case QCA_WCN6855:
>  			qca_read_fw_board_id(hdev, &boardid);
>  			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
> -						  "hpnv", soc_type, ver, rom_ver, boardid);
> +						  "wcnhpnv", soc_type, ver, rom_ver, boardid);
>  			break;
>  		case QCA_WCN7850:
>  			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
> @@ -936,6 +947,13 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	}
>  
>  	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
> +
> +	if (!firmware_name && err < 0 && soc_type == QCA_WCN6855) {
> +		qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
> +					  "hpnv", soc_type, ver, rom_ver, boardid);
> +		err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
> +	}
> +
>  	if (err < 0) {
>  		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
>  		return err;
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
