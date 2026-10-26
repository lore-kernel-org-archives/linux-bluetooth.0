Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793013949;
	b=uDNTHWmbzuiNRL8tWbDlQ+hJVajJGwi6xt4+IaDfBkKjaR40toenJoohePMqRCm7+CBh
	 SjRajTmVSimr4uwEzXaeLcb1H4PSU2NPh/gqYA5QEm5mltPvG7shH1urV9/Nxt+4JKUmW
	 X2D5yVxz1x3AR8h4F/5H2TUXxDaQksYWAbqFxWMYEWhZA1Zy3koeFI0aVJMzH/Cwea43P
	 g7Gm6xzzbO0HweGxKcyrH0pVu8odvhHB8A2nU+YxLTleeCPe5pH9JcV48hmSf/7N1f9fO
	 lUKk6p0RRz0KntdoJwthoLYhP05+vTBgXgfZ4gFp242llPPWiAKmsxvPqFfX9mtw8aQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013949;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=kpZyhfaDwEx58Hf8F98PivHYwKz/1TShh9vNrajkRso=;
	b=VZ+NG1snAYYfbKsQ22j80WIUT5rZak4pLH+X+C3nuCI+ORcAt1+OaofdsCnJCAolTHXF
	 Ci2OKpq2BtZBWKzFg6GZraRm1bWLtdduTSenRckKNnmmEAMF+ks7qgzRp26FYsZ0bG7zd
	 LlYr6dKNq5lGg4+cjvlwEhD6SyAUZyrwUf4aHnfvjVDKsSMc+qKyKpO3t8KIDicmRTWwh
	 mdNpgwCOwvNAARYjtoXWSYGL0z26pMF16SQRrn3d2UGvzKEJ6Led07/3yDwPTIFEepxoc
	 2SrmUTahlgUcv0arbqJ4xPxn4lBZI7jTQlZb8BOhzqRRqk+SpYLNtAOUgT6xduGbweQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dnEBl84P;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AOUsYe6B;
	arc=fail smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3660C606A327
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 11:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3660C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dnEBl84P;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AOUsYe6B
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAtCi03050216
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 11:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kpZyhfaDwEx58Hf8F98PivHYwKz/1TShh9vNrajkRso=; b=dnEBl84PS75rsH+m
	t8WJ81u2wB65Nq2f6dOZLiSzrRzUKj9Pyzz3f2MND7GXZofF94QSfPq6MViMHQBq
	bSksoKo1Y38NbJHZz1v6vnCKdVCH70IYmaV0Umc8+BS+KcjIdEcJfBQ+4MEMozog
	o+2Ym5XwBrdsZDjk/RqWosjsWX5+LEAvltQ8WhhU5dARfQE23oIebl5uYuWOWQTA
	em6gk0bD2HUH9s1AEODOEAXwpQeH600P0hHKdXLJEuXnKFdhGr3hHruBA9KPExlr
	TdUGU4BwIYnoJZYFsYqTPOXVafySOKY3NF+LOeofxcYziPiLyE4e4WNY0W/SMTdy
	RXQfVg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvdd9vxj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 11:25:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f62934ef6so368387785a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 04:25:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793013946; cv=none;
        d=google.com; s=arc-20260327;
        b=DLxWk865yWjQfhxIrufl2JG0gp1CPXb+t5Kc8xXzC0bwxex5zSw5qsf0dCELl5NEiw
         PAJ0WShX4yDCVbrOzXOY6fYnmGNtc2kHJDbP+p3zv8WaHcnwxaPrrYu1uLC6CCVJgWzr
         OFEEYPjkaYxesU6b/tqg/qEcS0P/dDuhKOMCKtIw0yuLyHDIHncUMfAd6eUUX9wPhfuf
         H87rrLGcHwBSC2mHtH6OB72cj9F48ZhhWkUjF/OxMNlDBj70RC0Ee5VcqOHn5gFKQ8na
         FqColENXER3c2s+cEO+jYidFfiqkjSKo6fb46JN122bDfylQvfXn9ksLQyY3JkbDRPQc
         IedQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kpZyhfaDwEx58Hf8F98PivHYwKz/1TShh9vNrajkRso=;
        fh=6WoiOnlIc3WIc0nvgxKhIRSauYdT2UCqFGzf4cN7Vhw=;
        b=lmiTIOttPc4zkz0KGZ2SSCVINyEKq29OMGFEsSdX4J489TS+kiV0xEWNcwuR3WtdZ5
         dkmDOJ3RM3SqsYOQpgFqHbixnW7EvNiDg1m/nZzRAFLYmIYG5VWEqXcgaeXBUCduoign
         yoq5s3bE6MYmBGuOuzzKCu7G3SMH9m+VmQ9oL8CbwXhf44SojQDlpZb7iGcy0TAgneEl
         h6zk+WjPJAJrV74LCZegoHRDIxK7XSc0lZ+gV3l89QSMK5paYzDwke07ofAIbQ0Cvref
         Gbvh3Lv8aQbLTvwcz5ioI2TRD5DtNz+ei17g87lHYW9wXYYI8VHu92IjOU9GyCe/eL9T
         6VCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793013946; x=1793618746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kpZyhfaDwEx58Hf8F98PivHYwKz/1TShh9vNrajkRso=;
        b=AOUsYe6B+tr9jcb3Y3bSQ5SEIWG76vCozA59tpwZxg092fJzIqAxkcCUSVlDqSYdCO
         3Le7sTlWyrekQILLlyBHm293aJJPUOsYXa5GN68/u3NMlHiz72LGybgN0HCXolEyTGyc
         p7d4AoArT92bflVqszORm8S9ZRun6tLHK6068JH77owtZRnU+/OnIbXv5Ffcb+3EOepp
         p8lwoK5E5XDSzbFqwIMP2S1IRRCwfO9TRCXW/CN354BYSeFB5Gjqo2CLgCoVEnl0TOMw
         1CoibTH/0+emlPhAqjdlgPH5TDlAuAx8am3rdm+OhbUjDQFSpYM+6VzfuNJj3VxUhuy9
         cJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013946; x=1793618746;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kpZyhfaDwEx58Hf8F98PivHYwKz/1TShh9vNrajkRso=;
        b=NyJjJPpypa/bj8eKqp9qVUc5F8RvRn3L4KdK2YHhOwvpYJ+YRrl0CHmEZi4tENwJDI
         LIn3rXIRxlVD3lJ1Rwq3WHegEqTkukd19hGswO/vWPFmfvYMaJ1KMW3sGT52F5/h2VFq
         4eeqnEk5+TrWWMDkYyfFkxRHn7WInwcVLMK0bMxXHreh7vr6a2tZgpAH8LEQ1FaCdgBW
         1oOEA22FI/+CXe2Ma+V/91VbPbpt/eBdjU6wOqFRgpDuxllD5D6zmc9L3T2WfZo847qy
         AVD2RO5yQMWYB355HH2Z4jqvG4GM3rf7pkxpY70uT9ZBIa6flVJGUXe9Fi04U3rFLx3o
         edRw==
