Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC07722EE4
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 May 2024 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636299; cv=none; b=BFHFJ6a5FEBbf68srAa0HERlM8qzdpHMzGd+8SJ0FJDCuVUf8q+oh8xAqOkz9ioAP4afKGQSqZwzQ7fwVVLvg+0BqooAo3tMq8yUoBNjP9MCFaYD9g68KU70MRt4c6tEL6FB3QhqkqU/BZC7iEGNr2769w/n+BWBgJpyplRxeFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636299; c=relaxed/simple;
	bh=kYoS0DMOZ9opD4qUEZZ81bljlubz2EYYFhlTXUUBuBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amT/GpmopFzhjSAjMrZMLb9y+WjLjiur8/cRDUcIX8SxdPVJ6hRJvDMXEipQA+6qXfD7zARoBJmd4HboaYtKoL4GxW624aeV3I63Q8LfonlRu5WYwZQBrbM1icTSDFuJVG4ObSepTi0rYkv009zoDzKf4yNzmWPJYpoO8F0ZFtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O4kmKZzR; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O4kmKZzR"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51f12ccff5eso663567e87.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 May 2024 00:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714636296; x=1715241096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juAuSH1JPhY7PWUJ70Ld08vmAUyCp8zbapAQIba/lj4=;
        b=O4kmKZzR8W/uAJ8Z6XHT1oeyyWTlxcDK34bqXY55c4d/mGW0oMTgyfyj2PjlTnVJbt
         y9ALVA7H0rKFaJjtF1Ip9N1+GfPUxwk/loFEWbCpv1mO1F6QDrtQ70BqOYPQvFVmy0om
         rGs8tjRGTfszA35ZYV7Piz7seQGv5Af7Y1Yxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714636296; x=1715241096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juAuSH1JPhY7PWUJ70Ld08vmAUyCp8zbapAQIba/lj4=;
        b=K8+lPFnVUzVya62CMfGAvFCVQ/kTlGA0gW8H8I0IX97Xy+Dj8q6X0s8QDDIbyfmPVw
         cR9VSyhxzTLPCUFm1nIpZgHF1BLBKpQwyNHn8jN7jF2sC7wVfBjt0HMiN4pnKo0Q8+R4
         x/Ts+X0ORBMFcFdF9TxEwF+fqEeymaH5IhAUlS7wG8KTqwOQ77kkXGwXZNk/K9FlZmad
         30HBOektix5SdONuqLNDlDl35SN17AegTlKsf2qqThPaPqftk4e02vHsAt9oWASTjqwx
         5UifxnnlUGGo84QlB1v1aYoPp/j79bgA8VA9t1sk/xYVdujKPDelKiF2tAecpYbnPFQt
         YTig==
X-Forwarded-Encrypted: i=1; AJvYcCXidbYjc1cw54Q8OgjIDoYZgkYkgXe1vLYzau56EYBNbx4z5eb+9iZwhUJ3LJN9rLNmoEFeFT/hsDCl7zdC0Abrw8I/ltci3Tk7GzFWVURx
X-Gm-Message-State: AOJu0YyAGmsh1gmb2yy8KMK2Xwvn8kdsAnKnNtXQTzK3TmiiDRwWrjwB
	eLmDP7SapLGiAOSZhyr5+ijX7p8f3qGfn7biOwe/9QWsgB6kpBQhMUNQuJFrmord9Z0zqk8Kia8
	5STne48AdeKHYG+NdVYiunZyuHst+KPY3dGOd
X-Google-Smtp-Source: AGHT+IEAVYn1Zg5pB/+HWCfbuXWxOWUqPfY3srDAkAXrE3zW+4aKcPJ8YB092/ynCkhEGaNCe+bioePdFycOCNiVjR0=
X-Received: by 2002:a05:6512:3108:b0:51e:12e2:2a1b with SMTP id
 n8-20020a056512310800b0051e12e22a1bmr714499lfb.41.1714636295807; Thu, 02 May
 2024 00:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412073046.1192744-1-wenst@chromium.org> <20240412073046.1192744-2-wenst@chromium.org>
 <171322232789.252337.16326980700188367647.robh@kernel.org>
In-Reply-To: <171322232789.252337.16326980700188367647.robh@kernel.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 2 May 2024 15:51:24 +0800
Message-ID: <CAGXv+5GroxzyUSQZNW-r9xt6Sgy+EGv3+08Htbb_ZcSRvaBR0Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S
 SDIO Bluetooth
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 7:05=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
> On Fri, 12 Apr 2024 15:30:42 +0800, Chen-Yu Tsai wrote:
> > The MediaTek MT7921S is a WiFi/Bluetooth combo chip that works over
> > SDIO. WiFi and Bluetooth are separate SDIO functions within the chip.
> > While the Bluetooth SDIO function is fully discoverable, the chip has
> > a pin that can reset just the Bluetooth core, as opposed to the full
> > chip. This should be described in the device tree.
> >
> > Add a device tree binding for the Bluetooth SDIO function of the MT7921=
S
> > specifically to document the reset line. This binding is based on the M=
MC
> > controller binding, which specifies one device node per SDIO function.
> >
> > Cc: Sean Wang <sean.wang@mediatek.com>
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v2:
> > - Expand description and commit message to clearly state that WiFi and
> >   Bluetooth are separate SDIO functions, and that each function should
> >   be a separate device node, as specified by the MMC binding.
> > - Change 'additionalProperties' to 'unevaluatedProperties'
> > - Add missing separating new line
> > - s/ot/to/
> >
> > Angelo's reviewed-by was not picked up due to the above changes.
> >
> > Changes since v1:
> > - Reworded descriptions
> > - Moved binding maintainer section before description
> > - Added missing reference to bluetooth-controller.yaml
> > - Added missing GPIO header to example
> > ---
> >  .../bluetooth/mediatek,mt7921s-bluetooth.yaml | 55 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 56 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/med=
iatek,mt7921s-bluetooth.yaml
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Luiz, could you pick up this patch?

The other one is already merged in the MediaTek tree.


Thanks!
ChenYu
