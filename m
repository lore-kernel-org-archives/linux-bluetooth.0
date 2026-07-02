Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A64386450
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 12:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994496; cv=none; b=XeEgL78qjAYxPe6AwP9DWemgyuEbFdXF0Xd+PY4vunuGlJTa+sIBzMApUjVEMr3Da6ZEy2aWIGPQtK4ZY/593uC+G9CH3Jgvt6rnSwV+3kk7O47zlLqyZaiXz84/2ZtsYFTY6V9FU14DIU629cWBVWd7hjyHOfy7ZtF/POpT2ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994496; c=relaxed/simple;
	bh=3mmx+/0sXAdWT+pakhHyX3kTBrQwKkeYxwkz9M2nEYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJdyRPtyAxwXApQz7KsZACvgXb+O1GxkDkKERhuiuPtI94mpdMwLCPJSpOQjcK/rA/hTdQswMeO/pTbEBKX9HUFbsuuUYd3BvkmGwI4IQ/SbSJd48uE3T7dwT+Qave2pIgF1HWQvb8u9snJtCkURAduv0HkfQRSXAxGXqeaawCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Eklqlkdk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kGc+VJ8C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Eklqlkdk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kGc+VJ8C"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6627TsrF3964218
	for <linux-bluetooth@vger.kernel.org>; Thu, 2 Jul 2026 12:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zm20ylCeMzuZiz3s/y5e/wk5
	Pyn0IY6ZLPEKM9fU5YE=; b=EklqlkdkxONpR0ssH8uNTgSBlMOWyb7qIXEVdKze
	tOTnf/GGrpmP7faX6K6FJMtJhVhsazQRM07+nFw6XnY5Rp8voe1/WC5w67qG41AU
	Ye2T3Og026cHn0LN4YASci+ZjzTJzTIN0h/1Y9/CXuzP/KYTyHgOu4RnGwsh5ZLi
	ZpVY+YZBRfxVTcBRBGDbDg8TKFVdt7oWbjiFq5jBFS9U2MSHTbK9354u+6HThI81
	WJJDl1e7PkeWHdvMDYFJxsp3h5L9lsCiMHv7264ucXy3LAXmyWTHY1R1xkOPkcb2
	RdC89JYeALQJvpOBxrfQsdyTSywoKJHoTXo4yYc9E66RbA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5knc13m7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 12:14:54 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-969289fca9dso368878241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 05:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782994493; x=1783599293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zm20ylCeMzuZiz3s/y5e/wk5Pyn0IY6ZLPEKM9fU5YE=;
        b=kGc+VJ8C/QhXZ9xObaTi8QGSmoncLciXvujqqSoqLXJ86DYu8HudvaV90wntNvGQ6B
         EoC6CEHdTcq0nznU+OkEmts9dDaF6AAFyWmwwSlaD+7QMDA5pcD3qR55T14LJdUkp/g1
         6dlt6EmEAPBk5aDkAXtZbZKEs0BGbnr/PrjHamh/Y/CqUzIjHoOAOfdWNKu1Fj4VJ+c5
         8UXMfZQ6EGFGLefCjtPfup8jQvve0n+uWGrrwIjlf/lt5gPIYXpwQQLvtjtT0+3iS8g0
         ri2FbRfsDCWq4hLsVxJ5lCqaYgsvNkHzXVojnPGfrtL8uIlNgicQ6xvmnhsddGTc/GFG
         7loA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782994493; x=1783599293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zm20ylCeMzuZiz3s/y5e/wk5Pyn0IY6ZLPEKM9fU5YE=;
        b=Q56HrOsiOYobKhCbfnJn5nz6VhocvWlh45S3a1mlLrLWaXcwPGLvI7gS+2pDPx2VP8
         15ttop11kZZegWrC7n0RX4AERlaKXUfFzGRDIs5BkdFeELT5HR8MYGoULf8K0Gj2ym6U
         4IQ3mzAKpmYysmxnWw8Cg0trovbitSqWP20aTcHg4kVuqVzLguZ/2GGs0fTDAjn3OyLM
         nmH7vHFc6vWCqUIfJuF4Ye01uqwNwYPN7NiZzx+NxuKnE0hSirXOR5BgCMsdWo4qdYg+
         PEGUhT3ty6i7jzYZrQpkxVGpqhHa2o6io4F/DVG5oiJjJ5+kxGGZGSXRjG63Ixygsjr0
         V63Q==
