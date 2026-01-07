Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469E829CE9
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 03:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767756950; cv=none; b=ICuyaH4KZsmyuEWX6Q3fchbdNoMDh/bWd2LBrqFEk9by2uQm9gKQEEEX+/cMYeY3X0wj/yflCNBb813tJh42ZAAwhtDgEDFTSq/qrX+GJ6zZWpFhviR9mTW1M5IJD1IECnYjZFT1ij0dJA7FsBJeKEodwf+Qk1OWu1FNA6iYaps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767756950; c=relaxed/simple;
	bh=kNAfGMcKM1HMz8nNrLdwXvZDWrZBIyZgu15ZTlC9Syw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BlHz3K6U+J+t/wOZPPwiHQaMqp0y8rABAIlHVkyQRce/YLFrVvKGLiuO5di3pIpubb2q1v4NcudTwpiPJzBzinch4yOQE9HffsBXyHCubwbLCAph8qCA0rqYD16x31rae7BmTCFCv0zcQpbnkq9yps7mOFuQaULdV8RyVl+6GQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjYIFlHA; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjYIFlHA"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-8888a1c50e8so20145296d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 19:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767756948; x=1768361748; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FIwsGLUv8RwX13ptE9SOtFXkBF/gsuxVLDJhY3bx380=;
        b=KjYIFlHA5qEJILNF0SbKiU1Oo3pr0xdbbyubtxWZxGN9Jgfdhvguv2SA7Xqq7XOu52
         37mapfpcqCpNwAGsGptlzs+gSq6G+VtruCIgHRww9Ct4DIR6nTOd5S599FSTg5g8L9Z9
         pNaxRqlq2RVkhxWmKhvEJ1PGHtH2abMZV6rk9zB4ZpbPTj7wBcnJA4KR+MUABOViowA+
         gt5XPyjHgaseucMe0h8uRoAixHmQQdVdrSpydNCrKHNYvYTSTsNW0AASjtZihSgfaCvd
         8hBLa+osvvXEeukXH+IZxJIljRRPGxl4N1txKEGSJ3EoIdFaTBWNOxupVZARVymuK/Hr
         aEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767756948; x=1768361748;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIwsGLUv8RwX13ptE9SOtFXkBF/gsuxVLDJhY3bx380=;
        b=RP/XX8AUc/rfeSaijyw2IsoXbCoGlKDnr7h0bl4Nsivm8pQANA8PQ8ma3oSS1DdXmN
         H6ieHNMakgkrRNcVO4Ap1jD2APkt5MHLL/mcP/8uoSnr2VRJM8Pu/Zdn1Y7qXkuw8pwP
         RVIKLlU5/s4VB73lDQa9FcAlnyQQaSoxrmHenqFCWmYVt8CMwzeldLGl6jDt4lGd8QS/
         FKEJXjjt+nedo45OeqkpfxjSYHe9OgwrMKi0GeqxIwramqm7jjWGutC3TZRFi3jbVJJe
         9p82NVGCAH8biyoZ8q7HxhNQ7kW/MUCoNxdWXjuC36ZfMDErIKSYZjqilPGgga+VH9/I
         CHIw==
X-Gm-Message-State: AOJu0YwxKeqZ/c3xVsau6upWHxwUBbZIFIyDSSpeRv8hrDcIhOrwlhMH
	JxLUEhrbTTGJjjk4SrSwoREwrapYnRNZmsVXFJobCYRvgBrNoejawB053awC8Ujq
X-Gm-Gg: AY/fxX4L/9kJCUw27Fla9Fga6B7yfZ861KHnTT0kHBQh62ALnwMis8bsQohGQUPS2y9
	FBQ14Dsf0HIPNJnc/SFXS8P+n92lK646XA2DGq/Itwa4yt0kFy4Xh3u9lhroRppV0PW7u0DsF/U
	v/xQxqsB+Uy39CLyNXXBnMixLFo3QWh0LJok+FSa8sR6vl2eVcxZM61QQQYaRL5O8+ZZqjMAqTq
	CIZHQNuooAXF8K8fbXRHVXg/Xmtisb1nPBMRJ8OJEZuucDTf4o2SVWEM44orSkwxCPnHiz1jdm6
	+UG13z6ZYmyaCLf2cl0DXVbKWMfZRntAcWsh5CXcnJu9LlwD7Cn6p7qOoQ8aEX2m7vWljk5NTaq
	9JveeflfHobAQOJGX8ZjTZbbRwsaIyA74rw6nAkbVit7GsMA4Mt7jAVFQ6x1nj4JOCzR2DvCB9f
	z+MjNpvWEZAVcl6aCx
X-Google-Smtp-Source: AGHT+IFVtk5TJQGu/0nuaPxte4BxibVAfBx8AS+OSKiNiAI5Lr48wEiBb+7teELEjx+NFWrW56K8Jw==
X-Received: by 2002:ad4:5ae5:0:b0:888:8140:d74b with SMTP id 6a1803df08f44-890841ae2eemr15089516d6.31.1767756947744;
        Tue, 06 Jan 2026 19:35:47 -0800 (PST)
Received: from [172.17.0.2] ([20.109.38.225])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770cc6edsm25865636d6.4.2026.01.06.19.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 19:35:47 -0800 (PST)
Message-ID: <695dd493.050a0220.1078ec.0647@mx.google.com>
Date: Tue, 06 Jan 2026 19:35:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2638282282590906512=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lilinmao@kylinos.cn
Subject: RE: Bluetooth: btusb: Reject autosuspend if HCI inquiry or LE scan is active
In-Reply-To: <20260107024820.1722270-1-lilinmao@kylinos.cn>
References: <20260107024820.1722270-1-lilinmao@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2638282282590906512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1039197

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      27.26 seconds
CheckAllWarning               PASS      29.26 seconds
CheckSparse                   PASS      33.84 seconds
BuildKernel32                 PASS      26.21 seconds
TestRunnerSetup               PASS      568.45 seconds
TestRunner_l2cap-tester       PASS      28.29 seconds
TestRunner_iso-tester         PASS      86.29 seconds
TestRunner_bnep-tester        PASS      6.44 seconds
TestRunner_mgmt-tester        FAIL      129.30 seconds
TestRunner_rfcomm-tester      PASS      9.64 seconds
TestRunner_sco-tester         FAIL      14.71 seconds
TestRunner_ioctl-tester       PASS      10.37 seconds
TestRunner_mesh-tester        FAIL      12.48 seconds
TestRunner_smp-tester         PASS      8.73 seconds
TestRunner_userchan-tester    PASS      6.77 seconds
IncrementalBuild              PENDING   1.04 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.113 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.575 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2638282282590906512==--
