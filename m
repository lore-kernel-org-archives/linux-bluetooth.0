Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D57421EE8
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779466290; cv=pass; b=IlJMl9SCJJNuJxOJz9fiFw81HJOlP1Hgi2dhtYuCyg2UPnUi/1jPT/p/DNM5DWMegFMsMfhBOuiHoLy2DQP9qOZpGw5z7n1pTQ8qtZw+md1GTrpDlh9vJeyiH/eU7o15evTFK79rvE/G1JovS5zJBzjsIP3bQzrdempA+3hqEvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779466290; c=relaxed/simple;
	bh=bLtI2OBA5rafdql0eae6MY8/XGVx80bBush8lA9uIPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnK49ZL703++gK/dGxg6I3S5SSL/pdHxI52z1VkcYYNVkmN0IDs53OcvDOp7rMGGvt1IB0PUBIUMqZHBA2t+QTBXI2mI/1roVMOucohWjRX1qBAxbdS+3hvoJ3ROB1yx3Z/kW7RpeaNI3AEVP2gaD9GLs36SowK545vOXTb9jt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C8UL5tlt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ESh5Wm3q; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C8UL5tlt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ESh5Wm3q"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MDpYNb2125208
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 16:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0lu1niHMrECx4L7qZONZo2E7wZ8eqqnrUPVegshXdyA=; b=C8UL5tltXnXU+6nX
	jHhbbZeMbZja0B7v1zrospoXn2ug1pL3ImgZciQ7OI7Py4ei7tviaRBOQVb6TZ1r
	7I6Sb5E4UsdKg2h7pRgaEEj5/YV1kwv/Wjp+ceh6enYt2BxwvxAwubUsJLS51Ohc
	d5cBl0XI2mFp9IWXX0Kfda9Zl5qiwh42eMTwIE5X1jsDKzWDHLF8Zb5SGuy7KHhE
	yiAXYXtAXMz/bAsnEaIqUKCqh12KIGXxeMogYcgjahBO5eTLbxD6Ss+r2P1FRlzy
	8oLVz+bFkGxYTiKaz1mHJxjjo40BRWgU2Am9jF3DdDh2Uc8jvHTiiiE5YVNpqxGQ
	SlI3zQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eard88pvc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 16:11:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-90f5248b209so355821685a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 09:11:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779466286; cv=none;
        d=google.com; s=arc-20240605;
        b=KeEhnxmB0Wi26FC6VLfrn1iBS4P4usLv0Jg6b5b6I7R7bAQTPiMs0Itv8XYJj676Ym
         E7jtQPChOnZemZE9tskgPFHlk9BmwrgB3VIV6HqqbTE61PoGezQcapG18aGSVWhSNLeA
         KzGVRnOQrVpkvxvmxwG+Sg68p/bJLvkB05zJRAr4nZIZSFBXXZT5457Zkw176gDrqej6
         5iJZRJryo36hCvwXO5c2UdjbKxznuAikV96TFHyuxe9SHMHK/WiXVj3St0x+k2bYKmSx
         Jjy7/FZE90a3Gd3Mcfz5wPpszhRKAn2x5wmZws35aLkycTJNtkcdcWZlF4dgAtuzSApo
         VOYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0lu1niHMrECx4L7qZONZo2E7wZ8eqqnrUPVegshXdyA=;
        fh=Nt7h8TTjj9hF46qkn2O6clcglrOfLPVT6CSUsU+BKQs=;
        b=SNuRNlY5Md2heoG1/i2oQLaAaTXMlXIZFk8srdn7rbtsX3iFhCafezU8DvxJed7vHa
         ceEdAAF+pmx4UiqqhjV36BEckBkTKAA5M2rTNVbOwKGd7U1kLv1tiJuqGWjekotkIHlL
         xn7nhR//USYKZHDFqQTu52oAHS2sGig1BKCkefSmPlA5RaRO3AXfphEkP6aGhWNpcfc1
         XDg6sHYHX0sXr2VY2DxEBori1BW7WxrwI5SjK6Kahv12ut0U+3suMe2/ts3JPE/VQDdM
         2aOVfCL8fkactQCeZ2WK6B141UiAT4dE+xLqw9iB4Z3UsqkHaA024g87hgjoxGx+bsVg
         4KhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779466286; x=1780071086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lu1niHMrECx4L7qZONZo2E7wZ8eqqnrUPVegshXdyA=;
        b=ESh5Wm3qAaAts3tpP9XIDB1KaaqGSN8VAIzim+gOIISrlpz4ZK+uVZrpxuW6oJhQBI
         vFZX3q1HK11yS99yP74BJ2C+VPbyc4L3VFU3byWkeIOCnaNyA1Sw3DFJ6DPARGp8BVRX
         y8Gb/kOeWwKNshSwnsKp9PAa/aFl/hTGBGcxb9KZJ6tMPGGlJBXmo74HlAZSDLLh81RU
         4P9uUD/qP4dIBMCBnU2BIbvrZU70m11JViIdZzsgRxG9TD2Hi92KEPcOOd3oz+z9cjqs
         GqycjGV0rprIqivPrg8O5qTSy6zLiki/VGa6wDUFT7h4BHGWPecwY0RP9JGTEL0U3kYl
         4Z5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779466286; x=1780071086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0lu1niHMrECx4L7qZONZo2E7wZ8eqqnrUPVegshXdyA=;
        b=K2Yabjlp9NVtXKKUydv3tZl0esLKD2+AtuHZc6z+ZTPQ9wArPvtn2QqACutZV6emVt
         WttsV4QXIiCj6vO3bVJ65Yg7avaNhh40+jBlKHu2JqdAT6vYtYjr4Y7w397KFgM85642
         W0iILhypt9EXVjKbslrgzwqyZep6uukVEMQga7rnQP8+pRT+TAk/74QK4H8nVVSeoP+a
         Q7eOpX8Web0D3cG/GRavNUM7Bq7R0ndV5P430yfpxS/Y14lUK8MNvsFR7V5k/NAQE6Pq
         v6Tv/LVboQg+2MPu/6QcTmY9BYiu5wCtK9cxRtwb86V2zr70y+82AG/VRggtzkeeOpzk
         Hd1w==
