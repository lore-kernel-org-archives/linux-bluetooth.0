Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BB43DA7D9
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193215; cv=pass; b=RVcn7oRchT5LfTiZfJywVJeOIcWuikYIq701WysA/KmyIo0snK66dRgKmjFkkUzPMns8ORYRxrisEaOP0Hwmukdmc0Fh583eW1a2eol7s20qPlmYqDat2HHOZb0qKyQkhoYGooI+470trSoVoDaRrIcKbEMFDr6wxQ2YPtJcrXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193215; c=relaxed/simple;
	bh=uCqDdKgSE05wWFAXOn24NCojvJkTjvFV4xaFhIaDAx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uK2zf1Sd+7Nvdqcvu5sYcoDqBAlWvPFO/fjWQ+hsgCv/YG3WaXux83Qa25U8Zda2uSm5+lMzxszLdi4CCvp0AKd8wYIojnQq63dwHA+J+cTOgkb9TgXebMyAtWZOD+rMqS4aMM3HQBFgKxMP37PaB6saZy8P31E4Phzgnb3pwmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d7+5EgcK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TwLzV0hW; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d7+5EgcK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TwLzV0hW"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G7DWX31994854
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 09:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xFVa49Pt2B8c2YYrLGC9UiUElbNn58UHEJ43nuRf8mM=; b=d7+5EgcKohigk/Rr
	f50a0z/LZV72FFBzPnB6iROcFhInecWl+0+L0nY99Z41rukIuVSOycIuzUr8v6u1
	YzjXctSOPfKgBVAOxptCXH+HqIPNSsAgSdenpQm/tzJXy3Z1mQiyoNsvWNe8nHQY
	qy5rsaM3RL1ctlWQLte+ZhcU4mIkDF3clW0nMB+E8GgpBhPQbyffYyS9Od0w88w4
	4x91VBZjg2haPe8dxW5CjnJ29A/PJoExvtdKA9LKvcFb3XmtFjoioxot6lUajnLk
	r4i+E2BmY425n4WZEI6Zyx1MEPY/a+j7WCdKMeMa9TqBRbj8+KnLAAcMWUDu85Rv
	0PMEeg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feefqjy06-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 09:13:30 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8ee2847cbd4so96110006d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 02:13:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784193209; cv=none;
        d=google.com; s=arc-20260327;
        b=PpKTJ5TOyXadV01nd/gHrKaBy7S7DxrifI7Tgz1cuFvRPWaX0GPQdpotWcqo3f25xl
         UJ76BMDhm4R5k2NlarGQm0sCRRtLNoq4HFT1LoBFKFFjOSBsa3oPSVIorZ+J4hYkGftj
         jKLcdzMmxpKl+FBahBkJgeR/iFEBuEII8U0BthM1QBqGg0DeM7F34JyTipb8huBKxolD
         DiwxXkI0BqZCiCKoiOj0DBEVXG+ar7dOz9C2l8jGxWt0noJjw1CgaY8OCDPsid177ioz
         sI54R47AbI6A3TJQnuxVDJ0XXTyBcMGE6Sl/5v1KC07ilK/Hk5TLKGjH3Y1uz/PLliGN
         2XrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xFVa49Pt2B8c2YYrLGC9UiUElbNn58UHEJ43nuRf8mM=;
        fh=/DsZnsBSx5ia/4btZsCem1pl1AQwQ5VBPtPicRsC8mo=;
        b=Oy5r8qPSSkdlUbaW+Xu4l2kSSrDMsGJE8+94sHucfHbzML4Vnflx+965u0galWMFaX
         9Sr8YKch5FR6LOiw2K0GqVOpIR/YfMwj/RtL2HuH4+Ih8uo59Kcf82AVUPSmWvbDwa8B
         pfkw/OPUgiiaISJXWqYrblgoJdMbp/2yodv6pBT59g17diVgCg9MkPpdJGcZxNUfDePN
         mXn2Tdf2ugBpTayu0h9m198MMqjEnCp9liEPQvmz04wxJtrBUpxmUOlRe5PV7kEj61kW
         b5BGO/CZEiVB9KkQAUknKQOjj0/XRC4HFfLO2KNQlcESoZP1Z9A944tY9JjsiMkISYTD
         37mA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784193209; x=1784798009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xFVa49Pt2B8c2YYrLGC9UiUElbNn58UHEJ43nuRf8mM=;
        b=TwLzV0hW33RYt8nI0/zpwTi7ztoge/roka6KcZ0Jcdz9gRd2W0DHuaLsVUVXZdz4fm
         LOZ0smBTI+KUX5b5koWhpGqvy5jO14cE+INR+8QkJUYK5ujgKWhnulvLTp9IhdcXdj4V
         +a0h2sg33nJu1QJuQDW/bT9U1uej3ZaTLCjbV9runbis7DrI6v7WSmXs15Cc0vtupRbt
         PAaTzIlB0Q0RFJ4l+rnZcOb59NkdFkXe8p0VAjhH+AbtEdRsKkERuFRvcZxt4mVpk8Q2
         XapZGn3a3bgZ9+xnIlzdHyk2uTmuY4LmQiAHPGj3z93FRJDT8pHnvpD3iAtWfIEH+WG3
         Qgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784193209; x=1784798009;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xFVa49Pt2B8c2YYrLGC9UiUElbNn58UHEJ43nuRf8mM=;
        b=DdCEnOsxmovg4fA+0vTS8dZyzP5Igv2AMFSYus9nwc02eoz8EDOarSuu0Ed14E3shX
         MSDCdLqDH0ZvQKrKS8dCetB6ypmh0xE52m3T2gOJbFKG6nZ3vCZCXDFxqKlvF41843V4
         wofd4/gcAvj8ZgUY+dESjeLkhW4Q7DeIFYPgls6vQzDhAHCGb+QeSjMD5E5DDU3gmQj0
         IjkJHdsKHe7n8DneppfwMRYaH1VcsHmAXP0xzDFkT/mvoW3lXpJSO+g9ClVUP/gq9mfK
         tqFgx1lnHXbDa7wJT109noHrYN9A9Cp3ua+iEkzCKAnXEF72VwB1VPS00smNC6rN+r8U
         55Nw==
