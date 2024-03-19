Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE2B81AB4
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864643; cv=none; b=rms3t0vCwx8Bk3165/UWuZA23l6bhDd5Gg3ew2XPZ8n5ubeVU4jlQuMn0lUdADuljGMqufULrUDlGK1ef2TP9ILw8CQnMstI7cB6UJVryLr7dixtjLaTpJUJqNT8BKGUZ++livLHziI7WM/mouOqXQZIhc5VQxzH+uqbGKWGaPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864643; c=relaxed/simple;
	bh=4BDyA1fp80l7JzPfJ1e9Vcia9HkvY/RtUdxfuRXBrig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQthsZmLCDD+ixrtOkGGrNDy9PODWRlFnn7LTgnUpKfTxynv9vTP+8Salu3Bw0xp2+xLuwZ6IhED879h3lQPf0munZ7+LWyDgfU1QV3gEc1xqUvb772mA+L1Qn5R9E23jx8NEt5SuNooXCj0D/2QaijLC5PiJqp2ILl+0Gwq+3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ES9j3iV2; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ES9j3iV2"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-690b100da62so36269626d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 09:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710864640; x=1711469440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/L6WBF/yO8q1qFXY+u+U+qwB52PYKW+UCvdVhNRdhUs=;
        b=ES9j3iV2JBRMkvAan48pxSiBUveza/4c9K0/dDfwc09aOzmZdkhz1smErukihYnfuj
         NOoc4XxH9Je0U6HtJWckEac3HeoMmqKcVDGP9CEe2H5MT1YtM1IJyksu6P377sGaEXrh
         GRfCrPYB1a+6U9elDBRxvJS3okcwMc4hdktyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864640; x=1711469440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/L6WBF/yO8q1qFXY+u+U+qwB52PYKW+UCvdVhNRdhUs=;
        b=F0NomO02Z1F7GnBszrENs30wflWk5ymcX2M3eOjt+E4xvxihrsIzKV5+PsLJJj6QHz
         ThAkoEr8N9FgZvY2yxEYw+Dnc6EuBfjp0ij8wacTWm+1hqwUv9vmmgBrWHqqEOCSsKbt
         dOBUSnfW8hFT9wnS8UrIaoCfQ8gbtW83lCD1T8jIfLnVw0qxc9x+D9s8cVXDm+Mj+4a2
         bmzxUHI2YG3pIXIxMF8x+kp8ZJApS2nWLUOAC66l63cO8tLNEdPFAFYdwmPc7MwpQykm
         cTyAwyUYTwDzIbbRxmqEa87w1eIIyOqR4wabOnZj5y67Kcfx//1/EeAkllXaSSIQw3JV
         qVCg==
X-Forwarded-Encrypted: i=1; AJvYcCVrl6UMUEsIgsgiyq/8F7aBTIWQ5BxQTlR2hEjJn0/m21u2fiM4VgZCO17OhJLjuBl9qfJLNhU5TdtpldGQtNOwGhONUkR2xZXM/xpBFGKO
X-Gm-Message-State: AOJu0YyT8vOvqQh3aXlsLn4NbQYSoExnv9oaCuSVxq2UpvHRmeU/uVto
	9QMt03ibt7kezkr2XWYY7YmZHxpCaB5Ct43juvqN7xrIOeKKK35aYRca6BR7nI9LJSK+6+GYcso
	=
X-Google-Smtp-Source: AGHT+IGy6Mij3qG5PQrtsU45RwXRBb2G6OXILO2rQIblNijuw6GNsCVR5+gtvAGu6bE9TB3sOX2dQA==
X-Received: by 2002:ad4:4351:0:b0:690:cd2d:5f11 with SMTP id q17-20020ad44351000000b00690cd2d5f11mr2921736qvs.26.1710864640542;
        Tue, 19 Mar 2024 09:10:40 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id iw14-20020a0562140f2e00b0069154e0670asm6610264qvb.90.2024.03.19.09.10.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 09:10:40 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-430e1e06e75so434821cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 09:10:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2xIKDmh2z1wrkIqA+x/W0DPi21Rpsomxbqai3WOLQRPa/UCobdy9BckxAnA2QBSJSfaZEyJU0bfkOEoGJ1BqG2NpkAG+l3EFE+g0gRu0f
X-Received: by 2002:a05:622a:11d5:b0:42f:3b05:dc8f with SMTP id
 n21-20020a05622a11d500b0042f3b05dc8fmr390619qtk.8.1710864639829; Tue, 19 Mar
 2024 09:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org> <20240319152926.1288-3-johan+linaro@kernel.org>
In-Reply-To: <20240319152926.1288-3-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Mar 2024 09:10:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VUFodCAXEJgfpSqZZdtQaw5-8n_-sX_2p6LuQ2ixLRpQ@mail.gmail.com>
Message-ID: <CAD=FV=VUFodCAXEJgfpSqZZdtQaw5-8n_-sX_2p6LuQ2ixLRpQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] Bluetooth: add quirk for broken address properties
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 19, 2024 at 8:29=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> Some Bluetooth controllers lack persistent storage for the device
> address and instead one can be provided by the boot firmware using the
> 'local-bd-address' devicetree property.
>
> The Bluetooth devicetree bindings clearly states that the address should
> be specified in little-endian order, but due to a long-standing bug in
> the Qualcomm driver which reversed the address some boot firmware has
> been providing the address in big-endian order instead.
>
> Add a new quirk that can be set on platforms with broken firmware and
> use it to reverse the address when parsing the property so that the
> underlying driver bug can be fixed.
>
> Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device addres=
s")
> Cc: stable@vger.kernel.org      # 5.1
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  include/net/bluetooth/hci.h | 9 +++++++++
>  net/bluetooth/hci_sync.c    | 5 ++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index bdee5d649cc6..191077d8d578 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -176,6 +176,15 @@ enum {
>          */
>         HCI_QUIRK_USE_BDADDR_PROPERTY,
>
> +       /* When this quirk is set, the Bluetooth Device Address provided =
by
> +        * the 'local-bd-address' fwnode property is incorrectly specifie=
d in
> +        * big-endian order.
> +        *
> +        * This quirk can be set before hci_register_dev is called or
> +        * during the hdev->setup vendor callback.
> +        */
> +       HCI_QUIRK_BDADDR_PROPERTY_BROKEN,

Like with the binding, I feel like
"HCI_QUIRK_BDADDR_PROPERTY_BACKWARDS" or
"HCI_QUIRK_BDADDR_PROPERTY_SWAPPED" would be more documenting but I
don't feel strongly.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