X-Forwarded-Encrypted: i=1; AFNElJ9PN7tEIDEUwFVWH8RsVkn6d0YldecEjDY4KKr9kuwfU9ffbVRoZZqYBlg9/ao9wI8QcQMpmwFErXHcxTKNldE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQQMY1PreWC088LYhdgCYQiNZ5EhiJNye9rHHiCWHSdrpOYILZ
	aXGBiwnxFLtZ8U+NELtTWbwIEJAKHzigiuEGD73yCo7SBmbHJI7cqK5fSI8OfY6HThPllzCLg3Y
	IEGyMFIS+1Oe+FZ2llm83PLqngH4K8epN/7u4IlEUdly1DumEPuDjUDbi0RGASOOni1lzxNbvNK
	coKu3o1UZJL5qOSm4BgBuACHyrlk+aNRlQ5Gq3LoibxvPNgw==
X-Gm-Gg: Acq92OF80EJu5221WKAiHRAem1Zw7wv0Kupm8hco+zZ6r513AE/ra/6C6QE/CeE4hGA
	yF23DRhBvwKWW7xgDAgwchgCGM1SXQ2QGk7uzQm+b+jdDTXJ9DzHddErj+EX28ul6JM5GU9PRDa
	PpwrLs22vFjErh4Pgs4usjHHT2udbZU4IrI9TFlZ8AQRBdc9rw+vrrkVA4MetrlEYDLgC16AwWL
	MLU75czEqt2MhKL/pFJ5xyDcafVuxBBuhcBdjo=
X-Received: by 2002:a05:620a:1d0b:b0:90f:9cde:9788 with SMTP id af79cd13be357-914b48d6853mr675636785a.5.1779466280579;
        Fri, 22 May 2026 09:11:20 -0700 (PDT)
X-Received: by 2002:a05:620a:1d0b:b0:90f:9cde:9788 with SMTP id
 af79cd13be357-914b48d6853mr675629485a.5.1779466280032; Fri, 22 May 2026
 09:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
 <20260520-monza-wireless-v1-2-9f6942310653@oss.qualcomm.com> <cx3pbr47tsy5mnag73oopkodnx4jgoiipz5pzrp4uze7mk4fgg@zogzww23ueni>
In-Reply-To: <cx3pbr47tsy5mnag73oopkodnx4jgoiipz5pzrp4uze7mk4fgg@zogzww23ueni>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 22 May 2026 18:11:08 +0200
X-Gm-Features: AVHnY4KZcbVzn920hjyxYOpqLudIDkA1KQq_MhbagXA8SoEUbTo3JjxoNdQTHfM
Message-ID: <CAFEp6-3_NuWwF=gthfJyqeHMivGnfF0xpsTXT-xGW7pgFs+j3Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] Bluetooth: hci_qca: Support QCA2066 on M.2 connector
 via pwrseq
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Fus1OWrq c=1 sm=1 tr=0 ts=6a10802e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=O2y7hZ9sxHz_cEH75X4A:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: eUM2EE_GD_9x73A5MH9r05rDzhrkhKrq
X-Proofpoint-GUID: eUM2EE_GD_9x73A5MH9r05rDzhrkhKrq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE2MSBTYWx0ZWRfX5iVHvwMvDeSt
 oFR1ibCivXTELogqeCcDupsEbLrZg0WQJObgUgDMKcKfkU7Up6sxL8WDMyXpsHMZ62YQV8ocQDj
 pJ6uFLL2vKWAK9kitvzdiU8Db55QTMU2mc//E+SL4vJAT91yss5l0uXhlhoCw3nYgaQwRmJr4Rf
 Qz+5xQCfIUbPscxZ0FC4TmrOcMUAq8aBR2RCaaFQT0CiZ7+mxVjQF9oM77tqYqMFpRwB/unK7JJ
 ple6Bm+oUyH7L0QlT4tIVekWQjEexWbiZePrtNhpoiEjEPVuuGBssZecycdttRrgl374qGvkrRT
 UYgV+UZoxMBSCMsUmQ6IdBXymBs/NP6HO2lqKf5luD8XYeqyW2Y0eaavz706/XnrZLY7Qah5imz
 qxmFzhhEkftFfa+Uf7GMCvMyhpa6ScxPNdOl1mawuqF4mnkHd9zr4wF3CdERGekBVmKg5lU93dx
 4MFCAAbgcibdD9oUTjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220161

