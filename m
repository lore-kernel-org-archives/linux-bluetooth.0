Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9141B1482F3
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179398; cv=none; b=nbRxAEZGpyIqhY7nxu8TzX8ZJBM6DtD1axTv49xXY3wXFlXJrWFjF0bp4RteVSRWXkgm6IT5z/CO8KajkHs0fv5ncsNmS6cw92H41Yl0FmCldq/7ML+Kc7P28Y8DFZ9NpCaf41vMBrgPzKgbs/6jsxcgSIWzppH3Qj3hvHfzgyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179398; c=relaxed/simple;
	bh=riMN+cbrD/mqU9EvHWHhYWsxbYk0tJV2YaPAqNhHgBo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jsQLthaT9p8DhmBVeyguOLadMoF9fmjplXUWCRjxqEaU68ZZaISXtSfTKM9zhKuSRYNClAx0GQnzWVbYpJXYhv0ucW3CbecYT0taJuXwBMvj0U/gE/A3lnAgIxAba2XZMRddMK6YlF78Qbry1pSbyuervmC04I5bEAh7XHlIhfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgYy3U4f; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgYy3U4f"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1faad2f1967so18684155ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jul 2024 04:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720179397; x=1720784197; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BlRfDEie0Yb4xdRVTeoRPZdVodoJ5OlLSIhHBtQXRQA=;
        b=mgYy3U4fYl9oEY/mlI7T7MkZXzBgbTotTtXTwoSKEeAnrxkuxZHSDWxAD4Er0WiZCo
         QYrJ+JQbg/iNgKDu5ETAEOakQOI4QvvS6J5D3gBPljqwps65ZH0Rr6mY9/nM3GqJbHoC
         oRR/xKb5ETjMipep6fqUx9xzS0LngQ4LrCE6/8Ig/h1GCsWm0XyFXtmk8CaS0ZiIvwrL
         UGd3ytpr2t4x0yFsgquW6cJ1I+B8Iw9mRoijiWO6Ac1A1lXCu6G9Sz+vIobv33QEhLyj
         EToqqRsItuuAoXjoa8J6YhRF1U6OXzceTpEch/DvWihhxgPNStzgh26e47w+5+tawKpG
         T01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720179397; x=1720784197;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlRfDEie0Yb4xdRVTeoRPZdVodoJ5OlLSIhHBtQXRQA=;
        b=xQvOFNFBFewyvUeA39CoUh4ZQhQH1J3TCj3Az1mjShUX3R+bifwk7mLr4eHqG3FaI9
         DK8bPufb256byxv4cHwELZoIWFYXAW6PSZ1J8Uv/xne69qHz0SbZtp385kEyeikVsVXF
         5cayXYNM1ag6p+ZDO9KCXGtTsRUMee79fLDXVq27uW14cH4pnF8LyFPWUm/qaNncfNYf
         GyamBBylUhBtxUl45lmWjT/SdG9ZchgWsEUMCwqMk8y7QenaQpzpNlcwGPgLrSokTQ3b
         rwPjGIrC+JLzo8T6T5kIKoiyv+hn330pu7CEKQJKa0qAbl2HPn4IE6XX1FbvostCf63x
         1l/w==
X-Gm-Message-State: AOJu0YyK+GHwVQNJnRs1Wh/qGlO0hVvJdX1L+AnLUc6gNymOYAY+sFR5
	99MKsHwbK9cSahlsetldU+l47PYQEE4XJg7qtzu7N9dMY57EWkfSGZ5THQ==
X-Google-Smtp-Source: AGHT+IHMyeDluwKk/KEOJUmJQD2EIb9Lo/xdh0cSt7kgOMfJMyBon1NRujt9TF6NyFgWYvP+dMstoA==
X-Received: by 2002:a17:902:d486:b0:1fb:4b87:6e88 with SMTP id d9443c01a7336-1fb4b877074mr21823805ad.29.1720179396556;
        Fri, 05 Jul 2024 04:36:36 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.100.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb24fbd598sm39821095ad.199.2024.07.05.04.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 04:36:36 -0700 (PDT)
Message-ID: <6687dac4.170a0220.4a916.d92a@mx.google.com>
Date: Fri, 05 Jul 2024 04:36:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8756257372777745351=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: fix error found by SVACE static analyzer #2
In-Reply-To: <20240705075709.26809-2-r.smirnov@omp.ru>
References: <20240705075709.26809-2-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8756257372777745351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=868674

---Test result---

Test Summary:
CheckPatch                    PASS      1.30 seconds
GitLint                       PASS      0.96 seconds
BuildEll                      PASS      24.63 seconds
BluezMake                     PASS      1738.36 seconds
MakeCheck                     PASS      13.42 seconds
MakeDistcheck                 PASS      178.63 seconds
CheckValgrind                 PASS      254.80 seconds
CheckSmatch                   WARNING   355.35 seconds
bluezmakeextell               PASS      120.21 seconds
IncrementalBuild              PASS      8162.11 seconds
ScanBuild                     WARNING   1011.55 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):tools/rctest.c:627:33: warning: non-ANSI function declaration of function 'automated_send_recv'
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
tools/rctest.c:747:9: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        if (!strncasecmp(optarg, "hci", 3))
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/rctest.c:759:9: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        if (!strncasecmp(optarg, "hci", 3))
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/rctest.c:766:14: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        channel = atoi(optarg);
                                  ^~~~~~~~~~~~
tools/rctest.c:770:9: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        if (!strcasecmp(optarg, "spp"))
                             ^~~~~~~~~~~~~~~~~~~~~~~~~
tools/rctest.c:795:13: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        linger = atoi(optarg);
                                 ^~~~~~~~~~~~
tools/rctest.c:799:18: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        defer_setup = atoi(optarg);
                                      ^~~~~~~~~~~~
tools/rctest.c:811:17: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        num_frames = atoi(optarg);
                                     ^~~~~~~~~~~~
tools/rctest.c:815:12: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        count = atoi(optarg);
                                ^~~~~~~~~~~~
tools/rctest.c:819:12: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        delay = atoi(optarg) * 1000;
                                ^~~~~~~~~~~~
tools/rctest.c:823:15: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        priority = atoi(optarg);
                                   ^~~~~~~~~~~~
10 warnings generated.



---
Regards,
Linux Bluetooth


--===============8756257372777745351==--
