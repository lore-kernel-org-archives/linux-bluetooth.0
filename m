Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AF41990C7
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729600318; cv=none; b=Z37+PErXlxmv3GB9hDJPBtYMtyOLh1IBU90RAju3QB9PXYeAHPGtIZHZojntWYLbRdJwZe3IpBKX6AoS80oOoXGHAnA58BFVIV6QAP+paZMOkORzHBpxj8a7eVeIIuizhQ8004sFGjlXmTaB1LAfelqGecX9wEMcqagXOzO31Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729600318; c=relaxed/simple;
	bh=2g9xhbIwPQeIza203qN04jLyIVs70NGKUrifecUNLLQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hZLHsavuCYWyduCF8v9nqVIuIA3esA178wQLuuz9mqqoI9XPOajrivTW38NPweUN3PLrdyxmCfwysGenIOMxyIVZt9AJsR+uyu0mfzUIfWAQ4lSUVx3OZ+h7ZLt/j7auVrdclpHWTTdfg299AELaiHI74Axe26L7fo8fFowNzoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfWy8agd; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfWy8agd"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-460963d6233so34541691cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 05:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729600315; x=1730205115; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2g9xhbIwPQeIza203qN04jLyIVs70NGKUrifecUNLLQ=;
        b=PfWy8agdREG+r35MPLKoD7D3+TGFtKlrRmGBMXLGAhAM0neUxD8Xn4wycsobbfekmv
         X3lfN84nkmz1bzfbCASQjl7GYIHK9c6fdSHuUOuUNKVCyqCJbQORFFGK2XJGCGkWl0Kd
         N0Eqi6PEhDZII/4OGlnS+7p9B8PE6kQsHh74OmtLYqO7goA2dNt4cOaTDTwbkfnPAeAd
         t+AeQGdzBDDmeqbApA4yY0XxqIVgehYRGyCQHs64j5Lh6MQE1V4zqh750Yjbt0dLAFIv
         y1R8cslUWY0Sn8BLBb9bANt8V9iALC6tDFYZ7tXwZINsY2OyUbqT/IyYHC242hv6w5zM
         sC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729600315; x=1730205115;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2g9xhbIwPQeIza203qN04jLyIVs70NGKUrifecUNLLQ=;
        b=q2xWzzwBdGE33THlE8WhHvAYPtTDDuZ4vVAh4CPsZch0x4c/KNMhDHsa/FfWnQUF4y
         2JAKkgFWa3wyWqbq6FJ6cY8l9jGdCpUOVp3goYB/YV2e8u3xXl22tQkFq7S+RQ+v/91p
         /GKG8hN0VSNOAfSVdoJGsLF/yl4aJ5YRkNBzA9QUXigiGieE8lyP0A/V7/QaUhvjSh7v
         Hf6FDDUja6reIW6hWj53X6ZeArjuXvB6KfxDRrqgOW1p8J7jhOHhVZhOuF50ZmCtOQvi
         bsDdI16ubJZYHUi/HGb487LsmXNQjpUvCEJNwdhkk6oYLJtO/0YzacSulGWJRe0405Q1
         j6og==
X-Gm-Message-State: AOJu0YxXITVOCDJ9zseaMJgtdRhSzTiVHQs2LlyIH0yFEiy1z7irGpii
	CU1wPSLt8duAbLRCS7lT8FH9JGEUTVpdNyyv09tNB6c0YajW2QcDoezV4g==
X-Google-Smtp-Source: AGHT+IHoAhIRVXGSPyl0lc5PwBgLg/udqS4O8Dd1fChL7MWtelLwWI7UkdrNbR40dgNARZn++t5ixA==
X-Received: by 2002:ac8:5e06:0:b0:458:1578:56a6 with SMTP id d75a77b69052e-46100fc37ccmr36288461cf.24.1729600315334;
        Tue, 22 Oct 2024 05:31:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.46.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3c3b003sm29125121cf.1.2024.10.22.05.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 05:31:54 -0700 (PDT)
Message-ID: <67179b3a.c80a0220.2e9cba.83c8@mx.google.com>
Date: Tue, 22 Oct 2024 05:31:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3413992364496860113=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Fix bluetoothctl --help hanging if daemon isn't running
In-Reply-To: <20241022120051.123888-2-hadess@hadess.net>
References: <20241022120051.123888-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3413992364496860113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: client/main.c:3187
error: client/main.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3413992364496860113==--
