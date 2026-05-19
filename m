Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F8E2D46B3
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206546; cv=pass; b=tUqgJMd6eNiu6S9dq+9TXJXw9ab6JyeKDIXgPNd0PP3D+WCkjH+JXYVnuc53eXwfWA9CkiSgka0rg2OLW/UkYqm92TkPIhs6jZ3mV6HImGR/XO8W2GtHBm7jsX4FWHSyR0a9NWExumTVScjXvcIC9ZlGhatb4hsi0HM6o5rB5Z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206546; c=relaxed/simple;
	bh=Ah4YdxXpI0aWAarxNoUZNyImcrbh7HI0MZrM1xqtdjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jf65PkkpcTDCorYbI7SOQXDtGvem9D55hPpCKm6YgHyAmAPaJVmqfDTMcZx+oeHJMtjRrChak3FuzjEcXqgslhyc7O6bwAsOPP2U7HUrSFbF/lIJTmH8pr5k7LhBKA+19KElcqX70r7x5t73jksUVtkSBmjlkHa9imdYYceYUCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8fG2ezN; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8fG2ezN"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6579254f996so2418081d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 09:02:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779206544; cv=none;
        d=google.com; s=arc-20240605;
        b=MWeStHPtkFd9mLz7eKv2jXE6o3d9rDH7vIUL4LxXme2jqkj5ihjZ4WzxBqoyVcJKhN
         fFgHII003f9IJDwFcMwbjmaH1/Z2LAD4gqpNPLjiXukylE5pjW5G2pMNw7PPNkum4KPy
         4bLB8kpcf6tve4aYqFmSPmMUyvIy5sHLTBvnDGiL9XAMp6UdOPq8h+3cympt+9TwCzjr
         5QbPLGeIhzVcWXdOplbb6rW7qpIkvXN380XxXuPdCcjoosHNZ2YByuhtdf2APhYuWg+D
         XTjoXyaHwCaQ0Jw+gfYQ2Y5SZ+0/Em0XbVJWiykocKJYLq264vTUDk28BlUnBToctpyy
         ekVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TH1p4l8MdeemPhbOeUGNY1iwtq9xiaoF6lM7k/QLCTA=;
        fh=1fU1bKGqRRcNQUk4VRTo98kyE4unAp6onEEqIkflV0U=;
        b=JuGsAWRkPSIUNBd0gGyKMOy6DNtEo/X0hGCalihWFBnQBe6kgksz3vAr5j/0QQQ0lw
         DJSm7PG14b6kOlRDyXYzdYzs5+BF3v3+F365hHNSeBQc6Xtu22suL7NjwKmRS2BWSbVC
         ImFn4+4KzKrnvyZ1G2ThuE2oYMBiuBy5fjxxqwTnMJQF7FWjh11bPR73fGQiRRqoldJe
         qNPhDIMYGmxdNJWfNQEsLquhok1Gdn6XifrowJ1bskYhvujR/9iG5sew16QQEyKNWBgk
         MTqBxM8DzOlethm/Lh/bYwQq1FGOM1CjJuQn3EUBCpX75UyIDqqmGjNbY5Pr28DlpwIE
         lyyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779206544; x=1779811344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TH1p4l8MdeemPhbOeUGNY1iwtq9xiaoF6lM7k/QLCTA=;
        b=R8fG2ezNeHi35m5U4nFeJUKsx0yjUFbr9gM0Bbfyyd5oEB0OTkrUqYs57ReFQTDg7N
         yF9CC/saiPJO6znLgQHQs3mqdr/yi9YaWX23pd/XLW15vVhGMJx1zb0jTKEBSi6DNUtM
         li56GUXf7oH4O+iOfTZy+7pQ7lVIouEB37lcjcBjU+kzDopehnlzb2/9NKJRjxHrDpym
         Za4C2HD6caxsFgSEfpjvreHSsOVBwWtMeAJPLLokodV6iLx3ieegWrEkDfrogkHsDsW9
         kCVk5sDlu//wm5yMBSoomJ7gkZ4yfP9R8rs8FPC/Xtr4e779XtCrG2Zamwm6DqYG3oHx
         W8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206544; x=1779811344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TH1p4l8MdeemPhbOeUGNY1iwtq9xiaoF6lM7k/QLCTA=;
        b=b8aHeIz6xuFoDLp9xA5t1eqmIPLcG00sYP6QK8ZskNZtRTDEvf8qCxc+k58Ok72k2A
         JLUUXADvWy1bs0vHf8/0xXR3MWxTlUtiXZvuMSgwcXhmmTVAkFqBuyV0IHrb/PpEfKxl
         rJfkCX9M6jmzISRGHHxFvIXSbYeUi/7xaVJnuV+hE6B0MKwUP+eRWMdFtDzdnU0Jor9G
         AmJP9JhSzxnuNeY+w6BfeRu4BzB1FcN78JptavZ9Grss5idEFCbr4e7Q/gWGnrmoCS/a
         +DIQpXCbfpntgzJ7kYZHEN/h509XgmI3rc9kOrOscv//FUThUY/txhhpBK2pwvQ4PmFb
         xhTw==
