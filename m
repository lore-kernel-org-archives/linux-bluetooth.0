Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8ACBA27
	for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 21:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753997633; cv=none; b=Il+qyRe1B0R9FSeyrwcYyhLa4022TLxUF5k5n0zT5etdJiy13JIoxlR15CAX0zeADu5oV71LLtHhVHmG/dZb517/MURuCf9cQp497SMmhSBtDN/OLYS9nxQfZ3zy8zPsx7ntqRVHWefDG0CnUiQ+Kof/dvhpOCiirnS76ncMQSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753997633; c=relaxed/simple;
	bh=ykMD0XsBD7ZkbUmi9OH7IABPDvDUcOgR+jiy8E8CMKQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CFzbnpcX/2ngsDFqbEYf+EvqvYjwjx1iy3o5w8Zr8QDEW6ru1c4kIgb2bZ2DL3WDmjIYVSvryujWalMPxfYa6nhb2FoHz1neBbRzrT/eI/+oC5zdMgSOhfxvlP571sYJvDdVBAcVM/zZDUAqRsV2Toj+lQqnXdMR2dr2wKVjTyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVk+Rj3B; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVk+Rj3B"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24049d1643aso7558675ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 14:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753997631; x=1754602431; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CcQGYejUAgq7WImnXeUIKEyf8QW8lm7w//Ye1apNp6c=;
        b=bVk+Rj3BNR6bFB76F1bsFAbGT97ef6qRQo3+jVm1L/3bzRk28LU0oWrchr3v7PF9vK
         UC+r5mOGh25VPLkudXaUdgHNWTN2mlQopxWzZb3H5oWwVBoqyPWClkrrmc/xnHsQ45VD
         56AwntEC2E+ob0XqRzG9rrR3CZdfFJbqHcoEuyV7OOTqBBds7dge8l+m7sxjqIDmA2dL
         CpFCYVrMJd9AT9TvPr9gJovy2wml9yM+LAh82NtH2z1JUVoqC58UkJc5r9MP3kDZ7Rj/
         Sl3Gd+9ymzffR6KB9bTqsWljjjSchsFl4ysgN5imSyzT43c2OmM3/323uAhUmIjRgahm
         lTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753997631; x=1754602431;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CcQGYejUAgq7WImnXeUIKEyf8QW8lm7w//Ye1apNp6c=;
        b=J81cBWjG9euBioYcEt3c7i+fzc6SaZHOSYe6n4fK/zVCMsZY9aLDTwtfvvzcpgT4vY
         jysvfskU4EWmojpVTpsLU+vj+XRLcwVAFvZslxQbyQYgySqbCatiVjI9/ZX9Af5R9hYk
         aw/JVWRs4NpI1oR6lO3y4MUJOwWFEZ6SBfBEsF6mIze+e0oaOLp6AHO6IhMoQc6NMlVS
         W/jG0IJbz/V9HpCsV5pRozFxu4/TQUANoN6qiUJsjC6SUXWgbtPh6Dao/T7xzdRkaI4q
         ehhs3p7yc9Yywx4dNNNQx+zJjx2UucpQpmIYT3WA0gSGfws7dPXiRrXcKVHG32L885jK
         x7fg==
X-Gm-Message-State: AOJu0YwHy/KqiCaWRDPDy9k17je20QTGEUi8BumjTgMXuCJU5DKzsEuk
	6oUm2Mw193BqnWJMS33KuSRTaHMF/g/CzqSdiVeYZdwrHsycLs9HuZNVXGD4Xg==
X-Gm-Gg: ASbGnctFgl+NCwwQWLngpCz2D3cZaNiybCu0NjJ67aUvPD1hPelgzAz9hYsxQy/pMj6
	WBgbhDzGP7vfKin0DA9rxgIRuJlOnxk/HfrkvVJYErj1LOKr8YXYPM5+u11ja92uidhFQC9b2Lj
	xfuAnaqrV8r6eitwUIdFKgh7o3/a3bZvrDk3ypdG6gUSCT1nPokp7K3SsYPFAoO9ug/1ROImHsL
	esMZSS/KivW5WnsOUk1n8mgTSMhgE11fqHuKHGK1kMswXp0HYvnj0JIyfdrTm7X/91zqEL3cZWg
	o4iasVAtDxHjLz1EgCwaSTcXSJNEHdVXspCsEoSZUFYlH23O/WKwZwjIlIFXzeJFOpc91MEfdOA
	6oAkUDYvLK55Wr3OcXQmrCH2sEc0B8w==
X-Google-Smtp-Source: AGHT+IE8zsnhpZs4TLmzpw9lXLcOuuRtEZ2fUYoYuBRl11VkuaIFEazNH8v3c31BNV9E1d908TuPiw==
X-Received: by 2002:a17:902:e887:b0:240:5549:708e with SMTP id d9443c01a7336-2422a6c8956mr2326705ad.46.1753997631366;
        Thu, 31 Jul 2025 14:33:51 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.182.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0f603sm26402005ad.48.2025.07.31.14.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 14:33:50 -0700 (PDT)
Message-ID: <688be13e.170a0220.219616.258d@mx.google.com>
Date: Thu, 31 Jul 2025 14:33:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3387769377929555818=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,v1] monitor: Add support for logging host packets
In-Reply-To: <20250731195624.684876-1-luiz.dentz@gmail.com>
References: <20250731195624.684876-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3387769377929555818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=987469

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.45 seconds
BuildEll                      PASS      20.21 seconds
BluezMake                     PASS      2673.43 seconds
MakeCheck                     PASS      21.02 seconds
MakeDistcheck                 PASS      184.12 seconds
CheckValgrind                 PASS      233.05 seconds
CheckSmatch                   WARNING   302.89 seconds
bluezmakeextell               PASS      126.91 seconds
IncrementalBuild              PENDING   0.38 seconds
ScanBuild                     PASS      906.98 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:83:26: warning: Variable length array is used.monitor/packet.c:1919:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3822:52: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3387769377929555818==--
