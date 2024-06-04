Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148EC1482E6
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Jun 2024 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717525681; cv=none; b=gs1NF7rUqpzn+6DH1oUGPZthve17BI3ygDRC5axlQaIR5tnjLAUpWPaYHn0WOpdRCmdaNw7f8xEptdTGD+XQo4DI1NHEIgy47Xy8QTwG1x5Ca62lsqP+6+90+rYwM4rjW2j9JdNOm7mpsbnaovO/sgsKtU1UFkAFFo6uHlkaseQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717525681; c=relaxed/simple;
	bh=tgO7W51+bHcDvjyP/YA64C67mrFqdBGIc+5LxIoRFGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=meqAbzTTjOQSThVQYx1ehkL4iyXNedhFHnCXZLsW4Q63Ra0jx4f7MVtFm2dGVkFQsLJbRlNbExQCMqN+OZ4AzaatKHmRF/XAJNmIrp6r9pJptIinPb+i0fZiKTsCP9v/ElQ4m8RS8tXpKEVFKE/DuQ/dx0rfkh7yGQTMLA+2fIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UfKRuEKu; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UfKRuEKu"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52b962c4bb6so4427309e87.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Jun 2024 11:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717525678; x=1718130478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtWwyHQ/s1Mo+jSgQ3jPju5LLIQLxY5LIc0kGaj+Rp0=;
        b=UfKRuEKulQPRJ1eQ1jv5CPwj5N48I2Hd/0RecNZvR1umL2CaLMmHTBGRewMLx8xPVy
         G8ohgactJFSAKbfIQPzAjtKfd0Sxw9ZtghZ+gPnY03Zy3F/AuVdbxqpIYaBWAInoXrKp
         gIaaWDULocIxS0mx9djiuvA+RM3Ihq3jAZBVqt9hPjKydR8f38k2Ee3Uek4sOlzndqk/
         dD4Azb1LLUXGqSiMu5p5k1byuGyaulNDQJDToit2cIh1xnjFr2Vmb2+SP6i40KeANUvt
         HughqwuP0jI2ouIrSLA5Pi2guWDS3j1FF1vd4CKJq38kHz60Q3jIWz1rgtycCn6OtAv+
         yGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717525678; x=1718130478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtWwyHQ/s1Mo+jSgQ3jPju5LLIQLxY5LIc0kGaj+Rp0=;
        b=qN1wr/Kji2yWBbaxEQuTDp5/A8C3LgqPY+jVZjpnHm5NvHGi0zQzqvuGI4QO8cFO/x
         6aUiEuWg6rsiEqSGQt7sylf5JpJmmYx1EIF2WO64JgJWkLFg0+3pTkBuLjiM3KmGft3k
         wXN4qFHZ/lkTGAR7C36kbE6J5/y5Dl+LDsQE20t+IQDIMKhNUV3/XsLhmdPTL7+ZFnLK
         5fRNp9fRKFDxAjJMpZmFW2flw98dF8J/JQ6WBZsRhbIW8M+812+uHrpMT0De72LgOm9K
         mgbqJ4ITXJIPIjSVn/0RPjC2Nrc7GXPaQkPNRjh70/N5MmHc/LrS7Em1UOayiySsCVi0
         qpig==
X-Forwarded-Encrypted: i=1; AJvYcCVuq8ysLAq72Az5Tq+PmSw7+09CstNEpGA9Ev9j3M9QcMHvZgXSltvLnSt9qNU1+2FsQvBATEAFcpCGjJr8Pc1O18goxMRH3PZZ6ERS1rDQ
X-Gm-Message-State: AOJu0YyLlLpJzyE38RW0vC833ow2bYbij3MO6t3bpoSNzzG6RtvYi8dy
	YitaW4Zb1EtklG4qyUbXPghze070/DtWIUpDOeoC5lxmY/ybF/jhv1xJt2blXsfD+sxWSRNKznH
	Iys0CBIPepuUEp9+95jTLn5jyixh8NJ+1ex8Ajg==
X-Google-Smtp-Source: AGHT+IEIBmN6Pbw21C48aFo92GeQIhF5kiBTsuKNdmIGqw2sOD28tsikvtBG3m69ha2Gd5/MsgbO+7NQyJOTbJOSXRc=
X-Received: by 2002:a05:6512:2253:b0:523:9515:4b74 with SMTP id
 2adb3069b0e04-52bab4ca5e9mr311493e87.14.1717525678190; Tue, 04 Jun 2024
 11:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528-pwrseq-v8-10-d354d52b763c@linaro.org> <20240604174326.GA733165@bhelgaas>
In-Reply-To: <20240604174326.GA733165@bhelgaas>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 4 Jun 2024 20:27:47 +0200
Message-ID: <CAMRc=Mf_n9xcFHofq5Q_X3xs=2jDeor1zfFAd=bM0FywyhFUJA@mail.gmail.com>
Subject: Re: [PATCH v8 10/17] power: sequencing: implement the pwrseq core
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Elliot Berman <quic_eberman@quicinc.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Alex Elder <elder@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, ath12k@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel@quicinc.com, 
	Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 7:43=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Tue, May 28, 2024 at 09:03:18PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Implement the power sequencing subsystem allowing devices to share
> > complex powering-up and down procedures. It's split into the consumer
> > and provider parts but does not implement any new DT bindings so that
> > the actual power sequencing is never revealed in the DT representation.
>
> > +++ b/drivers/power/sequencing/core.c
>
> > + * Unit - a unit is a discreet chunk of a power sequence. For instance=
 one unit
>
> s/discreet/discrete/
>
> > +static struct pwrseq_unit *pwrseq_unit_incref(struct pwrseq_unit *unit=
)
> > +{
> > +     kref_get(&unit->ref);
> > +
> > +     return unit;
> > +}
> > +
> > +static void pwrseq_unit_release(struct kref *ref);
> > +
> > +static void pwrseq_unit_decref(struct pwrseq_unit *unit)
> > +{
> > +     kref_put(&unit->ref, pwrseq_unit_release);
> > +}
>
> No existing callers of kref_get() and kref_put() use names that
> include "incref" or "decref".  Many include "get" and "put", so maybe
> there would be some value in using that pattern?

These symbols are not exported and I personally dislike the get/put
pattern. Best I can do is _ref/_unref like what kref does.

Bart
