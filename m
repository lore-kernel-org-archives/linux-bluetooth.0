Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118202;
	b=SpcqUdcQlIUdZ9LvePQod8p13rp103UWXa1+tsarBrCxE4Yvno2NwGAhLyvaDLyEDMim
	 nJUTUlcjEcieVrxWTNb3162p8wAV1ryJxg2bBAAJQJgdep9ieHtJyp/UhZ+faahB5p5C4
	 F2iHNjlhX48dHJxjMyEz95rATT5i7W29KZ2n0511YlbdAcnSL+VhzuMa/JiGi3jO+lHgi
	 MT+bjLHrYMIIMwBjHpqJWWaDfZSmjb3A4v1MMUkccwqLo7XdMkQAEeGqkXoRP99KHcKzu
	 GQAzck4ixa0+SCj7e+3rPrKRlOIy/tQ+FUztLORTD9OHPykCJoH0MeTfo+nZRtFILCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=y9KQL0tzMZ5wLGbnleX1k3KezJRO/wXbWLfjAafGGqs=;
	b=AE1tLf+umCADu5+dXf9TDcnQZpsVVHOAtMouxZiBqcjNXEnaqV1Ie/DrIFqFCn+q5AGH
	 cC0oE+B/bSMj/BhJyglW3AvVsi8uk0lTNHeYRA6xqW2H8aAt+NarZX0cKeaU0B9L90VzX
	 9ulL98pLWgwSZ1cDR9WWjysewpPtauYlrRxeLJLLn5yVGWvsYUBlS14jf8zlsNVBcrkXr
	 Cs8iFuyr/IUmaA3cbg82DUDYS0RgGJd/VPVghBQ83sKErtp6UEJ8Rad15xcjlkybcnPDX
	 E30iKGqoOHtrl87dhtlnZjo5JlLAFXcnFvvXuYZ4yBnUk70uzBZ4NL7QASGYAHOx6vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ICMZcZPb;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E69B606A325
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 16:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E69B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ICMZcZPb
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91c79a9a739so898676d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793118201; x=1793723001; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y9KQL0tzMZ5wLGbnleX1k3KezJRO/wXbWLfjAafGGqs=;
        b=ICMZcZPbb6zvC8h1iBt/jV4YqS6ggaY8Hu7uqmOyM1I7kZNkgNBu/DKtgEbSxKrMV5
         7jjCdxM5sLrnvgInQwVn65hq1FQLr5YIU6pTS3UCejUyWYjIe+5Qxf78S5ykqptQBRKN
         3yFVamy9ebo7evHZyu/FKbxdUc1sYCb4pxfR7fkJ9RjMfbdKhARWomfizCiyNZRR/cDY
         r9Mep+H65l2iGV/wtsawejEDBXhPLPg/P7EGt6KymSlJkrz/Ex5lW4mOgDPU997Srhnd
         +ws1jGNTTiE9dTBV4PsG0G7x3Q59hPCx2ubxzBWQqrojVTqmTzfCNKlflvw4h8U/L6u0
         9bIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118201; x=1793723001;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y9KQL0tzMZ5wLGbnleX1k3KezJRO/wXbWLfjAafGGqs=;
        b=CEzBYNvo1AJSNebws9W+XDj5hGLwj0ZTXzl2rba8avA8Qc/dt9+LhMddkwX9xfOMvP
         xAOYyUdf79B3MWomQ5MNjYeOgRvdv9zKGN0m2cJFLRaUvVzFFBpTjKpVcmzVBC5b2yIo
         KWkxbnN9HPfgeXAQ5fUjAUgJIXLLuE4GMDSwaibW3iOFZ7NFgM4Qm40Z3U+GacHWTK6H
         Be3Nm+xi0p1kN5UiWVBWnOATJ8AYj9PBLRbfYipEaeFmYjqcaN4iGSRcjzCelAOjaDPN
         KOg+BKUDL5eLXG09qN2JibwCs3C0CrI5Fw9MH55S9XKzNeQT6n6vnWX4bfe2ibAQWVJX
         n65g==
X-Gm-Message-State: AFq9FYKrwWr/34V8aze5/GUycPgLPKxCMMbKvvSBVBdFMySWAL0qQiLL
	wHu/lhD16pxGFGI6fsXriT+PNNmK+ZtQWzExWjId/bs0HeRrq0RTWOwHoru2Uw==
X-Gm-Gg: AYBFou3TO21HJ60f3ONT6XbKcrohe+xJOva7C6vFIDq2rZSEYa0xYrkuBux/hFvUF9a
	lU6Yy9ubqkniOVEtOkPXM1iUjW7FAH3JyOLQ3VcEWb4/IpSbG54h30Pyu9IZ1YTarR40yIjnRCt
	uLBRo2i5tqAUX+5ethPBBL6N7bG6oUQL0m9J4MEVzRU4XmPSUpgflpZ4n8WLxxuADJvyOugmVVy
	+l6wvWK5k+V1IHT3AO23thgMgOJXXTx6DMSCSYnS8UhTWRDi7+nkf479M0TC6S5kWbQqGGJ/pel
	5i7GdstH62BBQJOwuHbwbBHz/ZL/B82Ab7IVs9OQsqwh90IAYsk95IpHyHUQ+vJc+6TkTD9Xn1Y
	P5/7Gccf27L0wNpcx0x/9ZP27b5CsW9/SH5UHwJNbgYGt3B7tTL4gjL00Xn8wVQOWQR8TO9YQNT
	j3l+zyLiIuJSc70aRbmRQ6/LaxW6gyOgRR753rhJMa5N1QnWfPSqdaUdSD66+n3jDgDi504UBbZ
	MB923cOU1MIZuqkfwzoydw00KQNAqPAUGVA7KEQHV08DraNlR/BGYLi20Bzbp7OhXDlONQQOi1k
	5ZtKQYFrww==
X-Received: by 2002:a05:6214:4792:b0:91c:6d83:60ed with SMTP id 6a1803df08f44-91c6d836156mr47582596d6.55.1793118200876;
        Tue, 27 Oct 2026 09:23:20 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.115.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c6ffc2sm107361246d6.28.2026.10.27.09.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:23:20 -0700 (PDT)
Message-ID: <6ae0cff8.b322084d.380f6d.7251@mx.google.com>
Date: Tue, 27 Oct 2026 09:23:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3888376796801247022=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, bsdhenrymartin@gmail.com
Subject: RE: Bluetooth: L2CAP: fix memory leak from repeated configuration of a connected ERTM channel
In-Reply-To: <20261027150417.942699-1-bsdhenrymartin@gmail.com>
References: <20261027150417.942699-1-bsdhenrymartin@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3888376796801247022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/l2cap_core.c:4382
error: net/bluetooth/l2cap_core.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3888376796801247022==--
