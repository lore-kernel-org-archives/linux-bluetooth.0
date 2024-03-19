Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45AC14A84
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867732; cv=none; b=sNhz7DpzZKU4PR2W6VzbunRlQ53jKcM2vn8nNZBH3d7euzJsEOWaQ59ymlrhfMxZ5b1S+4j83qjw1EyAebVg68/B4kNBaeJAuLoU3E3z+jEk60yH17Xx60J0Yxq+T6bwunOSckcZDshAssDu00tePj6/WmzxOlNVC2TZPIH5hBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867732; c=relaxed/simple;
	bh=Q5lgL/UYUi0wBc5ljNWF/sNTHnsGWvNZaNSG+iCsiG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxnTsUfAye4fy0NeQaxRVsKxTLF08d+Ci4HA63Nwm9T35sgvgsGWSKVxcmWGxcKcLCMNauhlT6L2oflX6+cfZGMrcPkSmmEfDRtzFn0DnwB1WmXXi3PUxYO9om77zlxeZZHdwokzOrsTBEHTD4aT3A0AZVwYbZafRdTlN0RByDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mbbe0BL/; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mbbe0BL/"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso5548078276.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 10:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710867730; x=1711472530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSJayiOdnOskGqQNRA5Szr6q3i+a3h1/Mm928Gh7jmc=;
        b=mbbe0BL/+Zu7RgS85t25vJp/cl2gd8/Cd7oVK6wSSePI6BEGSQZm3CpKGzfbZUOGa+
         Z/a9TTqeMP0qHaWL/fA5ZqAv08KzRYCkqutl0zQ5n4nthBJsgh7WCWVPSSTdC4BbJQJX
         ollUsi00VsSuPuhyDIw86vBbC/n8AwfO4yBhz1S/cpyZNFMhjQGULr24HHTK9E1Yyzs6
         ebyoIrVjsriIhRwTuW9k/csgvssLiDtSXiWzbEmo8uu+1p/laJSjr9HuQgP9bFKWbRqA
         lZFIYQHgMN/LZcblY5/KmUURJcGPPcCrOZmoE/RqnKftl9pXzcaF0RBZ5woiF5qJ/Va4
         p5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710867730; x=1711472530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSJayiOdnOskGqQNRA5Szr6q3i+a3h1/Mm928Gh7jmc=;
        b=r9R2N95x2Lda+SheVAK95JRh7VnZWJlGis+8Ck9d9+OYgVxZW3XXyZlpK4eQyMq65+
         haO1lUQBpM2LI1a3IflT6i7s/z1lAnsKwL/oXlD9euXElXq5XbhS1i3UDc35qvwwnYVN
         H3W9aOXoeCsOEk+M8KYNW0meNTemAo7jKGMQwEzjNbbEuJtd0Y5bdm2UL0bld4LFsBnY
         kE8QZw9S8qhtV36pWK5qvLCzVmkM4wbhUWcO6g96rMPmd0h9D2RPSAG2HV7fFIq5QenR
         fpmS31kAH7VlucS4LoMN1tyqWKmpO9Z929G5WYDBiNv6nr1ubPJBN8oSJyDNfnfR/6GU
         P6Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUAfz4Jk+rIJ3W2cFI6cjMZt6CzAbU1xlm+wpqLo8mb6Y4p/kLHHMtOPsUbdvz2b9OjDYiX/sWxlxWhzY2ARQWX7nBGRIu/xU+Mjcohal/O
X-Gm-Message-State: AOJu0YxBhZq0DWXLHMyJxEPqw6Tis8q4QTe022zrGoRYKJET0ejruKfO
	oAij/tFUfoKxtBCR68zZU3C+tP06LQjozwfi7KQszbZHyY2eJJdaGDBWAOEx0DT9yVfZzSua6FX
	tco1/ii93Io1amwiZ2siGxVV2V+xK7fgAF5sq1g==
X-Google-Smtp-Source: AGHT+IG80CC2WBTporSlwkYDb/CO384o+uaEGdCM3vQNY6pEDnUAqPCq1EIEYUMt/sysyvog9AyZoNTpqnUl6MsDJuE=
X-Received: by 2002:a25:8503:0:b0:dcf:47bb:59f8 with SMTP id
 w3-20020a258503000000b00dcf47bb59f8mr2412752ybk.28.1710867729606; Tue, 19 Mar
 2024 10:02:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org>
 <20240319152926.1288-3-johan+linaro@kernel.org> <CAD=FV=VUFodCAXEJgfpSqZZdtQaw5-8n_-sX_2p6LuQ2ixLRpQ@mail.gmail.com>
 <Zfm8nifvqb3xO5HG@hovoldconsulting.com>
In-Reply-To: <Zfm8nifvqb3xO5HG@hovoldconsulting.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 19 Mar 2024 19:01:57 +0200
Message-ID: <CAA8EJprp89VgFMjHv=EynROUs632CfQPbEka0GAcEAy743EMaA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] Bluetooth: add quirk for broken address properties
To: Johan Hovold <johan@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	Rocky Liao <quic_rjliao@quicinc.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Mar 2024 at 18:26, Johan Hovold <johan@kernel.org> wrote:
>
> On Tue, Mar 19, 2024 at 09:10:23AM -0700, Doug Anderson wrote:
> > On Tue, Mar 19, 2024 at 8:29=E2=80=AFAM Johan Hovold <johan+linaro@kern=
el.org> wrote:
>
> > > +       /* When this quirk is set, the Bluetooth Device Address provi=
ded by
> > > +        * the 'local-bd-address' fwnode property is incorrectly spec=
ified in
> > > +        * big-endian order.
> > > +        *
> > > +        * This quirk can be set before hci_register_dev is called or
> > > +        * during the hdev->setup vendor callback.
> > > +        */
> > > +       HCI_QUIRK_BDADDR_PROPERTY_BROKEN,
> >
> > Like with the binding, I feel like
> > "HCI_QUIRK_BDADDR_PROPERTY_BACKWARDS" or
> > "HCI_QUIRK_BDADDR_PROPERTY_SWAPPED" would be more documenting but I
> > don't feel strongly.
>
> So, same reasoning here, this it not some quirk that people should go
> around setting without first considering to fix their boot firmware.

The address can be considered broken in many different ways. The name
should still be descriptive enough. If you want to specify that it is
a broken behaviour, please consider something like BROKEN_BE.



--=20
With best wishes
Dmitry