X-Forwarded-Encrypted: i=1; AFNElJ+TJBuBRGvaMF5HTJ6y9X1PvwQLQkv4wgDT5/S0qxwaWfWjH3znCoUuBXR+5bmyPNZybNbbSHU/XEdLjEexBq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxChuDl7ySzyMRg+eKE7fYuoE7fB3NZvMM22Z28jHmO5xAELOFq
	GWmXTmSzSEExhTsWQVMAGbkG/UPYn56B9IM2yH3xctzeIW0MOxNQrNS9bcDbvFFv/O69Gjjp2Fo
	3szFmjEcg/Fn2VGKJfev3YyD8vPEekkI=
X-Gm-Gg: Acq92OFpVC1wxBXzVgeMXcROlY+8IkytIqJ8ECn/jjeHI2fYW3IDYlMDWnIrabHoB7a
	T1gloW/cyNMxucCcXqYA5GrCh1LCMTAx/XXOarTL1hvgkhFI+ADTTBG5W9W0J0G54a1/D2723Jz
	5a8WrYLso9n688AxT2GFGkbnD0Mqnzr57hfBkeFBASuaD7N3WO7hX2picvJmrRS1y1yJr26du/D
	il0k6tuX5SdzhXOdyo/ga/oTIcMG0KYn/91LNkBmUI4wdnZ99M+JjzkfBALNZSgi4m74VIzdnFT
	rT9nUqqZ53iHNGZIh1YeV5s5jA09DLIPq6vwtjJffnrAA5WBEn7FPVpimFOfcIMbsDtQiQ==
X-Received: by 2002:a05:690e:1501:b0:650:38c4:9d80 with SMTP id
 956f58d0204a3-65e22808b89mr18509860d50.35.1779206542470; Tue, 19 May 2026
 09:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518002800.1361430-1-michael.bommarito@gmail.com>
 <20260518010019.121323-1-meatuni001@gmail.com> <CAJJ9bXz-Or+hQnCGYi9AD9+deQQHKewipU4-17CSgrS-4i-uEw@mail.gmail.com>
 <CABBYNZKA5SUNT8maNVzuAvxqaWYt-eU7F+h58oe8e==QsH53GA@mail.gmail.com>
 <CABBYNZLMEH8D+fZp_xfu665-E0QxNaefcVEsku5wnUQrxQjKBQ@mail.gmail.com> <CAJJ9bXxVeO6a-gi+7B_FV0tciZA5-iLt1600=Fmweh850EZg8A@mail.gmail.com>
In-Reply-To: <CAJJ9bXxVeO6a-gi+7B_FV0tciZA5-iLt1600=Fmweh850EZg8A@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 19 May 2026 12:02:10 -0400
X-Gm-Features: AVHnY4LZjn6otD_WGR8aShI_hCziH7zE1s4iBXtrOmPAvhm-yONcbIgj8gc7vS8
Message-ID: <CABBYNZLTSRefwvey7XV+0NPOfNKua69Di6z3uV-hP5dSD495_w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: rate-limit ECHO_RSP per signaling PDU
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Muhammad Bilal <meatuni001@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marcel@holtmann.org, johan.hedberg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Mon, May 18, 2026 at 8:43=E2=80=AFPM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> On Mon, May 18, 2026 at 5:37=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>
> Two questions on this:
>
> > > Implementations shall be able to handle the reception of multiple
> > > commands in an L2CAP packet sent over fixed channel CID 0x0001.
> > > [] https://www.bluetooth.com/wp-content/uploads/Files/Specification/H=
TML/Core-62/out/en/host/logical-link-control-and-adaptation-protocol-specif=
ication.html#UUID-32a25a06-4aa4-c6c7-77c5-dcfe3682355d
> > >
> > > Perhaps we should define our Signalling MTU:
> > >
> > > Signaling MTU (MTUsig)
> > ...
>
> I went to add the constant in l2cap.h and noticed that our const names
> don't quite align with the spec names.  Do you want me to call this
> MAX_MTU to be consistent with the const names or SIG_MTU to stick to
> the standard?

I guess L2CAP_SIG_MTU is fine.

>
> > So we need to reject with L2CAP_REJ_MTU_EXCEEDED.
>
> It looks like this would be our first use of L2CAP_REJ_MTU_EXCEEDED
> anywhere, which seemed suspicious.  Can you think of any other
> locations offhand where we might want to check for an MTU guard?

This is our first use. I don't think this error existed initially; it
was probably added to handle cases where signalling channels need to
indicate their MTU.

> Thanks,
> Mike



--=20
Luiz Augusto von Dentz
