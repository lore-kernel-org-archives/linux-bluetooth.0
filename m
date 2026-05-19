Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3271B4F0A
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182065; cv=none; b=WQTj2nXnd7wJ9DCmUlLEIy0IlKpg4k5M6HLj7dYNus7Ka8L6LpdV9p6j6Sxy0ZlPokMHm/MwXbM2fwS22gsQA+fzVzBCrXdnHupXs0heY7tG8ydujP5LV4KsYYGKAdyvKrQ5vj4ezeS7NQq+Eg1Rpax16VBKo55KOm/GBtPXjq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182065; c=relaxed/simple;
	bh=BIueUmPdhwBNCUmgJMVkDUuRPiwbcemnJiq/kXjbWOY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uEaf1n7mIyi5U1VtKJH4ixttmttC3WEMt2K51V1BTVa5cmR7m3N0YIKL1I0xKkaYfHJuGoAX0lY7dVL70bBGGnZ4TEOBUHmGZWusHv6gtsfZmZoTdXckaM2JExGNw9GAxmIJTcIXd8peGj1UADJHGmlp6oIFzbKNVM51y39rjKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uv3556p4; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uv3556p4"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-135200bc7d2so9023877c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 02:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779182063; x=1779786863; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cXT5dKjBXMbuQaeKzlT6Xr4Kv4HdYTGtIDB0w/WmuqE=;
        b=Uv3556p40Ffb9AbHe/7iNPDm1gy9vI/l0jqyXoFPB6vmQEqRb5mUX7EhRgeYwS0e6I
         O1m/bqf/LRrE/zxWIRDiNctIUYg99VTm3k0vK3yvqicfuPnnuD7QJhrum7X5kOx2uVJx
         PydmLcVVyBmFQMQHwstChPOYwWqseoR4abClLzPOmt1vvc+wfkpRwIrFZPqOrlqnl8fD
         vgIUeNAUzPHVo/oJ99LB8MNll8vD2zMvsDhQlsX+Llnht9Ew5bVzlJRJ+bIm2yiMXqXL
         CCoZMa+RJi5643l1LBUZSikojbjYnPR0aWxK7v0wKgLE+UMw4yQZ4sFBPupNSrMRm2Zs
         RN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779182063; x=1779786863;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXT5dKjBXMbuQaeKzlT6Xr4Kv4HdYTGtIDB0w/WmuqE=;
        b=WbDp+aqWwNuE5lmzQzItRfrNX9qa9eO120BubzchfPj8P+4KbWaDHm9/ZpU49JE4pJ
         HI3QllgxPwdcAvAz0kmdq2owcYAjcIYz/6UnIi6m2ke9nPLmMsPdwHQPht4HUaJjhqpk
         Gci9IOLY4DhVAe7240RfTERen4KnQ6xPpJx7LcTgEadXhmOGFOvRvqBdtslmJV/EPHOf
         B7rnwEMAyP74SVXf+3DH4lfA0ORl94yrFOs5B/Pl/TnAuPUeDqHKCP2DhoUo178x10Bp
         HUP6BdUJB51+L0FIxkuBoDuTkU/ZKBSY+nen1ZLhfXYZ9Su/M+SninSVUFvVrYBmdje9
         sLrw==
X-Gm-Message-State: AOJu0YzQxG7/R/jgs2orrA8xO6ib7zlHCoVZfH4uXXhjy4HUvZvEB9rp
	LFMKp2DfG68MUE9NDrHh+HKR9RDbeFXWCL71b9EIQTXcdw3SErZctGFe6SL5/odv
X-Gm-Gg: Acq92OHuJ6kX30Az3WoaGpRjK7vcM5FBsoCiKfAZSUtWOzfYwuNlWavUk4ofnjdf15O
	8FcZvD24FzONS8Y/WCOoBxazuYD9tNnrhwCaNK81BMNrUJ6swNi9Khx6GGKHgTYlku9iyrzbI9f
	k9GPN2pC9EPUx0vkjXMQFwmBYDGdVY4GGp0V11sReItCfYBIsd2t8cUbUSvB6g++tCM3TC+pkof
	pNfr1RTDAlmfUvpDt5hhJR7XSK+5Ewu5F/5jaHu31GOR5e3HU7tC9+VD2WlqEnPZMpwAjO3kMkQ
	P3IB5fx+JfpkfeiJpoaoRKF8gfMFwq6TLL+AJ5ePZiyRhGsh0Yx8jihk6r6/JvKWwUo0+lKWiHL
	v8M7PhuODhtgdrTuMprfA/dxGrFLHZLBPHR3hLGu1PvzPSsWfBQ4kkn89hrwLXYjZRUwdOPaYq5
	yWHa3aeYkRn9/fKW5AXhI32SMtWBIvCzQ=
X-Received: by 2002:a05:7022:6727:b0:12d:c039:65d1 with SMTP id a92af1059eb24-1350451e8cfmr7967519c88.1.1779182062781;
        Tue, 19 May 2026 02:14:22 -0700 (PDT)
Received: from [172.17.0.2] ([52.160.149.130])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc33a618sm24327021c88.12.2026.05.19.02.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:14:21 -0700 (PDT)
Message-ID: <6a0c29ed.9652e1b4.14d1d9.40b9@mx.google.com>
Date: Tue, 19 May 2026 02:14:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6241322722505134997=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, meatuni001@gmail.com
Subject: RE: [v2] Bluetooth: RFCOMM: add minimum length check in rfcomm_recv_frame
In-Reply-To: <20260519073003.34206-1-meatuni001@gmail.com>
References: <20260519073003.34206-1-meatuni001@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6241322722505134997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1097117

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.18 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      21.39 seconds
CheckAllWarning               PASS      23.49 seconds
CheckSparse                   PASS      21.19 seconds
BuildKernel32                 PASS      20.51 seconds
TestRunnerSetup               PASS      420.35 seconds
TestRunner_rfcomm-tester      PASS      59.01 seconds
IncrementalBuild              PASS      19.56 seconds



https://github.com/bluez/bluetooth-next/pull/214

---
Regards,
Linux Bluetooth


--===============6241322722505134997==--
