Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798023;
	b=yq6w3CvUyWZaaqNhgj9b+/rWh+rILR3JyHMM0WBnER8yXLHEDKwQ0WT0MleUqBGnHTvu
	 1PKiF7IuuJ+8McwPuPfQMcyJYHewCHgSHpATslTUoyCgzUhEdhW0JCtGZ5nI7iYJBl6J7
	 7cVkQmYXoEkQ+fXIKEfwLQpjCKVPlEAxEoNlVJkeDdA0xpM9oRYMrBfLYMWSjGPSZha+V
	 G4ZyVpFSH4UUI3/BWK0bFBhu31x6q/bRhwhRbAR8L6YUCbbEmzJ69qh8V0THgnH0HMTO5
	 5vS5w9k0He8h2piiRzu86L60pxU4tk7o2sTeaQnEdqCaFS4nyipgD24If+oQnxs4K7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=K4z+sUO+Dik2MJjINHTz4IuttGS5YdWrrzRJdcE9CUE=;
	b=acMA4xwAncMTpk5jqKKWPuXA9cp3VLMbHCes+y8KOFvg63+pUpfMhy4zwKtbQjeMg5Bs
	 UvpOrb/ns3fs0kK9BYXsmxJh7s5sGDuTWcthHzklQCrgm18q1U+iF/DwRoxOGKLIXyqCG
	 Jtk0kpBSDdYGz9em8CpFVIp/y5flRxjjcygbDlzaGrsP5FgWaSZqt1LALUiJVmlIL99s9
	 OTBoIcjNSg6y6wCiOjDiEZom6YA7wnOSHcGikHqEYr8Cr5YRLJ08jUCeliGRMPEblMSMz
	 k0w2BhadA935KwTIotyPYLViTzYiazTUyfLZfJWD9x6jtsNw2IqS5nDb+3bzqUEnk7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RkxJJHtI;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD7F606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 16:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AD7F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RkxJJHtI
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-170135e43c7so12871865c88.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 08:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795798023; x=1796402823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K4z+sUO+Dik2MJjINHTz4IuttGS5YdWrrzRJdcE9CUE=;
        b=RkxJJHtILtB9F0Q0K2XfnOrCu6aYl3qCRKBXAIwzF6vdwGM05b1Y0BbsyfS48wB7KX
         Q/wBNgaF3+rXEtSIDuo81tM1f6WaHd4S2HMtj8nTT6dyfhShO+dcfDOJ/lYl/NFCy7Y0
         dIEFFgMPfsZ4SL4xtNRgsUQlAqRKKEH9fGiZ0ZfhdTTqRkNYML9DnUbYnVFINvBsBfpk
         fOWg5+21i8759dYAXg3d1Ke+NeXjpCpID2hR8MvfUgt0B1wejU5HiMgSInHgbr18P+Ln
         3/fXsQAjShljgSHQNDeg+rO2wKsiUFeUCR9OhKiI1nN/s+UIwx5SREINk0wD8CovxH+Q
         FqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795798023; x=1796402823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K4z+sUO+Dik2MJjINHTz4IuttGS5YdWrrzRJdcE9CUE=;
        b=tG3GcKHAs2P3ZriwJbT4TJrVBZLrqI0a+nKPYaeltNpbo3U/jbmxeV7ZQTZhO1o4D4
         0T1FOnVfOSu/+dZ3EW5BUfr9jhrJoWss4MMBlY3seCHeZisYEH7fG2k+kfAYf1QTanqo
         6vinyjOSdthnPOjkec1FW/jt5BbuigSnx4PKgd1Ax0MNIIG0/vZ1fwNZQ11qqIOw7g6p
         G4xposzDbI+7HxzOFB2sGHZEomcVcScQqqoCtW0Vdd2RQGE4HPPAFmn0qycSdzz54y9v
         ThuyqvAC8tMi4KuYrfjb713GMvFQUXMTM+lR3Y1gs7OoKKoNy/HK5co0tH07QB+T6ZXo
         98AA==
X-Gm-Message-State: APuU4Z/bgSDEi6gIR98q0TtLWhRRpjIHUsJpBqRI6GUT09y9MjTAZ8aj
	Vt2nA/FyflAcSGep03qget2V8r7Ty8QgBZGOmpkozAvxYcdCASrPt88ThTXnNmmdrEw=
