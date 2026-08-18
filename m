Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AFD3AB47E
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787055668; cv=none; b=QyxKSWYZSM08xkaMwKvOIQdA7+M2eJHPqUEwePlG31Zh4oSj6TjfZcxyZpmw46rznl+nULC++CdJpshM/0lG9S3Na9lFHbf6Z60vgsk9fO0irUjFlAaa9ZQhSoENIQa6ltz+5cQ1K8RwmjLXEouoS81lRYXYCMz7sz/n3mHUVS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787055668; c=relaxed/simple;
	bh=efCpH6GzP5QpnETbu6LdGMZiar9MH8Oj8GgHjE+F48I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WzlrYTrYIQSt3/hI7lnXd/TudR6IrLBNJuDb6aGK7Ma39LWeDuiw7k61od5+qBaAPvEWexfFNNRZl/tbHmowvJ8j4PCrj2RuQd9YKu9kh6GzVIc13SWUdxStHGCnTFBR5SRPHgItvV+HHq8eieVWmsu8UiASJs1deFVjL5gbwZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWwYZgma; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWwYZgma"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbedda4c154so2555582a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 05:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787055667; x=1787660467; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UA1GdxLKC71nQnzGyxdhPQwN2u7iUXL5vEaq1YXTpaw=;
        b=kWwYZgmaJ6vT0z/FOXQpL7jpBarm5r4uinpxVtEsGe0JflI6oMYODJYGHONmFxwJIl
         XrV7ENufx91sprR1p8pMlR9S7wPmujdJrcU4dntkdLJN5/pr7lJ4oBk6UbZWIaXZkXLD
         Qn86XrOFzdJfsVeDfJ+yIRK2oQjfrvkbxuYIiN/y+wszqiB08ehDev9tpvs3LB/Ar+9B
         umL0fR6xpCwaGluU2l3lSlAdzDdNmAP//GA4HwwS4KvjU04BDvCxBj6oi/qQlNkTdBnP
         n52GxalvT7nA3DlXp3+g1NqYqMcIxuvdUWkKVBpG1KtBpaP/QPhpFO/vRjZVjYIwkkFe
         FQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787055667; x=1787660467;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UA1GdxLKC71nQnzGyxdhPQwN2u7iUXL5vEaq1YXTpaw=;
        b=U27u9LsAtsXQCq4hUSmb3Bdz6XjQBjC/5SsY1pVJthMOarr6HL5sGJvtoUFBqZj1po
         b8KEz81kyTKq4kZyoVRdWOtJv8sA/ct8v40G1vR0kaTAVI8gbPslAnvk64J0x18ENblr
         //u/3OpaDyWw2RrBuxpz8Yuwihbu1DvYiKSxqF6Falg7QBo6wh+OM2sSBVEcFiNSAjJa
         rekoXiD/fyDSuS4XwW2ZYqV1/e4aLq3F9FV9kslgREH/EGcx/jaq7YU/mv3oIk0aLu+D
         JeM+zL6XzdaKeokC1k3zpNdbI/TBA2oJuuyhqi8Y1NUJDLF+U6s4vZQdgTaCS/CA8dS+
         sUjg==
X-Gm-Message-State: AOJu0YyuJ71HkhoEgzaMtjSEovsXSkiJ5xv7R47Tbqua2LiuHYWlkyAa
	m48AE98eSsbST3cJzZ28iLavi7YIA5F+2WiJNy3NhlGjFOGjpPuE2hMmQLWxvg==
X-Gm-Gg: AR+sD12+rxyWXfneXK6A9A+ymYvjEzwAlnJvuhnnZLtAAQJFUi8Fz53nYlza4kVTfy9
	3Cs3IQEwXev5uNpQAOwRovBhsRAarYQ055rRI8wmoNE+W1LGeXdF1mA+fOe1RLmEQsqUKz0Juzi
	b317aM0RFcBKvp1fgN/w35rOwndFzUQ50g8ZpSAjbG0AKxFdirPFF+9hyRx2HbKfyjId3tdtSQo
	+w68LJUKQLsFSbOmXdEWtmUCHL0xK4PW3UoeRvO/m/Czqmdo19uVj6n4tT8Kb0V+YoC+hXBD99j
	bWLa6dv2XOHIDbM+fs73vVmiYa47YJ8mskgXaCbJM4XAzJhStffSrMX0BoossL3j0GjJ/uaBIAA
	Uc/XH1Znom/9JRE0VeC3+Tzcbt9Kdh05v8RyQU01YWAag9rcurzzWEFfpDgjqa5Cw9DAijQTTgm
	fK1z5iIbr52qz9PsVyKU/6sgfloc/Y1dXM1+yk1GSRIavujRcbn18LCmypK1QioqDUBc1sheSSr
	SCJiQ==
X-Received: by 2002:a17:90b:3842:b0:38e:524:8797 with SMTP id 98e67ed59e1d1-3933b89a285mr28574831a91.13.1787055666713;
        Tue, 18 Aug 2026 05:21:06 -0700 (PDT)
Received: from [172.17.0.2] ([4.155.111.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e84118sm9344400a91.5.2026.08.18.05.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 05:21:06 -0700 (PDT)
Message-ID: <6a844e32.39f23b82.f1625.d3c8@mx.google.com>
Date: Tue, 18 Aug 2026 05:21:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0316277409541794153=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] avctp: Fix typo in comment which contradicts the conditional below
In-Reply-To: <20260818105827.600893-1-hadess@hadess.net>
References: <20260818105827.600893-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0316277409541794153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1147758

---Test result---

Test Summary:
CheckPatch                    PASS      0.30 seconds
GitLint                       PASS      0.20 seconds
BuildEll                      PASS      20.88 seconds
BluezMake                     PASS      628.01 seconds
MakeCheck                     PASS      3.27 seconds
MakeDistcheck                 PASS      165.31 seconds
CheckValgrind                 PASS      168.89 seconds
CheckSmatch                   PASS      333.63 seconds
bluezmakeextell               PASS      105.42 seconds
IncrementalBuild              PASS      629.40 seconds
ScanBuild                     PASS      1011.35 seconds



https://github.com/bluez/bluez/pull/2411

---
Regards,
Linux Bluetooth


--===============0316277409541794153==--
