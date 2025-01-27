Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5E31FF1A5
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737977409; cv=none; b=gqJwuADw247mf68oRje6LbJenUfFxbcREPlqwTOs4nygKyKdBHe7h2K3uKqI07vB5sVOwnnJMGIMx3OH4yWV8rOy+N7345n0hmR0hNmLRXWN8mq/xjtFvOlLqcsFkNGC5d1wNPqBQa18o8lEVuUdp9mGlNHe5l5vgTZguLFXzwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737977409; c=relaxed/simple;
	bh=3do1wMg3p8XuzYcXUfBWwnqjCQB0+9uJAcMgA7XrEAs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QeatRFGzxiLuplRn76cVWp7Cg8jI9zYFXzLFKqB/HqoKB+x5cAAXDj9DQI8tniiL6SecM+sXTlrhE7z+ZvhvcOSMOZqC2TmvIhYXfsOspnF0oSlSfBNZBf5ROrzAnc5x9Qea4wIW9bqWNymBEQfH+TB5vnnpb8x0KmRpDiqMGzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONQqQ9WX; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONQqQ9WX"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d8ece4937fso39403326d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 03:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737977406; x=1738582206; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rzdYj3TA+EVUb3xfNG/n9L9u8KL2+A3gzGmF5UuqPDk=;
        b=ONQqQ9WXUgZ9RQl01VqwvcFvIL+4XSGR98Kfb+EKtKzSJJDQw9tyRa5jhD78jIx8lS
         ky8vfl/A/vD9hvIpnb5BJ2c9JL6jZvJvRkNNS+P1JUWKVrYoHZN0Trf/QOMQo3u4/9m3
         Pw265Gm/5abpinXmxKsYpMJDOJ1EPATWsAZODUfffVPgbiqDRxE6Sb91n4OMAm1CENjT
         tzCA5DNUfsw0ljW9W2+JknxflvWNf/xb5F9RJyXuO8slED/02J1FMIUAT2Xz3MFEU3Oo
         TnBdIBdZU2+yo49qr/Xsa1edxNhTs0MJ8bFQ9GJse/dKOTv6f/vlfThGNT2mLgu73+wM
         o+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737977406; x=1738582206;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzdYj3TA+EVUb3xfNG/n9L9u8KL2+A3gzGmF5UuqPDk=;
        b=OnbcL+NdKBwiZEfJSyb/StxkDNp5pu3p5zOO9NyG9ZL2DILJpcw0Gq8j0L++3NRAfN
         S0iF2UUXJ4J3fBpvZYibz52FdUtCtPv/B6CWm++V8tc7xCoBJgiX6YgAQ+gFj/9+cMVQ
         ra5oHbF2lIBet+1QM2EScVWNiRdURPxr/9/yQ5ehRxLPtAEYZw1QarilgwekWNmqMaVU
         EthdTaWeExmgVYHym5AWdqj+lk3Njl9a4nCxagKzqJi7JlWGQlXEvcO3KiDoGmh2F1M5
         89X82/VBFhpo3aU0MoE4sa3R2+8jQswqXoSLjavLQu7OxisH+nat1sqLOqf4pSf7Zb0z
         ksqw==
X-Gm-Message-State: AOJu0YwwaDqBw8p+jteMOLzPDI3UUcL0ZVyLRlwy+QjbI7VQj9lOmcLw
	gz53/pXikNWWbIc+CqekVw0DsKKKRyXBdj8I98Wu1rACbkEVNL6vPtO7Aw==
X-Gm-Gg: ASbGncs7LPZb8XEoAJUba55RbKJ+kiXnbydTscd4wN6cUKxBxYGKx9kkzviankh3rt2
	bcR97nAlHjffJxkVWmaKMVhVDpL0JcjSPeHpIzeYMLf2ggMGdaDJEFnNI9Ei9k0F0LIzEWDFAJA
	HkgSfNg3wnO1e3qcAMCintNwecMZT/hIGhYK8nGPFmBOgFP+2Ega6hFaD7DgShYvxWyghk+LSLs
	fTHwAoWWgeUlM++QLbJJ5ZcpXDv01MSVI0OPwxpTtV93DTuGlVlnXi0DUVufVpxId0rHDUPFDuL
	dAs+wUZWV3arW/fqRhkMyg==
X-Google-Smtp-Source: AGHT+IGsh5XG815FjlPr7LDbXEu6W3FK4Buzudg1FK6QjyBW7F2ZI0HxE+aPhTVWGx0uL5s4KDQ1sg==
X-Received: by 2002:a05:6214:2aa7:b0:6d8:7ed4:336a with SMTP id 6a1803df08f44-6e1b224c1a1mr695337336d6.31.1737977406194;
        Mon, 27 Jan 2025 03:30:06 -0800 (PST)
Received: from [172.17.0.2] ([20.161.77.187])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e20525ac6fsm33580226d6.50.2025.01.27.03.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 03:30:05 -0800 (PST)
Message-ID: <67976e3d.050a0220.3ad924.c82a@mx.google.com>
Date: Mon, 27 Jan 2025 03:30:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3939945945256319509=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel: Add DSBR support for ScP
In-Reply-To: <20250127112328.48145-1-kiran.k@intel.com>
References: <20250127112328.48145-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3939945945256319509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928519

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      23.96 seconds
CheckAllWarning               PASS      26.58 seconds
CheckSparse                   PASS      30.02 seconds
BuildKernel32                 PASS      23.92 seconds
TestRunnerSetup               PASS      431.94 seconds
TestRunner_l2cap-tester       PASS      20.60 seconds
TestRunner_iso-tester         PASS      29.71 seconds
TestRunner_bnep-tester        PASS      4.84 seconds
TestRunner_mgmt-tester        FAIL      119.91 seconds
TestRunner_rfcomm-tester      PASS      12.92 seconds
TestRunner_sco-tester         PASS      9.54 seconds
TestRunner_ioctl-tester       PASS      8.20 seconds
TestRunner_mesh-tester        PASS      6.13 seconds
TestRunner_smp-tester         PASS      7.10 seconds
TestRunner_userchan-tester    PASS      5.23 seconds
IncrementalBuild              PENDING   0.45 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.198 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3939945945256319509==--