X-Gm-Gg: AZFdTZfNz+fFvYvmtVy0xiinnq+/v20OcrqLkL3eY6ad8RGBhGGCEF2jqtjIqZ99lzv
	/RBoFytSQ2a2VIT3sMaNqXkjrTWBgx0ddyd7t9XvK4Mid/TtXzra8AhzSkGhRFUJ87mxEoXaVjx
	UWVFnKdcPU1jZO4zxIAHbRSyIjC3aZ6UPQijk0OLwxuXoov0VIDzM683OIfRdlm6cPkNIsqC3JW
	+P5dy/YoFr5+yvT8MFE3QIPGDy5/qKa51rDJAILyed1x/LMp9zsuPB7u9lg+jEAWsVvDMlQpMiJ
	ksLCvtkBQ9P2Y1DnrYE60pNjjAfjtD7z2Wrxn5Vtha26/R4kE8TSFc5LVqXzazaBtzZGLzd1qPq
	OQJv2DGPjSrv4yL++JtevL9sjo/PoER5FGf4wkJEmV4aXlotHgnehYC3HJ5SKRRkt48QOaHtvRZ
	lrOfGTFoiXL4zzOdctqxoG4S6BwZoVwmZh1n4itLrLPQVYJfnv9N/IVoouMMgka8E1600vD0sJ9
	6SbPY/PEQ/AJBwPhGILK+Lwiq1+7gsc4TsM8FLJrmd8IuuD6U9hX7TrPN6/aVKYNpYuBVBOB8Pd
	mbSi0S7wJ/ufaZDf0Pw61p5zi8hSDmUoodULaAzKuxdoX/SgIKGvPsXRjs3nk70eb/a35zGO7x0
	=
X-Received: by 2002:a05:7022:150e:b0:1ac:9da7:e881 with SMTP id a92af1059eb24-1b55690bc2fmr26925725c88.36.1795798022569;
        Fri, 27 Nov 2026 08:47:02 -0800 (PST)
Received: from localhost.localdomain ([96.44.128.241])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5568592adsm56748646c88.15.2026.11.27.08.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 08:47:01 -0800 (PST)
From: Weihong Guan <weihong.guan@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Weihong Guan <weihong.guan@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Kyle Pepper <cochcoder@proton.me>
Subject: Re: [PATCH] Bluetooth: hci_sync: Unfiltered scan for peers outside resolving list
Date: Fri, 27 Nov 2026 16:46:56 +0000
Message-ID: <20261127164657.3505415-1-weihong.guan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127054519.3146135-1-weihong.guan@gmail.com>
References: <20261127054519.3146135-1-weihong.guan@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luiz,

The CI's mgmt-tester fails four LL Privacy cases with this patch:

  LL Privacy - Scan RPA - Auto-connect with IRK
  LL Privacy - Scan RPA - Background report with IRK
  LL Privacy - Add Device 2 (2 Devices to AL)
  LL Privacy - Add Device 3 (AL is full)

They fail as designed, not by accident. Your BlueZ commit fa6ba55020
("mgmt-tester: Add LL Privacy host-resolved RPA scan checks") expects a
peer with an IRK, added without HCI_CONN_FLAG_ADDRESS_RESOLUTION, to stay
in the accept list with filter policy 0x01, "since the controller
resolves RPAs". The patch changes exactly that case, so I would like to
ask which way you prefer before sending a v2.

What I see on hardware: without the flag, hci_le_add_resolve_list_sync()
returns early, so the peer's IRK never reaches the controller's resolving
list. The controller then cannot resolve the peer's RPA, and the accept
list holds only its identity address, so every advertisement from the RPA
is filtered out. A connect by identity to a bonded private peer never
completes (no connection in 15 s, resolv_list empty), on an nRF52840
(Zephyr hci_usb) and on a WCH CH583 running our open controller, as in
the patch's notes. With the flag set, the resolving list path works.

Two ways I can see:

1. Keep this patch (an unflagged peer with an IRK is scanned unfiltered
   and resolved by the host, as on a controller without LL privacy), and
   I send a BlueZ patch updating the four cases to expect that.

2. Leave the scan filtered, and instead put a peer with an IRK into the
   resolving list on an LL privacy controller even without the flag, so
   the accept list matches its resolved identity. That keeps these tests
   as they are, but changes what the flag means, and the Set Device
   Flags cases may need a look.

Is either of these what you had in mind, or is the flag meant to always
be set by userspace for such peers, making the unflagged case unsupported?

Thanks,
Weihong
