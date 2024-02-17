Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08EF1E501
	for <linux-bluetooth@vger.kernel.org>; Sat, 17 Feb 2024 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708194659; cv=none; b=s9nihwnP2VxHqJRGsUS2YqOjWknoxbeZzlfocQhQtgfa5MozM0C8RJ3x1XHjqpnfF6yCuTufw+vZlxuYKlgP8Jk43GEYSy6/VcpZCEApDGRdicjbveexpSsClYkvUjtGCdr+C49igsPZpoTqNO+Pu5fC0j6JsHMTuvQTsWt7TiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708194659; c=relaxed/simple;
	bh=xTu4CwC01bOUIpKw1wk4DHay8JL9daGjNYWi0BvJoFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxk++7TDYC7Jv3nydukh4foHehORTAMtleSVw+VObAVszHCQs2JrATiP4vuROW/eFB9hQayDqdjAZyY0c8Be6VUBDhwVHa/e8nM8PUr/pQuM7F/kVM1H5eMKHhGtStl3qi8oEOGfeS54rk45TxUjNsYy4j+7j2W+FNFRsV5lqXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=q+ZTbwOW; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="q+ZTbwOW"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d5c2502ea2so764803241.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Feb 2024 10:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708194655; x=1708799455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JeWu4dlZldb0QpDIIyWPdxjS/RZoRXziwmFM0VAD7xY=;
        b=q+ZTbwOWLrtB7LLK3P+2bWMpv7DfIvhgi/2egNQ4e52dlt56kAs4JbMUWCIypEPg3u
         jaPViUylF4qtQbcTBTyT70G9+UdrSLhxKL21A/9s6yJsxSRyq8xTATGcF88R6HEN/kSI
         FEcX1CQfyK4WEt+SUb+cFk+6mPzCSgU0ZIWA/kkH614YOW0bApp+lbnisuRUJID+UlaS
         oOt0Z2o/J2lyYUVPrLC0B6EbShI40Z+7a/Fx8TFCEz+8kcxXF+2Zmg6PaMWL2HnIyTdI
         P5Fq871GtTT8Z3hp9dz0flsuvXqyvv2rjvK5Pq1zsVljnHdz9MUClSO7sH1Y4x9CWtmk
         ubmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708194655; x=1708799455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JeWu4dlZldb0QpDIIyWPdxjS/RZoRXziwmFM0VAD7xY=;
        b=uSMe04pPfOpm8SPd2zgA7U20GT4klgibaAy0GSofKfRIgjlHTQmeVMlaumMCh4FXkI
         bD99ko7HuvzQBFbpoENHrU8YiTgJ4hXruBv8yxty0qOqYuRY3J73G8uKHnw4bJDduQ61
         t2ydmvgNoY+f8ValVGXDCIiXoRlSB4pkbhKDZGWC2I+ARhQzgrHgIW/nfLp9P7KnMODY
         2zoXwlBDGOdU44x7CNRIVa+0iVR7ou1hJgrcw4O+jCVFsK+h7k2yZN9QRBmctMI1TU7a
         fgjMQWxArurf5KSRFsky8bR2ukkkD/QGfOpMIujjLc0kOpKUjBRbBEN3a8KHJ8o4dGIU
         NXIg==
X-Forwarded-Encrypted: i=1; AJvYcCVWTBDpytqH/Kz4FYG9oMJ8ND1CBzD+FQ8fGYxzh9m5a0KjTVfg5HnHUzXbLV2RDKoDIpoR8JRodCu4zFp7ziyT0mv6jMONgLb9woU/ZYRD
X-Gm-Message-State: AOJu0YzQEBZRRiCoYsxlTka9D6Yl5VHfUrqBszDqFEq/Zn6iFfFa9B5X
	2For8UdBHd/JMFU9G+U8zuorb0z9VV17WF9VIfkVa4ZWO6qe0Sac3RrfvugJslu5EdLpk9PopSP
	nT8U51O7/zZkk4/Pns/ff0chCbDA2jF0S3ByXHA==
X-Google-Smtp-Source: AGHT+IEGwogzVe3juwTbP5wzSPlB4FZp7n7jPtu9uTl+n1AS2iy9ckNua2af79j+lFRcSQmRv5yllrZrWuBKxrsF4JY=
X-Received: by 2002:a05:6102:3a08:b0:46e:c752:16e7 with SMTP id
 b8-20020a0561023a0800b0046ec75216e7mr8759486vsu.24.1708194655651; Sat, 17 Feb
 2024 10:30:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <20240216203215.40870-7-brgl@bgdev.pl>
 <87cysvd2er.fsf@kernel.org>
In-Reply-To: <87cysvd2er.fsf@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 17 Feb 2024 19:30:44 +0100
Message-ID: <CAMRc=Md10bNPswsLqdCmqzEmD+QmyZ+Eb4SUWknH-j5kK-speQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/18] dt-bindings: new: wireless: describe the ath12k
 PCI module
To: Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Saravana Kannan <saravanak@google.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 7:35=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wrote=
:
>
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add device-tree bindings for the ATH12K module found in the WCN7850
> > package.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  .../net/wireless/qcom,ath12k-pci.yaml         | 103 ++++++++++++++++++
> >  1 file changed, 103 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom=
,ath12k-pci.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k=
-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.=
yaml
> > new file mode 100644
> > index 000000000000..063c576b99a0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.ya=
ml
> > @@ -0,0 +1,103 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (c) 2024 Linaro Limited
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/wireless/qcom,ath12k-pci.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Technologies ath12k wireless devices (PCIe)
> > +
> > +maintainers:
> > +  - Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Jeff and me are the ath12k driver maintainers so shouldn't we listed
> here as well?
>

Sure will do. I also noticed the subject is wrong, should have been
"net" not "new".

Also, Jeff is not showing up for ath12k bindings in get_maintainer.pl.
You could consider adding an N: ath12k entry to MAINTAINERS.

Bartosz

> Jeff, this reminds me that we should add you to qcom,ath10k.yaml,
> qcom,ath11k-pci.yaml and qcom,ath11k.yaml as maintainer.
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
