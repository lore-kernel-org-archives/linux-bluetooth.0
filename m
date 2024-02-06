Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36133132C31
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Feb 2024 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230002; cv=none; b=ogCpALuFEXJyGoQJ26ECa1Fvcb/euz3/OKdon9eXNb50Lt1+qZLtFxjpPeXJr2/rAH5Pxp55l/WnzqvxTw8d2cJx9ItUsUVB6XaonJSWgHMm5ODTtrFbIxBhT0iPkZi0TCBViR48HP11DvXSdp3l/ym08Xd5sNI2khE/b4Kwx74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230002; c=relaxed/simple;
	bh=aMq6Ev53JhKItZopaFHmojcK/XgDpAgWw8I7zMdSzz0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hm3Lbhv3yTqk6sFFjjjvgIaFPesjCHmD7yhmnO8RRDB73pZ3RDa1lYxmGcvVl7uBmSI4OXWlO8v0RIm+YCBzmJvd2Z9hY7sF9NN3CF6Q97jBrijzUI3h16Cs0hbj5raZPn1rp/i66fk0LvxTqJKoL38kw33SK2QDtlTGJacXKbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKKAfT7t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKKAfT7t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707230000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BtbUbRDPVKlGYyqU0oAlhSlLe+49LmexRUKFCwgBbwc=;
	b=iKKAfT7tlgUDCgoS6S+TYOzb0HlKWxOisasKqoAHh7cXdW4UJsuUaBpvq/fdvrabCjw9xV
	DYnbLGBqgdNQedRuJXroCbMSlx7mhBuFJSdVnsN7JwUA8/66DeaGzfZbtSggJUTlfOqSMX
	xfcgxeShSZxcagUG1xBvLBsoQLIeNeo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-NG8IGyruP9GsIrw6D8JHJA-1; Tue, 06 Feb 2024 09:33:15 -0500
X-MC-Unique: NG8IGyruP9GsIrw6D8JHJA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33b3040e495so353812f8f.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Feb 2024 06:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229994; x=1707834794;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BtbUbRDPVKlGYyqU0oAlhSlLe+49LmexRUKFCwgBbwc=;
        b=fVgLtT7H7jpp/pIMK26d3FhZSTDuzjvt3Q+Xs8nL+exGkxX6T4hIudzrrD1A0ob2Zn
         enSXf7CSO3sl0PvvnYNd9DomLhlrGsPB+44pqam1WOV/PLGwLfU6zU2OUEAuKvOG6bLb
         AO5ICHhmvHvpN1GSMcBB5yNs0RRtE5boBhD+bvXazSBHXLLvfHU6QA38+JQPlVTTe6Lg
         0xvQw10BfIk2JobvR4mwqtZeuRVsAH44RKB8LPs7gebQrGZSg/16sGZEtBOLcB/pXP0+
         KXXm5l7D46PKVHtSZT825yGY6ipcbUnBLI0hjBPbiD3pjj76eycayur3MC5F7gNpjNLR
         tTXg==
X-Gm-Message-State: AOJu0Yy2qIW5M20Zlx0kNbO1A2w5CYBRV6jGVy984ZY/tBpCjIOlimvm
	U9tTWt07zsiSd5dK6gzQMmEpZegIoQkCnpe4/xpjyzMSzAMeqVtOyC65xeIf6ff3VRBobu9hzAD
	Y5/6fzD4aOynkr9DU89Y1xKjsNpjwwkBwPWEewLwNq9a8/DAhjew4j3oQNicit5rZcLJE0QrGrg
	==
X-Received: by 2002:a05:6000:102:b0:33b:1bc3:832c with SMTP id o2-20020a056000010200b0033b1bc3832cmr1845652wrx.2.1707229994101;
        Tue, 06 Feb 2024 06:33:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHY3hJx27JYlFKsOm9A/nvgoNSmaOOkAaYji+4JZro7ZBv7LOcSLCBqXnr98yV5ZJVYM2D12g==
X-Received: by 2002:a05:6000:102:b0:33b:1bc3:832c with SMTP id o2-20020a056000010200b0033b1bc3832cmr1845636wrx.2.1707229993789;
        Tue, 06 Feb 2024 06:33:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUyAXPidqmtg5gS/+JjKWqqaymaerKreVi2SSyh+3fVdIPGK3sYhQJ46R5jexNnwJqE5cgSGJ3G75vbkLnQkAxyvXJ/am189muxW3MbTvoY4j5tfewt32FNaXDROLv39wADkU6gtckVknKfl4A=
Received: from gerbillo.redhat.com (146-241-224-127.dyn.eolo.it. [146.241.224.127])
        by smtp.gmail.com with ESMTPSA id n17-20020a5d4211000000b0033940016d6esm2227222wrq.93.2024.02.06.06.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:33:13 -0800 (PST)
Message-ID: <f40ce06c7884fca805817f9e90aeef205ce9c899.camel@redhat.com>
Subject: Re: pull request: bluetooth 2024-02-02
From: Paolo Abeni <pabeni@redhat.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net, 
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Date: Tue, 06 Feb 2024 15:33:12 +0100
In-Reply-To: <20240202213846.1775983-1-luiz.dentz@gmail.com>
References: <20240202213846.1775983-1-luiz.dentz@gmail.com>
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

Hi,

On Fri, 2024-02-02 at 16:38 -0500, Luiz Augusto von Dentz wrote:
> The following changes since commit ba5e1272142d051dcc57ca1d3225ad8a089f98=
58:
>=20
>   netdevsim: avoid potential loop in nsim_dev_trap_report_work() (2024-02=
-02 11:00:38 -0800)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git t=
ags/for-net-2024-02-02
>=20
> for you to fetch changes up to 96d874780bf5b6352e45b4c07c247e37d50263c3:
>=20
>   Bluetooth: qca: Fix triggering coredump implementation (2024-02-02 16:1=
3:56 -0500)
>=20
> ----------------------------------------------------------------
> bluetooth pull request for net:

A couple of commits have some issue in the tag area (spaces between
Fixes and other tag):
>=20
>  - btintel: Fix null ptr deref in btintel_read_version
>  - mgmt: Fix limited discoverable off timeout
>  - hci_qca: Set BDA quirk bit if fwnode exists in DT

this one ^^^

>  - hci_bcm4377: do not mark valid bd_addr as invalid
>  - hci_sync: Check the correct flag before starting a scan
>  - Enforce validation on max value of connection interval

and this one ^^^

Would you mind rebasing and resend the PR?

Thanks!

Paolo