X-Forwarded-Encrypted: i=1; AHgh+RowHII61N+EcoGh2jClXpRWpxOr4xmmJQpWuet9IiNxe400quT+ShjFCAgqKDMIKmAJdxqPnWv0fdtgJIMyPrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+LMI1GvR1QuvYMJElFkVIGrhQmoSAQjK5FeulBCev0eeuK0aE
	8xihmvw9F2/shenHLn9pcFOUI1hWEB5ZDZ4PM5YaN9MB4N7sFx303nx8Uh+mleloD/lIZlE1iOo
	w2o+uYr15fiHhbz29OdVum1eMnNaWXqPdLs3/btmam61clgq5GCNmBitq8knie6en/k1QRps=
X-Gm-Gg: AfdE7ckH+5zfnN+60gwmOoaW6nYg87ReP5hym80p/Jw+yENQdVXkw31c/UNK387tYFL
	+ijTA6H22E8fHM7sG9a6JcbGe6nJiPycIdn313yGmQFY6is4YdPegaIoFKPpIBI4IFN724lvVWQ
	catyldRYDHNZklcpcEhrpaDVqnj+dc74NMvEahxVAENXV0OsfYi8Z89mjKvL+MWC2MR8xlFPPKp
	rGippj988RWNT5YZiZjw8GuovtCHH28KnKJFG4uGtzcS0WDcmRR7lJ69poz62ZESJpYFjHP2oGy
	+OrI5qFFXCSvcJTxzVb6nBMNWBmuaq21K5YyAKrAC1Y8qQ4O+0R9NZTGweIbHP0uGMPRIixDOSk
	6H3CV7hrufKc3o3OQbYAteatfEA2PUL/HeI+Ih7/ATLs0o8DWNfeR3m+4YFHQb/x0wEDwSViM3j
	tHNZlr5P6ik34nNYl/AX/jYaoh
X-Received: by 2002:a05:6122:8b12:b0:59f:8ddb:2fc1 with SMTP id 71dfb90a1353d-5bddf5bae25mr1989771e0c.7.1782994493309;
        Thu, 02 Jul 2026 05:14:53 -0700 (PDT)
X-Received: by 2002:a05:6122:8b12:b0:59f:8ddb:2fc1 with SMTP id 71dfb90a1353d-5bddf5bae25mr1989761e0c.7.1782994492816;
        Thu, 02 Jul 2026 05:14:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aec89eb6ffsm650658e87.83.2026.07.02.05.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 05:14:51 -0700 (PDT)
Date: Thu, 2 Jul 2026 15:14:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/4] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
Message-ID: <43re752djujsh2kiyvjlkpmztxsh4atg6472qhir4lgay24zbo@mtlkn2xc2ors>
References: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
 <20260702-monza-wireless-v2-3-7b56e2a6a6d4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-monza-wireless-v2-3-7b56e2a6a6d4@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: W6CwxD2Q1rPHp4vR__SDA0LaYS3-oKYR
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a46563e cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=GH4E13IOXdwHnVtn7D4A:9 a=CjuIK1q_8ugA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEyOCBTYWx0ZWRfX/nuckU83az//
 1qxsKW5R+YsVB/Ba+dNsHSx2agyJ0UZ5Nb13zRY70CWN82gBlDW1Ke1vImkegztLXxqVC8PiC3G
 P5Dci5MxYTsxvMNGDb+nJf0+EDeH/o6dpgYgi2v4kHpmcO0uWG8wsttl/MuScxJXIWNbZsABKZO
 QU9q6Fq0QfXH4lC7jwmgWDlNzBBzwx7qh/y9rj+qW4KgWfphl9RzV4CvdHSzDpY0McnMRw8meBf
 vyr4IHUTKsxvYTW8LaEIR3FX9rd7ydeLLkCeCPtDHUNdU6IMCiw2YCLj6ha04XzMY6diPrSXhFp
 Zwsp01h1K7BlFpTiA7AqNVk0Ln7u/wfDEgSYyW6DZqdy3D5ZbbyTApYjpu1kSgzWO7BdMHCBi/P
 1aqwBVVBh3iBmhgG0rgeRZ1W894OfaOiHfRQYfhWZKPkhJgZF/inuoci4tEm73EqXCV+ECARDcp
 QsgT85oFWWFZ4JPiXow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEyOCBTYWx0ZWRfX+kD3lOY9rXH2
 0RVDh9GYgVj9X+cB1rF/diIMQqOVqg0iRkQnu5Vtvm2h+tdG1JmbNFU9rjGo6p4IV8liXsJKazZ
 oJUjFsc65V6KYXIJa8I4IkUaLT8HTCo=
