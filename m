Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5FF438FF1
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519420; cv=none; b=IXB51do7NCc2bVTmyl7yFZhKHbvJRcKB1e6kcsM1j+OE5YMnzcgCgnlW1KAnaQrEjAitqpYiUDli6onG4tG0xf4YarjFOsWnA9aZLFsx8/kJOSnFLEX2i/rgavyXS1aD5GjYhDWCSGCPPNXElIMUxeghxXxSB0crWNrzZPdjRnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519420; c=relaxed/simple;
	bh=sPBsslAgDyBEqkqyhXy70QNpG2jHwWeV/wAs0+yUVUE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=COnysgOCz43dDnmgUAxN6j7jP6KtnmjpRsIZkbJUJ0gwTZPNXRGvnhdYJkMVeG7hRoK6q1+vb9aXsljoR6iNTcqh7jyjBrJJ+tL9PqX7QL2Yqs2nfDJTPqrvqp15ApWl3QtYZedJE4dDt8lwpNNqI92zaN882AEDmAGp78SDmQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlFzi9KU; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlFzi9KU"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50e63771eb0so42733681cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 10:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778519418; x=1779124218; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tJtlMn05dYDxJ1TiemeZYjSpfoZoZP+7Gnuvyg917yA=;
        b=BlFzi9KUkoddrw8GaF1WerA9OLFezISCNAHFZ2a3dMW4EQ+pwUcehaph4NyR1KDh6+
         zi4ABh5rTXFsQwkbhI34itQmvAiSydgTz2PJKp12m6WUQaThuzAp4thaRtYtNH2m00FO
         1zEiR2CHGYsWLjBbRC2PAp5c93OqkcTazCHwbgDYhvaplm74FOSFNz8ZF6mdnflIHEmG
         WpAI8+3FIGfrhZb62ESVlaJhY0GVN2sPFrgTTqiYMRzP+DAdrIJXDnZ5csRga0k0H0fd
         wmfg697uH64yPMFzdj4ASaG3+ySJUG5cDHlzA69T81v/DF+L0iEgiT88ZFUSht4XEQXK
         q42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778519418; x=1779124218;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJtlMn05dYDxJ1TiemeZYjSpfoZoZP+7Gnuvyg917yA=;
        b=DsvshHYh4wxYJ0iRhNN87ER5HShqGYZe+AasjeB9ts6SkfO2w/PgWI3eVV9i8Z/CX7
         YicsHAi0eG0lWQq72yz+eYNOv87l1uP5Ydc1c8IsNPIZPIs/zXJg6+NWfzrjt4Vfcukh
         imhI8ksjtPj01xUIPStjF2/XXqQuH0s0a2bmyXIxl9hQdmlH7QMz3Vv8N1V3TNudhZkw
         VnN3DBJTBYQGEARmiKdQc7bhGhBdqgMLu9LKPakeC++pEyONhWMfac9FxHhOSntVicsR
         C3fldC6cLEVlqkEplhVD0eyKdM0BLY12LwbNeFTmD+lVwpaZoczjqY8+GXgl5oxOpyw7
         CATw==
X-Gm-Message-State: AOJu0Yx851XRFEk5qAdSh4mIuQN5JDMvTKkxEt4UfeaZwnjOiYe0xEwe
	FI8pKenEElP3PK6eoWdF/hDvlLUETO1TukYcsUEdGqtBYj5x9aJsBXtoHLlyAA==
X-Gm-Gg: Acq92OEDXpolJidvPpihA8mS/m7zd6ZlW7kqlBZqF9JuUfEHCVGOkQnckSlbaP4p78l
	3VVu/XXgRr142zTpNe+4BYp8Miv9nVJw+9mINcMDW4PghzNtjv45HKCnfs13qcnXBrzXlvfFirU
	Ynd1sh2EdTnrpkHwT5/wTBi2BnwunKnnGoCXzX5LuWrkscReg9hNX8waY1eh8jsbS5F3MzXzU/C
	23ptuQz4d0H8Z14XdDyrdVWuAa7ZAJ7KWQJBYPfZIfmsSmJVXRhoJ1k5MKztJmPKeoWsVqFB/g/
	PmzpExOGiDcyRVA1dFWvmPZ6oj6qPXlilAi3IU9QmS4TJtvojcMjS8t0WHzwxCRK9piHHANzCjj
	46yIEHoMZIWI1b8YIUoHHbJkgf7gelxwc7muHzOQW19DqI85SbKvs0TNHcDY2nIZJDf/mvLtiXk
	OHaoroECFKW/cv+vxZ031qfCiC6dMH004=
X-Received: by 2002:a05:622a:148d:b0:50f:ba44:ce60 with SMTP id d75a77b69052e-51461e7ee28mr343529731cf.36.1778519417980;
        Mon, 11 May 2026 10:10:17 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.93.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7bf7e4sm94438521cf.17.2026.05.11.10.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:10:17 -0700 (PDT)
Message-ID: <6a020d79.050a0220.3503a8.21c5@mx.google.com>
Date: Mon, 11 May 2026 10:10:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6908789912589764829=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: L2CAP: Fix possible crash on l2cap_ecred_conn_rsp
In-Reply-To: <20260511162456.657014-1-luiz.dentz@gmail.com>
References: <20260511162456.657014-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6908789912589764829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1092945

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.00 seconds
CheckAllWarning               PASS      29.77 seconds
CheckSparse                   PASS      28.32 seconds
BuildKernel32                 PASS      26.13 seconds
TestRunnerSetup               PASS      579.48 seconds
TestRunner_l2cap-tester       PASS      372.74 seconds
IncrementalBuild              PASS      26.99 seconds



https://github.com/bluez/bluetooth-next/pull/171

---
Regards,
Linux Bluetooth


--===============6908789912589764829==--
