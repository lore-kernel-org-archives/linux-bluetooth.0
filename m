Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCA3435501
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533986; cv=none; b=sFED3T8GSFfnDnHqufmRVZQo2cZrlnKKyUoNIC4UuWvSMxogm+P944x0FBfTDoFE9nDhAVfwB6yWJ0AfF2ppN27XatcI2bexnMcH7Ngh60h6oVBBw2hN/uQW5S7dMAUVn0gx5i1SD2EJdhaq0pcecjXVt+O0WT/M2ytR0B8m8dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533986; c=relaxed/simple;
	bh=YIbvr0Lf8dOYjgZPKRwh/yNxDXCiFD59laQTFtyvrD8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=C0XRWJBRcnkMBBoWySjZqJ/ufHUcagHCeNuYd9D4GR+wyYqhu6Ajll0RL1gHrxRzfyT2Try48A81ofQbtx+OGnJhdRoiDigfgUjZPpFX1KV0RRFvaLv96hoBMsWm7pFQrtTM9ya05K9PI2zlf10TgW0aUzHJF1lnjizATIltFok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IT9p1CiF; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IT9p1CiF"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e65e18969so61436185a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 04:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786533981; x=1787138781; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LiHsxI42fx1Lf7SSL7DrY7dj4JsexXf4b9/US5wYxD8=;
        b=IT9p1CiFinHmmcDR4HOdP0AFh0cA7ezXN7j5SEditykd8m9aT/b5Ih7ckXeyPVWBIf
         0U5uZi8t78BImFoc4MijsfMjgp7LVDS9DmbvNzGp3KNHxIcd1+AJTcK9MSd6bsS87aml
         UDsIuBMMAi/csb6PYMRTEQKuSMKilzq6hSxG+5usqa5CQEDUh9DMX/vzhP7Tw9tpCrst
         4yK2PQgUbNS5Kr/3b5jHv+zP24wHxpoWLhVBDAC6HSy8QfbB+WkWjWW+i5A0llLX4wme
         v2kIfHFw1fDmwuSZWqt/EcpqLzMu91BvfZZcSqlWFPRDLy1nCLtUTCt7ufLmToOrGdtJ
         P8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786533981; x=1787138781;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LiHsxI42fx1Lf7SSL7DrY7dj4JsexXf4b9/US5wYxD8=;
        b=YEttD7QYX31aJMidH06vITEkaba5lT8spu/7SmKs1hyB2DY1KaWfZG5RcSaOnNqIg1
         TVCe/BBSLIrtmwQvCOP0DaJo1N8fyPkQaxExdQw7BaOyU9DLrENAQLcX0XrHYdJadxAn
         PckDkLGKsHQUCISy4u37FvXIjHI1z3Jd9OVb1V7CMSjB4EJ78rKqsuF0L1xv8CHm7OcH
         xkjH4FucBKcUWpC0uAs5pocBB68epsQYeiWQHYeXRzBpGBDJUckOuX00h+zFwwOyXARq
         v3LnGExu+aS6AZeqIBXpucWwVQtAMA+ZHBkSrcDcXxgRNgpSUiOdoz5eSFvnY0FIZ/Cn
         2qOA==
X-Gm-Message-State: AOJu0YyjxRU+w56eVY9jAf6JA0020ujQ6ugWtSSFwKB9ZL8yjvAwEAaE
	CC3A7KIV2nXAVyKdYVCBoSD2ZqwqpQHYJeie/kAAm/Awb7I13f4Gr2JJghoasQ==
X-Gm-Gg: AR+sD11+ycnFhk8cnv6/ODD9SjyorqYaKaGVihCV91MrHtkOn+fveWDTAPRBGcnRDWP
	JBaeYyi1uwkqj8NQSxFJ8MYIrKKze4FM0Gk4EE7xIyejgjDCAjSbZlk2ApV1a9o7hnnAB3MbBUd
	yhbOlDrdWsyQ4JlOlsmFwiZDxA0CB6CMt3HxRKbitwVT3DwH3U9C/XomvYt720kdlulFNgrzw4N
	xMgWfU6hsD4xauYct/jH7r95cPx94DnVPJnO0aSrnaErezNHjvK3deMO71L4yFb8lZd2AH5xZAq
	BwCs76t1eIsAbqz+J4TLrlA57qrw9Nlkq5vmwxWGx9ZDI7ThlGb0i+PujmInCEmYpB2Lb+vf9P/
	YjjDx50x58WFCT/MFrxUOhmqtPVdqWzpgNmkHWeKlffYLaFzEnWXrwPPqS03Q13r8yGS8bVHO57
	wH5wqX8f2FPr2g4TkpBDqDzO6x/PufjRHz+bOtEcUB+A4Tn2kSi+bEbpm0ELnFkZ6VZpom
X-Received: by 2002:a05:620a:3181:b0:936:ae3b:82f9 with SMTP id af79cd13be357-936b4f5b429mr253175885a.1.1786533980800;
        Wed, 12 Aug 2026 04:26:20 -0700 (PDT)
Received: from [172.17.0.2] ([52.188.198.100])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936b5f139d9sm105989085a.26.2026.08.12.04.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 04:26:20 -0700 (PDT)
Message-ID: <6a7c585c.5d490f9c.223e55.1170@mx.google.com>
Date: Wed, 12 Aug 2026 04:26:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8791297085871058524=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 2122295973@qq.com
Subject: RE: Bluetooth: ISO: fix use-after-free of listener socket in iso_conn_ready
In-Reply-To: <tencent_C2311DA54CF022D59E9418EF890569EB2B05@qq.com>
References: <tencent_C2311DA54CF022D59E9418EF890569EB2B05@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8791297085871058524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1144631

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
VerifyFixes                   PASS      0.15 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.42 seconds
CheckAllWarning               PASS      29.93 seconds
CheckSparse                   PASS      28.65 seconds
BuildKernel32                 PASS      26.13 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      496.76 seconds
TestRunner_iso-tester         PASS      75.42 seconds
IncrementalBuild              PASS      25.49 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: ISO: fix use-after-free of listener socket in iso_conn_ready

7: B3 Line contains hard tab characters (\t): "	parent = iso_get_sock(hdev, ...);"
8: B3 Line contains hard tab characters (\t): "	if (!parent)"
9: B3 Line contains hard tab characters (\t): "		return;"
11: B3 Line contains hard tab characters (\t): "	lock_sock(parent);"
12: B3 Line contains hard tab characters (\t): "	sk = iso_sock_alloc(sock_net(parent), NULL, BTPROTO_ISO, ...);"
13: B3 Line contains hard tab characters (\t): "	..."
14: B3 Line contains hard tab characters (\t): "	iso_chan_add(conn, sk, parent);"
15: B3 Line contains hard tab characters (\t): "	..."
16: B3 Line contains hard tab characters (\t): "	release_sock(parent);"
17: B3 Line contains hard tab characters (\t): "	sock_put(parent);"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/573

---
Regards,
Linux Bluetooth


--===============8791297085871058524==--
