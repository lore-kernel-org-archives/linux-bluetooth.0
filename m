Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C69479860
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262102; cv=none; b=fXGRSCl3eX0sadsdnezW+rsSHrI8RvMDQh/HWruT/s/rHidOmLs6psHi0VTnNX8tJkzykKC27ltgL5Q4wnIf86l5KsE2cmRjxobkCdJC4ownHyzHZdt5xLhyTTQUobaDWSElu8TNzc45chleZhceA5YDXTyxCNebBTZcgWt6sIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262102; c=relaxed/simple;
	bh=pQr3e3+XIGK/bGFvvhbm/aErYvAZk3P5VSlngalnKXw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=h/xR5uZUWFrJYp6wCElSPFQOnkLX5xVA+0WKddbHuG7i1zI4tG7nXwPCkY1u7w5dJCJtL7m1+0inrgv3gWGAyJIe4/WeM/jaa9ZEFJSs11LZV+SN9aBXXKvgoMkL34eVPokqf+2dol239O6O57eiKLhz/IJceoG8ObZ28dEiVD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVf8LQDn; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVf8LQDn"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c4bf3dedf3so1407634b6e.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 08:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790262099; x=1790866899; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pQr3e3+XIGK/bGFvvhbm/aErYvAZk3P5VSlngalnKXw=;
        b=HVf8LQDnpySeYE79bUpwj+ksQIPijpqdnX8V3aNaQ7YFTNeloDXGZBpDc/LPcTgrgc
         EcqPL1APUuwOAFnCJa6ZVYYkC19tP46Q7Rzk0XSBcMp1goh9m1AJZO4peMYtywz1jrVU
         2XYYO2qA/YCDl/JaZkI3w5CugUkRilcnZPXSX7MwMafrfxC/ZCVJKqnm7vmXIMjt3ch+
         iMwc3lWD7nz5SUpH36CfQvnTnWB1yCeuoR6IB98yX2pIMITklZyQaRaQ6VR60YHxXdNR
         9znVKDpTEiC6LvZ/CPTg+HjpfKEX1TScpkRXcGGJTga1+QN+6TztVCs1FOKl59dNoIZi
         e7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790262099; x=1790866899;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pQr3e3+XIGK/bGFvvhbm/aErYvAZk3P5VSlngalnKXw=;
        b=DBBjtyn7iAp4SsLRzxLFIn0Xr3RX+4NZAZC7I72Pmsdkl7hSUxRpCr2GZ3i67aSA7r
         DWkwfk68wOMVV0Uocc0pr2i9+bk+mT6j2d56vbmIYTq8sf6U3GxZ9++Mpj3UmVdBM4BY
         l3PLQKolURvx4J39FmLMvZs6oBIF9w/Hn0i9zHsh2qFgAfe4RnuOPHgW8sPqdk3Ud5Dj
         01QGSnkrLLRPH7LQyZy6iYqdyNVh45e0wuVX7xZts/2344E8YhpEb+jB0rZWHdwRFly8
         rh2Zt8ClbVipy9YQ3V4i9IzQkpOkYHAQ7OYVIFQFPZZMLbP3zucZrdsu2DSDDEN0Tu1p
         eAdw==
X-Gm-Message-State: AFuF++mqGf5mp87aSujNbslOwcvfyyOyEjzSsd67Jlt4BqeGcMAB6Tev
	jr7ZB+/qAel5YcELzxhwTxTIQVwBruP8ftHsHCnZsA+Z1ola7WVTaE+hvK0wFQ==
X-Gm-Gg: AYBFou3RAnkURgwt55Zq1Cmi+zPUkmEefylkw1VyNlcnK93QFMnOher2zdi+NEr7yh4
	jfFA5j7qsqbu3NnCtbytxbBGX1qJXAELHYzmTY/TpAg4n0PBBCsYmD8SV2UNbS3qQCzd1JpHcp5
	i7H3pNA6UquXng9f+NGp01SUiVBMxVjE4YAKqkUOsHnc89j9wVwVbn33Cuw7qwqq7vXkhkrQa6b
	WA4sTnITnccOuQfth9QvGVtXZshnHK00u3pVVVj5DaNQ2YhkPEhpa85IWFMwu94HfrGqC0M4oYY
	fQVoGo9FIwNLVdQUrnpcIz+8n44qLVesNGURKMTkJUhnDybmO+Xtf4oPXXBqzhyr4If1N2litBD
	GO4zTI+g92MdAvg61N9Htk/+HefMrVR95oSk7zlYQyQ3KBwVH8yD/Rj0GKPYTE4c2OFIO57TvoI
	UWhx/1RU4dmUwk40FuYzlwZHwwcY1QyDlOxaQ15hvUGXbhJPJk7Z9SCH2mrtVvDKSILT5eKOit9
	dEP/g==
X-Received: by 2002:a05:6808:250a:b0:4d6:9293:9b56 with SMTP id 5614622812f47-4d72f150030mr2316149b6e.62.1790262098521;
        Thu, 24 Sep 2026 08:01:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.22.179])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4d5c3d7f3ccsm4967954b6e.6.2026.09.24.08.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:01:37 -0700 (PDT)
Message-ID: <6ab53b51.9f8a6750.10625.4aea@mx.google.com>
Date: Thu, 24 Sep 2026 08:01:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8500997369438033337=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kenzivoyer@gmail.com
Subject: RE: Bluetooth: btusb: Add USB ID 13d3:3631 for MediaTek MT7925
In-Reply-To: <20260924115328.15987-1-kenzivoyer@gmail.com>
References: <20260924115328.15987-1-kenzivoyer@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8500997369438033337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: drivers/bluetooth/btusb.c: does not exist in index
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8500997369438033337==--
