Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD92615BF
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Mar 2024 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710260212; cv=none; b=c7rD8CumsEKhvrDJM3ZD8Tf1iaWxW9DSP1CctCXbakol/GTd2isaLSCOYu/PQ0//RU7vbaB/edbas8xmlX4JloX1ANsrwcm+rFXT7Io0d8Qy4+wvDluXrYOYdCH5yXeHIsAGzqcFKwAWEyxpeI7BIkypbbfGPc3J0p0Vut9pdQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710260212; c=relaxed/simple;
	bh=QsBGUs9ruG1PZ+7YzSmTjDGhHVV3I/fNm9ZNuY4MCkw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=q/afk59xBwN63MQ0RMgTfkKkXHlTpJ8xGhJL/UOqkwVCzbIbkGLPjOzOZMruFiDC32sSkFzEipXAHlfInC37Uiw+Jufy1pW5Ckd7CwFzwaGobky/nfCniKwO3VOc90pWLdgT0Mo1jnLPsnZrgA1U/8P3ZPlhlYaNDou/7YCCMgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/ZEdNkR; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/ZEdNkR"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c1a2f7e1d2so2841901b6e.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Mar 2024 09:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710260210; x=1710865010; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QsBGUs9ruG1PZ+7YzSmTjDGhHVV3I/fNm9ZNuY4MCkw=;
        b=B/ZEdNkRbi4qSHDJCJy9B1qgSzYPvYPlUY/KfInxUGNu+z0iVZ4pajfPmrrTiYxVk4
         uxrfGqBSz0nHsJrpMaQVGJEUc7g5gLfotfA7oksZwwnh90kTpaT+yDZT7EJ86K2fW6+Z
         1UFgtRZnkNh+yOddZSb7umLaZpHLoyJ5S9Mw1jnzjTpbMp8EaiLdmHLL6esgibUBJ/hV
         vafD4vb8IoVfOngQl2RBI36SFFxUJcFgxKa5tmLQu0OfcFVSAHPsjyiGs22Kv6xxzHAo
         q5hoC9GD9qhP7VMYXhuEjoV7vz61xfw7RZENEVs9+9GFYpBrfP15GaucV3SxDWtIyFih
         pXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710260210; x=1710865010;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QsBGUs9ruG1PZ+7YzSmTjDGhHVV3I/fNm9ZNuY4MCkw=;
        b=Rv5b59tM7TkaDMJAYLcju5lQPcjL3Ti5xX7QnYWaOtl3OZoGjin4AzE/7I3ftRsnnC
         KVckcXu5IY6ePJOLrqgMi8MU6pBxn8qczUsHQoSzQEMYgu/X5k5fnn1sJShGEq95o9BU
         6SiwE1YNm+HrJ6B5y+IpwPVwBlTgba2QX4JDNlLI5FB3719Pcno3t/eoD52kwolgOI2W
         pimla5cR36Mrj+vXQokqe9XX1r18XRhLxWE0SSBa4lcKFhUVTCgFjXnisVfeBMf09v6Q
         8Y0TlOizZO+M9AAZMZV1yUkZ6wgy6ovBKm2Q5YQYKS28x4ZaCfmMv5Q8+Qzt6xRD9PrN
         pNTQ==
X-Gm-Message-State: AOJu0Yy2tmwSRdsbjr2OEhc18FZ7v+YChsIPENJFqam2GUNdMAq9eh2f
	euO+GxsIj1a1Nv4geGUieJ1aoYzmohzvT+mHCBIgS2HPA8GVgG+Q7lBs8yvy
X-Google-Smtp-Source: AGHT+IF1zqyNbaFFO5+3dSXDOvmhgy3EtJdajs8guZtojzveY5XlJbbQeUGjkkJoqdZ98hiP5tHE7g==
X-Received: by 2002:a05:6808:e85:b0:3c2:16c6:cc11 with SMTP id k5-20020a0568080e8500b003c216c6cc11mr12864651oil.20.1710260209865;
        Tue, 12 Mar 2024 09:16:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.185.156.206])
        by smtp.gmail.com with ESMTPSA id 8-20020ac85748000000b0042ee243ca95sm3887095qtx.50.2024.03.12.09.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 09:16:49 -0700 (PDT)
Message-ID: <65f07ff1.c80a0220.17ae.eddd@mx.google.com>
Date: Tue, 12 Mar 2024 09:16:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0693366013862406185=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] client/player: Use macros from lc3.h to define presets
In-Reply-To: <20240312155901.1118469-1-luiz.dentz@gmail.com>
References: <20240312155901.1118469-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0693366013862406185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: client/player.c:1405
error: client/player.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0693366013862406185==--
