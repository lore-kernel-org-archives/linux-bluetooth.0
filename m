Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C20137C5E
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Feb 2024 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232887; cv=none; b=llvS4nhRIxQBAXP05VnnH45qG/cj7a+Li4XuhNdwdH1dCWQ82OOcgcNBZbmETj7ca2Axss2aAmh4xmDPvieB4enrG8HCFV/bC7nuL1qMoR6118uBrN8vQXsGQIZbWwJsWeokkbdzSsbGcV6t6lvQJQZsahtWERs+qyjnQSddKYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232887; c=relaxed/simple;
	bh=/gMmpLzJWIxb8FFUuYsNekgWVFElmoa+JkzyU0DhqOI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F/jLSAt/UwjlPhF0YzJZUvHKF+f6VYH84PB773KlLbkTg3sXlYo8mCSrO4VEbytBzAEdiWq9+cnRIBbVJAZQRsPn/Tgur+t8ilFh9dFrtJ2idGK3vC3mVuWYGkUrfCaT0dzA8bZ16BCXlG9U9V7jV0ndWz16PiQCa3Dwsf9kWRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HxU8vQAt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HxU8vQAt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707232883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KtZT4d27yYdTQVnM02PQAeokr633B74ghQRGfAYed60=;
	b=HxU8vQAtm/ZbUyp4CpwowxMSJh09mTe9yRKopUd4G+PdGvOLBJREs2r9FrSLZbeUYGpKIk
	kJ3zGLO/rosloV8iS7kxQMG0wrlyUS9afAy8LPrOAiCCvUm9cRgo5BrwyoHhQUyhXGJ29Z
	9+S/Tc7kTrkjgWFWGcKsKKFXn4gCbHM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-Whe9BrofNL-b8Wi1okopMQ-1; Tue, 06 Feb 2024 10:21:21 -0500
X-MC-Unique: Whe9BrofNL-b8Wi1okopMQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40efaee41dbso4441445e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Feb 2024 07:21:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707232880; x=1707837680;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KtZT4d27yYdTQVnM02PQAeokr633B74ghQRGfAYed60=;
        b=fyEp6WTAK1MUDqE9FmwPo1wQLm5x0iOVphf/OtxshoiCilOVVoY5n6ie+5AdPTYzOQ
         82Z5a61NiT1vxdW8dGDqOxU9D6iFWUexK/sUCsPxkEQSz5SVUJapyCq9KqOni+FPcjjy
         W7NxKkE2EvNLLqNqo5NFJLXaqlxpHV/dMwiKyPbaohs8V+ID6okz2RGEeVMeAtD3HkrB
         vDCIelOfQUP88QgwIRGzUojR4DYBAsifQlUjWrg8vh7y3gY2wV9BRnoDPHocl/MCaODb
         kIqI3ENZkxXqdXhGT9ZHB+erW3KvZ+7AN1rQwJtvtGwlNa0jWUNTD+syl7QJdrENgqBk
         c3Uw==
X-Gm-Message-State: AOJu0YyZ1FAP9PpfTzdOo1x+HAzQ6nGaFTu/eCatvWpOllKZS7kvSUzG
	YYls0+cuRjVr0bwz3r1zeBP3kFQBNDuN68zujC3LbljOhZpl9NQ1PYEMfGn6Bj9C1rLI98Ktpjc
	SY7B/aTAzoX01w2bF6vDXvkKblRu0wZdsrrj5DyRlXZJ9W6zkvth8CFYG9vybGoeZ1g==
X-Received: by 2002:a05:600c:198f:b0:40f:bda6:ccc0 with SMTP id t15-20020a05600c198f00b0040fbda6ccc0mr2469157wmq.1.1707232880369;
        Tue, 06 Feb 2024 07:21:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3kW/Q7o9D30UrkCa43SPi85YrQbYtYPA6s5PpWkoqxyKqbVOh8q2xWSGv5dTR2TcD04ZqrQ==
X-Received: by 2002:a05:600c:198f:b0:40f:bda6:ccc0 with SMTP id t15-20020a05600c198f00b0040fbda6ccc0mr2469133wmq.1.1707232879996;
        Tue, 06 Feb 2024 07:21:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXNFiX4vOsphCQ+kSGaykMnM6WWOxavLDf4HhhMtjb8C4XXI66VGZxDkAk3xQ+vQILyzxS2KmSSPcX/wBqIK6eNQMCTVtsBSCfohIN+Z5BPR8Dnh+epDySli7dZ3dZStzk3mpVgfwTLVUED9dhErTxcc9UtW2if/sk=
Received: from gerbillo.redhat.com (146-241-224-127.dyn.eolo.it. [146.241.224.127])
        by smtp.gmail.com with ESMTPSA id fa26-20020a05600c519a00b0040feb292609sm1560480wmb.37.2024.02.06.07.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 07:21:19 -0800 (PST)
Message-ID: <69c9e55b40ff2151ed456d975755d9d4e359adf0.camel@redhat.com>
Subject: Re: pull request: bluetooth 2024-02-02
From: Paolo Abeni <pabeni@redhat.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Date: Tue, 06 Feb 2024 16:21:18 +0100
In-Reply-To: <CABBYNZJ3bW5wsaX=e7JGhJai_w8YXjCHTnKZVn7x+FNVpn3cXg@mail.gmail.com>
References: <20240202213846.1775983-1-luiz.dentz@gmail.com>
	 <f40ce06c7884fca805817f9e90aeef205ce9c899.camel@redhat.com>
	 <CABBYNZJ3bW5wsaX=e7JGhJai_w8YXjCHTnKZVn7x+FNVpn3cXg@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-06 at 09:45 -0500, Luiz Augusto von Dentz wrote:
> On Tue, Feb 6, 2024 at 9:33=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> > On Fri, 2024-02-02 at 16:38 -0500, Luiz Augusto von Dentz wrote:
> > > The following changes since commit ba5e1272142d051dcc57ca1d3225ad8a08=
9f9858:
> > >=20
> > >   netdevsim: avoid potential loop in nsim_dev_trap_report_work() (202=
4-02-02 11:00:38 -0800)
> > >=20
> > > are available in the Git repository at:
> > >=20
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.g=
it tags/for-net-2024-02-02
> > >=20
> > > for you to fetch changes up to 96d874780bf5b6352e45b4c07c247e37d50263=
c3:
> > >=20
> > >   Bluetooth: qca: Fix triggering coredump implementation (2024-02-02 =
16:13:56 -0500)
> > >=20
> > > ----------------------------------------------------------------
> > > bluetooth pull request for net:
> >=20
> > A couple of commits have some issue in the tag area (spaces between
> > Fixes and other tag):
> > >=20
> > >  - btintel: Fix null ptr deref in btintel_read_version
> > >  - mgmt: Fix limited discoverable off timeout
> > >  - hci_qca: Set BDA quirk bit if fwnode exists in DT
> >=20
> > this one ^^^
> >=20
> > >  - hci_bcm4377: do not mark valid bd_addr as invalid
> > >  - hci_sync: Check the correct flag before starting a scan
> > >  - Enforce validation on max value of connection interval
> >=20
> > and this one ^^^
>=20
> Ok, do you use any tools to capture these? checkpatch at least didn't
> capture anything for me.

We use the nipa tools:

https://github.com/linux-netdev/nipa

specifically:

https://github.com/linux-netdev/nipa/blob/main/tests/patch/verify_fixes/ver=
ify_fixes.sh

(it can run standalone)

Cheers,

Paolo

