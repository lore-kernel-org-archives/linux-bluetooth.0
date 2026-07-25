Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696382836F
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784984748; cv=none; b=oNjk+/p6NsUojaIhSVD9rEdUXPFd5J0aXv9KFshQJAZ3PAM2LC7ndCXq5OmcskAvMDdXMOZdU7HKOv/R32dKAg6NpV9SC1FiWAEro6sWFEwld5oO+eovi9qMj85wtqp6CsBUCU14GqKrJ/agYcorHEY2XorATqA/TLTfEP24MR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784984748; c=relaxed/simple;
	bh=vJQAK7yDNY60iq8Yl+mENSFAmmzSJNZVVqRkJWo9er8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gwprR2nCIE1xCwBnrKRedTRfi6/WpIjuHLILvp/LcTFy6o1NgE5MleI4RjO5H9no4ctwxPBtNlZ5RApA+3J7gRBD3TvQLL170dD9hwXDHfZI11S7OD9werDKddaw+7LN+Ofdhh5kZ6Ubt5gPzlisMAJW9T9UuCGy2RK/0AWKT7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQmL/In/; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQmL/In/"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c0ecfaee7so10274221cf.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 06:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784984746; x=1785589546; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WFzpekDsPRWNwC5pSG/jLBAzrrxkGXBJHWAcHK1m48o=;
        b=HQmL/In/jO66iRb49avIbShH1X6+UeoxnnR1zVveABBEkATqibEKp6oxciXNoDNx8+
         ml/wcDxqWQoUDAvAZXFP5hti7ljNQL5v7jCrZICyICjiij2KmRo5dS/l8F8uyNUQhOOh
         c4psNVQZtb026hhB8I7TN3L7f1WngahW4c3NMgOAt3CZwUuuU6Dx3xs3nonBZuHvLva4
         i8T7yZYd045PsilN/aQBW5noEnBelzuk8Bb6ZFTj1HY2unN0+HIvNuobNMvbDCanqg3D
         dj7SZNhQygayJFOByhfT/VYaCucsQvzuUbIplk6iJSvLyx64/jUOn44B24zGHEsJDtG6
         VTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784984746; x=1785589546;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WFzpekDsPRWNwC5pSG/jLBAzrrxkGXBJHWAcHK1m48o=;
        b=dMp9EunKV9xi6d/39wURCVykbPL1ZcdZNxZ19zp6IjdGUcmdo+r1Nq7Df5L0aSfFM2
         74V2FmNPZYvAmj7FdAvAEHLWffS/jNR6IrHScQW/hG38anNTXRpgzwkio2vSfD1zJRfi
         3eyg0u1dY4NO4CJeuKK0XqZv6bncMF5htOJ6l43sKELih0NiZ/cwNM9gwQlvbRYhqCON
         DIGhIUTH6eJJP3PLxS3vc5rl+wXMiNTF4jWXf4XY6SZCZ1xyXTaIxkmJnv4wzf627udT
         kap2FGrYv5hGQZlbxve7XvElbUUs+Wpylcc+JrARyeLJLZNXD53fjISP3NHhCD5lmOwD
         kvjQ==
X-Gm-Message-State: AOJu0YxIOFsRhmjXd2wIBKRykU+KaV8QalaI8Mx14AyzVDW+nDaL066f
	ME7QXoB3udgAGBf46um3OykmrDM5x7+ZsYlL/KrRUeX8VDVWj7szv6f8UmTKEQ==
X-Gm-Gg: AR+sD128w9F6gxp6JD/diLAUO+ydA8mGOi4fKSnwcPQRZsK40PE0+wYXPQb50TD4W+X
	qf3MG37tYLsV7VyIvOAhZH7/dMJ5+GgpZu85fnr9k4g2yVMnO/x0R+uF94PKWF8PtE2oX8ky5ok
	U6/eobgHbHxZoQZckgeO8xJvrigxVUUgaYsbfijZTgSjfMfHZixqUQdL2/whyb4AUmJOVPknKkI
	oMXoXWHWzfXS3EK7cZNqapTRW3OhGSZ+e89ZcC9QWMVpEfmapPlkeK8r/8L9sjkbOGGJmKuqOUj
	ZroFmHnZyI2pSpZJl8HfXmbmwHHWWccPV2+gE3oCmJ6tpIAoKV2a2IdbdJn90mOO7ENmOfWmUia
	l02ixexS6Zafyv33cld+iPkdPawf+XSZfwLtp9SgetES2a64dvIqKHWboq7icYmZElY/6nfsdAc
	ttDyRdTcialg==
X-Received: by 2002:a05:622a:1a8d:b0:51c:7b12:600a with SMTP id d75a77b69052e-529a87356a8mr21097911cf.86.1784984746191;
        Sat, 25 Jul 2026 06:05:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.103.114])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a2a4d545sm18719011cf.30.2026.07.25.06.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 06:05:45 -0700 (PDT)
Message-ID: <6a64b4a9.d69577ab.323a1f.e87a@mx.google.com>
Date: Sat, 25 Jul 2026 06:05:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0115083872373209259=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yaojiale02@163.com
Subject: RE: Bluetooth: ISO: fix UAF in iso_conn_ready
In-Reply-To: <20260725105127.434136-1-yaojiale02@163.com>
References: <20260725105127.434136-1-yaojiale02@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0115083872373209259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1134356

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.39 seconds
BuildKernel                   PASS      27.09 seconds
CheckAllWarning               PASS      30.08 seconds
CheckSparse                   PASS      28.59 seconds
BuildKernel32                 PASS      26.24 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      498.28 seconds
TestRunner_iso-tester         FAIL      88.01 seconds
IncrementalBuild              PASS      25.99 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 141, Passed: 134 (95.0%), Failed: 7, Not Run: 0

Failed Test Cases
ISO Disconnect - Success                             Timed out    2.049 seconds
ISO Reconnect - Success                              Timed out    1.995 seconds
ISO Reconnect Send and Receive #16 - Success         Timed out    1.994 seconds
ISO Reconnect AC 6(i) - Success                      Timed out    2.606 seconds
ISO Reconnect AC 6(ii) - Success                     Timed out    2.005 seconds
ISO Broadcaster Reconnect - Success                  Timed out    1.922 seconds
ISO Broadcaster Receiver Defer Reconnect - Success   Timed out    2.328 seconds


https://github.com/bluez/bluetooth-next/pull/495

---
Regards,
Linux Bluetooth


--===============0115083872373209259==--
