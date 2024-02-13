Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AB85FB8E
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844239; cv=none; b=Okdz/GVN++fTQ5kj7r6mXNPMsG+yQUXbwriExxAJsCR1QPv8PJqW+EojSqOTTze15w4GqjgJY09JO0VAZ9Cvm1k398VbXxnUtI6QaR50giLhkDZQJ0376TUtC8ClQGXXyrMYNX7TWKARoFLSfhMkJT5sJHKX1bRGkXjt6IrE9ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844239; c=relaxed/simple;
	bh=etqEnKLQpaSGFLtQEaCCb9IxvS+DiYicGgvTAjbEdUY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IysrkXaehxo/E/SYfrFK2WiRzRJE41exo+o8XTIYFvskwQcYa4uQaDNXchlQFVfusXIUh8yPkEHlWp5iRF2KhsfnD9RuTcPWVx6Ug2a5MMESuEXMw5tLjj1ExZ9kiPBTbnjTTiMwsNgt09DGNz6/bz6/Fg6/CjYzyqd8miim2vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpJ4hpH/; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpJ4hpH/"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6de3141f041so933171b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 09:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707844237; x=1708449037; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c7ZjrKb0jf5zOMVBy1EEPgUcYhf/MMtzlInisbT4Wlc=;
        b=JpJ4hpH/YabdFVeC1Ri129Hq+EeW8r1mkci4Hl+VnocKlCD1EF5IRAsj8M5oSDxje4
         XAKoTsJFz51LT2EoX8y/KLa77sgoYfNP3PWie4drK7Ys5WtQbJiHF+zN4eXeevettZa7
         6u+c7slnSJm2nG6OV07Kc4mTSCLR1MR8Ott9AwWAeY67DRJiWsotzEarnb37Mt14TlOd
         nY6US7EN+txVS9mxgslB1aXxOnSOuwNL2ZskiARRjQsKXRP5bnotP5H0aUcT4ic/6AVJ
         5nhMXIYrd/kixxF5Gs+YAsbysr8/6jAnE8vpMtmJTKU011vXb/fBsk4elCShO0oVd9Vm
         xzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707844237; x=1708449037;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7ZjrKb0jf5zOMVBy1EEPgUcYhf/MMtzlInisbT4Wlc=;
        b=X5RKuvCFObv4rO/hNcZGc+If2tRHdLZ7fUvLYShLAMZ5ooT3GywR+ligxz2q5Q10ct
         7j+8b/SmlacPZSkW3p8Jte4AAdLjeQj6W3jYUdT36USe/MN/oIYSkR87FZqRkk1t5MMX
         i6o/9ImpR2+W5yZ0iJywj6QZeTfUQ+i9aeIQ+iXOJnfe9uaiijhg/FFKvVtTkSeP4Xpn
         07Rloq5/BnVMlbRfecAmZvWtLnre0X/NM2JZLnuWfnT9YHdigHYRT3oysWROvYMmwDli
         Yh2/kdv+T0aMIfNSGImn2hJp5jgWE8UkzHYoZbtJ8GxKzJwvmmi0eLzHmHtIq2i/J948
         lfnQ==
X-Gm-Message-State: AOJu0YzsGmP90tYJvAJADRZwC4143aN5oEqLOwa4LOxrdndL1DQvPmhA
	HCkXp802/B1ZW3jbNl25b1kfBuL7LTCMGe0duCjCeEhzeJXhsbhldi/Hnaz7
X-Google-Smtp-Source: AGHT+IHW+lb4+xz1syObTLXT3tYClBzw2/nsQ7kpriutCy7WFPxv28CicyCU0AzsiDA2+Gjsm+WD+Q==
X-Received: by 2002:a62:8411:0:b0:6de:1d04:c600 with SMTP id k17-20020a628411000000b006de1d04c600mr8928677pfd.34.1707844236662;
        Tue, 13 Feb 2024 09:10:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWcM/aOr6xZmdAkMQHjoVNacm91g8zI0IrkOS+mc3I0dM9UN4QmMInEZygxYqf8NwdV1HdwxKTErSY0E7/vyPtaf9zDkpfWUw==
Received: from [172.17.0.2] ([20.172.5.214])
        by smtp.gmail.com with ESMTPSA id n41-20020a056a000d6900b006d638fd230bsm4311973pfv.93.2024.02.13.09.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 09:10:36 -0800 (PST)
Message-ID: <65cba28c.050a0220.1fe6a.c8ff@mx.google.com>
Date: Tue, 13 Feb 2024 09:10:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6707210414067369219=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: btdev: Fix set PA data array overflow
In-Reply-To: <20240213155803.3159-2-iulia.tanasescu@nxp.com>
References: <20240213155803.3159-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6707210414067369219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=825705

---Test result---

Test Summary:
CheckPatch                    PASS      0.31 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      23.97 seconds
BluezMake                     PASS      716.04 seconds
MakeCheck                     PASS      11.60 seconds
MakeDistcheck                 PASS      162.51 seconds
CheckValgrind                 PASS      228.35 seconds
CheckSmatch                   WARNING   328.25 seconds
bluezmakeextell               PASS      106.95 seconds
IncrementalBuild              PASS      658.05 seconds
ScanBuild                     WARNING   947.23 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:422:29: warning: Variable length array is used.
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
emulator/btdev.c:1086:10: warning: Although the value stored to 'conn' is used in the enclosing expression, the value is never actually read from 'conn'
        while ((conn = queue_find(dev->conns, match_handle,
                ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
emulator/btdev.c:1369:24: warning: Access to field 'link' results in a dereference of a null pointer (loaded from variable 'conn')
        pending_conn_del(dev, conn->link->dev);
                              ^~~~~~~~~~
emulator/btdev.c:1491:13: warning: Access to field 'dev' results in a dereference of a null pointer (loaded from variable 'conn')
        send_event(conn->dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
                   ^~~~~~~~~
3 warnings generated.



---
Regards,
Linux Bluetooth


--===============6707210414067369219==--
