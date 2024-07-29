Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637D52BB0D
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 02:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722218816; cv=none; b=YDtXZR6mUm1bi1keG9DLqZLifmV0scGrFqe3lLsRcI7urNABqG/9muj+1rLPTUZgCxY2mQXBAQwsww0kqKqFFInGu9v0IUy+ccz/BUwcW3v+39du6gbSrMMrRrZXe1dYA92MX/u7G8UPO1VXlRcYRBpKOBDf0vl6rRyKlC2jpCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722218816; c=relaxed/simple;
	bh=dV6CiAjwh/E9aTqM1uIGSYCLo++WMRi0gQVx6CTFxIE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sD6jOsWxXJ1sTeiuDgY2IFhUcJVlkGjJATRveFMhyqGOAemowJHvR4ZhWlsstLSluQaehhoUUj3acaPoAmda2okkLwFBo0ShqGD2GbmKG2DPkTga8q106wSmstQ0LVvT0pW7lB4cwJrHIR3gXUthMDmeAR3KSWrRX6dGSedeccI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpkcyDOF; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpkcyDOF"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-492a76c0cfbso415874137.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jul 2024 19:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722218814; x=1722823614; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dV6CiAjwh/E9aTqM1uIGSYCLo++WMRi0gQVx6CTFxIE=;
        b=fpkcyDOFbXJG8wiHGfseAVBiRKaNyGCCdJlL+7q3U2uort/+mADLtgKIk3AGXj8QPo
         OlZDrjtfoM+apTGQwpi2wHkRyeYCzyn+BT4CQbG0G2N+W2SqKJZ2XQI/JmFNP0f997+Z
         fGeSdtm+lzKTLY1SYvnF6oEiIvLvEngLxsH+l++uCx41cZV3jMZ3qAMVAC3hbbISBQ+J
         Qbx62Qha3oBE3ujdUvc5pvzG4dpOaxK4SVSpOHF1d4X0IyyiSsxcSGxq6Tja7WuUoPgi
         pafgLgmeTjffA7dZFhnlh/UgjiHhUKzVU2u5i9VGIbcWdclkRuSq+iRpTBGZN1PxNHvn
         eVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722218814; x=1722823614;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dV6CiAjwh/E9aTqM1uIGSYCLo++WMRi0gQVx6CTFxIE=;
        b=vO+AOWueveZn0Ik8UQpt++yQm18ERI10hNZ1bTSyCX7o3w0YQRzZabuHl4H7euMLnx
         uGY9I+BLD1oIhxWjox7dwumsWyMseKvlRw7yXjBe2QOgDVrEV0YRnwpqG0tjtLt/0ghJ
         EULhm1sU+1QXSeIUzjQLzoN3sonsItRaOGSyrJ8KppJKpj9kLAo7GclG9a/t8FVpqS6h
         ocGrfqfCBO20MJtE6s1L15lSjbdKbDYBWwwFfNAQ1UeDPO4cGp2hz7qZVSmYl1H+jF7R
         TkI5u5ESOhoR5MT7xvj12A2Ou1IGpaOs19zIIv82C0gUifhJdbQJ63ZPZfkTS/aFCB66
         9CJA==
X-Gm-Message-State: AOJu0Yw6YPKxRdDKX5mD/4BxKk9tl2jprPeOhVpa7rOrNk57qGemRtTj
	PAkl4Or3AZ29xBMAYEwMzH4cIGtz3zKUc36t7q2s10SH1lyI3gO7INsWVw==
X-Google-Smtp-Source: AGHT+IGY1PgU3SMHIELLEHEpMPPAJDY9fzCXERLpBPR8IVH1lYKbniZ8PdAYCfkRV6u/FZMsyy8otw==
X-Received: by 2002:a05:6102:c0a:b0:492:ad30:b6e8 with SMTP id ada2fe7eead31-493fa15fb2emr8222963137.3.1722218813927;
        Sun, 28 Jul 2024 19:06:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.198.149])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73955b6sm482449985a.2.2024.07.28.19.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 19:06:53 -0700 (PDT)
Message-ID: <66a6f93d.050a0220.eaf99.d91a@mx.google.com>
Date: Sun, 28 Jul 2024 19:06:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7569190177441810312=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xuerpeng@uniontech.com
Subject: RE: [6.10,1/2] Bluetooth: btusb: Add RTL8852BE device 0489:e125 to device tables
In-Reply-To: <8AB7BB893B74C562+20240729014309.5699-1-xuerpeng@uniontech.com>
References: <8AB7BB893B74C562+20240729014309.5699-1-xuerpeng@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7569190177441810312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:555
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7569190177441810312==--
