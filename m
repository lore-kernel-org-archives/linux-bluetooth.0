Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E663E2BAE2
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713390015; cv=none; b=pZamOOrKBT2vYSX4DNfmNNYLye0cC5Jc33xtRRQ7dDP99bltjxgV/8s7n7S2tcRRJn0XDOjEpoaA3/vybcu2uBESAAILwbg5bKUyvg+zyNa5kgsw0uGoh+66Nkyw9q+gxF5YLrJ1Kw79N57yUScJ15SMfXDNkk+BDOPubkNDdKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713390015; c=relaxed/simple;
	bh=0MEIVSFrTNRJ9VhU4kNSMf9m5mQ4hSaUGRxtnOFm51U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YavRfKjUM8LEjpjeWeyZe+s0vqZvUYw5FQRrKaiXHrGYzFxKPd2/bcFLbFwJvLbIG2D/d8A3GGB5OFw4gkx0KoZcrra11oDn0EM4O79CXDLn5Xb5L+BaC3H8ytMYQIMRzTzBFi1T4WRILUMmWYGhH9cxP0EAGegtPEMRnW0D7oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bz3ICiMI; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bz3ICiMI"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d094bc2244so2605791fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 14:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713390012; x=1713994812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEZEMZzTI2QOVYA5EQBv61TnMyFcIBms1HQyaTOsAmE=;
        b=bz3ICiMIWOQq8YD35LIhg4msKo/Qm9/mto3X7jIxsa/dJpARfkLXiivcVsG2OlA4aE
         ODBKbv8iE2mMv5RTKkv6+8yKB0W5iVF+/ITxJYkaVWuBV6S+BrN9yjdO0IhqgcPHfFl1
         gq+0j9295va0X3+eay1diP3aswXt+uC+YY3BkvmcEwPXooviTP+NLR4yrbSY3S44OT3I
         DkWjI9QJdU2tKeELtd/CsOukICkcEQO6sSJoA0nflzZnYXsSrLXO8/o5rUp1jDyMRKf+
         OzTFPjg62dBBp22MbtYjoitrjWkvxIfK9hJtv8UoFcuZYunCF1KeoXCzDYC863f9pQ58
         VnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713390012; x=1713994812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEZEMZzTI2QOVYA5EQBv61TnMyFcIBms1HQyaTOsAmE=;
        b=VoncJk772KurD/0SbAwFJ5Tcw9CvILEJdtL0V3gYoM87jWH3Lxsciv8c2ulXcNVAlF
         8Xi94og2DvCDF7SOVxLiSrw7CTmFkxWlaA98Dopdp2NpvmXYXhfa8IWjLrPqVJftL66G
         7f8BYvY7Nh8WlUfSeZQauIg09NIdIyNv2pfqGEdboATrmCjD9Nq6S6CU5ggLH/qovc+r
         gFGMXKS8OAEPDeSnLFNgVzwOG/Y4zbyvXoROQ7VCTmKhA4CtmP/U0EAMV3pHsXZot3BB
         /LHWcB6FgV1BnaNtKmEhfhjcASarmu3j3pWrjnafkHj9Sj/1A/tm7QSJN4oFeJN61Fvj
         ne5g==
X-Forwarded-Encrypted: i=1; AJvYcCXYl12eYrfQyH0Lo5ykTZpYpqH+r6miuOGBAgE/93uiMjIPjwPvInB0BVjqU4/gXcI6XW/Eha8BQlCuegorm6V9dGdgEV/u7AsOpQjEi8i8
X-Gm-Message-State: AOJu0YzYoBgVDoczdCXCLpnDoIaWPjjLkBzMYmkzbRBJ6ul5RnfsdBVO
	59aL0n8ybZus10w6gtcYowNjNDxixnKvxX27gb6GPXShAOoAAK0SgosJ/ZT5sulZqPiG7xVodhN
	KsYtEsDxF/kkJ38Ck/SKjcrTGfbw=
X-Google-Smtp-Source: AGHT+IFfZsfhA416jfibaQcOGXmJd7MMsyuW+Q3IuBrWKmeeq+Ze/u2iRL/OPa/TLP/xgwpETu9XnYOaYXa9zhxRUX4=
X-Received: by 2002:a2e:8543:0:b0:2da:1f03:b893 with SMTP id
 u3-20020a2e8543000000b002da1f03b893mr294787ljj.11.1713390011838; Wed, 17 Apr
 2024 14:40:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1710914907-30012-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713358336-29619-1-git-send-email-quic_zijuhu@quicinc.com> <1713358336-29619-5-git-send-email-quic_zijuhu@quicinc.com>
In-Reply-To: <1713358336-29619-5-git-send-email-quic_zijuhu@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 17 Apr 2024 17:39:58 -0400
Message-ID: <CABBYNZLRyZu5mEtMjfoQA0VFZrBBbNK5KSYGM4uUrQ5EgmZS6A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] Bluetooth: qca: Fix wrong soc type returned for
 tool btattach
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: luiz.von.dentz@intel.com, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Wed, Apr 17, 2024 at 8:53=E2=80=AFAM Zijun Hu <quic_zijuhu@quicinc.com> =
wrote:
>
> qca_soc_type() returns wrong soc type QCA_ROME when use tool btattach
> for any other soc type such as QCA_QCA2066, and wrong soc type will
> cause later initialization failure, fixed by using user specified
> soc type for hci_uart derived from tool btattach.

Then we have to fix qca_soc_type or explain what is going on that it
can't detect the soc_type if initialized via btattach?

>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/bluetooth/btqca.h   | 1 +
>  drivers/bluetooth/hci_qca.c | 8 +++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index dc31984f71dc..a148d4c4e1bd 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -153,6 +153,7 @@ enum qca_btsoc_type {
>         QCA_WCN6750,
>         QCA_WCN6855,
>         QCA_WCN7850,
> +       QCA_MAX,
>  };
>
>  #if IS_ENABLED(CONFIG_BT_QCA)
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index c04b97332bca..7c3577a4887c 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -238,12 +238,17 @@ static void qca_dmp_hdr(struct hci_dev *hdev, struc=
t sk_buff *skb);
>
>  static enum qca_btsoc_type qca_soc_type(struct hci_uart *hu)
>  {
> +       /* For Non-serdev device, hu->proto_data records soc type
> +        * set by ioctl HCIUARTSETPROTODATA.
> +        */
> +       int proto_data =3D (int)hu->proto_data;
>         enum qca_btsoc_type soc_type;
>
>         if (hu->serdev) {
>                 struct qca_serdev *qsd =3D serdev_device_get_drvdata(hu->=
serdev);
> -
>                 soc_type =3D qsd->btsoc_type;
> +       } else if ((proto_data > 0) && (proto_data < QCA_MAX)) {
> +               soc_type =3D (enum qca_btsoc_type)proto_data;

Like I said a vendor specific ioctl will not gonna fly with me,
specially since each vendor may need a different size to describe
their controller version, etc,

>         } else {
>                 soc_type =3D QCA_ROME;
>         }
> @@ -2281,6 +2286,7 @@ static int qca_serdev_probe(struct serdev_device *s=
erdev)
>                 return -ENOMEM;
>
>         qcadev->serdev_hu.serdev =3D serdev;
> +       qcadev->serdev_hu.proto_data =3D 0;
>         data =3D device_get_match_data(&serdev->dev);
>         serdev_device_set_drvdata(serdev, qcadev);
>         device_property_read_string(&serdev->dev, "firmware-name",
> --
> 2.7.4
>


--=20
Luiz Augusto von Dentz
