Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1EF4FE2F5
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791575581; cv=none; b=OWrEwcKSqSXF2ROooUq+MfFtk8CnS3CgVUCji/TLTlitso65bgerV4OxTlhg9Mqc64eIGOL4LXriJKsbnr0J8w1JwGupsF82yB4bZqtLUsZbas/WTd2LasVAPD3hyTT1D811C45nzo+K4AcuG55VTVgVgt5rwXDpKOM39ULLYbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791575581; c=relaxed/simple;
	bh=5WxdIbA+Io2RPOmHUgqyGcp8X4K2FJZumNcr2+rmExo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KV5H8HRZIbkFWd8Y80hdHcJHgfM1w+WNectb/d4rcM/bdDSLi1yC91h2t5piRLop8fFT3O9R9whkZjtbcioIXFgT3asAnIsIMddfbCm1EMgYNPbjMJGQXDSRrOwmgmusI9L3PEHiyB0Zuh3jDwX/MjTebHgn3Sxu1c5O1bUMgMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pStGtGu2; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pStGtGu2"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-15168a20b47so84309c88.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 12:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791575575; x=1792180375; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5WxdIbA+Io2RPOmHUgqyGcp8X4K2FJZumNcr2+rmExo=;
        b=pStGtGu2RRNSNJEcYK+HXuwJfz/D6MNOIH4WaRi5gbe09DVy/tj8MFQoVZcVgv2evA
         34nTHrvxYsIjqLFWm+Cl5bkr7hZHx31g+VKZclElzItAzpj+9M60A+Zkmf44yOWhgJW0
         u+iK/+K5V0jTHa/ACgIBS/U/5uFmOkQ31KKBbtpQSIEySMB8hci7/zcul6nOfJxQy/0Q
         8sVESH8QYkRjUip2jPDV8Hw3Nf6MeJxW70arULhhthpSie2jIE+pa4Hdk1h7NX60L+dc
         QcDPq5+BIybg+eKjPnY04lsQgbDrKbXWcAVMJeo4TJs8jPer/oRlcQr70Q3w8wDvGXB4
         Uocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791575575; x=1792180375;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5WxdIbA+Io2RPOmHUgqyGcp8X4K2FJZumNcr2+rmExo=;
        b=CY79W0okjUzQy/TWjnD3eLtcr/e8oAliie1mXYoXJjZogrXOjXwwfO4q9rc1/yAVjG
         Cblm+zxTe3tSFfn/x2hCGOWk0TgOOAY7mMjdSApnNVOohAm6hzVH+JrM4nRkuThZGo9A
         uWN1td7FNegOCDCUV0MklJ/m8+lM9ekAtB6ZvmTbk9cll5hiX01HS2J6lL7874HtJiRj
         GlbEhqXdkVhZycAyjxvIZy/b+3jBnupPaAdNlFXJUlDtlCghScMY9Rv6PtxNpYeYdOXi
         tbstrVSRUMjNrZlDDvhZEyU6bjd+OuhlRt1SnUi23j0Ase+3abST52+sDxO4zgsfc8l3
         AqkQ==
X-Gm-Message-State: AFuF++krfDgqfL1Ymc9u8vrbZxJSB38d12rX1bYJlUvelHxSpokf4nEu
	V3uxcW2TXgRJHqgkeWXzlKvNPab7enhOicg62A7oJp1JZOYYu3rclTDlPaxMCQ==
X-Gm-Gg: AYBFou2ocqbKmWUYwstjatZbD2spVlKsfke55ui1XDHbgTmU7bPCb3hXMnSN/bQ+m3L
	DbRljptzEChHy28QS8zfPV6+75DpeRXs9Q1J/6pPWpzwxA6a1IS1CuDkiRD/svsxg1fBUaFZ8lC
	Z2htuUIWRndiSHdQsE1TGOkHLkDjuJKTH4Q1M75FnbkNhLCBEibFCN4OU8GPfnPZ8YSS4sneXrM
	1GBv9S1gYsB/pMOuMawZRTa5Aijt5DtsnLdQDCIkdDCyiveG/kUa8RqtWrjEJvg6P8p5IpKyEQD
	iV6OtmTmBsadpyjAZPLCkztrgt5Qw5gqFtzk8OEJFbzhaH+U14CjE9E92JYTWN6GMTKNoM9j7b4
	O1YHXOpaUfaP/u+/fn4OQ/P1mm0/tFVN1uE4D3oI3JMPzO38GDQd1e2nXfR2vnMKuVMfxArF7x5
	6vwyBmP+QFnS2GWIT67TWSCYwHOT09CevrhItbl8rMSZuaoFr5WaGS/PfPH9BzPJaVBYeYj1UeD
	Cu0OUuS
X-Received: by 2002:a05:7023:a5c:10b0:14d:c7ae:85dd with SMTP id a92af1059eb24-16a5dbfee9cmr3370806c88.7.1791575574868;
        Fri, 09 Oct 2026 12:52:54 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.210.246])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1dd57d0sm8238933c88.8.2026.10.09.12.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 12:52:54 -0700 (PDT)
Message-ID: <6ac94616.45417901.a236f.59b3@mx.google.com>
Date: Fri, 09 Oct 2026 12:52:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5102887519250421244=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/rap: Track RAS CCC state per connection
In-Reply-To: <20261009173341.1143848-1-luiz.dentz@gmail.com>
References: <20261009173341.1143848-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5102887519250421244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: src/shared/rap.c:395
error: src/shared/rap.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5102887519250421244==--