On Wed, May 20, 2026 at 2:33=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Wed, May 20, 2026 at 01:01:43PM +0200, Loic Poulain wrote:
> > For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable
> > is controlled by the W_DISABLE2# signal managed by the pcie-m2 power
> > sequencer rather than a dedicated BT enable GPIO.
> >
> > When the serdev controller has an OF graph (indicating it is connected
> > to an M.2 connector), acquire the 'uart' pwrseq target from the
> > connector's power sequencer and use it to control BT power instead of
> > the bt-enable GPIO.
> >
> > Also allocate bt_power unconditionally for all SOC types since the
> > pwrseq path is independent of the SOC type switch.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  drivers/bluetooth/hci_qca.c | 33 +++++++++++++--------------------
> >  1 file changed, 13 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index b5439b9956cfb0497e6ba6ccd9ed61224d23a9dd..de5cba7b7f44e280a48dad5=
d670fa2758d3268d0 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -1873,6 +1873,9 @@ static int qca_power_on(struct hci_dev *hdev)
> >                       /* Controller needs time to bootup. */
> >                       msleep(150);
> >               }
> > +
> > +             if (qcadev->bt_power && qcadev->bt_power->pwrseq)
> > +                     pwrseq_power_on(qcadev->bt_power->pwrseq);
> >       }
> >
> >       clear_bit(QCA_BT_OFF, &qca->flags);
> > @@ -2415,25 +2418,9 @@ static int qca_serdev_probe(struct serdev_device=
 *serdev)
> >       else
> >               qcadev->btsoc_type =3D QCA_ROME;
> >
> > -     switch (qcadev->btsoc_type) {
> > -     case QCA_QCA6390:
> > -     case QCA_WCN3950:
> > -     case QCA_WCN3988:
> > -     case QCA_WCN3990:
> > -     case QCA_WCN3991:
> > -     case QCA_WCN3998:
> > -     case QCA_WCN6750:
> > -     case QCA_WCN6855:
> > -     case QCA_WCN7850:
> > -             qcadev->bt_power =3D devm_kzalloc(&serdev->dev,
> > -                                             sizeof(struct qca_power),
> > -                                             GFP_KERNEL);
> > -             if (!qcadev->bt_power)
> > -                     return -ENOMEM;
> > -             break;
> > -     default:
> > -             break;
> > -     }
> > +     qcadev->bt_power =3D devm_kzalloc(&serdev->dev, sizeof(struct qca=
_power), GFP_KERNEL);
> > +     if (!qcadev->bt_power)
> > +             return -ENOMEM;
>
> This builds bt_power for all devices even though it wasn't the case
> beforehand. As such, you can drop all further `if (qcadev->bt_power)`
> checks in the driver. But, you also need to check that this won't break
> support for other (older) chips.

Ok, I will do, and double check.

>
> >
> >       switch (qcadev->btsoc_type) {
> >       case QCA_WCN3950:
> > @@ -2543,7 +2530,13 @@ static int qca_serdev_probe(struct serdev_device=
 *serdev)
> >                       return PTR_ERR(qcadev->bt_en);
> >               }
> >
> > -             if (!qcadev->bt_en)
> > +             if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))=
 {
>
> And this breaks support for pwrseq for non-M.2 BT devices. There is no
> OF graph in such a case.

Not sure why, here we handle OF graph as an optional pwrseq provider,
but still support legacy enablement.

>
> > +                     qcadev->bt_power->pwrseq =3D devm_pwrseq_get(&ser=
dev->ctrl->dev, "uart");
> > +                     if (IS_ERR(qcadev->bt_power->pwrseq))
> > +                             return PTR_ERR(qcadev->bt_power->pwrseq);
> > +             }
> > +
> > +             if (!qcadev->bt_en && !qcadev->bt_power->pwrseq)
> >                       bt_en_available =3D false;
> >
> >               qcadev->susclk =3D devm_clk_get_optional_enabled_with_rat=
e(
> >
> > --
> > 2.34.1
> >
>
> --
> With best wishes
> Dmitry
