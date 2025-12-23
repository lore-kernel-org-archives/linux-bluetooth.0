Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2961D34BA44
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 10:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766486390; cv=none; b=aHr0n1ZATniEnhe7O3fsn2mOKR0dalLx9QgefumVAJuGax0ZMpZhAfaSFnTsXZvLAfMfkjSMWJzPI4wnSmP4loXEEsNvsP+QGSRyET7NfeB13fPzgNrenSeFHu2QZBjPaBpKp0VTG2ml5QCMA7KhBcZOssBgwTe4bu6wkBW0PwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766486390; c=relaxed/simple;
	bh=3zW6l2yiymPbYgEJXdHPeuMO2/tUQQK0KMfEPmuu2Yk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YZAGRapUF9aK25AhWdpjV/vrt/1O2kqYy04615+hDqMp32NK+wjjK7e0pqmalcyTvBQa0cWiMOOEz2orp868YBHtTeGGRAn/KjXOjDD87XkBuiZJI4ESEGQaTiAQhhqUP3I0GmaXtfdN9j5o+rgpMPplHnLiJ+cj7sAU4nvquEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HizLiAhn; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HizLiAhn"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-88a3bba9fd4so52642716d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 02:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766486388; x=1767091188; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EysKTIH7M49frlBF/lqESWjqlH5CBwqVvWzmjnWtOwU=;
        b=HizLiAhnb9j/sq4wfhc/gHFRu37GIvBJ3+NW4rLPGy61u7OIQcW02mKBdctyLuZkwx
         hm75Nmkww2728UvVUKItCfuX/XygY9MCmTDnWc0pYVeIqD4gZt/1uD8y7XGI7svt+PFd
         aDts3YTo1MXel746/rqVcyIpRocA3uR8lYfryIkPVHRya2AGlyBDhH8cvYqJXFymAJ4D
         /C9PTbOPbV63VAJaeRx/gCcE9g/+ZB/Y7lByuL2ro2vJ+zP3JQB0D7zcF6zEzwWquGKy
         zlI6ovkz9fg5mPO0PAsEyakhX8rg77SBedAtlNTPE4T8VXb3XQgA5fs1+WxRFoHGUf37
         Mv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766486388; x=1767091188;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EysKTIH7M49frlBF/lqESWjqlH5CBwqVvWzmjnWtOwU=;
        b=hKog/b+XdXJwQpJAV3KlXo+9T/tT+g+9mNVzSIruYWLFzWCaqZJdmzFB+6yb63vvcO
         neB8RXcsMNvy0+06nkstBcEjD33j3IflwhpsLNEX5y/BlRRctG6zNKb/rr5kgc/peLQt
         PD8ZpY3ZODb+ptoLpQXKFTHzcZGBFXnNhNB0SwRgy8GZ9qqVoL84J6NE0L23enW5sRIU
         7D+XcPctll0jEl3xGRx+V4Jbye13TukyVzuKCF0HTvxpvhQD8NGomBB8QUP4GsM72JMw
         +Gh3ZFT5IH7BKHZYAcD/bITqaVrKs+M0PelrmUQXC0ghO22gGZQnh+v5UNCmIl4D8p/U
         8wIw==
X-Gm-Message-State: AOJu0YxjoDFOjL1d8VNIiFlAxfQlzYHYimAxwZpnZXWkdhadFU+EgVDw
	YxeI2oV0IAk8rioPkhBDZvHgOl6mEETFmYnW+3W1wGSCsiudSAxl8CF22ZdbzgBfupU=
X-Gm-Gg: AY/fxX4tbpkLtP3h9ANb/Kil/8WsTnLprHKjSgdM7t/5rmZThu2J42j/RkwGbIW+500
	BR9vTsIbBQpefp4rUehMGqihq8Yf0v3N8WwGxobvUmt9fY4jc8FX+R8LgHnLzUzE/aeod38mCAZ
	Dzg+4KBqoPIlgYVF84ipLYwtmw52eF9Y8GDIn+UX3YRWarfC+3MEhWL/rNT93kQ0ySzbrt+p/wL
	G8kNiif14Z0O3f+Ft/CD0UlPCKqc52gZp2ldVUtSo2Hja6pEKvkQe9u75ge2X1ywGn14zFiQK2B
	MIkXMo5D1qDXyo3jWDBtaM7VukxJY0BqYwhClRWwsWSmfK8KHAC1a8dYNqyx2Zx/gXnfctPW9v9
	oxfh8GZqq8orf6px0kfgMlW7SO7PDiMhxVZrvoZsitlAz3PjCf8xC+zjDNdECxus9njET/YxvVB
	KWoruGMg89sVOkub1/
X-Google-Smtp-Source: AGHT+IHWOj1FrG96stR2qC2XbpNCyc7HUnHCM6iq7N/kpkfe48rgDQiWeg6XN2+uEZu/78GBCGKu3g==
X-Received: by 2002:a05:6214:88a:b0:888:80ae:48cc with SMTP id 6a1803df08f44-88d82817e19mr158000356d6.26.1766486387845;
        Tue, 23 Dec 2025 02:39:47 -0800 (PST)
Received: from [172.17.0.2] ([40.116.73.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9a544ba9sm101814126d6.50.2025.12.23.02.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 02:39:47 -0800 (PST)
Message-ID: <694a7173.0c0a0220.3b7bd9.6c35@mx.google.com>
Date: Tue, 23 Dec 2025 02:39:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4832543577106390073=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, f-tornack@t-online.de
Subject: RE: [v2] Bluetooth: btusb: Add support for Quectel NCM865
In-Reply-To: <20251223094535.91725-1-f-tornack@t-online.de>
References: <20251223094535.91725-1-f-tornack@t-online.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4832543577106390073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1035981

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      26.03 seconds
CheckAllWarning               PASS      28.60 seconds
CheckSparse                   PASS      31.60 seconds
BuildKernel32                 PASS      26.00 seconds
TestRunnerSetup               PASS      563.07 seconds
TestRunner_l2cap-tester       PASS      28.15 seconds
TestRunner_iso-tester         FAIL      48.06 seconds
TestRunner_bnep-tester        PASS      6.30 seconds
TestRunner_mgmt-tester        FAIL      124.15 seconds
TestRunner_rfcomm-tester      PASS      9.39 seconds
TestRunner_sco-tester         FAIL      14.39 seconds
TestRunner_ioctl-tester       PASS      10.19 seconds
TestRunner_mesh-tester        FAIL      11.44 seconds
TestRunner_smp-tester         PASS      8.69 seconds
TestRunner_userchan-tester    PASS      6.66 seconds
IncrementalBuild              PENDING   0.75 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.108 seconds
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
Mesh - Send cancel - 1                               Timed out    1.871 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4832543577106390073==--
