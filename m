Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C29F14EC42
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565271; cv=none; b=tiuttYk+Ls6ikGu7DRxdPxtCDtrMwIpvsyhBMlLxyGn1DjbUXc29XzdCpQoFyHszwDZ1qw0fXN2OS4f7nFMNp8gPfZIVvh+08j+DOhl4OX+MpztWOf7cCRRyBaDqE4XbMjKV/sccS30U5xF/cBbpJGEci1/NsXo0B8bNNFjSE/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565271; c=relaxed/simple;
	bh=2KZsGUjpiM5OMM2x4irkSuuAnHmnmIdn3WZ2w+/5EOo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=roNEAyDd4dyctdU/TS82OdufwrTxGIQUiatV1YC5cmW+n2KAKie+hVmqrJDM7hGenyjPCRfvB0aJ1lHDvg0i/Dz9LMjZXwdWKYv7xqR6Gsaaar18OHoZUcqMgng1TzTWMqTdxFuXsGoopE763GZXmrzpghONlAulZ7g5FVuGxPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgsu3ASX; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgsu3ASX"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-446416dccd5so1999351cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 02:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719565269; x=1720170069; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1hZzxoZxo/JLo6VmFYYbaqjmP5uvKD7ha83FhErBaHE=;
        b=kgsu3ASXPsS5zxY9CUl0ADMN4wjZ7Lh+WBXZ6iqU0e/DipUZiIRbpbbDK3p1/Umc4f
         opRfIb+nJd/PgQbxbhQeRK0jRrkeIVwwd5WNPctmdehMd7f+we95iZ0r0Fea6yXkrsNg
         69SVy2fD7gtICIdBS4cAZooY8T/5D+2JSZAVt4C8xzjeKwYCIQrigpfcIu77nA5jECHz
         tOuniJkHLS3ZyH6kMXstw2y8LqKSHvQahdvZ1eYk0zN6AVoBDBeRDNkL4/pJE+9eyfAB
         05LFxl3LAIxqUq1FlI+BRvtw7WNsMp0TUcZx7pk3n2ppSoGIdqLTYvjZKfEA2pb95y/Q
         MEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719565269; x=1720170069;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1hZzxoZxo/JLo6VmFYYbaqjmP5uvKD7ha83FhErBaHE=;
        b=Lz+90xiGvch2as59Yj7SxG2yHhwe6/EmOLKQdV/nk+/8kCQe1kf4/t9rSDsQ3uvSjY
         3CriXdp45lNU3ReCktqnXL+cIIh0pqSs/4GxbD78SzkjPYU2o5ajBUa7PxXoKjG2VSWs
         SIdBHhSXJFEuLh0vdLDB32rPoSA1aYSMbh2Uj55j37UKuqCZBaW33WX11JzPVIxrCxjm
         o/hWKKEyn1uYrqaEEihoGZGWD7I4biqmGplbSDuUxL+mOxkJkRfdmwFGKrrry65rVSHB
         cAARUBFlEd2CQxMQlWMQpGb/AxX37e+helQrDDe19D5nX8Vp5CvB9bhTjBPin9VtIi9R
         P8/A==
X-Gm-Message-State: AOJu0YykGuSDGbsLcueQdYADRKbuyET/JHIsGDi60OAeTpEKJYg3i/eW
	gzPHlEv5baRdhOi6Y/WxOhTWzDr3f9hVD+WYrr3+lHFTooMcbx7fUgSykQ==
X-Google-Smtp-Source: AGHT+IEiP1vgqcs4Nf4MsCkpn6UqB4VqqubAttOVzxVa62KQESjX0z63KaXzbY6SXWYKlDe9b+9zEg==
X-Received: by 2002:a05:622a:211:b0:441:56b5:9c8e with SMTP id d75a77b69052e-444d91c3ab8mr170703331cf.30.1719565268901;
        Fri, 28 Jun 2024 02:01:08 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.14.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465143b68fsm5564111cf.50.2024.06.28.02.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 02:01:08 -0700 (PDT)
Message-ID: <667e7bd4.c80a0220.b2c50.2350@mx.google.com>
Date: Fri, 28 Jun 2024 02:01:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1979042731313526285=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_prathm@quicinc.com
Subject: RE: [v1] Added BREDR not supported bit in AD Flag when discoverable is off
In-Reply-To: <20240628072342.2256-1-quic_prathm@quicinc.com>
References: <20240628072342.2256-1-quic_prathm@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1979042731313526285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866438

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      24.66 seconds
BluezMake                     PASS      1628.70 seconds
MakeCheck                     PASS      13.20 seconds
MakeDistcheck                 PASS      183.58 seconds
CheckValgrind                 PASS      268.84 seconds
CheckSmatch                   PASS      357.98 seconds
bluezmakeextell               PASS      120.30 seconds
IncrementalBuild              PASS      1413.67 seconds
ScanBuild                     PASS      1029.33 seconds



---
Regards,
Linux Bluetooth


--===============1979042731313526285==--
