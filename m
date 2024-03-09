Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33C87FA
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 Mar 2024 00:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709945630; cv=none; b=RtRHW9ZwCq+dKob+vSb7H/sFrc6uJ7S1omDKmWTBBQfLieg42z3Db0z+EACExC52UrFOf0OFCU3UIfCWAPbt4fQ7Bd40fv8b+iDr+3uTn/TgWxe37ShqT02S0jFM43Ja+6zVmVqyTqa47pJP2j2KJ71ua48vs3cfiaQhf3FZtbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709945630; c=relaxed/simple;
	bh=m9sFBDT7hpj6nHZ12uB54UeoimW5AfqIm5cFpv0bMqw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=G0f0ni55vo85srpqLYM522lYQ/4d2SggsYMkcOSnlSLRN27SrgxJ6iaFe11POp+WbIC7zs5rfx9AOHg1cE0rehjUnl78Uajfd3w5pI1hjOsowaZO68VnpuOd4GWkHZ67vzQSKxPL9cqkxEXeF2BknHFgI+QWJXy09kk7Ekdwi1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWUp6yxw; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWUp6yxw"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-690b7ce0f59so6269196d6.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Mar 2024 16:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709945627; x=1710550427; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HoI9sLzeQrWbEiS5qkXJm16sjhFutL7pTuEtZXsx1+0=;
        b=mWUp6yxwbgIw8HOhFiNxQOgfmIt86esAhMB2IkI0BT5PGFMLWPir5s7qH/KEatnDPu
         g9TyQBcEuBRCGbLSCK743pU/sX5C3JdYD/b+i9QBPVHi2VZHSdEyT2p9WsRCPp2erw/W
         zdRNH2aEDCAnrCPvBs+PynwSGWlsX27JXabCiWFgKzR4bVzTqyWECE7zLGCgs0v/zgxD
         ZZ6SsIVK+QB3vOAgfcZ498Wp+/xDzcvVLAHUUWA2nCI2yQXvvYG3O7grvaeXviuoxZLr
         7wETmU4Mf1lQGhgs3Z718m4V+CpQdp8PBDsGeT9FxOLHduLPsWNSs6Sj0RJ4lkp3x5Zh
         nCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709945627; x=1710550427;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HoI9sLzeQrWbEiS5qkXJm16sjhFutL7pTuEtZXsx1+0=;
        b=mk2T9rH+zsbJfsKcJuZl+iwA54kGY//1KvFe21AVOZ/SQ1HuHfZup+B98fTzVb1b6n
         9oDKQ6Fn2aOTz62g06C4d3hx+hxTw9PvZ5xNMD1UsO1jzMEO3Q/9JcolId2kZ3DeoRms
         lxmzkih0Qji45cQBwWWdGx52HIDf8x89k9CpAasoG3mZqHI4s5feJxrQZ20NFzj7LqBL
         eIuwz+WSv1ct3HMXT4KRXNvTpPLFaLKCckrQQtKWkEzkaAzAvwK+N6Olg61ToWc2h8QJ
         WcmyTEqxIbTtj7aa4iC1CA3VhOmGJLMrQpmytfsj1gZg68MD0OEx2syzSHRx5Lv3tpNO
         o3mw==
X-Gm-Message-State: AOJu0YyvpGeqym+AgAGnF1CjYDTkDRSqU0c/wj6hmnLR8ZMbYkM6t50y
	utSrAzBAEPU6YbuYBWytqHmDR6AfwsZnVqA+3kdjdh6lXFQtLZBvWcWnSKSO
X-Google-Smtp-Source: AGHT+IHVf37NWTcnSy8AXaRzPzM3M55m5fhbUUsV2ScU0ZpQVM6ts6SIqGv+58ZeZti47Lno7d5ccw==
X-Received: by 2002:a0c:f04a:0:b0:690:baa3:d411 with SMTP id b10-20020a0cf04a000000b00690baa3d411mr1064234qvl.28.1709945627650;
        Fri, 08 Mar 2024 16:53:47 -0800 (PST)
Received: from [172.17.0.2] ([172.183.51.242])
        by smtp.gmail.com with ESMTPSA id ej5-20020ad45a45000000b0068fc8e339b8sm299627qvb.136.2024.03.08.16.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 16:53:47 -0800 (PST)
Message-ID: <65ebb31b.d40a0220.dfe07.0fc3@mx.google.com>
Date: Fri, 08 Mar 2024 16:53:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0980245126151196526=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/4] shared/uhid: Add bt_uhid_create
In-Reply-To: <20240308221007.250681-1-luiz.dentz@gmail.com>
References: <20240308221007.250681-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0980245126151196526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=833928

---Test result---

Test Summary:
CheckPatch                    PASS      1.71 seconds
GitLint                       PASS      6.28 seconds
BuildEll                      PASS      23.74 seconds
BluezMake                     PASS      1635.49 seconds
MakeCheck                     PASS      13.16 seconds
MakeDistcheck                 PASS      175.34 seconds
CheckValgrind                 PASS      244.12 seconds
CheckSmatch                   PASS      344.72 seconds
bluezmakeextell               PASS      117.34 seconds
IncrementalBuild              PASS      5980.43 seconds
ScanBuild                     PASS      1003.69 seconds



---
Regards,
Linux Bluetooth


--===============0980245126151196526==--
