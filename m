Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FBA472533
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 19:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663356; cv=pass; b=ZQgZuzkm+2/gdFxp3xvcgRYvUaeZZ/5GufQqbA/JAWHYqjQss/dYnlhpV7DN1oJ+/4GxadHIUOd4MQoiQxop+4CoYenWIJDKdnxdHhR8Fis5y2l/gdLP4qe4cDsvo30gJjY+Qo83sATHM6EEVZYE3X+vn9Q6qdO9uTNNMU80Sdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663356; c=relaxed/simple;
	bh=9CJ63TrqAIoMhHJmLPtT5v0WzHgjilE9n44mEHQSjI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaL5RWgABUGgBH6m2BMAdCS15bxIMm5yNgJ1dQJ+VaPjdOjNhtea23ANRcMHqHrXXPfpBiUFm0iXYlskfAOTVPfGoBowCq173HgBSEo2psa5mEp+slQkoWAIw6bIai4qkwIA+pKHagsDotvmAPV5nPE+8hBgIgQJ6py9ZoODqSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtQTMd8M; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtQTMd8M"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81e8fa1b8d6so120755097b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 12:49:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784663353; cv=none;
        d=google.com; s=arc-20260327;
        b=S/xgbkg6kBP/Ur0Psto73FfiKFU0JDN4yCN7zuVFAZLzR7ozgumNE93trpAZhFu9xH
         Vi2DCVjkosRmyk6R41cl8/hqrbessy/hqRDOiXKZng9s1R9Fb5Idy8jAGk/iReM5qHqp
         2f5HW8INsABULgaXb6V3ajtz7F8B4tclAu46Yw9jui9DkvEX3pnj1WYrHLNQbzaL/Vf3
         qhWW+Ji+zjmWdsh4ocgZuvF4zzoL6sobeW5dUpFqb8/FYnwYNP8R4LNfRiBpFmp3hwKV
         nB+0Y7eGnGvM5M7JjnCAETsh5POKjAJvsUmRlIMZY8QRHYiunDHYmE5i97YQG6KFNkjD
         ApEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9CJ63TrqAIoMhHJmLPtT5v0WzHgjilE9n44mEHQSjI0=;
        fh=Bh1nlN3ZYF09su47mg1ScalFfOowyFJSDSIvbweCwvI=;
        b=kFlL6d8PLXxchnutE95GbClk7bIaZtVynrIuu4CugkNPSezhOkTLfQhnrMGceZoi8P
         TZgr6ilujKEAtsxxx0ntj+q1ysvCzbQ5DMZPPltjj1YgrL8beq73OdotHsPHS8MSDbgt
         JHRXriPKmOUgo0yIEd127qKLXSzwLZ/Eupeyc38MpC5Z2fV4sbG/8onxwnBvrPn7wE14
         B9zq4urroiKyKckO+A0cfKIufPzIBPUvS7kQGoRH8HzphANiz/TQnLLL8wWrOd2FCYXi
         hpX1acWryG5gd8l0IcJ3YE2gpLib9zcufAcR1xcU7B9cFRupYqZkT233wXJ6bkCXhDTw
         pThw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784663353; x=1785268153; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9CJ63TrqAIoMhHJmLPtT5v0WzHgjilE9n44mEHQSjI0=;
        b=QtQTMd8MSH/xxvcipyfvjs7m12RTxYSM1N+PhTQRhzaPT0c3ai5EZWuWgP5LR3r61o
         pn59WQbsthryFLl+zuK3lZaUNR1L+x8CJlYlJIOtKxB1fEWDXoRnKgGoJTw93HwjwngH
         qVvFMvrKJeff+/rfjZCk6xJhZCErUZlrWZlpDDrwudmI4CYnFojYN5LkImo+GwlI9UUu
         H4xwV1Y2QpGE8Av82tewhl4QNUue+taBIVbUem01zMgcTCae7CoS+AXLpuUsFWAGE5r2
         n1Aft0+spbwlyAOOzLKhN0/Lx4yIJAhQjUSQBTZTS3i6kYlatOVu3x4SAl4heAJ3mrb0
         Az5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784663353; x=1785268153;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9CJ63TrqAIoMhHJmLPtT5v0WzHgjilE9n44mEHQSjI0=;
        b=Tngx+AwtWDex7Srn23KfoLDWRbnDysoUz/zw8NiuruqHDU0gCYSrUlJ49MYU4h9hWD
         oLHoQc/oAGO430hmZ2/jbmV1FhcZ9WfMqSxlrYgrFHSPOt8tvXfQMaxfuMy24T5wVN6j
         WLFeOnb+U25XT04YNr6Cb9PuicMvSNXnVn8Q0K1W0w7ojBBwVKw/clcsvexIw68JrDUr
         AVEvXMWWfUoT0M9IpZMst8xGskFzSnF7i0pwEMy6AtINtRhXrm8ECaxIMIXociHFgU/0
         njxLZwkU8EspIzKsJgg1n5pfBQD7hCmg1HJYc5bT3f9yGlcrM9hxPooeZoU1pqVAirON
         +5PA==
