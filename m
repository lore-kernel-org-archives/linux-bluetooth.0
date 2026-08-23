Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6BE30F803
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787480826; cv=none; b=oRbv2Z4ojugiNaHahRnfrJ/SBdosQqxxEllcrM7ouiHVUCddbVPfAfjlyHDk1U7lOrQDFd1nfRYTfsAmAfO/624ohJwhLsb0XpochmuH2vrJyckuwO68bWhrWCM/W/lOzeiIjGeKPaGT4+sgL/WYedKbHFNy02X5DwxcXrTy8Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787480826; c=relaxed/simple;
	bh=XQdx5W/KCcgN6coDvdZhtNK+7RP0BBrtIDdFFiVYw7I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Q9v0KbeO0f3p2dYIJPIMTKz7Cv0g+/2ci4yFv1oqHLhzDackDunXb821WRTO88OvIt7EbwenrkVDxlcoSkfzv9vnUvYuaSV9uzkRRKrWk4miNujM7PVXNmBNKMaydcMteg3IUgaeqPZaSUlHSgkiN2PR5CdPSgGcc987xsNhf/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVuaUI4o; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVuaUI4o"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so384057066b.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 03:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787480823; x=1788085623; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XQdx5W/KCcgN6coDvdZhtNK+7RP0BBrtIDdFFiVYw7I=;
        b=cVuaUI4ohI5m9jmksrtARfY3gu3bDLy6Wpb6qYMAuQCZ4uP02JmOCy828MTX8t6iPY
         K2VCnAnWJWetIoFkAQ3r4q++j19RrSQo2p4O0BtEH6jVcwnrJ6aYnrIbJrYDe3ItxSF4
         8LvQT88yflG7l/HmJrvIk1Q9t945UtZIvJxZqvs6FovWTLhD/OVFWH+TSiHSpO691cN/
         vJldX0RRXD0G0YeQb0hiwTKlzMuuB8/9J9JtaErfXfy+lhkAbgm3P9f3xJD9fZDFMJSu
         gAlWIi0eRlM6kEA7SofFKrIbV0M9xLYpCXBG8v4pcbRGfR6oPm+TeitbL9bCQKp2nmnT
         V70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787480823; x=1788085623;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XQdx5W/KCcgN6coDvdZhtNK+7RP0BBrtIDdFFiVYw7I=;
        b=UO70gFo9r4ucHvBBNQLZQRkPSGiwpVZBG/I5fFJoIxU/UoW6Eew9rar4rqsR+VY/G3
         WEeiVQgzGAAIMVQd1D/04Uhr2KF+AViQN727PvmT83/P6Qg7Zf2bt5E3QIsN3cWyo/b7
         2SAe5Ic5m3AYD8QD7np4s5ugpp6nnkCJ1cZVBmIgQZm8+ydERCNvqnRPACMdgPxk8Fxz
         m3ekNOhE8cVqKxW6m1/zKukUl9ytNrUgfdaLBbrzF4dhFnUOT3biCIzBx4H1dfAeRt4B
         R8qBYpwoq8dnZhZImIkR/ymNSbKLzbwejsgQhJgMu72e7iJK1BWVU+DOFOuDmn1B2SQY
         nluA==
X-Forwarded-Encrypted: i=1; AHgh+RocJtqnjKa3qYEQ7N9nzjorTeTQd5bXrMR1vEX4ki2sEsXZ5BvZwyHg0wgn500lkjyGBjGJdcxTLVIDcN/v/pc=@vger.kernel.org
X-Gm-Message-State: AFuF++lvhkmRKEvVAzgLX+/JBnz2Lmj/szZwABkZP3H8dDiIdJemAJL5
	zo1WUkPzda3BATlsQIAkRSpVBbTehLSLZDNUERevYIBRZNZejV3QnwftNY2zDZaM
X-Gm-Gg: AR+sD1063REHaCeqDb0CLixc9Czg0GhD6YZZth+WsxY2IJMisiYYQ7dfQPn3F8qE7N7
	jWUTDxAKH47oFmGF1Y00QtffW3mj76nHYDdP+J7Onw5CdiE39mDRiG4c7gEuwxMRJ03toOZYLio
	u53NgFQZEFhBl3kE9YyFzjpEXNemxTLMvOGl+C0pB4+e+8uR1QXcYLcC6aEN+nHUdARs/QI/BWX
	VqQQECctduy25ODezsnTa0l2hs5T8VerpZufgCLeq1111GpVaZ6NQQyp9E+q4MGQYH+79ZDnLi2
	NePB2FLPwGOTykEy30Sr5TaGD0DPsvxsxJ7ks6QFP4ul4Albv5V5ecUAyD4XiDrvmXbzS7+RQtF
	HE/EMH/307XwKWRiaXpEswsjgruc4hp9tORVnx7iDdV9MV4E64+LUNpAGHhPlJqtNROAFgbYsVd
	GguWxBZ6aGBPLL9okWZZ8VXkaEPsV9qsfBVp+3ZkrkRy4I5TmPfamjT8FKZpg7DD/sKUs3r7uWf
	U0+nFkzQft1P+josiihS81xmlBzCDwm9gPQz98r3AqW6bLuiZ8wPt7VwTJiVi6s8ZNtapy7PKIS
	XLdND8uDBAXlmg==
X-Received: by 2002:a17:906:9f8e:b0:c12:6d25:2c7a with SMTP id a640c23a62f3a-c2492621d0fmr1178244766b.17.1787480823260;
        Sun, 23 Aug 2026 03:27:03 -0700 (PDT)
Received: from localhost (d163-170.icpnet.pl. [109.173.163.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249629563dsm730670466b.17.2026.08.23.03.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 03:27:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Aug 2026 12:27:01 +0200
Message-Id: <DKW92HEH75C6.24ZHHWR1XJ46C@gmail.com>
Subject: Re: [RFC PATCH 0/2] Bluetooth: detect broken extended scan instead
 of guessing by chip id
From: "Kamil Serwus" <kserwus@gmail.com>
To: "Thorsten Leemhuis" <regressions@leemhuis.info>, "Kamil Serwus"
 <kserwus@gmail.com>, <linux-bluetooth@vger.kernel.org>
Cc: "Alexej Sidorenko" <alexej@sidorenko.cz>, "Luiz Augusto von Dentz"
 <luiz.dentz@gmail.com>, "Marcel Holtmann" <marcel@holtmann.org>,
 <regressions@lists.linux.dev>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260822141115.58815-1-kserwus@gmail.com>
 <68dc7fba-ddda-4505-bdaf-4bb7af2df44e@leemhuis.info>
In-Reply-To: <68dc7fba-ddda-4505-bdaf-4bb7af2df44e@leemhuis.info>

Hi Thorsten,

> Would you maybe be willing to submit a revert?

Yes, sending it now with Cc: stable so it can reach 7.1.y and 6.18.y.

It does put Alexej's dongle (0bda:a728) back to logging repeated -EBUSY
on extended scan - noisy, but usable, unlike the current state on mine.
The RFC series stays on the list for the proper fix; Alexej, testing it
would still be welcome.

Kamil
