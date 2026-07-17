Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D323C3F62
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280908; cv=none; b=CwCJOzIMRGn7BoWG6uY65c7ZsxIrTU8OusgsrLMTVlFERHma8d698EcAth1sAWSXcOCQLeSsV+VR9YBn5kCRFvhy9PnozNxXZbM+rVYLMGm9rGubDh+B/fL9UWJOI1H4sK+t4VM9dX+B5tac/Bvn2JqqbOGVTxSlf6uEsWaL7Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280908; c=relaxed/simple;
	bh=8bXUNSJbbznLWihRmenUr5H9/NgzmpuUPUrz2ktMwHY=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtddYMsRvK4WIhzYXje3QrjD3qnsYI2Uv7Asjmq/GIH1iNqzAgWwHK5/qbCwiWuMZh8IDcbW7RxE4jk5I8ykeR1L6VldHffYhMugCDiZIh9krbr5gISWLcwUtEh5H+ADfYne5GAfcWoEEAVzugChczCZGOKWbKl9qK97gJFqexk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0YCLF5f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0YCLF5f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17891F00A3F
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 09:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784280906;
	bh=1hTRNVqknymCeCEznv7yylqhodwXKwch8r9YrZ1PWdc=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=b0YCLF5flRWFCnagUNdBJ0LNwIqdOrRKSu6YQOls7LB9JQ2P+EgGlsWxM9E3KOGLw
	 +jRioRI1fYMRSI3agFw+tg47n39p5EDoZdm2bjG6UkkVdCE5Wsn36oomtExB4/ruez
	 bpt3Mx+MbmmhcxrniHiO/BPj/HZiTvLclCRsgtIrE9n+eI+44u7hYxRLulerA1oWbK
	 IphUIppW8iofYOoH5p0E2WFAU949YRNLQF4PbOzXGZ20i0ePrZ+aur6ed4H1ZCDXMW
	 LEn2/0pG216PQUWGVYkqsegS8sQTpKpHQk6p4vcUiCJOukdgM2JOtjsjfu4thOPyri
	 FJ9KlEJOBf5OA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b0f19bea2fso3848592e87.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 02:35:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrlJJ4OFZGKe1kPzaLPkU0SmmX28PHvKrsNb0IhIEQAQIe5tTAr5jQjz2/L8aMW4r12+qBgzYtDYYSXEiw+EFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhUPKE5KbThOWYCjK234Da89i9v+QXGhp9KzWSJBTT1jUxkon6
	IfSMbg3gv1uuZxBE5Lwl05WyTibFxhNsiV+zSKvfe54OZBrfOiScYpjAdIjborQvIxa6c5/rQ60
	DKR+5mexeUbVNZQQ0S9DdKxFUUYcoUVaNwAnzrbRMGQ==
X-Received: by 2002:a05:6512:1292:b0:5ae:c745:f39 with SMTP id
 2adb3069b0e04-5b28f9b63ddmr359035e87.44.1784280905637; Fri, 17 Jul 2026
 02:35:05 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 02:35:04 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 02:35:04 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260716-monza-wireless-v4-8-9b02e6f549d7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com> <20260716-monza-wireless-v4-8-9b02e6f549d7@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 02:35:04 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mc3gt_uruVmUmqsOsvKX=52V4TBVC0hbo69KgjEGhch3A@mail.gmail.com>
X-Gm-Features: AUfX_mwYix0SKFJrhnSfi2t34SSBz1xGfCSYL55Jk4eOHRiiAR31kNMM_woGXiM
Message-ID: <CAMRc=Mc3gt_uruVmUmqsOsvKX=52V4TBVC0hbo69KgjEGhch3A@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jul 2026 18:18:25 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable is
> controlled by the W_DISABLE2# signal managed by the pcie-m2 power sequencer
> rather than a dedicated BT enable GPIO.
>
> When the serdev controller has an OF graph (indicating it is connected to
> an M.2 connector), acquire the 'uart' pwrseq target from the connector's
> power sequencer and use it to control BT power instead of the bt-enable
> GPIO. This is factored out into qca_serdev_get_m2_pwrseq().
>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 41 +++++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 25c4387136245fca25e375951f960d7240116781..22f6185a946ef04c45e41b2b34126e3f58d603ca 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1872,6 +1872,9 @@ static int qca_power_on(struct hci_dev *hdev)
>  			/* Controller needs time to bootup. */
>  			msleep(150);
>  		}
> +
> +		if (qcadev->bt_power.pwrseq)
> +			pwrseq_power_on(qcadev->bt_power.pwrseq);
>  	}
>
>  	clear_bit(QCA_BT_OFF, &qca->flags);
> @@ -2387,6 +2390,28 @@ static int qca_init_regulators(struct qca_power *qca,
>  	return 0;
>  }
>
> +static void qca_serdev_put_pwrseq(void *data)
> +{
> +	pwrseq_put(data);
> +}
> +
> +static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev)
> +{
> +	struct serdev_device *serdev = qcadev->serdev_hu.serdev;
> +	struct pwrseq_desc *pwrseq;
> +
> +	if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))
> +		return 0;
> +
> +	pwrseq = pwrseq_get(&serdev->ctrl->dev, "uart");

There's devm_pwrseq_get() you can use instead of scheduling your own action.

> +	if (IS_ERR(pwrseq))
> +		return PTR_ERR(pwrseq);
> +
> +	qcadev->bt_power.pwrseq = pwrseq;
> +
> +	return devm_add_action_or_reset(&serdev->dev, qca_serdev_put_pwrseq, pwrseq);
> +}
> +
>  static int qca_serdev_probe(struct serdev_device *serdev)
>  {
>  	struct qca_serdev *qcadev;
> @@ -2417,6 +2442,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  	else
>  		qcadev->btsoc_type = QCA_ROME;
>
> +	err = qca_serdev_get_m2_pwrseq(qcadev);
> +	if (err)
> +		return err;
> +
>  	switch (qcadev->btsoc_type) {
>  	case QCA_WCN3950:
>  	case QCA_WCN3988:
> @@ -2426,17 +2455,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> -		/*
> -		 * OF graph link is only present for BT devices attached through
> -		 * the M.2 Key E connector.
> -		 */
> -		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
> -			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
> -								  "uart");
> -			if (IS_ERR(qcadev->bt_power.pwrseq))
> -				return PTR_ERR(qcadev->bt_power.pwrseq);
> +		/* M.2 connector modules are powered by the pwrseq acquired above. */
> +		if (qcadev->bt_power.pwrseq)
>  			break;
> -		}
>
>  		if (!device_property_present(&serdev->dev, "enable-gpios")) {
>  			/*
>
> --
> 2.34.1
>
>

Bart
