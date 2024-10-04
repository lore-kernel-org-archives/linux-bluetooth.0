Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0631862
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 07:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728027044; cv=none; b=jTWYeO/PxNBtWGQCw9wnmJxBuQzpZRPKRDcp3gVqWAmyNtS1mVvAlsGP30maw2esO1XUTp1G82s3eyAwyoP0gBSQyYtIgmnE1kcbn51GTE++Q7yXU5S7u9uLKgY4rfJCI19NojoGYI+L3vflkThHoZFvKi9R8eXJ2ko+bAmmGbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728027044; c=relaxed/simple;
	bh=93GR+LhSnWzWHwwq0a2v2o62knpcSroivfa3z8RhYTo=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=jSbUqAL9a1PA19v5G/zIbi9YC/8rG6cXdeW2pc5Saqd8DZAffWy/841c6Illk8B8dwoXucP//fEJHTi3c8wsvtyh3IQYDQANEShym8Wgm22rG87Mwpq3NXcYGrBc1HNwXbd6fVGZw+A/RJX6tBqVQ1YcGFKIAYm1eItT3rRBixY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9suAaBe; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9suAaBe"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7e6bb2aa758so782400a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Oct 2024 00:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728027042; x=1728631842; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oRkFzW8T8w8ym6koJpww/06LEcgdMAntqrbK5PntlIo=;
        b=d9suAaBeazkBum82+qYOmKgtrSTabpsL2aJPKYlA/8JoXPtHG2OPZeypKm2Hm6QvLk
         UBaBPPh3ScN4JsyMzFx6iIHkaxQjTnHDXpLpmYP6onmyoV3JCmvG0vY3F8skrq5T41ew
         ZagbwFwRf9EpoCwHKHZhTX0ZL1sV3itkY6FLMxXE9pRnHyDGQ2KKmE8e3S8JDKFX2aoB
         a1OKreGIFLOBYieDcX+9KhN+a1pjnQhhw4S6Oni29GUIqwmUb7lTddg4efjTVk6iKdAn
         Dr2kceZTZQO/8G3prGHsvYfHisi7BXS1+mpIXytQel9RJE0JWJy1kpOjdA+FDOPk3cGq
         Am6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728027042; x=1728631842;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRkFzW8T8w8ym6koJpww/06LEcgdMAntqrbK5PntlIo=;
        b=qu8HEtinrugFWo06TvwBPXi12NgLH1x3TAs2tGHMxZp653itEoKBJNrIKxmTg15yXa
         cq98LNpdJsTz+CSQf00u0uPvvRUyBqDl6ufgShPvSrYo79zX/25GQi5t+AAr8R9XHBlc
         CySsTwGqVmf4vHLkeKGWMf4GvIZpfIWONCswTZcZbu24E1WFAlNXR8bAOnR0W3xc+dUA
         3RoesLKp/WFufgwWFuneNwcOQ+yJ7livcjR/NV7YPPPiMr2xFnpDoEQ/3W8wcTcibJyX
         ExC7AYSCS8xBIiLJmHF/0FwJnTxTo+mu+JHsEV6M8PZ2jkGcLtJkB09USpJo7hEgH6bU
         qfOw==
X-Gm-Message-State: AOJu0Yz4PQ8W9oSHlm+bqja4+RUR8jqKPQf5wz9Ts/wXcSpK/fBG4PDv
	joMYu8fnRTYlDZdiwr7raycELiT1PDLAPUJi3NlajzOydwkmbPT/aeroAg==
X-Google-Smtp-Source: AGHT+IE0SzjOZUxwFb7QzRIHXikH65Qje70/RSJ+KGSRR3DQeFrclWKCktza+tHk5UAFrXyf03aBTQ==
X-Received: by 2002:a05:6a21:9204:b0:1cc:b22d:979f with SMTP id adf61e73a8af0-1d6dfa23d10mr2993584637.4.1728027042315;
        Fri, 04 Oct 2024 00:30:42 -0700 (PDT)
Received: from JUNHO-NEOSTACK. ([221.154.134.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9d83fa2sm2566149b3a.47.2024.10.04.00.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 00:30:41 -0700 (PDT)
Message-ID: <66ff99a1.a70a0220.1fac1d.b37c@mx.google.com>
X-Google-Original-Message-ID: <Zv+Zn1cDkCQoOmbv@JUNHO-NEOSTACK.>
Date: Fri, 4 Oct 2024 16:30:39 +0900
From: Junho Lee <tot0roprog@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: bggixx@gmail.com
Subject: [PATCH BlueZ 0/4] mesh: Fix segmentation behavior of Lower transport
 layer
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

These is implementations of segmentation and reassembly, except for the
friend feature for LPN nodes, implemented according to Mesh Protocol 1.1
section 3.5.

Junho Lee (4):
  mesh: Implement lower transport layer for segmentation and reassembly
  mesh: Add mesh conf for SAR Transmitter and Receiver
  mesh: Fix inserting NULL into bool type arguments to false
  mesh: Add features of Segmented Control message

 mesh/crypto.c       |  69 ++--
 mesh/mesh-main.conf | 107 ++++++
 mesh/mesh.c         | 125 ++++++-
 mesh/mesh.h         |   2 +
 mesh/net.c          | 868 ++++++++++++++++++++++++++++++--------------
 mesh/net.h          |  33 +-
 6 files changed, 881 insertions(+), 323 deletions(-)

-- 
2.34.1