X-Proofpoint-GUID: W6CwxD2Q1rPHp4vR__SDA0LaYS3-oKYR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020128

On Thu, Jul 02, 2026 at 12:46:15PM +0200, Loic Poulain wrote:
> For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable
> is controlled by the W_DISABLE2# signal managed by the pcie-m2 power
> sequencer rather than a dedicated BT enable GPIO.
> 
> When the serdev controller has an OF graph (indicating it is connected
> to an M.2 connector), acquire the 'uart' pwrseq target from the
> connector's power sequencer and use it to control BT power instead of
> the bt-enable GPIO.
> 
> Also allocate bt_power unconditionally for all SOC types since the

Can we just fold it into the main struct?

> pwrseq path is independent of the SOC type switch.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 81 ++++++++++++++++++++++++---------------------
>  1 file changed, 43 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index e09debdb00a1b8e74ccd5de6147e240e533b4594..b04593a96e14ac9e87ae76fa00eda308e81dea25 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1872,6 +1872,9 @@ static int qca_power_on(struct hci_dev *hdev)
>  			/* Controller needs time to bootup. */
>  			msleep(150);
>  		}
> +
> +		if (qcadev->bt_power->pwrseq)
> +			pwrseq_power_on(qcadev->bt_power->pwrseq);
>  	}
>  
>  	clear_bit(QCA_BT_OFF, &qca->flags);
> @@ -2256,7 +2259,7 @@ static void qca_power_off(struct hci_uart *hu)
>  		break;
>  	}
>  
> -	if (power && power->pwrseq) {
> +	if (power->pwrseq) {
>  		pwrseq_power_off(power->pwrseq);
>  		set_bit(QCA_BT_OFF, &qca->flags);
>  		return;
> @@ -2387,6 +2390,35 @@ static int qca_init_regulators(struct qca_power *qca,
>  	return 0;
>  }
>  
> +/*
> + * Acquire the M.2 connector power sequencer.
> + *
> + * An OF graph link on the serdev controller is only present when the BT
> + * device is attached through an M.2 Key E connector. In that case the UART
> + * enable (W_DISABLE2#) is driven by the pcie-m2 power sequencer instead of a
> + * dedicated BT enable GPIO, so grab the "uart" pwrseq target from it.
> + *
> + * Returns 0 if no M.2 connector is present (nothing to do), a negative errno
> + * on error, otherwise 0 with qcadev->bt_power->pwrseq populated.
> + */
> +static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev, bool *bt_en_available)
> +{
> +	struct serdev_device *serdev = qcadev->serdev_hu.serdev;
> +	struct device *dev;
> +
> +	if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))
> +		return 0;
> +
> +	qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev, "uart");
> +	if (IS_ERR(qcadev->bt_power->pwrseq))
> +		return PTR_ERR(qcadev->bt_power->pwrseq);
> +
> +	dev = pwrseq_to_device(qcadev->bt_power->pwrseq);
> +	*bt_en_available = device_property_present(dev, "w-disable2-gpios");

I think here you are looking into the exact details of the other of the
graph. There might be other devices on that side, while the code now
assumes M.2. Or, consider having an M.2 controller which handles
W_DISABLE2# internally rather than through the GPIO.

> +
> +	return 0;
> +}
> +
>  static int qca_serdev_probe(struct serdev_device *serdev)
>  {
>  	struct qca_serdev *qcadev;

-- 
With best wishes
Dmitry
