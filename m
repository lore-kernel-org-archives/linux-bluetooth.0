Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166F41C5D72
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778935594; cv=none; b=Clj/rshwSZABXiLKbOFVnTJv5KtJgoMoRH1fbBuTWKhGz2F0lxXEAeq0ociV1HK50KJgVpd3y4qVLFigHHbBNvheBeKDl2rO8Fu+WK87y2cDvlPc2UMpMZgRq6xppsLF7b0u+zqAVHu6iqyOoF84j/0D5fx+uzCZpI2kPN+zYVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778935594; c=relaxed/simple;
	bh=XXNtbOzwX8jPh8hZC0cxPsNGYESsWdDdMvXV59/L57o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YT/844KaoVNoPfyjWMvPty/T2oAdrWbAQjGwWWzeDdg5LWML1pTaKqGrhdJoo+92yu91ZOC2PoZu2q8zspYYkudXGbA9zFZf3z1cMz1yZh6FClReSF2gHzhH2syBN+JPOAFDbJStpnE3JthLIzkmj7RLowXnf2cTqmf0+ebwmF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hegOR5H4; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hegOR5H4"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-902deb2412fso118059985a.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 05:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778935592; x=1779540392; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rt9z5rGH8AnZxQtJVRjpo96DtgZTjzPpP7Pr3K/glTw=;
        b=hegOR5H4uEtrZee2w/VUd1IeZTwk1obDE31EUgX5EjfDTPDL8tccYwojVWwr163sKu
         7ucxdWfSd0MQUmIoaUL6NeGYXZ3E0MdLRGFxCWVZVcjvQ2rFWUCGIV9/VJsSzSsF/KkI
         QR4d05WpKl8e/VoDji9T95QXVSeZ33URBbLyoLagjhSu74Tv7C+EZs+hIAxN2uyJUcdr
         h8nZLgQhXCcD9a+RTCc4rzsY0XZQUXZf32+U2Qav2jIe94ovVjwrFPvP6l+wV/ERCYkI
         VBgVG8+AetP18GuuCylUXh2NzZCPSSsApehpbd/dBwFlusm7y56HI8tes91xnNL5Z7sz
         6WXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778935592; x=1779540392;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rt9z5rGH8AnZxQtJVRjpo96DtgZTjzPpP7Pr3K/glTw=;
        b=WLCzp+15D7Uq6Co0AnDLb5+TOHcErmYJ7GImnXo0aP1ubo1KmLFhixYEJ4hT7EHCDq
         lgi1JQ0u3Fcer3lPoCIMT0CATeulj9Sm8UGkdvMomEjbHAVx3XuX76OhzBVlIgmFG5k4
         oBfUWkWmckQ5HBzdo36VO0gOJmzPdM17lZVhvtjEf0gNZmQBCB1UPNz4YAehnXS4l3uo
         qUJk4PgnAtLn3otg6bk3aBzUdgeLbV4iv1FmV1Yb1WdkUvRgXH4fSz1Zr69toNGKtBDt
         H9IuVJ7flqZ2tk2h91fqyLQzN6HufWGk1KpGjkqymxiRP/SffLEHv9M2DUR+hM5zKG2j
         T0Qw==
X-Gm-Message-State: AOJu0Yyz5R1XNu8BJd66f6bjq6eyUo5wetmi1Jm0tu6ztciWJBcxLKcU
	Yrf5GGAtKk8l5LgMOAXAwX1NYyXT4iGjxnY5aOILI8HZdZQ8CbZ4lPcA0ClNBQ==
X-Gm-Gg: Acq92OHoo4lRmJg0n8JgZY3DSFcHjRGZSTTen7RvgOKcKLMiVfyNO+4Pbin1MyUHj+c
	fExiU0RwY/60cv2/JtwKa1s6L8zNBQueCVKlNrHzAh5E33yocPYBXV6cVn4O65M/cyKTWJM3BnU
	W9nY5aOkWybWH6MUJIM3lgalj6S1Q7oIU/ji/GGif7PzgWUJGUD1Xb/NHV5urz0W6Una7K1pCzo
	hEbHCvZz/8ZRKsEowwkvwyYmYW6WXdLPNQXb9O/Dyc+7Gnjd9YplJ5/51SfGRcMyG3BAvI0ZzDt
	cRGdI1Is/naGF0asRk5plgh70bFixMpHP6WrJSVIWHENECwJ8wq1ld1fjrYd3ZYAqS07v/laawZ
	bdywcFzxP84sAjUZ8GBl1bUTiJKbihZWB6oPr4u+LCrpOitGlC1mx2NakG/EV2x5YXM3eHtijgI
	2WAzzKiBgqOhzf8NqIDK/CtFnAbGtTh3w/RnHMlWLUXJTWFiMLxl8=
X-Received: by 2002:a05:620a:4089:b0:8cd:8efb:b7d9 with SMTP id af79cd13be357-911ce71dca0mr1237374685a.28.1778935591692;
        Sat, 16 May 2026 05:46:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.213.115])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83b18dsm847821485a.31.2026.05.16.05.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 05:46:31 -0700 (PDT)
Message-ID: <6a086727.f3350d4a.330d6d.8493@mx.google.com>
Date: Sat, 16 May 2026 05:46:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6729091927804069293=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: enable context analysis
In-Reply-To: <342a530a1756cfd136542a33e5d947fd6c0a85d2.1778930064.git.pav@iki.fi>
References: <342a530a1756cfd136542a33e5d947fd6c0a85d2.1778930064.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6729091927804069293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1095802

---Test result---

Test Summary:
CheckPatch                    PASS      3.56 seconds
GitLint                       FAIL      1.79 seconds
SubjectPrefix                 PASS      0.59 seconds
BuildKernel                   PASS      26.34 seconds
CheckAllWarning               PASS      29.76 seconds
CheckSparse                   PASS      30.21 seconds
BuildKernel32                 PASS      28.37 seconds
TestRunnerSetup               PASS      552.61 seconds
TestRunner_l2cap-tester       PASS      379.41 seconds
TestRunner_iso-tester         PASS      591.09 seconds
TestRunner_bnep-tester        PASS      18.71 seconds
TestRunner_mgmt-tester        PASS      2023.25 seconds
TestRunner_rfcomm-tester      PASS      63.64 seconds
TestRunner_sco-tester         PASS      141.94 seconds
TestRunner_ioctl-tester       PASS      133.61 seconds
TestRunner_mesh-tester        PASS      60.34 seconds
TestRunner_smp-tester         PASS      18.18 seconds
TestRunner_userchan-tester    PASS      19.47 seconds
TestRunner_6lowpan-tester     PASS      51.14 seconds
IncrementalBuild              PASS      32.11 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RFC,3/5] Bluetooth: ISO: lock same hdev as what is released

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
11: B1 Line exceeds max length (87>80): "net/bluetooth/iso.c:1095:2: warning: releasing mutex 'iso_conn_get_hdev(sk->conn).lock'"


https://github.com/bluez/bluetooth-next/pull/202

---
Regards,
Linux Bluetooth


--===============6729091927804069293==--
