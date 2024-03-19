Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35A51F608
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710862638; cv=none; b=tt6PyGRCvg1o17sWCKuTTZxLj+RCC9ps9m5VHKSWw7QkpEl0hTiS6rBq8aPmwRda+TWQGACJubfy2CzbFiZ1EcHoYB1459d9ANHYTSNEC7iv+S5oYSxtZI1aF3+g8wIYBF6MT0QR2MVBbMkktwfihc9nQuxbf2xmMdC4ShXA2hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710862638; c=relaxed/simple;
	bh=jk3RUCOcVj/a3O6laaxcgHlciBGTzBI1Dvyr6lYCaH0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=g0pUuzkfv7t5QMUQjpJs3hN+kHlkMAAnvRPxXZ+C2+g64ws3J5yKo7dZl3TLFNJcCwdm2IzzvMXIl7XH34CoQNZg937JDR0F+YlWUT/fgOpnAMKElpAakcWKEybc6ZIrzF8ucXkKj/nvDQQIifTl5jWgamkX/DXDS3ObbfSfAxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0FhLhVi; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0FhLhVi"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78822adc835so262798285a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710862635; x=1711467435; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jk3RUCOcVj/a3O6laaxcgHlciBGTzBI1Dvyr6lYCaH0=;
        b=V0FhLhVi24a4pMW9dBWWS7XVotFbTm8bE2pCejIb5gc47dawrzRhWK9U0vg/m5gAtr
         p+70MEsVbXlSYLkZhUvwSVG4/881zG64eAoN/45p/4VLpCsfpnhbsU5QntMHEgq+yiFr
         3PqzaHj38OPUPECMJ2R9d5CYD1dqfyPlspMykXOOI4XHGGanmvmMJscqtJYe8E9tkX1a
         csJrCSQcrzdS4Z/88NQ/nal64p3RvybRSj4VbwmRTtm/UNAReLjuyrM1swLWOGWP/DZl
         LD48Yqyk1f1+jx/5wowslWUOy3njw9QrXOIpU4SvIawU05qi85HrTAfueTZwBUdpmhVT
         5avg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710862635; x=1711467435;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jk3RUCOcVj/a3O6laaxcgHlciBGTzBI1Dvyr6lYCaH0=;
        b=lJ0LkryrdJPiKgSRySXQUpgWcgM2sxhaaxgwM/vRn7GFKiV8pGeQ9DlqHdz9sziUgH
         PXpkqmjUEVE3pSx6y3pdElITsU0gfw3DzgrpQ6q9Jx/eqnvtuw73uCthQJ9a2jpFVwFQ
         OrFhL1UvNqHhPuyJ7FIpnuBrOtax5bvw9pF/Ax5y37+KPBIlxauFi3+RuGFDK+nhQVNT
         QpRV6IyUueK2YmZO1C3r5T6P3g9nY0hYZmLkiqKlTRJsRBdFiFmhLfq8XzCs2qJr5UhB
         ODYnJxu3IOniY6yWkPnVD2TDE7sDQ0dgGACHYnA2ACHyY97izNKNol6daic/S5co234E
         +1tA==
X-Gm-Message-State: AOJu0Yy5d0RtmE8PUIBXsDH07MEJ9NZgeSusFIDtOm0vPP36y0xM9FKD
	FG6A72tqtmIOIIHRiIDDWG418EKtpEb1P11aFu4/7vHMccK6ylkiUvL6Dpra
X-Google-Smtp-Source: AGHT+IH8zQs1NfR+no/Wej2UUm69NBZ7COd0bII3Z1WzSbIfYH7czrZvmpYIxFL7+aYNQRcO4k8mDg==
X-Received: by 2002:a0c:f309:0:b0:691:3d90:15d8 with SMTP id j9-20020a0cf309000000b006913d9015d8mr16809421qvl.64.1710862635369;
        Tue, 19 Mar 2024 08:37:15 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.74.5])
        by smtp.gmail.com with ESMTPSA id 4-20020a0562140dc400b006940b9ec66fsm3630312qvt.82.2024.03.19.08.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 08:37:15 -0700 (PDT)
Message-ID: <65f9b12b.050a0220.c0856.f4d3@mx.google.com>
Date: Tue, 19 Mar 2024 08:37:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7336726789008358310=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johan+linaro@kernel.org
Subject: RE: Bluetooth: qca: fix device-address endianness
In-Reply-To: <20240319152926.1288-2-johan+linaro@kernel.org>
References: <20240319152926.1288-2-johan+linaro@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7336726789008358310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/hci_qca.c:1904
error: drivers/bluetooth/hci_qca.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7336726789008358310==--
