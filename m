Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E253164C9
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225420; cv=none; b=PmOSC70TjxI0T0xc9N7dHTDO03pgDwM+tI+4KN+vsiitBMzkosKE76D+d4E81MBErVwV3d2+gZQ1mV78U8btyrYiV0KU+nparTLdpY88OM3YaM2bP0rknSf6ACGoI1L/JcAauUUSHZixf1RDCWpWTmjgVvN5f+BZdWA1T6/Ffzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225420; c=relaxed/simple;
	bh=NxaybHfTkCJWV3wNdw49tIMZkm/O38ckXVCxBXRPmYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwcwKugMunBpgTeb62gEUhEVs+H6lK7R148Ud/Vx4uyl93fJRQS3RY37X2kex7ENTYure6xIcStX73LnyYjyAe9PLvdfMkigO5YNJjqNJYJ5XhhL/Ix689mGCes6g9IR7CmieGdGMH5G9Q+Jdnk9RGXjh599kqonZrmw9CpQtm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhAihntD; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhAihntD"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e94d678e116so5110573276.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756225415; x=1756830215; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NxaybHfTkCJWV3wNdw49tIMZkm/O38ckXVCxBXRPmYA=;
        b=NhAihntDfuUqLqSFv4WfQomRo3IGPXF9tWCVZwlNJcWVv9jHjLSUSuM5ts+Pb6G8eD
         76sleVTKTBX383rghc0s5vipVsgX2PSr9VfDXYuXJhYv46okwk33AkDeUhD6X7w+x2l8
         x6a5iLQUYq1cJSDxsq7TKQ4w+nt3tc/7//l7UWaeu4afax9FQYQpXSt6SMgSGJBvZhyV
         K/mYkcTFmqH9Uce+qlrLNLnyV8AqqujPMMkk6drS8LtxxtndgzWQTC7qGBxTwmZcSiVi
         y9I3NB4hUYRTOMFDJiJsHgnD0mTtvbwBPKjlZ54eymhPWOYxWxAicr63F5JNYqMCaSsM
         /OXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756225415; x=1756830215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxaybHfTkCJWV3wNdw49tIMZkm/O38ckXVCxBXRPmYA=;
        b=RgdTJnY0BnSKkk/LilQZm5aHeKw2f/3iB6Iv/YroPkD4aCwAr57LzwZiFsMWLqa3aU
         Lt7+hHvpLWKYCOi9kiD1SLn/T9SGYjSbExR9n9LGjT7vlQs+te/eyVTWxZUS9CfYcsoT
         pDCGZvLg2HNfR9oOunp/kDc2mWGW8UeUjuDhEnAgvKw7W/g2lVAmrDfJISWmw+HC16Yd
         br79bO/BQhVruNPrcRruBzh7ojTpFJR0mTkSOa1lel4+3qGNBdHU087ES9NgS9j+kCdc
         M8mdQ8tSKO08XE11Ke+3YOfTDr+JgSYn+XIYM9OXNoUrNZuou1YKWAeSgiiNOkHdNsYq
         AyhQ==
X-Gm-Message-State: AOJu0Yzr0+gJhQsEGN91TI1S28gORMMsFJswpB7drfNAvIHMqmwy4IuQ
	Rad3mwxk2po/gSq2VdXF27HAAoiazbpGVi+0f6JZKe0lHLJ8DBxMGRpopjIavknK3lmGKgkYaRG
	Itpun3h6/a+INcVekaqE12AOBaYlKtZYoxwQVMqE=
X-Gm-Gg: ASbGncuXcox9QN5fCjazWoCVkZ7DcFQ3eyRSqcECQUiQRcHHwT24HUOQo4MS1/xXQNH
	oXkC1Fk3Fpit78rx5h5sBC4/PDwq9CzoXwminZRraTjg56PUWm1H8C67VEp8H5LzSec78kOXHQu
	fzJmWTdiAqVg2OZp36lYB45t6yo7V01lg3Boa2YVbPpohbaNIklLxV8qDKvnzbs3qrL8jESVuFD
	KmY5SBo
X-Google-Smtp-Source: AGHT+IEuDSruDEWla6jDIt4TRGXkOWkuFhWtUJl57XumHQViEGQwz8GEDY09caQ3IsI0XpzFL7L5RUtx3HKnbQDFr+0=
X-Received: by 2002:a05:690c:64c8:b0:720:c20:dc29 with SMTP id
 00721157ae682-7200c20e1acmr88353797b3.51.1756225414896; Tue, 26 Aug 2025
 09:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825172504.339117-1-arkadiusz.bokowy@gmail.com>
 <CABBYNZKazQ0zROk1+gs5=U+zaZDwkMmD01MTYLuMZ3VUaoZZQg@mail.gmail.com>
 <CAGFh027fC8z3mx4zMm9Zu8GKFu7Ae7MKbze3Ef+4g0x90sRCag@mail.gmail.com>
 <CABBYNZL23GLaO0tQD9iYaG=OeUbxvbKrKCX1yOv7kfvM+L7W5Q@mail.gmail.com>
 <CAGFh025kOatLYjLrBMzrFQQG0oQHZQ-4=U-d0Nky780HrrOPhw@mail.gmail.com>
 <CABBYNZKN3PwV4XPM3=7t_1-+=m1nAmEVcZ9UB0yfgks45vnOXg@mail.gmail.com>
 <CAGFh026t_ba4x48ZQqhKnBxkQC=uLF5O8vHx--c_fxJTS1b=pg@mail.gmail.com> <CABBYNZLHWsNXWRXn4CyK9yOQ6=TosuFMz=NQ6FPBk+_tu63shA@mail.gmail.com>
In-Reply-To: <CABBYNZLHWsNXWRXn4CyK9yOQ6=TosuFMz=NQ6FPBk+_tu63shA@mail.gmail.com>
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Date: Tue, 26 Aug 2025 18:23:23 +0200
X-Gm-Features: Ac12FXwxLROVqsQuXnUABrBJb7Ni1yw2_i7BkkX03h9P0i3YXPJlAcFSgzM9JTw
Message-ID: <CAGFh027-mBYt-6DYLcxV8S_qXH2javvkyK56J7Lo4_9mGeKe=Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Fixup quirk for reading ext features on
 some Barrot controllers
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Great, do you care to respin the patch with the above changes?

But, I'm not the author of these changes any more. It's not a minor
post-code review change but a different approach. If you really want I
can reupload it with your changes, but the proper way (from the
authorship point of view) is that you will submit this patch as yours
:)