X-Forwarded-Encrypted: i=1; AHgh+RrLwiFQ68ksjgjg1DO4NGAp21SMCbkLgU6OqVv6Eva4bvLW6/KJwby1NYtGsLU6xoNzjrJdPTlqGvIUJOeduPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9cpUKp2iaGlEDmSTgdrWamHQSSXXM5kqcAxKXe3q+mS6A1rHk
	9LpmGB29w7cgxOBlHQdSle1EBbBSfbhLCQ7AYPav/WaYfIWxOnHqlgHs3T6WYhwamCOzKIhD6Sd
	VY93T/+uH08gIArSvDfeyVw+p1BCslmg=
X-Gm-Gg: AR+sD13iZm7T9nLUfdnOLiwI1g3emgflcIVpCFiI1dW/XUfLQaiWImg9t72vyqK2kO4
	6g7PiZR389/UCKVvChtdkkJeCoGLvHnzwoXx1a4dxsfBA1+FSJjrpHxOJg13AsLfcMVzWvWeAa5
	+Q9sMOo+FZ6dPjoMLphBKfQIJ5vMuzPjinW5kpBrcHoP7IHSHGuhzOjHj7WrbgwnPMtdvgfhMJV
	iF2Yt+oO7tK3DBhV1Ob9jrpOmGlMv/aCfrM+WzfHac29YnTjb5pdhBSYYK7BaYU/OYdpyk+cbI0
	fk2SJVNqd1VP0Wr3VrIhUT5hLODEaTO1S9TXb75sR0Fzl0sA
X-Received: by 2002:a05:690c:7342:b0:81d:cc00:cb8e with SMTP id
 00721157ae682-81ef27f1cbfmr62315057b3.37.1784663353595; Tue, 21 Jul 2026
 12:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719-support_vendor_hci-v1-1-764523a4ca3d@oss.qualcomm.com>
 <CABBYNZL_H2iRAshF-RCX41jbt0jots5i5W=aUUJC_wEN6wzp=w@mail.gmail.com>
 <0c5a924f-7382-407b-a0f4-dfd7dfe0d5e6@oss.qualcomm.com> <CABBYNZJbyfqLGNdXedi4+ZDNW0VNsiChaOTEb02Rz4rYd6UyNg@mail.gmail.com>
 <b37e1706-6a36-4e07-a4ca-8a7dc2bbebe9@oss.qualcomm.com>
In-Reply-To: <b37e1706-6a36-4e07-a4ca-8a7dc2bbebe9@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 21 Jul 2026 15:49:02 -0400
X-Gm-Features: AUfX_my9l_m79v6VUer57xXn-tsku7kczMc03aOe4zegguo3iF3yJhqM4wPwR3w
Message-ID: <CABBYNZJn2VvcNZq4xE2XS8ZZ5auVPTwB4W7q_Xpr9eNUALsfGw@mail.gmail.com>
Subject: Re: [PATCH RFC] Bluetooth: Add generic support for vendor HCI frames
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Tue, Jul 21, 2026 at 3:40=E2=80=AFPM Zijun Hu <zijun.hu@oss.qualcomm.com=
> wrote:
>
> On 7/21/2026 10:22 PM, Luiz Augusto von Dentz wrote:
> >> Could you please give me a clear direction
> >> Solution A or is_vendor()?
> > There might be a simpler approach, just consider anything other then
> > the known packets a vendor packet, so it is automatically stamped with
> > HCI_VENDOR_PKT then push it back to driver from processing.
>
> For this simpler approach:
> in TX, userspace send data to kernel by 0x31[inidicator] ....
>
> in RX, how does kernel send data to userspace
> by 0xff, 0x34(indicator)....
> OR 0x34(indicator) without 0xff ?

For the user channel I would say it would be better to always include
0xff. That way, it remains agnostic and it won't suddenly match a
different packet type if you change the vendor or something like that.

--=20
Luiz Augusto von Dentz
