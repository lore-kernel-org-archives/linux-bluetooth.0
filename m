Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3EB395AEE
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582326; cv=none; b=qKAh5p721VQ31s4kysSn4v48Nv3ipBDUPwn2xYFwzQPuZVkukORJBcOIHHp44Yhg44ajs99jQ0miNFXpH0Qr5ChBMEMVftk5o6eqmzTyjSiER2GjBH7OXShVuws/i/le0yN52y77ELqYwY8GGcupmuTTclc6PD7KyDrmGFca7pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582326; c=relaxed/simple;
	bh=bfuLMtPO5l6ks1YsqDqEMfUw2aFROSOl9sf2OJ/XftU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PIjZ4GfZ4EcwTm1edwA25ET215mqwIcKcvQPrYAe3sY9thZWPWuzTgSzlbODoNQMMh/Kmu13hhP+ciyXFcmAkrVtxnwy0HHStxAPwLL6sdO7tMTVxl4U0mptmyb0Yg59x/GneBK74x+KbaqUNOnnGmsfS42Wjw6tAKdQMVM1lL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAHXJQbf; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAHXJQbf"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-479d5ff103aso2517932b6e.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 03:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778582324; x=1779187124; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zU9pJ79BtpGXxDTzrEjJd2NV2Xj84EBeCPw+40P3MSs=;
        b=DAHXJQbfZe7B3MDiF9GcV33AANXCQErR6KLVJ8FLhQBCqJcEYDUVA/3rL/IhKeqfi3
         g2gNhzZgEsVWGLyka7IvwWfDKhnEVXXVp6wC1MFVsN6RGCwdynjkTDQiH/oKp9G8nMWY
         0sv7DpsBdiHKv2Rxdp++NrxNNB9YMDRDNCFGcjUtXSX8/hsrVc2jEdxL6H0EYoMG7lKP
         Fecwic3nAvY7kesoIp5Dia78DcdwumsVYSYwsOJQijmbTgWf7z4hMI/XJBJuePFE99xh
         OMjwGSlxfuvaaslIr4Ph9DrMrBHeOjE7NzVgyNewrRTLwQ8adVOEMRXyw+G4uLeYslGe
         j2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778582324; x=1779187124;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zU9pJ79BtpGXxDTzrEjJd2NV2Xj84EBeCPw+40P3MSs=;
        b=qDDLMpOnUHZ5GIA2sFv32KtjZge9UeebGNVdDBA3QyaQ0OE/kOtk3kX+cJqGWKwcjq
         nurKNXkjOwLL/K1D30PF6q50L534uGFpM+/DKd/W6j93YIJs1T+ROum3EVwo83MFYlln
         NUr5i611W3vunRWk14Hu310+X18rT609SRyxXhxkwKGsHXAAZXo97T95GR08pnnI2GeE
         y/c1WxR+qpx/4NlhjQeTDY0hf23RxbGml6Rs9J2R8NCU+fzt02tLyFxZdbbDIrTuvBzz
         43zQzn9Mma1DmA9MJ42WNuJRnVvsQ3s4G4JwnhdGSeBRsvD7/N+ZScJXwDz17H06J2S/
         GECg==
X-Gm-Message-State: AOJu0YzZ5Gb1rYpKq8+/bYhjL9aP0HSJpXjcwx9KnmNWfHpZ6aStqmaE
	Vo/hBeKu73Su1ssJhX4gw4XZOz5OVrTlOtwVMj1FaerKRtB9qaArW4Voy6YPow==
X-Gm-Gg: Acq92OGj1NnRz/372FfApWQpxcMqJ14civIY879zWXInBz6P5zjBMrPEX85FyrIt2lu
	j9lN5ru6W/KPY+HVwJ9+cI9j5tE3u+SipjHlblyp93F8+UVPv3Ebx8A2AF+ik6sDoPJpMUR/CBv
	8HCCZQ39FIyTCynEkOx63fySIyn/D7UjI3HaUaFvScm082gONHOu7bntVjdL4rZaDJEMRHrSmSP
	mD2MJcl8/UepEFWBjZuuwl1ufie1NDB9VXpsgkKl9P58PCfLOCbTX09uCYUIqdQciMzpl+BXhRk
	5G/lr6CYVKoCH76pyYzByiJH/TZQsMRYxwxXQLvzuzv0He1UdyJMZT9sC13U6BXyd9BbKywwvtv
	QhxNhDZs0PhSKBWen10KFi7B4oQZDh8hwq5hhMH1UobOMrbGARVjNCbkES5sZaWM7Ejuk7YtFoG
	LTRH8LqbpWGDcLAO32eHLqAbCy+Did45k=
X-Received: by 2002:a05:6808:c147:b0:479:fb10:1299 with SMTP id 5614622812f47-4807fd39577mr11579044b6e.29.1778582323821;
        Tue, 12 May 2026 03:38:43 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.182.164])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c763b33c1sm22232843b6e.1.2026.05.12.03.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:38:43 -0700 (PDT)
Message-ID: <6a030333.050a0220.3b3068.1bd9@mx.google.com>
Date: Tue, 12 May 2026 03:38:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2632450872591260036=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ravindra@intel.com
Subject: RE: [v3] Bluetooth: btusb: Add support for Intel Lizard Peak 2 (0x8087:0x0040)
In-Reply-To: <20260512083444.1214935-1-ravindra@intel.com>
References: <20260512083444.1214935-1-ravindra@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2632450872591260036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1093368

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      24.75 seconds
CheckAllWarning               PASS      27.64 seconds
CheckSparse                   PASS      26.15 seconds
BuildKernel32                 PASS      24.57 seconds
TestRunnerSetup               PASS      521.93 seconds
IncrementalBuild              PASS      23.69 seconds



https://github.com/bluez/bluetooth-next/pull/177

---
Regards,
Linux Bluetooth


--===============2632450872591260036==--
