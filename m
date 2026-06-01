Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BBC25B0AB
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 23:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780357635; cv=none; b=aQ90/QgzLYFiDvpGzLeu9l9DzlkTbUvr2c/DWFrKb9CxtcHWOLGw2HS+Je6MnSmrGh+FD7+zMLKYC6y1PNr1d2B3tvZHwZ/eAux8z4BkdoicNxLWYD0NOLI+DlWOBc7UrRKGyM40P8tV/kz2CP948RXwp71keZiUG+B17GbW3aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780357635; c=relaxed/simple;
	bh=Swbq2DZPqdbHqYgz5yg4HdX7mMu7hdjjQfH3rBKFYPI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EW8zHKmQpTKx/1dVCWKRraWQfpIHAMGWhOwRMDU/bdJCQnIfGP3RMfCyKFWY9Zpqfb0JJLQOgnQNjUTejgW2fnNDOyFeLZujOzkr13wobv/i0KkH8Bgl6xjkn4OJVfIFCDSZI+e+x5m6Urf9d/4W3VQFry36gGidbQ/VvmaoXDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7AK0t1R; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7AK0t1R"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-91541fa94aaso304389185a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 16:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780357633; x=1780962433; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yGNnTdKts3jRPDn/Ty3WLFdOA2eFmw6qd/WcTyu9h38=;
        b=i7AK0t1RB46gIu/y0oR8WZbvdmznaxDFv2VgaDRr5D6WrAaxSMr3u3VkgoeEEilChR
         3b8g8x4yMzo9q4aAjExauanXhYxrBvC3Voaxg4ytvhNC++dUGmNw0RNpX8Sj4CTbzl5/
         XWMekPcXt5DQMTEom45oktWBn7V3c5JxvC0l2I8iv7Iwhm0Ccjgy5uH66mBA8MuxhtOu
         i7LYWwW4tqdlmA+ItZ7/CeqJOzN37tYc1cMD+HgjgTUz8wh6u2gWkBbX3UCD7KQOKFdt
         xmBuyGmoXJKXRrPACZXK2g4uo2zyx24zSzjsCBVmJZ9L3Hk7zhH092Fkij1spuZBcXWG
         5h3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780357633; x=1780962433;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGNnTdKts3jRPDn/Ty3WLFdOA2eFmw6qd/WcTyu9h38=;
        b=a3txXUxkji38s/6j5f6KYCvh5I10JOcYmOpWOikD/nYGUXnocj6UJ3Nuj0zBKuNjDb
         orboZhJManldguzuo7MmYBy0yXLX+Ka/gAMUp0Ium002L3HBy338ou9lCLcahq96X7ZJ
         jbuJifX38GVcixTkqNIbJCRkS+TvWz8BuLpBwneq8BR3rvMqnUuRyRd1SkaQoR6YOUJv
         VYPF1FWA5M/rDgOhO5ibCBeSzWuSzt4eRRcj7dKemXLZeci9WS//YhacbT3N9yteiiIL
         FJcRNSa5TE3nJh1E5CGjOSYZ28pgVxvPZRox2YZ0qKRc1Dl3+UI0o7+MW35w9e5Ci0HM
         Xrtg==
X-Gm-Message-State: AOJu0YwpDuIPIULimaRhzIjsY/rMUuXrFa6ttE7JFQTk/1k8HR+iOKFZ
	2uHEv/JT2uSOuybxKJA1D8q4+4YcTafuJ50Hm0wd6ysbphi6zUdsFJzAGl4VSA==
X-Gm-Gg: Acq92OG+Qd5YTK/5nLRTqPb81l20NZHEIOdvuIoaq7KlJXPzF5z1tPhAiUBkQLzoeAo
	qyip3uBZEht5f43sLHS8vV0k30RP6jSpHkkAMYnxS8YJR5I+v1PJilubLQu5MCW8q6pB+Y5dW1e
	5I8+POE5Ie239IU1KiL9RcUHfTHAJGa+b01DWLrcNSZTzAkC/2LiyYTa9lQLN9J2NiI8DwMeiJP
	K00zrmzzAzvIo9SmcpcVcwl4fAmBgsy5QwGagnCGBPRRZYJEbH7SBgAJNS88fDHVtMdJ0mwIU7l
	Ni4ki7NfycRx6sXTmRRtTyGjF3pFZi5DL39NVnj9Z35KuZsIDuEOuw3qqzbfFGTBJABQzKtR1z5
	QvYYHF/f2Jd3dxCoIZaWwP7zyaugP3JgjVtgYUXHLRGBkL62NdH4KUlLSGzoipYbz2c+rbGVptA
	/gXFRYkzt3uwTBIjQzZtXjNaQbgIpebYYWguIuK9AtKt0=
X-Received: by 2002:a05:620a:3941:b0:915:79c8:ec94 with SMTP id af79cd13be357-91579c8f230mr176754585a.39.1780357632947;
        Mon, 01 Jun 2026 16:47:12 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.208.113])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153247515esm1135888485a.13.2026.06.01.16.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 16:47:12 -0700 (PDT)
Message-ID: <6a1e1a00.1396daac.39aa4f.5ec0@mx.google.com>
Date: Mon, 01 Jun 2026 16:47:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7404987849217812548=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] Bluetooth: ISO: Fix not releasing hdev reference on iso_conn_big_sync
In-Reply-To: <20260601204157.13923-1-luiz.dentz@gmail.com>
References: <20260601204157.13923-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7404987849217812548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1104231

---Test result---

Test Summary:
CheckPatch                    FAIL      1.31 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       FAIL      0.59 seconds
SubjectPrefix                 PASS      0.22 seconds
BuildKernel                   PASS      24.89 seconds
CheckAllWarning               PASS      27.42 seconds
CheckSparse                   PASS      26.41 seconds
BuildKernel32                 PASS      24.37 seconds
TestRunnerSetup               PASS      520.37 seconds
TestRunner_iso-tester         PASS      78.40 seconds
IncrementalBuild              PASS      26.38 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,1/2] Bluetooth: ISO: Fix not releasing hdev reference on iso_conn_big_sync
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#103: 
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

total: 0 errors, 1 warnings, 0 checks, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14605715.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,2/2] Bluetooth: ISO: Fix a use-after-free of the hci_conn pointer
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#112: 
During the unlocked window, could a concurrent close() destroy the connection

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#118: 
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

total: 0 errors, 2 warnings, 0 checks, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14605716.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,2/2] Bluetooth: ISO: Fix a use-after-free of the hci_conn pointer

7: B3 Line contains hard tab characters (\t): "	bis = iso_pi(sk)->conn->hcon;"
8: B3 Line contains hard tab characters (\t): "	/* Release the socket before lookups since that requires hci_dev_lock"
9: B3 Line contains hard tab characters (\t): "	 * which shall not be acquired while holding sock_lock for proper"
10: B3 Line contains hard tab characters (\t): "	 * ordering."
11: B3 Line contains hard tab characters (\t): "	 */"
12: B3 Line contains hard tab characters (\t): "	release_sock(sk);"
13: B3 Line contains hard tab characters (\t): "	hci_dev_lock(bis->hdev);"


https://github.com/bluez/bluetooth-next/pull/271

---
Regards,
Linux Bluetooth


--===============7404987849217812548==--