X-Forwarded-Encrypted: i=1; AKwUvBx5vVbYwNHq2ogRKiNzuJk/fMMyrAHZPbGW1vnvWHSEM/sIaEPc6nw7rZzY3xmUU1KAD88PrrNWqASP3abBNFw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJK6t3Iw+hoYJ/IwDBGWPQavfZtnDewHwSDxixVYrmDm1lxg6R4
	xi+fszWVywWSloOLj2hw4R0uEMMHkvIXqJyMnnzuULU07LtSE/NDvvFao1XF2Sm+AYWk3XWJC0e
	DZxp3kR+sLTxspANnKwTKVpA64uKiFip/gQagiNhBym58+/FAZtCe932BIJgBWuJEwrtlhI9qLQ
	cMnCb18yl4NBLFNbi2oUTYVn1S116KFJA6q1aADf3umGPI0Q==
X-Gm-Gg: AYBFou3MujLTSJWwjNDbqJbrKe2A4h4v24wvrB8vxVWV47w3mhC1lBWaKpurkYldbH6
	8r9i5H/X/eF+QH9CAsXUHTzJPReeO8iM7KQKI+ytT9FRyvFZrZ/+aiNTWq5eU+wn1tcUcEWLXMd
	LZ08rCjfqOzR4zOVsoo9gda7mdA4K1nmuV0RBKAp5dfz1q/dB008I4AS1hP06kwlb1AN8eCOHWW
	zpdtRIO6IcH6XiYEWcgzhPpSzUI2iLkNZs7+GsRVdsVpdPDN7BOvynbMcHUP579D8VKOEOhtuwj