X-Forwarded-Encrypted: i=1; AHgh+RqttSY+FXzVJ9jY9FrR6kL1cg51MfJnxwuPtywd8SdDxUa4uqh2i3p+hLeylJ/pqPAHyzzroE7PfQ0pytXA9bA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQKsJULpeitDLnLY8aGpuH2f+nbKBnJX99JrWjfGuGCGkhtDP3
	+97L7GJMADDZG3sWhAc+xuDS0D9kElzk0S/csYBWsPR5GlphsWSkTT5hOq7QaR4qK67Ep27lgvU
	6f1p8QDxlPIoJEQsjCSuHk7eLTMah+ek8aMVavRjjPNBtluqUzNMW4XtgSTcPAbxszJQxWA24/z
	LsYaHTKw2iffckKMkhmFicuL4HWVu1kcqEq32CaxRTYURVWQ==
X-Gm-Gg: AfdE7cn3G1QFgmi/JDmNRMPL0AMXM1PA19HdZqFJbx1GxsYDJHNq4ngF4PYqQj5X+7Z
	P/CVamFWRZ6US6nuGgBupEf34dcX5CzKQLZMsxr0X9cC7XzAFacZ/jr66QnQYZB7WR9fBt3W3gI
	Zwhn95mBVJfj6UbVBFSTXdKPCR2NzMP/EWrrLMgqoc9F8/ftx9LLu0PAHns6l/xEfowc8aHhQMf
	I8TQr6vnwWJvq/XD0VvZZ0twjgwu7nty7xGrHeoIlutifhzYdjqh6jhk+aEXDv8WcxgxGROFgvr
X-Received: by 2002:a05:6214:428d:b0:8ea:fb8c:2e0a with SMTP id 6a1803df08f44-9074c766c6cmr114860206d6.28.1784193209377;
        Thu, 16 Jul 2026 02:13:29 -0700 (PDT)
X-Received: by 2002:a05:6214:428d:b0:8ea:fb8c:2e0a with SMTP id
 6a1803df08f44-9074c766c6cmr114859886d6.28.1784193208701; Thu, 16 Jul 2026
 02:13:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
 <20260710-monza-wireless-v3-8-46253587af64@oss.qualcomm.com> <20260716083141.GA4101439@google.com>
