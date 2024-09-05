Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5AC17C69
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Sep 2024 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552942; cv=none; b=mF90EXR4o7nWi4PA4R5WcCXNO0XDJVHv3iF5jvumCNMMmXp6r/ens16ZkvYNB7gkIAYztdX4gTe/32sff+hHQ+50CeJgITlMIFqtExons/wkr85MjBoKu+MwISeOAtX2XNEKNXBCGhG4E3hYGsodRe9zMZdgiS+XoDrbnCPYLsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552942; c=relaxed/simple;
	bh=VsRL2N7yR0YXlV5XaDCeojPJx9pagzBR9Nbkf8flZnw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DM84aErki5iViLlWozQnoACcAvOYFfuJkx2pQKw6viujAsGFPurnWlOAi6i38FWBFYPaQwz/hSOElabzab4i7nXsyCUAaQJnDEO0HhnHCFTz2lnqfZvlm5LP8AE72TgKQXpmme9Cq9OVxY2TgHa/BzO0j8UmIKfe+iSkcFS2hdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltD+DUgO; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltD+DUgO"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a95efbaf49so67273485a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Sep 2024 09:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725552940; x=1726157740; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DMrrIudLEFeIlCH2GEktXzhY69sjYL2Rq3lwrwezFyo=;
        b=ltD+DUgOukvh3SabqXQWl7QgmkiJ3dmslfeTEgtDiDNkx7/bJFru5VoqeK934ZRoAH
         la3Zzv7o7jrSSMepz3H7PrIWi02ecAinmV8VWKiJLvCpGLLkYnfEHR6q8STNga4K9KBH
         3sqM9US9r6kKDM+VqJrY9RanlSHiHNVBH+MMsM+vbWnESMwqA4vnHp1McP0mfRe/Mdmy
         CkIzDrDYI9fEE4mg/AkvHbH8JNxZ50vnLnrUL33FuxaYVWYzHgSuOmafXq2/vbQ5Z6Qg
         thCGf0LORGUwZ4iP9XC0QW5bQ+6zesHkB/nhq0lDwWckHeVPjGk6elRSr6gOiJVDrAi2
         O22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725552940; x=1726157740;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMrrIudLEFeIlCH2GEktXzhY69sjYL2Rq3lwrwezFyo=;
        b=QWr9FQhiXJzOubEI2MEhNGzPZt1TCTQboNULsjzGpXl4gbwicqdIRERRLDEdIO3z6T
         OGOqQGe0/Peyl/yhq/f6ih0I39Fu9U9ZreLR7i3m2rgYTa4vaN/aDgcufPzTjG1M9LTe
         FE+6SVG8ow799GwYWVmbrf2cxUTFiTYZ8S0NHfkfWVqBOaDb47aaTBaMaJY8zU+Q7Cap
         QMGzqz7jtEQC6M0Lw93ABkxFNoc6sLrJCPnPsObY+5YyLNcX3zzmXValZrQEPaceq722
         g3PnZViVncZeU5KRkiIDoswQ+WtMIkLXACIgkoe6v41iH6U+d6olwta2kQBGtbP1qFbz
         qUsg==
X-Gm-Message-State: AOJu0YyqElODdIjgnlfYG653DSR23a7sgcxhvG8rv00e8HIj0+tx9Bkh
	KoBinQwfZ+7b8KOLtwluoGkODAqQKlcnptNf8bxHWCgifTcExriDzbeI7A==
X-Google-Smtp-Source: AGHT+IH/2Dnvsps3WoG1Hn+sH27gGFoIlPkubuDS586JE7GtHaiZSQXPCY+dr8dF1qAsESrQAynWYA==
X-Received: by 2002:a05:620a:2456:b0:79f:41b:aaa8 with SMTP id af79cd13be357-7a978838211mr1404124485a.29.1725552940021;
        Thu, 05 Sep 2024 09:15:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.14.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98ef3a2ffsm87540085a.29.2024.09.05.09.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 09:15:39 -0700 (PDT)
Message-ID: <66d9d92b.050a0220.31b617.45ab@mx.google.com>
Date: Thu, 05 Sep 2024 09:15:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8853878892983125506=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: transport: Fix broadcast sink check
In-Reply-To: <20240905141340.65495-2-vlad.pruteanu@nxp.com>
References: <20240905141340.65495-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8853878892983125506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=887276

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.88 seconds
BluezMake                     PASS      1959.80 seconds
MakeCheck                     PASS      13.85 seconds
MakeDistcheck                 PASS      183.69 seconds
CheckValgrind                 PASS      258.77 seconds
CheckSmatch                   PASS      360.72 seconds
bluezmakeextell               PASS      123.36 seconds
IncrementalBuild              PASS      1754.22 seconds
ScanBuild                     PASS      1061.91 seconds



---
Regards,
Linux Bluetooth


--===============8853878892983125506==--
