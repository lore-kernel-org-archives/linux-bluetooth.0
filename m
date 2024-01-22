Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DD53A1CF
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705928049; cv=none; b=XLmeO8Ih62ndNR7cJPUqcVZbbtcqopxXSEqtxoElXNvV3VAWtLAn5DlZLNmdq/bF9/GvkKXHxPLFXew2WFpaQECll3QSd9/kKZ+Z5SD6Ffu/3aytdZsFkNFx5RyUHin3IDbURmSokE9kEqDPvdiSXHT7LKU52aa0BnZGajO55OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705928049; c=relaxed/simple;
	bh=pCJI1SFxIC3zwEo0KhXmUJfDfsjED2/R8b7L3p1qCoE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cLGKpZx/ebM1iGnXcuqHNM3wVJvrLmU0S5VVJys0i5A67MOSIEAB1v6e8eGBU3Ur33KZNlsBcb3vVkHN0O/9rArLvdQ2eLjdvMpx8cBBDoJeBCTHOg3cGzV1dKOmHdSclj/vwXDJUxQ5/JtHU8kKZhewvRkbzz3LMI+B4Kh3CeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZB0+ja94; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZB0+ja94"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5fc2e997804so26161757b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 04:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705928046; x=1706532846; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pCJI1SFxIC3zwEo0KhXmUJfDfsjED2/R8b7L3p1qCoE=;
        b=ZB0+ja94pLN6jWXC12qZRJQswFji1Cn+0mRIbrvYJurz2y5kkME74Hs/1A/OtxbANh
         oLIi7hIHdd0FU8+No33N3jrRiHlKyMYHcMQ17KrqFhG73+pz6K1QkeerBDSBxvFapHv+
         4LfbrpKO88XLBGJJlV7RW1mT4JmGTcHR+VWc77KLtX1YJpSxb69AWBER40UkBx6CSkMy
         IbzDyfGTmFLCvBtPHl15Wka+m9CM3y51Jncn1L4y3xFSAc8QwhYRASRw5ZojuWfdLV+E
         t/e5dOtgGHC/jNlkiX2G7iE/19RdraE9jXhqhu2BaiXr7L6RI/9vKPEdT6W/hDmXUpVo
         9pYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705928046; x=1706532846;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pCJI1SFxIC3zwEo0KhXmUJfDfsjED2/R8b7L3p1qCoE=;
        b=JtblfYaEiE7lZNDfArmfwmBlgs8uARrDlSkTeVSwCTAaHTtwFGgm74EUJag+d5XAPZ
         Pl+QnX3a1yKGyOwX1snxVMAP1Rn5cPoGzEV2Xl9MZZxP1Rv5cvSnOUMHkqcw42QNruxB
         ndKP4C3ORhT+2U34SlAUJDfI8gqSAOXGvYHLUBv/F79XfJJkew/ungR84EtdL6tz7mDu
         gMAqZJvSEuve4y6QX4v/MsK9ZszpdW/8fU5FmOQgDXxj4Cg4aVXgP8DxWpAv7zouuFtr
         jcWanej8jQ8bVsOfF92zBSXTYuAyqis2Mb0Tz/fPHoplTWWCXzSKcEAcxO0itL2ZULgu
         bk0g==
X-Gm-Message-State: AOJu0Yw0kMnwQSZdz9zLYRBhKVID2r0uhVfpNBiV0n/wiHt4icuFYGnQ
	/TTfnE3anV/l+Eau5dANhLFUcDjuyAQxDUCh7ZwwFOFzpk86a80xp4JKT+ZM
X-Google-Smtp-Source: AGHT+IECVorh0Zvxry1ahJfH9FBn7z93AUpvwaS9dgA854ILmhf7kPqDokx0faIQlkTFXX2xjjTShw==
X-Received: by 2002:a81:9113:0:b0:5ff:5135:f754 with SMTP id i19-20020a819113000000b005ff5135f754mr2997687ywg.2.1705928046642;
        Mon, 22 Jan 2024 04:54:06 -0800 (PST)
Received: from [172.17.0.2] ([74.249.14.160])
        by smtp.gmail.com with ESMTPSA id fb15-20020a05622a480f00b0042796ee2fb4sm2472923qtb.30.2024.01.22.04.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 04:54:06 -0800 (PST)
Message-ID: <65ae656e.050a0220.a8e50.6879@mx.google.com>
Date: Mon, 22 Jan 2024 04:54:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3807624440796301626=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andrey.volkov@mobile-devices.fr
Subject: RE: regression in c7f59461f5a78: Bluetooth: Fix a refcnt underflow problem for hci_conn
In-Reply-To: <a3a31b2d-6039-4b50-af81-47f7ea1a0461@munic.io>
References: <a3a31b2d-6039-4b50-af81-47f7ea1a0461@munic.io>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3807624440796301626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 4
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3807624440796301626==--
