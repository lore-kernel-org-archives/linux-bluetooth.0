Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1940D2AF1D
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555536; cv=none; b=kEdeimnl/brQ8dvnc8hKozSjgwlFV4kNyRloiOJtQ2cIEPVPK+ry3eVGVCzit7B3u0rgS6d85wNVUw39A+I8niROvDv9zV4+DmEwdtWBMkQA3xHMLeQLudrRx2eigYfMzMpcqZfKH1RgA/KLlQDsC0HwjVBT5uv0HghPopqsIJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555536; c=relaxed/simple;
	bh=SNCoOrLhN7F8Li2fDCuAeDNVMAzfQGCQN5KGIplBgjc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Dd4Yn5B1qIx2zv5bjvD8SnGm3sHklRSvuL2e9+jX7/l/CiSdpOt4x8GoP0IwsuBF+7zPhzcgHwHWFIVtwdw2ioD58D2UfpK/rZZGVAxr1qTEGPSnaN1WwMgC3uQWsFgFyT2/Jz+Ob7kiHcqWmK3UjNhysApMxHsCPKvbcdclcAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf387e78; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf387e78"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-917a707f37eso46386996d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 07:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791555530; x=1792160330; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nKtmAbx50Fjs/QFxlhJyjCi/GseeZ7pfGdtK/Xgpjbc=;
        b=Yf387e78pzqUeFT4hv9z6il6/iVzgEtGjGjPTWHwO2RSkKI2a9Ofd/oSk5rSE5A3CQ
         AauDags0x9FIl3aQKCp3zqr3yEfWwLXXtwOa8Tf6hJMxSxgAgOu4twN83bi2vYC1Re1F
         giUL55hYGj8DxNz6RY1bvP+HYnL2DlEwBdWl5DRy7d4j1DqTMEHlTZkCmb9lyWcE224u
         BX4RPvQrsQ5T2JYZaksMyYRU8bxlJSudIu8eD4eRSu1esfHgVpKrQUvY8hA3vIl/9GTH
         moddh6XSkv508Yvb39DjiXqBdj44S4YwOSY5LbVtUn5hxJaHNOjXTf01F8wULUWvUNxE
         /DJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791555530; x=1792160330;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nKtmAbx50Fjs/QFxlhJyjCi/GseeZ7pfGdtK/Xgpjbc=;
        b=ASpfFh4iyApX0vbLGVhIkoXhEl7rwWK2AcLb4ysB0GTakdca7bCdczfD0CcdW6gZTh
         yaRkoqDT4kXnhLcbfjmHwvNkL3J+mWznwuoRIO0bTYOCUHQmzaBhG3T1iLn48CqmxdzH
         iTiPaZ1DbnROm3DovvfgalEKzhJUN0PHZKn93bADIn07Qx4T4MjgHEzoZhYiwmB8AuRX
         m+qLcK6MD+Ch33bu6dcRJS0e14vwvaRUDMXQoAe1ANe5xvpwyr5oxVpPN03PAC6KcEya
         cvps8VOoJVw1RuXvKJT0DRLJKe7DnnsC82p+T0phTwESUKsSqL+Hm78taOwhfLWrNrFK
         CtIA==
X-Gm-Message-State: AFq9FYLXwblN16MgGnNfcmH0EE4eEUROEROMuIIUYQ14j8yzCa1JRUah
	0GOn9qK25qiH8CRMMg2sFpMDrIBYi4MCzhZFsKqPiKc5Lu0P59L/wKXbIVpDvQ==
X-Gm-Gg: AYBFou2aa+5G3khOBvVZuZ5a71MB8TW5WoriJWhKfz94/H1hOdWSATB8T8lW2Ou6UxU
	xmDkg1CbTw9wvSU+k8w7Ltfjf7ahIB+LUNUorT9nV5DYql/uYOU15ns9mvQpuH+s7WS5FfC0osv
	wgwuw6OuqUbPf7JRr6O9dmmUILFs4Rk2wGtoVxoXjv3aD23RKPyw8xTYg2Jz3IAoKqtOD6Q4T6e
	e/TbzaTrpN6wgL0EVp31qROfbUpLtJcgdzFCvMgAJj6Vdp+ZLjQNO7+bSNxjma20C/QePDljN8d
	GBqp1QszysiTXJkz/NlJe0ZD3yHeJ8Mtcmx74BYR3N2o61PiA3e5DoveErim8U8WRWfiLdzTrsY
	+eQzgXfj5czS2ycgjjpReUp6u7G1RAWIlhZZHvAb1j9bnOJpzLkrC0BRjyRDWcakcbxA9S5Hm72
	rTKrOnlJtaRoywk0IvQ6gXTtmENaTNKFYfwXwF1plOBCyEwgEia1Qi0C6AvuOke9p7nDNCgvjyB
	0Xf
X-Received: by 2002:a05:6214:2502:b0:915:e85d:882c with SMTP id 6a1803df08f44-91b550cd3b2mr36846116d6.0.1791555529626;
        Fri, 09 Oct 2026 07:18:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.62.207.9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b55092ca8sm19214716d6.37.2026.10.09.07.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 07:18:49 -0700 (PDT)
Message-ID: <6ac8f7c9.c2fc00b2.184e26.eb17@mx.google.com>
Date: Fri, 09 Oct 2026 07:18:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5303112273999792983=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, edumazet@kernel.org
Subject: RE: Bluetooth: btmtk: fix skb double free on ISO padding failure
In-Reply-To: <20261009083525.733804-1-edumazet@kernel.org>
References: <20261009083525.733804-1-edumazet@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5303112273999792983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1182204/

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       FAIL      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      29.62 seconds
CheckAllWarning               PASS      34.12 seconds
CheckSparse                   PASS      37.03 seconds
BuildKernel32                 PASS      29.84 seconds
CheckKernelLLVM               PASS      36.04 seconds
TestRunnerSetup               PASS      817.51 seconds
IncrementalBuild              PASS      29.71 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btmtk: fix skb double free on ISO padding failure

9: B3 Line contains hard tab characters (\t): "	err = hdev->send(hdev, skb);"
10: B3 Line contains hard tab characters (\t): "	if (err < 0) {"
11: B3 Line contains hard tab characters (\t): "		bt_dev_err(hdev, "sending frame failed (%d)", err);"
12: B3 Line contains hard tab characters (\t): "		kfree_skb(skb);"
13: B3 Line contains hard tab characters (\t): "		return err;"
14: B3 Line contains hard tab characters (\t): "	}"


https://github.com/bluez/bluetooth-next/pull/892

---
Regards,
Linux Bluetooth


--===============5303112273999792983==--