X-Received: by 2002:a05:620a:178b:b0:93f:26d6:d70b with SMTP id af79cd13be357-940ef8af1a0mr924704985a.29.1793013946361;
        Mon, 26 Oct 2026 04:25:46 -0700 (PDT)
X-Received: by 2002:a05:620a:178b:b0:93f:26d6:d70b with SMTP id
 af79cd13be357-940ef8af1a0mr924701085a.29.1793013945915; Mon, 26 Oct 2026
 04:25:45 -0700 (PDT)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014-b4-nvmem-efivar-v1-0-187c85f65018@oss.qualcomm.com> <20261014-b4-nvmem-efivar-v1-3-187c85f65018@oss.qualcomm.com>
In-Reply-To: <20261014-b4-nvmem-efivar-v1-3-187c85f65018@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 12:25:34 +0100
X-Gm-Features: AclHuK_V9TSwenazx_QbQTVJlNkn-z_z7PltZHh3vUhKfg_kBmr_W8aabFtQzwU
Message-ID: <CAFEp6-2akDevVekLozzaH1e7rNuqqfpHjQiQvSkwuv_4zLucjw@mail.gmail.com>
Subject: Re: [PATCH RFC 3/5] Bluetooth: hci_qca: Support BD address from an
 nvmem cell
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Q4dq2EyDkD0iT-Xc6yz3NFYkx7jwT0B9
X-Proofpoint-GUID: Q4dq2EyDkD0iT-Xc6yz3NFYkx7jwT0B9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NSBTYWx0ZWRfX4b0KZLMgmKuY
 dcDGToUds0AteoD5BIrYX3FBh+TcjCpYSLlF4mQVD/D25Y7HXg0oCztoxjYQohYsbyw/L+4xQmx
 stXqX09q1p2Mm6Cr1YLUIMzQL0QkPT3tMNCEJ4GhC02Urf5J65X82NxZrH0vEbOtFvufcI3730d
 +by5LLL/682ieH6ZbS3pa+d9loxduMDPO5FuwR5X1pN0o+Xt6oVi65BV2VWDteG9y26rGn9Dk5/
 RsIw3bAJj4xhGmW6w0nOSd+yUafytwFgcg11s53CvdwKZ1g2Hm+ruQK0XwLc/pFM/kCTvuXBd+b
 hnGxnLp3BEEgDmb00UOrXfbuHSamhIExfCICLmb1QG6vrpr5tWHxjphKWsaXJVABNZsJHyW6miN
 p4J6PNZAVF9S7hEVhDQFHbyxbNO2u3bqSiLHmSONsPAT7NGsNbP7X6xEpaBt7VGXtSK7cWqEFp2
 TxyV634WaDs8/OQyjqA==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adf38bb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=v5oHNKCaMdnEZ5eDWvYA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NSBTYWx0ZWRfX7vHkQwVx0QgB
 1Uz+zo7wMpZlBmVgSYfvHJAMgr3wrH92xT5bELUeICPaIQiEU2A86KJSclCb5hmF9uyyMbrWYPB
 KhT9trEiJL2g2k+wEaoDkzWXLl8FdqM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260045

Hi Abel,