In-Reply-To: <20260716083141.GA4101439@google.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 11:13:15 +0200
X-Gm-Features: AUfX_mz2l-ruyrBEqJdkcXUQ_DW7F-Cm1EuP-VtmhPBeabFSDhnP6vsS9Wv2wFM
Message-ID: <CAFEp6-0UJyekA7zE74=CgneqvxDbea0Xw+u8O14bpcHX8Yb57w@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
To: Chen-Yu Tsai <wenst@chromium.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=APNfGQ4N c=1 sm=1 tr=0 ts=6a58a0ba cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=UD6jFWV5_MqAamJTNaQA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA5NCBTYWx0ZWRfX8CSnZXHi+2nl
 mk+bCnuS0db3jHfTL91JF7LmdPCM9smS0PdbNwAN9xpGMGrfOsSEy2eZWnVg4RjeB+VnZUkW1Er
 IKGU1M0lb1WON4W98r1Uz+V/xpaGRrA=
X-Proofpoint-ORIG-GUID: wXTrdWhcjuDQd_CApSfv_BPsokWn9RIU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA5NCBTYWx0ZWRfXw3ReEC+fYYWx
 bjCpoBAqnPR+DHUOdjKWoZliC5fN9o09W8JRQrN13ILTEyeutYg+j1npTPvX+Zd6xhpyIKayFZ9
 xE4tcYRUTrkq2f3JTo9wPBYLr/1xBp4ddvB85pSojnhUK0LfukqkqnQnTP+2z/1mMD54fqb6TuH
 YSjRo4yYlU8fj+d4ONPmcMQrxi1aQlsptbAYRPgrXr4fY1CjG01GKAkl0RJGvslj63I5Ims0GG/
 8M5yT/+lr6WinMTeqeAsw+iMHsIii+BVI6bmj+GslYnN8Dyq6T1C6GXPUjNu1yYuIiUyIpgg/0g
 M7pHdX0RmsIrh46GaVsJIhx25R1LBRgNsvfKiXpMXEMLH/BCn9ExS6AVw104n5RomPPVxBhUPs6
 ITIVLbXL+yhCpQhrqjpnoEzEAnFIDw3mjMQVkdJZyjZgFr1ClA/+4vyb/lekyalkYyq1wWSefEc
 S3GIbgDBPJ1SLeOoYMw==
X-Proofpoint-GUID: wXTrdWhcjuDQd_CApSfv_BPsokWn9RIU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160094

Hi ChenYu,

On Thu, Jul 16, 2026 at 10:31=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> On Fri, Jul 10, 2026 at 11:57:34AM +0200, Loic Poulain wrote:
> > For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable is
> > controlled by the W_DISABLE2# signal managed by the pcie-m2 power seque=
ncer
> > rather than a dedicated BT enable GPIO.
> >
> > When the serdev controller has an OF graph (indicating it is connected =
to
> > an M.2 connector), acquire the 'uart' pwrseq target from the connector'=
s
> > power sequencer and use it to control BT power instead of the bt-enable
> > GPIO. This is factored out into qca_serdev_get_m2_pwrseq().
> >
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  drivers/bluetooth/hci_qca.c | 35 ++++++++++++++++++++++++-----------
> >  1 file changed, 24 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index 24dc5bf6d192be7e1d500df6bdf36e6184f9eaf7..f6529d359ffbd97f8a3c4c0=
593680ab200215b36 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -1872,6 +1872,9 @@ static int qca_power_on(struct hci_dev *hdev)
> >                       /* Controller needs time to bootup. */
> >                       msleep(150);
> >               }
> > +
> > +             if (qcadev->bt_power.pwrseq)
> > +                     pwrseq_power_on(qcadev->bt_power.pwrseq);
> >       }
> >
> >       clear_bit(QCA_BT_OFF, &qca->flags);
> > @@ -2387,6 +2390,20 @@ static int qca_init_regulators(struct qca_power =
*qca,
> >       return 0;
> >  }
> >
> > +static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev)
> > +{
> > +     struct serdev_device *serdev =3D qcadev->serdev_hu.serdev;
> > +
> > +     if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))
> > +             return 0;
> > +
> > +     qcadev->bt_power.pwrseq =3D devm_pwrseq_get(&serdev->ctrl->dev, "=
uart");
>
> Note that this ultimately ties the lifecycle of the returned pwrseq
> descriptor to the uart, which is probably not what you want.
>
> I ended up manually doing pwrseq_get() with devm_add_action_or_reset()
> so that the descriptor is released when the serdev driver is unbound.
> This was for the Realtek driver. I haven't sent patches yet.

Thanks for pointing this out. I'll fix it in v4 via devm/action.

Regards,
Loic
