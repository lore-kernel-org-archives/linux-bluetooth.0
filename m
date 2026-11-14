Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794688638;
	b=NndCzG6wGXqfCUsnuk9B+lzLv1Y/9DLEEKu7MnAjPvhF+x/ST3rBvjrdil1Wg6JIYZMj
	 gLtNvGgsuWY44i6DfmGBNmvVxFwr7ydrewfU4CfJG4Ekx4v48XkrrHh2601b2liTHiDl3
	 L8ohcVdkiKGIgjMeM15eTlnEOJxCRoOCFFsy+ZiXEHFpcyYCfZF4izGCYclYChlp/RQVC
	 eBu1VZ35gyXXBMRd+SzkDHnynAEcKNzXk2C1yChuzlthlMx+72yVwKukMismTqoUHg0dj
	 KhwRzNfOmmFcE7uh2sfN/SAb+JBTZBFY7yYa+Qcx2YZPoST3rVwrYpo7ca7bMcI90Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794688638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=STFW8qHokIMHdE+g9UA0z3vmL/KroV2RbaWUKhe7x0o=;
	b=44XJ7FflquXYnXReSPfOtFmoLeoxTANp1cIwRkTUR6scRjk3KMXamD1IlM+I+UiByS/U
	 yxrNG5XcBpwd7KX8Jlwcd8uxQl27NEBLgIPYYGhJb+pHLGVT7emfMDDS9fu7nISUjCJZp
	 CD2ivvNgcdKRUWVS+4vrCYxRqRn3qDvmfJLvCo3/Zx1QXXoO6caCMThstPppN92GoHk0o
	 eD53/7YDRoZXfo52fnEc/HVUdHZMlXRZILV7zTKOlEnIQzrnbUtmheS/lvILaMmdIK/dW
	 7C97bHpWz0g95WxbUn4+UlSNuW86rf4tMh7DrujucULvJux6I/hWQa9+SwJQes9fu1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C02fH02+;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472D6606A329
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 20:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 472D6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C02fH02+
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdab938dc83so1057013a12.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 12:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794688637; x=1795293437; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=STFW8qHokIMHdE+g9UA0z3vmL/KroV2RbaWUKhe7x0o=;
        b=C02fH02+oJq4pSkbjcPQlmjO3Erju/X+af22vGdyctTrPDHvaFsPbFU35DyRjJ8Iny
         qbAdC9HWo2aJc3oRxRSRp3LZId6yYjzJ6/NK3nAa206zXLL3s3Bcn+Wjot5IRq3n8ByH
         q4Cq6RXs5mAmf3eIbucPS/BThOMTvPoduZe3z2rBL2yEOrYdaVRyUZT1zFvHKFPtURFl
         C6KpIJ+gWleUptuWG83xai8Ufz5xtltd7gVw+Wny7eur8AaNnto30NIoLVfnBA65gYvT
         xQ4CQHLayxF3qnRNY2b3yyX3/Dc8IA7ohuRLIXyzDHf2YcRor2l5PiVLHUikEZM5j8+Q
         mkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794688637; x=1795293437;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=STFW8qHokIMHdE+g9UA0z3vmL/KroV2RbaWUKhe7x0o=;
        b=dAF/DVmq6DkS+H90/3O6T0VZnBwZx4ZxtAs/9Nmto3lutVtsZZML13TMUsURyMHK27
         hdmWq+76fJHKT/lqdxES+iEMsgxpUBiVoH67JvPfP7o7Z7cMQJGoN1QwEP4OW8p9kdXm
         DnrUzOxqFuWsTk8fXyGzgnWC6P57FDbR33fvy9xqPfKnGG8AqL0aBP5xCtAXjx3fPXjD
         aoWkd9uFXyYjV+zz90d1zkmWbP/bwvvagDfDfO3/m9zqwJGJM8sqC4Xb3j3F0HCcgrHW
         cP90VG6+FQka9IT1SvAdlejRcnnDujEr0wJ0wHRX3bY2PT1pO7PRKFqMT/fJnLSrIUcd
         fE9Q==
X-Gm-Message-State: APuU4Z+VqrOHUuYdGWrHUHf6b9WPASzpqO26GbFMjDO8tsIG8mR7u34d
	BA/t5lIhiQryIUo4nCY5uS0PRfWDZrC+W3KVIfsHMrPaXFPkluuzn0vSKPTfhg==
X-Gm-Gg: AYBFou30xAp8A1ALQJgKsYKbzqUaaW09bRjtEaweg4Hw5rDld6B2RmRKmdVbz1ohHRd
	6fm4sOGnnKczQ92k36Rlu9Qg3coz2GHSb7rnhI1lTwGLEQydTJV/kApvUEgeQaDcj08WdBRsqcq
	ceypmECBiEm2/92k19bnONWWj9lTkSOhhlR74lA3ZGXoK+XzNI0dLlPAWJ/iyV8mgpeJD7kMXhR
	M2M+kGu74PVHQxelVwyGPcfMgHNP/N+o3uHWDrgLEwg6EC/USutWOy9DBvE2A0qgg8XvnxKw3us
	4yOT+sljTLD50gRtWuEVNlEVGlNoKtcNB289RB6sZmcCYnv62d8e9zPdm6kbb23+d9oXb7ECWhS
	Zj7+oNfKCzvYX4cgcgJCjVb3xveFSshlsdTp92bNVXC5TN8aJEw51LA/cW5LWFddjyjSSrkIIHk
	zwdWUneFe2ciwnPViKr/Psg/ge9WXK9/QwGnb+Q9E4A+MAeXDxW4xazcq88MjZDfaGI0lsA99NW
	JP7w2brs5TQ7hbFSIA/RLPAutPvZSG2867kqSm1OpLtWVG+lNTe+TY2Hp2vmvPzCvLvSW2ARFob
	r5I2c/8=
X-Received: by 2002:a17:90a:c88b:b0:3ac:8741:e2e4 with SMTP id 98e67ed59e1d1-3b1b0a4e341mr6226035a91.52.1794688637511;
        Sat, 14 Nov 2026 12:37:17 -0800 (PST)
Received: from [172.17.0.2] ([20.98.117.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197ce460csm14790127a91.5.2026.11.14.12.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:37:16 -0800 (PST)
Message-ID: <6af8c67c.488c8742.26003.b81f@mx.google.com>
Date: Sat, 14 Nov 2026 12:37:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6524514101550111588=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [RESEND,BlueZ] test: functional: retry pairable when Busy
In-Reply-To: <45f6af417f7b09d62d76bf128c1d6d22189bb2f7.1793381304.git.pav@iki.fi>
References: <45f6af417f7b09d62d76bf128c1d6d22189bb2f7.1793381304.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6524514101550111588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [RESEND,BlueZ] test: functional: retry pairable when Busy
   Pull Request: https://github.com/bluez/bluez/pull/2739
   Created:      2026-10-30 19:41:18+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============6524514101550111588==--
