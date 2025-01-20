Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BF019AA58
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jan 2025 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737363607; cv=none; b=CnoAXwQcqKDvzRBi5siskxt6etci9rbVDwIoNnoGxXHeRhNryQbA7gONGCczxOc7+33i/qiEsdc7yI8c9FSj+cSTEVi91MPKhq0mS9u2s7qctEmEh5jROSQmNO09rZQ+dxEmdhmpPUGab7hF0WsgqGf8Q4H6ncP/JDJeppaNsAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737363607; c=relaxed/simple;
	bh=ryrIhLEhZVdq9yT3h1xm7saC82NGQV8gcti5ObnWDLc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jv2f1acT8Je2DzFhgTw28BBEWl4au7kBEw7fM0MjLqdRM6X/LegZ6PJXjDcP6gYPSi9GQzV04PRfFbwrnEOvRm9Z7DfUfNT0uazc04GhC/bMoMhXfhZ4hcQ+jNe95R3sLJ4HCUseHbmqIKAzKJz8s34/U+LSrgKpxwKGA/S00gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdSisLeh; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdSisLeh"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d92e457230so42492546d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jan 2025 01:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737363605; x=1737968405; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ud0h5JoEyMfjyDtEqsmd/Fyw0EFsBlkc3z74eYijNk8=;
        b=bdSisLehUhbXQKBfro/28Zn9M0uva6f2xY/K/MyM7Ub97Gjv2a+/hpHjqONeFCie1E
         dHfzPH7J/uy0EWhy61PTc51cXSybc/bxBKMkQkhTsnkT/bIJVAHUkFJXyxXEKhlDQblQ
         IGPSvK34sOAtbyXcuov7KWHDL4N6wD71Dmei7omYsOr0ZDQ0EXAIE1vLk3brRPlAfYjv
         la1z3rEWVfcguDmCPfWpQkwCe4FS8RjqnTS/IyspLHcI0QiOchJ8phMVeVTcwzvpTIKk
         h6wNhHAg9X22CUZGm2gBVuT5SNmJHEk2MCTmkVihmJxo+nols/Cn1JCg7ErVv/z+dj2i
         tajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737363605; x=1737968405;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ud0h5JoEyMfjyDtEqsmd/Fyw0EFsBlkc3z74eYijNk8=;
        b=WAu4Nwm7eWNLPRupd937GYEjJPqQZIfOEwncVpU12P/xsAQyDwH9XG8aIF/KXLZ45G
         mVEf4fu94uJokm5gYitC3q6JlVT34YhwkjSRvD5sROLFUhiwKO4eMpQeITHLdpDJd44P
         JzbK7aZsVmVXiGOvphhSwSnDxG7dDQyzfSe5GPogo2W6FaSEpr7dJLV4pNEW7WOJy/pT
         /j+Plek42jrzOZZRo/WE9FU4VqXp9aDhuD2eI70wpJfdyEDsYtf8Q9e6AGLAB0laFYfS
         B7S4YPrtuJplq3UiySJ8lfCqNxBWgxTF3oE+bqq/cnm02BPP0xkB8buipJfx0JkvQKxe
         f0gA==
X-Gm-Message-State: AOJu0YxDvjMV9dDfziPe1gA7azh5e/VWHPE/L0S8nx/mbAaJFwJcPIWn
	rvPX7t0NWcPibSchYsUp6lkaa0e390aaTxu5POjXGtv515zbyQwT8bRx8A==
X-Gm-Gg: ASbGncvNsWM1XFIQOkK8Kf7Tu++NPUrW3HZYZnbEI22EGmt0tRTL+qvT63PuAcvv6E+
	vxMYF3k0yfypaKNMHWrQS+soWZ/xMvDhqrbrpCEInpFo7AUlOtDCJs290ea6OwwLZqott/UHRS1
	Me4auNopzaoxr8bFQ3A44yWJAycmcxxh7jNHHXgQ2mz6fg2mCIeOufFlHsZaneCr3UtCRqQBPqT
	PAuQxl4cB7qfgMwulGugMMEWbjw2w1aRewvVddb/IFbHHvYi0GGN63zQLKILilVAdcxJrHfy1U=
X-Google-Smtp-Source: AGHT+IGuCPL5VYcfVN+jvmYbSyiYTy1aGK+LExoNNKD3rst/91u6qfDtOFQN9v1spdgUQDKKMvW/Ag==
X-Received: by 2002:a05:6214:3d0a:b0:6d8:9124:8799 with SMTP id 6a1803df08f44-6e1b2134485mr191972946d6.5.1737363604814;
        Mon, 20 Jan 2025 01:00:04 -0800 (PST)
Received: from [172.17.0.2] ([20.42.50.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1bf056fb8sm25007116d6.34.2025.01.20.01.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 01:00:04 -0800 (PST)
Message-ID: <678e1094.0c0a0220.98f3f.6eab@mx.google.com>
Date: Mon, 20 Jan 2025 01:00:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4548384039187672371=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chharry@google.com
Subject: RE: Bluetooth: Add ABI doc for sysfs reset
In-Reply-To: <20250120162456.1.I2524c9a7d322be04b38b29bde3d7d1e578229cca@changeid>
References: <20250120162456.1.I2524c9a7d322be04b38b29bde3d7d1e578229cca@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4548384039187672371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=926859

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.39 seconds
CheckAllWarning               PASS      26.45 seconds
CheckSparse                   PASS      30.28 seconds
BuildKernel32                 PASS      23.90 seconds
TestRunnerSetup               PASS      429.76 seconds
TestRunner_l2cap-tester       PASS      22.56 seconds
TestRunner_iso-tester         PASS      30.42 seconds
TestRunner_bnep-tester        PASS      5.16 seconds
TestRunner_mgmt-tester        FAIL      121.67 seconds
TestRunner_rfcomm-tester      PASS      7.59 seconds
TestRunner_sco-tester         PASS      9.36 seconds
TestRunner_ioctl-tester       PASS      8.06 seconds
TestRunner_mesh-tester        PASS      6.12 seconds
TestRunner_smp-tester         PASS      7.02 seconds
TestRunner_userchan-tester    PASS      5.12 seconds
IncrementalBuild              PENDING   0.82 seconds

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
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.161 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4548384039187672371==--
