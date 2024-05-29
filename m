Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6417A178CE8
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 May 2024 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977696; cv=none; b=sT0zOhzPR9wixbJExx1LO4kyOZOgtBMc3nuvrCci1CjpBxiIIFYzDY3hYBf0vCMCwUVag2ygIcOaLZF+tBcppiejlvRxXkKFKTSwb37nFAl/FQ3/4dSpDwNUqtDhe3GhopNlSi7NakWmZhSeI+p8wVz5Z/oYpKKl7o9S9/r888Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977696; c=relaxed/simple;
	bh=vjTM4XCmI7L5RoM2RtE+zyK3YYS3O3pytRo63vGdEks=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Jd0NATpYCjEiGTyoElIlySYLJyPmR8FONXC4wewpRYqLMRqTRyhXKCjsq15jNXCBM7Pa69hrZJyUPBB6+RPEifdHc93srgPxxY9IwgXdDIGS7vmWPwshmvcPegUHyl/BgduEo3WvCZhQBqPrkoVJwOAz4Kash2XmwI/fG2DUrPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCthLx7V; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCthLx7V"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-df4e7763603so1738276276.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 May 2024 03:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716977694; x=1717582494; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vjTM4XCmI7L5RoM2RtE+zyK3YYS3O3pytRo63vGdEks=;
        b=UCthLx7VHX8iBFTiFh2pI6t/nTD5De0N1TKiIBEbTk4Js6E099MsrZxgZKPXMV1CV0
         SCjFs8LfsT1P2xR9JrAexKJqognAbSJJCsP/qhn03WPXX8uT+kweqt8uDDuI2H4KzLds
         0UqXbZ2WTHWY+mG1q/o6DwFieIj7HvGRhSlIpbweIw9hYqNTNAwEK88TJe19b+aUWXLP
         jh2qLfzjAUBhadbu0fEGGzZWG4+pgzNF/BQiCaghINH+ClaG19rSn9zsxeprxdZ+PXoT
         e/YguUxY7tUih7sO31uIw9DQv1gHiCqtyosWEI1yvTDx1QSM2xpZF7zX3wCsNmP5AnDV
         DG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716977694; x=1717582494;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjTM4XCmI7L5RoM2RtE+zyK3YYS3O3pytRo63vGdEks=;
        b=LJPUNsgnT3/cYhkeHhjPC+lyfM2tz9k6IIvfTI/PnVVHR5GCIfEqtOYd5HjJ+Koctu
         3oyMNQBc9L0jbCgGtVuFB4e9LmTZT8M9CEBY3wggRFRRDtt2qKrarkKVQrvoP/Mynk6U
         xo+zkp2CcbG6svphVSJ3sARKni+jGfbgr5a3d3aUkCuw7xrTe8BQv+AxtGKgxQ+5gfuS
         G54um8F6PvcU8fam4U7lTahTHS7RjHoTO6Fkx5WxLRXahXXNNqP/f1RB/2np8n4CINpZ
         UUc8CNjQAIEY6RXYL/pVPK+C+0LKxSqcUNso+geNpu+vwgmL24yKEKhjRm5q7VVt5nAT
         I5sg==
X-Gm-Message-State: AOJu0YzTgprDUBjqthRyIeekYM8yWBf1GJN2VjI4Ld2EivGwnlEZXHQJ
	oPgb6dDblpHtU7rmM3rI9zD/ziYAuUWDMtGXzFJCi2D4GZG2Eus+JiCg3A==
X-Google-Smtp-Source: AGHT+IFW5vqLb0XtUAfeh6Kz+i0rP5luELF3cHvKw1ANesWU/1e4KFcnqmM9QMZCJiaZp2YCdYQzAA==
X-Received: by 2002:a25:9884:0:b0:df4:ab39:8c1f with SMTP id 3f1490d57ef6-df77223cca1mr12924582276.53.1716977692945;
        Wed, 29 May 2024 03:14:52 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.77.121])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac162ef865sm52900766d6.96.2024.05.29.03.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 03:14:52 -0700 (PDT)
Message-ID: <6657001c.050a0220.812c8.29b4@mx.google.com>
Date: Wed, 29 May 2024 03:14:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7214495232095156365=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: Bluetooth: btnxpuart: Update firmware names
In-Reply-To: <20240529095347.22186-2-neeraj.sanjaykale@nxp.com>
References: <20240529095347.22186-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7214495232095156365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btnxpuart.c:685
error: drivers/bluetooth/btnxpuart.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7214495232095156365==--
