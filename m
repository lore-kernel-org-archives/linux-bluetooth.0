Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D410149009
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719490045; cv=none; b=BH1QH/FT2crE7bcNy7uYRYVxDrJVnrZa1gYby8fsvxiBSso92zw0RV5/gsVT66iptnntxSgMFCk3cUQ7F2yRDnoUxW/sgKEBVmGYcEaqpSTb+7U/YKa9sRDsPZWqNGk3ryEIHbLuuxutnkxELGmotAh1nBipZK1SCxyjxgr61u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719490045; c=relaxed/simple;
	bh=AzpjIg/FWWT1STPKP0uKBfOJ6osVshEDMCbQeRv1xv0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hU1KSvfOXINvqeEvuJ7S4McdpdZIDM3xfyu1I6opzEJRCeWWQqqZRIab+GB9Uh6duMUMt26dscSPgCDEbK6LMc/XYYeZab884+QA16mQnMjRQNQoGOHmng5HtqDp5e56zJE2wjhwxAcTYcbnKW0x1n3tr/NTLv4biaCYXCiCFt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZq16BRG; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZq16BRG"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-79c0c19ff02so282482185a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 05:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719490043; x=1720094843; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X+7p3GmpmvliKq5Xas/flFMj5XHx32/MJ8JesU0zJ4E=;
        b=ZZq16BRGbht2jzz1q3EOXsHDc0HJmQQnKus9V3I1lWqAuE9bhD9/+RFDUX5MamnQIv
         OAzpH6+l8zJFX5EgqPxHDliTzjvUBavAgIK52pDM38Y1z/F55Xi+Hv0FMZy6ZC9jUN03
         a2eH0U3RHonXPOxVyfcX8SanM2giTd2u2qugxfSPPbelj/RPHt81uYn5be+T5Ce3/wVO
         jLE8LXk+3PNS6gw6UwA8OnSEn9b+mTVO9Ugza6zD2LvXOK3pyGcpKKvjY/w5OWFIcOJd
         heR5DwNolb/rFoB0ahvidXU6pWdHRtevQ2MuDHSCqVPrBYkekJ2VN7kgSEVjPLoo4Cl+
         KGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719490043; x=1720094843;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+7p3GmpmvliKq5Xas/flFMj5XHx32/MJ8JesU0zJ4E=;
        b=YWxDULoyUwqyey7Z9/8GEqfNm49NrHH9Ruwh8Kjw9gh+cSvTf+wEqjk0jFEkt0IP57
         NQHM9P44buXW1fUQTVqdgfElJRzg/YamaRcCB9M7AgWOA1ajZoa1PqyKnBQGr67Sw356
         qQMi1CF1/mILASsCyif/u8P55RuwDUWsnp5Ohj3/9LHy584VnLtNF9kJBJ3HbRxA2MQP
         F59pZDgLnmbySDZo2vDCTJpkDI2DilmZ6VU7cWpVqcch8ruf1DhwXFsjKo0Ltd3hcjn4
         L2FM0bgnQYPhSDLtNUi0gSNWJCzx8K9IyuR3SD4BD0RAEhMpWybMqXMg5VErpxu0OkMX
         m3CQ==
X-Gm-Message-State: AOJu0Yx7zuil46ZEtGng0olbUb3TVbUNvBh3bAq4kuEumaoa+tx1Tots
	/sLaY2jU3kNuIz3GRarzgk24zUGBUuYgoO/x2WehmlGhSFjp8R4ki7EcHA==
X-Google-Smtp-Source: AGHT+IHZlP5FSEYF24m48t+2sJ5J0OAMdZkMn34tr3IodVvxXwQ24IR6pJgRBtN40n9b0uPBLvOFug==
X-Received: by 2002:a05:620a:4407:b0:795:548e:aeb5 with SMTP id af79cd13be357-79be6d51af7mr1560325785a.30.1719490042935;
        Thu, 27 Jun 2024 05:07:22 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.52.221])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d5c82f4a1sm48907385a.55.2024.06.27.05.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 05:07:22 -0700 (PDT)
Message-ID: <667d55fa.050a0220.820f.17d4@mx.google.com>
Date: Thu, 27 Jun 2024 05:07:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8085935160168669696=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ] plugins/sixaxis: add NULL check in setup_device()
In-Reply-To: <20240627103022.51199-1-r.smirnov@omp.ru>
References: <20240627103022.51199-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8085935160168669696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866086

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       FAIL      0.48 seconds
BuildEll                      PASS      24.64 seconds
BluezMake                     PASS      1721.32 seconds
MakeCheck                     PASS      13.36 seconds
MakeDistcheck                 PASS      177.71 seconds
CheckValgrind                 PASS      254.35 seconds
CheckSmatch                   PASS      356.74 seconds
bluezmakeextell               PASS      124.26 seconds
IncrementalBuild              PASS      1565.98 seconds
ScanBuild                     PASS      988.32 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] plugins/sixaxis: add NULL check in setup_device()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
8: B3 Line contains hard tab characters (\t): "	    device_new()"


---
Regards,
Linux Bluetooth


--===============8085935160168669696==--
