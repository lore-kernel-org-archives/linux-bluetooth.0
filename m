Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A54020330
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 04:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712205629; cv=none; b=G5DVQDO9Tpv85/5InRaFGvDLDDoYriXoNoDlmswDo124WV9SlaUGmIaglR8GuungK+UG5LohFwPWjMyigU3d5OsBXltC2P9Rhcjqdk1pChpb5El2scVG16KwnHyM1lJR8ELVZROhflx8sjMuvPFgmJVyf72sJegnN0+Y01Q4BAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712205629; c=relaxed/simple;
	bh=xUCS6boVQD4C1giw0JIy1xeDSjXD5lpQ1v1NzIuyPbs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=S9V3UNm1SrwQCAktEIcjuiKxX6/XSNEaClkeI0DfqDTzWiF1PuW43K3Lh4kch/lJtA/4NQv++cxlRAojQe14z2BgtgwpDd7fW7nMBqsTaLHWJpKUOBo3QZ0P+j4Si1dQY7t3YMg79i8o8PRBDFShFdSbH7zH+WAWIzm/Mp+9It4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDW2FhCs; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDW2FhCs"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43448ff9be3so3904151cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2024 21:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712205627; x=1712810427; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zkQAjefUYWpAs+L8HQfHSYOfqshvirNofTpSzXgClro=;
        b=RDW2FhCsRNTzxDQxeb3+k32mFuf0NHQXbHg9Kuui68JjyKZwxyC50y+t7zNuCHBXL2
         CE7jNXroL62Q1LM5VxSbHqHkq2wBodJIxLz3EYs378LwIy/NB1IbkLN9bnCGDJlxNP/5
         vP/9tTJSGSvtmFEEryCS9t45ALTfQa1ux2mONnls8TYiEFy7TEdzGssdxzkhIE6qiyxY
         NxfdthudHFoGtstMpW/Tx88WaLabmccU2JnFT+OXHfpVNd/XHxylq6bK3WKyrZUHXvDp
         je/bIJJEno2pXc4MAfpG33VtGwy7ztgYzRjnvk88oLNV5/kNn4pajgpxaZcpfaL8rnic
         ITLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712205627; x=1712810427;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zkQAjefUYWpAs+L8HQfHSYOfqshvirNofTpSzXgClro=;
        b=i66+lo8FdX8LLgx0npURB9xfSGzvwpIzD5HFcIv9k/Xw496kZ7XVaZE+spTEPM0d36
         Zl15toH9mDxXX4ZloyukkAGcQz+b2/q3/IAGpPi/2Ykjbiq+h2nDN24ZsilnV9KWrN13
         2YF5QBjxltJV/lJLSLpXMSOGe1EUjDMDxbB4u4yaGzkY3lNs/W6H+WUYfn9sH+7HaKFK
         qtBkyRtUtDwkvmmGSaD3PLOr+Q5s7r0xEVmrrnNorD8FvVSrl3ormDN4uCKPK7v5PqHg
         ntFWaRQmGxTRE/efltPn+5Ugox6PVzxice9mQs0lw7FNBosDGNWBEnChnPW+H+zO87kA
         W0oA==
X-Gm-Message-State: AOJu0Yxn15mZm4EF5F9azoKusYht7bJwBxezxjLtbJX6qtvoR6dKz0vk
	p1S30sc5aNpKjjUteLOitQVkhlDqswrwOr5nnyoExl6XdXtZXt5kb2VhEDbp
X-Google-Smtp-Source: AGHT+IFRQsrQB4JhamuKxOYjm0BSbpvc5kuLrXnI/RVd0+0e2aLRIu8tHN/7y1eqI0Yr6hPnmqcn2Q==
X-Received: by 2002:a05:622a:47:b0:434:5025:be8 with SMTP id y7-20020a05622a004700b0043450250be8mr693824qtw.1.1712205626918;
        Wed, 03 Apr 2024 21:40:26 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.161.214])
        by smtp.gmail.com with ESMTPSA id et16-20020a05622a4b1000b00430b385f721sm7226740qtb.15.2024.04.03.21.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 21:40:26 -0700 (PDT)
Message-ID: <660e2f3a.050a0220.564b5.54c0@mx.google.com>
Date: Wed, 03 Apr 2024 21:40:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6858438488268051285=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dimitris.on.linux@gmail.com
Subject: RE: V2: Fix busy loop when disabling BT
In-Reply-To: <20240404024521.120349-2-dimitris.on.linux@gmail.com>
References: <20240404024521.120349-2-dimitris.on.linux@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6858438488268051285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841263

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      25.64 seconds
BluezMake                     PASS      1663.82 seconds
MakeCheck                     PASS      13.49 seconds
MakeDistcheck                 PASS      190.09 seconds
CheckValgrind                 PASS      247.23 seconds
CheckSmatch                   PASS      348.43 seconds
bluezmakeextell               PASS      118.28 seconds
IncrementalBuild              PASS      1436.09 seconds
ScanBuild                     PASS      991.93 seconds



---
Regards,
Linux Bluetooth


--===============6858438488268051285==--
