Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEB479925
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 19:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579459; cv=none; b=bRd+R5ItOfuTc5Dja3lHFvnYu/aztY8V6NrYc6h4VYX0t8zsOJFWvCLHi367478I0Ohsx8EBPXjw24KkOYCXCLqc0VnQhAxReyv4AXB5ircUHUh8bcBEHc0l2I9BHPw6vRP3u/g6QdtZxShfN90wVwYhygPKQ0IodAkJh45hU4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579459; c=relaxed/simple;
	bh=8qGZq/yvE59YD482B+wqCxolzjikhvHgl5NwaKL3uiQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=P8NMppxgVB+95Lae5bAM8WoJeTazc1nNIoHgXUt9vIVycGxrC3XT8R/jlWKxNpXVikrUIYJtx9swBW7KUxrddo1eEP6XXfdCmayh/tnyOeBruls+l0UBwXZGOPkO5BBcWmaPFjcdUnkY8iA9lfDxM1uKag2INd06YNpqmAxl/Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Avm9wTgq; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Avm9wTgq"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bbc649c275so3140044b6e.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Mar 2024 11:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709579457; x=1710184257; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FWt+JMar03f8UopEk6nbMiMgH39Mf3nnWJJc1xAxao0=;
        b=Avm9wTgqjJFJNZ19cVBBY09vh8zWqlHQjdUd4kQjtB+W9EF0ZuB7ofbAui+1rSWUoy
         60mXgaPhHmIhmnkujUUcjAHrZM3LBh3WAXZXwB7GP17AYxBhcKeGcfeeQoB+3XssB+8s
         E6Rla4vuBQ0HZiqdDg9/CPajTmd6vesXLvjcWLMGayrQcBneeldl1s3DTq6d7+uGSQGI
         a+eDyGf5bzz7oNm4UkoL7Pw2gsr6fo1Y1AUU2N3rCOVGfZYUbOTR0EqOF3IX35os1KPF
         TRDElyVNA9TVINIqTaPir6rmrLM0a4Q2xcM7jBvJqn2BRiZ8qAYPJL807p6Y+R0dT6dw
         bkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579457; x=1710184257;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWt+JMar03f8UopEk6nbMiMgH39Mf3nnWJJc1xAxao0=;
        b=jlkRgQ+O9jkdt438pzbQNVyHGkMSSy+WCIgkAa0aI/zzQtKJsrpbUS0UtXEW9FzCGY
         VrDdtpUu30gYhWMMUlo6tfkvt7BaCWdMLMOncqSEF2yJd8cHTsFWbh02a18asHwq4B5C
         awLcI7eZPrxW4I7lhZmvp6dQvUYHr/hmlkqqrq8lfbH+bnThT8iKuji0Of7CQUxj0ay7
         HUd2dNinWyovIoOehfLtqtRbxphKC+Bczsb6M7jyYzw+kYuXa69BQ1174zr1wFna1IiT
         1RI0D/nldhFf+yHdZScyjppCNkVaXiS92sNIwRFigjA5kiViRTYC4dSGXEbRLhiUh9Z2
         ScyA==
X-Gm-Message-State: AOJu0YyBVkueX67gGhsGZGoDd/QOHzPBR1mh3vG8z90AZlABLvZ5pwad
	iMom0r3fz2B4FiqRjItVsTZySOEV/wT/LlqWJEqhCRwQfXDOPHX+AU98DbHM
X-Google-Smtp-Source: AGHT+IEAZxkF8OtvaZ8E3Bt99OnbyPB+BluAhTXppjVGVXBlQpN20Wxd+hVLK8WTfeoL2Fvf0j3abA==
X-Received: by 2002:a05:6358:887:b0:17c:1c76:dfb7 with SMTP id m7-20020a056358088700b0017c1c76dfb7mr2266549rwj.18.1709579456650;
        Mon, 04 Mar 2024 11:10:56 -0800 (PST)
Received: from [172.17.0.2] ([20.55.126.67])
        by smtp.gmail.com with ESMTPSA id j16-20020a0cc350000000b0068f7fee5a88sm5373330qvi.76.2024.03.04.11.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:10:56 -0800 (PST)
Message-ID: <65e61cc0.0c0a0220.6099e.60ea@mx.google.com>
Date: Mon, 04 Mar 2024 11:10:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5196609299296533050=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] build: Fix distcheck
In-Reply-To: <20240304181157.3170287-1-luiz.dentz@gmail.com>
References: <20240304181157.3170287-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5196609299296533050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=832197

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.02 seconds
BluezMake                     PASS      715.93 seconds
MakeCheck                     PASS      16.20 seconds
MakeDistcheck                 PASS      164.75 seconds
CheckValgrind                 PASS      228.43 seconds
CheckSmatch                   PASS      332.92 seconds
bluezmakeextell               PASS      107.72 seconds
IncrementalBuild              PASS      672.76 seconds
ScanBuild                     PASS      959.32 seconds



---
Regards,
Linux Bluetooth


--===============5196609299296533050==--
