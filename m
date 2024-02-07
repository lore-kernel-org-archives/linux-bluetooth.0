Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFC677645
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Feb 2024 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707314629; cv=none; b=Ss0BAcyXrn9V2GBsBGZOZGz65LRL5X+peZLhbrSkhffBn+wyfhQzDHSp35t/jKq2T8uJqXs1qSFhKf5MSxiwxranpFXES6V61Fa4415qVeWv07LS4gVY8H8QHB9CsTvG7UhuE6ciNqKTQY3qj2Ov6ErzXBnG2MEQpLk8AKl484E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707314629; c=relaxed/simple;
	bh=/P7zf8XXqFoPMmjcIWoc2mdDR4laoF78iQwm/C2WIX8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=grkSTcAdMWmIA4h/XRleuaAJQbaOrSp5rschrdDYXfxQvktLmBXlwIh062CkV8i0h6O5tTEo9subEaDRQFBtQgqnf/kY3aQSjJNwuMICsTpdKf5NJNwjaW/ceiGFxisU+UBhaJ7Uyw9PLJIA5+pr5dEzqEIBdc+4gBx2r0T21VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWqV6pmO; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWqV6pmO"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-686a92a8661so2754546d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Feb 2024 06:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707314626; x=1707919426; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0G4tDvnF6UO23g6SfSafzw6jVSYfC5OUpmA3Oadu7FY=;
        b=PWqV6pmOLrxux+JTK+hnuM2CdUCkciV1YjVK/FDcfcpcYkwnThgVaFjq2ld/pH3yH2
         En3fWGiVJtHWkLkkdtBIli6oJxR2Brt1gQMSVubmwW3BS/xz/K5smI3LcykEHg+IV7/Y
         a5z5ZvfRqdf7K/8ChYNEb8DU9b2ZSZOkVtOX3kZ8F4s2ufEynyc6w9FU9qIb0gof3BQj
         F8fOHsyUzkko8cL6XUF+lWSIZNaN9fnZoFOZ+c5tQWD5v+3FR8bdj6uBveSbpU/CGVRD
         OR0OI0bOims5VVBbCCxiWQrTU63yU/uDwCFrzY8qxZOMVJWE1vx11yxd3mfjXZPrEoj9
         jhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707314626; x=1707919426;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0G4tDvnF6UO23g6SfSafzw6jVSYfC5OUpmA3Oadu7FY=;
        b=ckqKe/VwpXyoDQHiWG4/Re6cIGbZs+heLddze2v0vyCr/Xl8JVhMWiCO+HVysBwvHP
         7ndI+VPboDC2Lkza3EUCVRKvKc87ULxeIvkjxCFXSXPtSyR0pPim8In4UhHgnKcFYj1M
         ILnEITVvovfzAMchsJRPGhny3k4nzO2FZJlVNUJXg7Itd2fjGj9Z7GYffc0l+kHYZaKL
         cCuLWHWVFabd0/oSxDY25SxS6pi5rCfjhn3tkzcoqgw53NFw8dGds2PDkl1QhFWHhTm+
         EE4+s2ETf1GfxfhFayRr/9MLY04XDWEzDvIxOvyUmiaqDJOX0IcWVpuvNzBiRdYBxIgd
         N9ZQ==
X-Gm-Message-State: AOJu0Yzdr8+AOEQZpgxLKW/4j6+GyuuOPG3XBMuxCogad+7fCruogn8t
	SvnNQeFSunNU3AqJgJSCs3vBDTmjRKtS+gokIfQmqJpSjFOiNKhPaHVOHvnr
X-Google-Smtp-Source: AGHT+IF19w/Ni7yddnPqFPsG4l+8LlQgtH5ZGfg+kPw2QTWJNNAFW9aqn6VESo5C06UxNWi/bSUbdA==
X-Received: by 2002:a0c:f210:0:b0:68c:a3ef:18a1 with SMTP id h16-20020a0cf210000000b0068ca3ef18a1mr4546519qvk.54.1707314626132;
        Wed, 07 Feb 2024 06:03:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLRhwmot10pSr9FSm1iFULikMvcFNoOb4cvzvDYPGYjpzbvhB0E+J+PaWw+Z7BT4QSVbkpgXl6Ui+KVs3iZxH56OKKgQYgJso2Vg==
Received: from [172.17.0.2] ([20.109.38.153])
        by smtp.gmail.com with ESMTPSA id ma16-20020a0562145b1000b0068cc0eba833sm281902qvb.22.2024.02.07.06.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:03:45 -0800 (PST)
Message-ID: <65c38dc1.050a0220.a70d9.29d0@mx.google.com>
Date: Wed, 07 Feb 2024 06:03:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0233541617723271200=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andrei.istodorescu@nxp.com
Subject: RE: Update Sink BASE management
In-Reply-To: <20240207122308.26457-2-andrei.istodorescu@nxp.com>
References: <20240207122308.26457-2-andrei.istodorescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0233541617723271200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=823945

---Test result---

Test Summary:
CheckPatch                    PASS      1.94 seconds
GitLint                       PASS      0.98 seconds
BuildEll                      PASS      24.45 seconds
BluezMake                     PASS      738.59 seconds
MakeCheck                     PASS      12.13 seconds
MakeDistcheck                 PASS      164.55 seconds
CheckValgrind                 PASS      227.95 seconds
CheckSmatch                   PASS      330.35 seconds
bluezmakeextell               PASS      107.35 seconds
IncrementalBuild              PASS      2026.10 seconds
ScanBuild                     PASS      936.05 seconds



---
Regards,
Linux Bluetooth


--===============0233541617723271200==--