On Wed, Oct 14, 2026 at 3:05=E2=80=AFPM Abel Vesa <abel.vesa@oss.qualcomm.c=
om> wrote:
>
> Read an optional Bluetooth device address from an nvmem cell named
> "bd-address" (as already supported by hci_ll), and program it into the
> controller during setup. This lets QCA controllers source their BD_ADDR
> from firmware-provisioned storage such as a UEFI variable exposed via
> nvmem. An all-zero value is ignored, so unprovisioned storage leaves
> the controller default address untouched.

I proposed a similar solution here, at bluetooth core level:
https://lore.kernel.org/all/20261015-block-as-nvmem-v11-5-f890ac74f87d@oss.=
qualcomm.com/

Regards,
Loic


>
> Assisted-by: LLM
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 48 +++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 7089e9b639b2..b704f4c3e1a4 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -25,6 +25,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/acpi.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwrseq/consumer.h>
> @@ -230,6 +231,8 @@ struct qca_serdev {
>         bool bdaddr_property_broken;
>         bool support_hfp_hw_offload;
>         const char *firmware_name[2];
> +       bdaddr_t bdaddr;
> +       bool bdaddr_valid;
>  };
>
>  static int qca_regulator_enable(struct qca_serdev *qcadev);
> @@ -2079,6 +2082,16 @@ static int qca_setup(struct hci_uart *hu)
>         else
>                 hu->hdev->set_bdaddr =3D qca_set_bdaddr;
>
> +       /* Program a BD address sourced from an nvmem cell, if provided. =
*/
> +       if (qcadev && qcadev->bdaddr_valid) {
> +               int berr =3D hu->hdev->set_bdaddr(hdev, &qcadev->bdaddr);
> +
> +               if (berr)
> +                       bt_dev_warn(hdev, "Failed to set nvmem bd-address=
: %d", berr);
> +               else
> +                       bt_dev_info(hdev, "Set bd-address %pMR from nvmem=
", &qcadev->bdaddr);
> +       }
> +
>         if (qcadev && qcadev->support_hfp_hw_offload)
>                 qca_configure_hfp_offload(hdev);
>
> @@ -2420,6 +2433,41 @@ static int qca_serdev_probe(struct serdev_device *=
serdev)
>         qcadev->bdaddr_property_broken =3D device_property_read_bool(&ser=
dev->dev,
>                         "qcom,local-bd-address-broken");
>
> +       /* Optional BD address from an nvmem cell (e.g. a UEFI variable).=
 */
> +       {
> +               struct nvmem_cell *cell;
> +
> +               cell =3D nvmem_cell_get(&serdev->dev, "bd-address");
> +               if (IS_ERR(cell)) {
> +                       err =3D PTR_ERR(cell);
> +                       if (err =3D=3D -EPROBE_DEFER)
> +                               return err;
> +                       /* -ENOENT/-ENOSYS: no cell configured, ignore. *=
/
> +               } else {
> +                       size_t clen;
> +                       void *cdata =3D nvmem_cell_read(cell, &clen);
> +
> +                       nvmem_cell_put(cell);
> +                       if (!IS_ERR(cdata)) {
> +                               /*
> +                                * Ignore an all-zero address: the backin=
g
> +                                * storage has not been provisioned.
> +                                */
> +                               if (clen =3D=3D sizeof(bdaddr_t) &&
> +                                   bacmp(cdata, BDADDR_ANY)) {
> +                                       /*
> +                                        * Per the device tree bindings t=
he nvmem
> +                                        * value is MSB first, while bdad=
dr_t is
> +                                        * LSB first.
> +                                        */
> +                                       baswap(&qcadev->bdaddr, cdata);
> +                                       qcadev->bdaddr_valid =3D true;
> +                               }
> +                               kfree(cdata);
> +                       }
> +               }
> +       }
> +
>         if (data)
>                 qcadev->btsoc_type =3D data->soc_type;
>         else
>
> --
> 2.54.0
>
>
