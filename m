Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FB615B998
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777117312; cv=none; b=TKuM6y6PRtT1VcWSWcbx9sdSAcNMEp9eJNYt3bG/RZ2AwEXU5YZG8/1fROtEBOGd65XgzeK7UeoRVn4wK3+nztG+MORx0R2AveevLAiPSYBRpuQOdSzeqAaabbOllOIaUqc740IWpzm1bnmfwvlyODEtrIiXFlY1BXF+KRHrkIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777117312; c=relaxed/simple;
	bh=2iRcHsUVEHAm1+Aj3YUXj4u2OoQEThm6mvfc01oUdqo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IbAPh6HZZ/FkmQBiifpZJnQ6x+Zch/IlkOgQBTvEGR2de/zFH5sM2DQ8TAODzXgs7VyCrLtyNmU9r6fH1+3JScBTNTITsUoiK70c6uhxXy2YHhiwEKZOxzWjLCpDzePHitCLC80O0Y4kKQ4lw/Tno+QUSCCzNwaqmrhYBDJdjnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n3PwIQVv; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3PwIQVv"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2d868d014a5so8524835eec.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 04:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777117310; x=1777722110; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w8OvM3K2BkyXrHC7viNBZUcuHku4guJN4asz8q5XECc=;
        b=n3PwIQVvmWmLtRst3pIVsTMuWIO0oCUuJGsIYQI1KRwdm7zcAX6juD91ImvJyhILAg
         0yjxzyu+4t0uJ7dGf5NjK10HHXPM8orgEsdEa1UT+hpXzBStD+8YoXEINjuzOgOx1EoB
         M8HIlqdgh6RkJ15V1yDAG1k0OGH+fgcfkrH25SJXHjFHxNNl/wSltUPk3tf5kpDkKy1E
         s72QMo+siFjAGpRXTItl5ogMxL0R/aKqbE+K6+XM2vz8n9c4g4QUOMUr+0KjKOKqNkjp
         k8Frq87k1GZ6uw9LahQWoGNGhTvFNUjYviI77H6bXp9bOfRMYJyR0gOZ8IUCsmVjdBu3
         9NoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777117310; x=1777722110;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8OvM3K2BkyXrHC7viNBZUcuHku4guJN4asz8q5XECc=;
        b=XmNJKQsAIVpdF6HaEAfMR7mFJBil0ism6zAQQrhP4PgXzPdA9cyrLFUom7q+LDlL2s
         Lmx/96yUX7g3a6kTIdYaYeXTV2AD3Uf77ucvnt5uqoebxPKJlVAMLrko0gq7eeSxqkhE
         cAryW3vGwf0OS0wUZ4k+WNuC7fKcyl3omb6Aes2DvSiqcnKUfb8GTKWzQokjiYFvHBYi
         //0kBDlGrauPUawRVJUfTT98QHE7bcEZJO7eD7H0eaH0QmqtQsVBJC5xYyp2XNjls8cY
         35rt9guDwrS8bZiuX+DUx6kl4PgesrDSVv3etQT3gpfly6Qfwou5iVDkDWOx1hspo3YT
         l3xg==
X-Gm-Message-State: AOJu0YxmfyMEJYhFQ2BFNT1A0qp0NMT+GeCnuM/+xN+DHG4mXV5/B5dO
	7nwIzMF/3uoG78YzeH3Cr6mqXXrekZv+b26nKn/8+fsI7qfVUSBUwKJbfY1xDw==
X-Gm-Gg: AeBDietNecl8ZNLE7qHRItTpxzUMvHCpAVd2AHLImRjcA/thTEanTBFkB96QfHn7r3E
	Va5mgCob8K3xTTgHZE0NXX08E/GV+I4HweU2wzQPdG36PexnDKDG19ogy1ICfB5uOVA0S6JfOEy
	yg8QxalFS/1t1Pe10M6g2Nt8iNOQr2jZOZlS2pFFxkbo+TC+fpVUJhbDpQ4+XwnZZmnXIQ8M8Cw
	2ijOBWoqTOSn0dGR+WdYxkvwCIV3SKUl5eR6Orp9aMhJFhMOlcx0aOcKrRCWUa01JPz7/7l1Amd
	SsUzGXm8vL3YkiH5R2DJmKUfAZAbALt0HYgPpDAzVwELDzCYt/rkin8tWTrpyteAzBBCrIRY1vN
	I3Xx6j0mSM76f5qFxIq+0X7ApzUMgLvcVGsCZeo0k3AwSq9QE1njjVO35uUs6NRIxOxU1927Vqg
	RbMP6GlmeKe2hvveXcrB7NrGQhM/PmgTTypS6XvQ==
X-Received: by 2002:a05:7301:6793:b0:2ca:7eb4:3e0f with SMTP id 5a478bee46e88-2e464dafc32mr18423655eec.5.1777117310174;
        Sat, 25 Apr 2026 04:41:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.163.6.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa5c38sm35369837eec.5.2026.04.25.04.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 04:41:49 -0700 (PDT)
Message-ID: <69eca87d.050a0220.1ad84d.b1f2@mx.google.com>
Date: Sat, 25 Apr 2026 04:41:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3440828757265559934=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: btmtk: don't generate bogus ISO packets from zero padding
In-Reply-To: <8f988c1ccaaddf60c259890a2ca636830f7e4578.1777113390.git.pav@iki.fi>
References: <8f988c1ccaaddf60c259890a2ca636830f7e4578.1777113390.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3440828757265559934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1085470

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.04 seconds
CheckAllWarning               PASS      26.43 seconds
CheckSparse                   PASS      24.99 seconds
BuildKernel32                 PASS      23.40 seconds
TestRunnerSetup               PASS      520.25 seconds
IncrementalBuild              PASS      24.13 seconds



https://github.com/bluez/bluetooth-next/pull/123

---
Regards,
Linux Bluetooth


--===============3440828757265559934==--
