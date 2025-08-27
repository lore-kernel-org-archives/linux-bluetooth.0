Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580AB26F294
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306935; cv=none; b=LaKqrzMnkBcwFt6/9MfAXoVJHlQOII2bXkw01Q1XnqSq+ldCTPgLuYAe+LUJEM6T9+AUFxWU0EVczKpim0WNMuaiag/upnZ8/wPF13WvIlRiig5oZcBFgOKm/HK2Lv6AyaEYJCK9waTfQpDQIr156iLiVg/vHiJ7rvFkn2ovfu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306935; c=relaxed/simple;
	bh=v2lmiEhHZWpiVJTAPc7NsEeQ6+F3KQeCwuLnM+Y7Yoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCU2qk7vpJxb24poeUNBY4rnuHVobqusiar84N6JT/5piLOAyHWWEhMtT99z/s12H9ver7Z+ZVxOb/u38Xc3o5cDB1rpKgikkoVSlEHrWDvQoFaUuRd71xxyu4CtHdJYhavVf7pWhUDnXugYiBu5WtDemI3JQNm21bG2kuALOmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xfl9P+4e; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xfl9P+4e"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e931c858dbbso5565522276.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756306933; x=1756911733; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mHluwwdULlE8Dh1IYr7/+tdny3lBdDmxy2wape6iVbg=;
        b=Xfl9P+4eZ5HnWwJwZsSKFSLn6Y34hmHwgnURQNb5WJeciQf9VxkpqrYPK2YtmF1Vwk
         phPxtdgI4UXLmaTUko2aVjiGNNW1HBK4GaMDWC9syf81lo+zOW3ApKvGeeQwauPCM3Lt
         4z6eybpmdyUMNRBlqP+oUyrhxPw0xCf1WDx2rB3CdeOQQHTREexvY0P0IFvJAJBOOJsA
         lgGiezHi+epIn3A3WbOa75joqKL5lzskEMabYcCZMOJBFK6LaTHdGr2p/Wzle+sqefxq
         KGd9IcXO6lr9ym7HnMcM1yPpOVYERQ9+DFI0LMvdjJF45xAqESYVFaBAh6Y9apJY8VpI
         AOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756306933; x=1756911733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHluwwdULlE8Dh1IYr7/+tdny3lBdDmxy2wape6iVbg=;
        b=P/XuTXWsVOWvCy1OS2Aej8VFoTwCr3js0VRkOSGeL4BH6RmprG+qp1I7l+dm4n/tcX
         wGkC0Ay7oHYZwN4bFTXRabwA7Nfl5N6VHxri0t7zy4zli1qYAyRP/jQihyfxqXMOA8h4
         z+Rzki0Blaw93mpVTajKAaxGF9lQmkwbY5QaVcpD2qwPboTbqe3S9eNyDhBeTHTiHlSH
         g9xKT3GtTqU/3lUKY7MD16UsKMlMS2jNS3QYJ1EOzhtXIvQm7MpfDvOUDo+ElM7vg+6e
         wsWEw1XR5Q7w+EgBgTMSxt2W+/HGs6umo5jNpbginD2Wxh8PiluUH0sHoLASVxFHhX7f
         haCQ==
X-Gm-Message-State: AOJu0Ywf7Rgs8qWBQNmEO1xWD/XBXwe69hH5mY8graB3K+/f3JNEXckH
	1sQlW+h42+S1Ss7hxuUxtNn9AXcRQ++13tP8dA/OVs949y3tOBv+hxD8+fsQnklgNO40kKebCkr
	0VuBOdKn2XU+wYjt8cBt5o+/K9GZ/ZgA=
X-Gm-Gg: ASbGnctSXESci6yD8ULTyYY0/eOTSS1+YqA4Uk7sNgJoFWxAAEAHdc2NIS6DUj5PhnO
	tbzkX2QATqwAoL1irRu3zJyyXok0dWH0dIS8tZ+rTrd9wYuqrm81mwMUo6iwyXNCvY7sJAMqxWU
	2x9UkRtnvlJhK++vx+PK9IbPfHHoaxGe5BNVZsZkGrDTCpj8QV+tGqUYrm0Kzr6Ix3jH9kMk12d
	vBjxqMw
X-Google-Smtp-Source: AGHT+IE9xoY0B2be1LX3RAOpy9G+fxT+Dd2DhdEdim0XZjxddVeNQm2tiLLH6KXEgbZ52ztAHQrF18YJ4g7+pLEy5tY=
X-Received: by 2002:a05:690c:4c05:b0:71d:bc04:a615 with SMTP id
 00721157ae682-71fdc307ab4mr208089677b3.15.1756306931250; Wed, 27 Aug 2025
 08:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZLmTCh_mn7w6U31B82cBZsmLaj92dxwfK9PVWZeMqk54Q@mail.gmail.com>
 <20250826170314.352122-1-arkadiusz.bokowy@gmail.com> <CABBYNZJ7kbHJ665-rsKQTfP_U=pfBwAPrGki7JSBpF7+wiXung@mail.gmail.com>
 <CABBYNZKorYK7MKUr1DsipZOUbkNuecW4WpbVKtjyb5ha5EnrSQ@mail.gmail.com>
In-Reply-To: <CABBYNZKorYK7MKUr1DsipZOUbkNuecW4WpbVKtjyb5ha5EnrSQ@mail.gmail.com>
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Date: Wed, 27 Aug 2025 17:02:01 +0200
X-Gm-Features: Ac12FXxsi330Rt28PyWHBFRV4fYdjDBtHmgqxzCxnTAhaP2DqaXvmdh5k9w7SAw
Message-ID: <CAGFh026z9qhAzLOnBUPGojtuO5dH497DppLxiA++-9=odBohbg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Check for unexpected bytes when
 defragmenting HCI frames
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Looks like we are missing:
>
> +       /* Barrot Technology Bluetooth devices */
> +       { USB_DEVICE(0x33fa, 0x0010), .driver_info = BTUSB_BARROT },
> +       { USB_DEVICE(0x33fa, 0x0012), .driver_info = BTUSB_BARROT },
>
> We can probably add it together in the same patch, so we don't have to
> rely on Fixes to inform the changes below needs to go together, but
> then we should include the contents of /sys/kernel/debug/usb/devices
> before the information why we need the changes to detect extra bytes
> in order for it to work.

OK, so, should I restore the quirk (so this check is only for Barrot
devices)? Or add driver_info = BARROT without actually using it
anywhere?
