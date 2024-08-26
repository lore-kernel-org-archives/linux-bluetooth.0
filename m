Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24613364A9
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 20:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724704686; cv=none; b=A7V4hYKSqVLUP5iWSpFdWxHpjvNtMcAnfN1tY5KF0xptfEd8HqrIFKGeXuIirW6uXeBd7yeoGuQQUqEwEUXtnacP60lCG4vVWOCDnDuUhPiBb+hMURnHi0jsUEIPPQgXd3RyPZ2hLF4s4smmjFGNASlAmKcYSfn+CzEkbvtUYag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724704686; c=relaxed/simple;
	bh=/PKGVeVenEkRUSYKrfUHshex3aUQMXILsubHLaYr94c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rvJFlfRKAAy82S+6u1U94us7a+PdUzo7ycEqowV+8VNg1WhLaR3lpj7Qg/2ZmYRsQiNCtNP1FKoREK5HcthjU9dwI8xAB6erG78SHngJl80g7a8ai0v15yEZRvykb5vII9Aisq33nk8aBNGq6yyiTVjMV4597HGUIITEqunLNhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0h0RH5Y; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0h0RH5Y"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-451a0b04f6bso26493311cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 13:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724704684; x=1725309484; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/PKGVeVenEkRUSYKrfUHshex3aUQMXILsubHLaYr94c=;
        b=f0h0RH5Y8lSDfglUXBfZ3YxBecQG+pw51UkWzm3lo6g/bWwgtGOLg5UgONtKs8jKO6
         VPBOquXpLCxtBve4Wn3zOFCtoqAiCy4xAhtPMeQKBb+Y5/VXFR/8ePUeO+Al3HmLH3SP
         Gs/wxLyuyTs2e6qS/55HFU1NSHigcaa15jiXi2HnK90sSU5ihCKddQtzhyOMXRaWm7ID
         7aJhrXVgOD2fIUHvfFdOseSqKL0EkJoBWw2nldOvvLrnmbqajGVofQ6cTwvmrBZ3t8oc
         5c15iCCkZW2bkKuSRov7ZG20+1yqM3pDqqikRN7tACmC0qH7L6Ji3rzXjDPc0I17r9BI
         a+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724704684; x=1725309484;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/PKGVeVenEkRUSYKrfUHshex3aUQMXILsubHLaYr94c=;
        b=AosoYE0K/AOcfMBVB/gKnrw+8XJPA4lhVKliY6x/d2SuiWY2DsPWPd/KAbPAEsTssz
         lAu4ISiqzHE49e/RG2b9PdsQjFsQE1WJyrOIXsDx5QuZHPu55TZeDn5Y9BtSzBRmUcoY
         lpTKng/1PIaygbH0hfB99cexwJTCocoLvQrp0oKh57d2BuYuGJqAKzkepkKS2gEW6gKy
         rezsu/7zFaDwfMpSN/a7tRiGoh6CbRT6ndY/inu2klaGiMHUaWQyChe5DG0Gk0jFThSC
         ekYZ3poN+PmCNDrGwYyImlcvUv8qFqr5IrA1GjgwKJv1C7Sgm1iLlfCG6ws47XxouUkc
         Y48g==
X-Gm-Message-State: AOJu0YyBpLAOvSK/DTOmq52a76II4bFTh1BBQlaG1SmW31OSayLFJMJ4
	rXkR4TND2Dw/6mWqBqgQB1px2bEpjQPSK/B8JOqM97qhYJeKk5r1YX4gXg==
X-Google-Smtp-Source: AGHT+IE28RmzxMk2m2c9Hf27Mh8GRZRAIJC1CvAzuK7OuIe9UH+jbXH12wZfD6Znp3YgIpmWTeKkDw==
X-Received: by 2002:a05:622a:4d99:b0:453:145f:9b1f with SMTP id d75a77b69052e-45509d4524fmr162854571cf.50.1724704683657;
        Mon, 26 Aug 2024 13:38:03 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.155.73])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe196a3fsm46814181cf.60.2024.08.26.13.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:38:03 -0700 (PDT)
Message-ID: <66cce7ab.c80a0220.27b09.13d6@mx.google.com>
Date: Mon, 26 Aug 2024 13:38:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8751992281075597553=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, me@michaelburch.net
Subject: RE: [v2] Bluetooth: btusb: Add USB HW IDs for MT7925
In-Reply-To: <SN6PR01MB5070DEB84C56913B4179EA0CA58B2@SN6PR01MB5070.prod.exchangelabs.com>
References: <SN6PR01MB5070DEB84C56913B4179EA0CA58B2@SN6PR01MB5070.prod.exchangelabs.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8751992281075597553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:690
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8751992281075597553==--
