Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07083255E26
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756147797; cv=none; b=ns1LC5vsh3Z2YP1cQJ4WpYVwvMd8Q9ktocDLqHza6djrs1RSV8nsuIATsKKrSJNT+iruBM1ithHbXqEBQm0gBD3G4XO26z0pfKrnqmzA/BoBjTZmDYbnpdeqaEa+RrE/ZNog7u8bGviXEZnjgOqiwQUyU7U81JuuQfqLYwh3pU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756147797; c=relaxed/simple;
	bh=vWJ+Le7MwX1O51TL6Q6wkkZ7EfE1tmcJO/wC85HslpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADTNd1+ZRpgA3S6LHwCeHIEgVVdgeFm1d5y6Or7y4pNWjD+1L0mWmNB5sR6NBdWNKxAdG1mzJbAgd0tbaq1VwnbjlBSGxw1rKgVirz6R6h/bBnN7/yIaajGLgiaHbhPTue4bBJ/INGjqF7+uO5Wiuwc6JF65pMPCVXSBSPEDe0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqHNwFsk; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqHNwFsk"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d60150590so36574237b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 11:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756147795; x=1756752595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vWJ+Le7MwX1O51TL6Q6wkkZ7EfE1tmcJO/wC85HslpE=;
        b=KqHNwFskpA+SOQAKwur7T2GDp4ezNi7yX8Rq86B+lF8kL6WD960x4ouhGEOzr12yao
         2oXopV4X8KH+/AXhgC9ItwgjV3EPErWJwPduVxPuB4GgVubo26RBmnR1ja6eTs6VV3kz
         OLD3pMkX8CWxRB2OTR9Dku1iwcmkdebuMR30tuCQ9YZsgR7SlzTNd8bCQswmB3rGD2tK
         OpPJTbvKhTV4CJ+yrz4ki3qrECmk3veH8wGXUHU4ap5HUX2Sy/BE2vFVC/tWIYCeVJDx
         lQiHnP2rgqsCyyZWU9oTqlDg3Yj4W6GJSxEXHublx5zjUjn7tI9H1gq01XbYjE6Cg4+p
         sJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756147795; x=1756752595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vWJ+Le7MwX1O51TL6Q6wkkZ7EfE1tmcJO/wC85HslpE=;
        b=iTkHlosGdZlgLNDZiVKCVqkcNEnuJo3hpt+Tms9Xm3Nk+8OqVZqjcaOYTaj3BJ/lQl
         uZi056d3s8v8ZsxsKgpis+JK9kutx/zGwLAAntVGH7+NTvrjQZh6xUFfxVUHzjjoTPmv
         tUJspI9aXv/RKlFnMye4F29uD7N8kkcOtap1I/+q1Htl40m/bhQOunrlPKD7ALDUL+Y0
         mGqWxXRvgxOnyGYGh7B8RG0GgmJG7LnuYZ5/6b2Vr8XPk7a1CZfSVfGZ15QjJcYcC72F
         VWym/dkwa2I8LbB+2hNefoIVOEQ/vVtngB9Q5gh8zDCDX9NhGtoQ3x3uF/rlLJbd5t8P
         vQ+w==
X-Gm-Message-State: AOJu0YwuDYEPZgGq+ZS1rcxoJs6IsJM2qnuVzEqR5Z6JUT6XFJF/tNtn
	MCVvQxuAwW0qTdVJ/fVwEqd9O5PJ11RwrnQrdkpgnPnM4O4pc3Kv2cCu/vrmW7/wj9oHEyFlmUg
	YVfSbfrvoQsRt32GX6EQxpUm5Ep4EVGlTMw/lPJs=
X-Gm-Gg: ASbGnctz71hH9P4zb8EHzK6qLD7uwxeUd73QF/NuAmuI0TrYbIzjdSjYUatbZNXSsol
	1UcRNtNgBopoCj989lrm9kg7wEehPoiOBROGpJe0l1WJRbhJgT6aFVdHheSMZ9TZ2Sg18KS607/
	9me5epxb7eUGElu4qA30LFu4fZjEMcXSFoh/y6cPkThdUhBD1caACvbpd9lf14d01hHDYx5ouAt
	qClie2j
X-Google-Smtp-Source: AGHT+IFO8SoUpSNfX5bDtTPEEtHply5On1VMSltLffLoq8GlgvQ742yFXGgFJg9Zv9xGrIk7ji7TLJb9Tp5FC3IrviI=
X-Received: by 2002:a05:690c:9316:b0:71f:ecde:87b0 with SMTP id
 00721157ae682-71fecdea20dmr101938637b3.16.1756147794725; Mon, 25 Aug 2025
 11:49:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825172504.339117-1-arkadiusz.bokowy@gmail.com> <CABBYNZKazQ0zROk1+gs5=U+zaZDwkMmD01MTYLuMZ3VUaoZZQg@mail.gmail.com>
In-Reply-To: <CABBYNZKazQ0zROk1+gs5=U+zaZDwkMmD01MTYLuMZ3VUaoZZQg@mail.gmail.com>
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Date: Mon, 25 Aug 2025 20:49:43 +0200
X-Gm-Features: Ac12FXzXbsFokNmjOaik1pPtl_HYzFonNeuicbztC8WKdfJ9di6GIcrI3ly9uP8
Message-ID: <CAGFh027fC8z3mx4zMm9Zu8GKFu7Ae7MKbze3Ef+4g0x90sRCag@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Fixup quirk for reading ext features on
 some Barrot controllers
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> This issue above seem to be something different though, it looks like
> there is some fragmentation of the response but then in the meantime
> we send another command (HCI_OP_READ_BUFFER_SIZE 0x1005) and that
> times out, so the description and the code changes don't really seem
> to match.

This extra byte tripps wireshark as well. I have exactly the same
dissection in my case, and also I thought that the problem is with
fragmentation (which kind of is). If you look at raw bytes in
wireshark (not the reassembled packet), then you will see that the
0x1005 command response is correct on its own, however, it is
reassembled with this extra byte from 0x1004 command and then
everything goes sideways....
