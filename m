Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8692DECDF
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Mar 2026 08:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774774542; cv=none; b=ESpyy2ezfjKMewcYbHsy/tKIKtHCz6hIqG1oErTCrWx8JyyrgOvDSD8TLMIgiHNBH4zXlXb56zM84K14psObb1M3WmyOhLzEjeoMEU6am4yL7ewgP1o3Sx/V+ZaTR9MjrzqYc6qXKOLcCLi9AZ9xRVS/RfHibryVYi2GEoxB5mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774774542; c=relaxed/simple;
	bh=VAl6VrdUoMuZXLkAJxz/D4G5/DV0TefyYv2qp51UayA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rI3G4QPJ+PTGv4Zzl13w1id+/yS69ABHuncWZLmNAhIrWVnC2MyD7Ulhe6TiUrZpWVocM/74lROc0v0bXaJf9FtkOGJoWYaGFYDzwd8J0brC6GwlGnpcPTj3cpuCnSXC0r6kzIdBbRMVB9avfT78dxnEKgJlTBS9K7mB8bYpCmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=citrvYbM; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="citrvYbM"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d4be94eeacso3374746a34.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Mar 2026 01:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774774539; x=1775379339; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bsv9GjqD6ejaEK5lU2x2MXHbi344pKHqckQ7fSPzfkQ=;
        b=citrvYbMqwuPHO9Ab5JfSt569kPgVCKYjXVhaGgsRDosD7a/GFFhpgWyBvJGHiA5Ja
         K+ES7TebkqT7135rdGH/KoHDJB35MNA32LqwSnGRM1VuElF9qTAjs9HsEECodwDfmzVP
         feLxh6ZU4jLUG6k9kWWqUq92eBP7nIMg6TQpTJJkLb/296Zhg5Y5k0650c4mNh4rrdm6
         lMiMektcXtWrBULrCg7eFz9Eln1DxG5nHaxnq53E0osxrpXGRKuVF/+tuEJCUCT8oD8g
         4GFRywzhFwUA4fpJiQCHdQ23p8CXd32cl+WRbUPEY0fMUfBeiuk7uVgWf64gBs5WsaxI
         BNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774774539; x=1775379339;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsv9GjqD6ejaEK5lU2x2MXHbi344pKHqckQ7fSPzfkQ=;
        b=mUUI3T1mMjITYlj/TsN/0zV2NSguTFlb6LNVuOmsnxcKjcXih0emBCFz8BF3uNmbbY
         8IHkfjqkNMKYMKs5uwKvGoHpLyxe59QZIxotWeUyyb4IX08BlrdgMvRO7sqD/ioTu6Dt
         Rq66XHehA/22tEmghgm5muOUcyp/wA4k/qUktHpyW1ZYWbrFRjJJSnYbX1zhJJ7DF8mg
         IgkddtVXAXPS6lVNqJJfYgbw+syp7C0B+s80dPoaI1U4C9o7YyWJE77dkZ27iKf1sFfA
         W0uDr5PFe1oju0mJwzaoNgOhQsrXtEFZaFIjk2j3XrLcSvv9BmCd/Z1N3GTZiD1wX11K
         mArA==
X-Gm-Message-State: AOJu0YxwdhB1KwkQKr5+bW1Sh3p07RIXZVnw9XZ/AupMqFZhwQzgc3Mg
	uhboYE16V8i03PRZkyC78YU3r79uw2O7Ws/w6qu0Kvyuz90o+7bhobWIimVXIg==
X-Gm-Gg: ATEYQzwq3zIw3EyCDnNJtZe/86oHw3bYj4/SPvel9QmOZQjHTIliueCbWPhHJveJ54o
	ab9TqaPZG0wzCkbHkrPGg0nI85cKuMTs6iuSZYopGDtIKYTKtRETJ07McxWImyIvedGt9tCxiU0
	43zXeVLXfMp4gTLEP4zqAghFQTefHaziIgQ0G+B81ay1l/vek5aPidW4QsC2RBNFcu2oX8mviHM
	l6Wir0Mj++e31ntRo7hGcrGS28T41cu5v22PXZ1BQateBhLD/rKjUXqoIz2Tv6jgCEad8GODx2N
	llryFXAlX3khaLVzz91XnpYVC4DQhFHoy56avQzsAUA5UkenlO+dcPdZFHZF7U6pho3brB81gxg
	BRUO4Y587enNQOSzwAMRMBNdhQxaLLp/ITKfrBVHZP7Eg3Z3yrLmL1mxu7iCbFTLN1sO1rOB+25
	AFmc6B9C1or47j/M+fehpwDP8GA5Re7w==
X-Received: by 2002:a05:6830:25d5:b0:7d7:d510:4bf9 with SMTP id 46e09a7af769-7d9fad64b6cmr5634130a34.12.1774774538947;
        Sun, 29 Mar 2026 01:55:38 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.139.82])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a7b6567sm3410983a34.14.2026.03.29.01.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 01:55:38 -0700 (PDT)
Message-ID: <69c8e90a.050a0220.277b2f.e2e6@mx.google.com>
Date: Sun, 29 Mar 2026 01:55:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1755960039992162401=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.longros@gmail.com
Subject: RE: Bluetooth: btusb: add Realtek RTL8852CE device ID 0x0852
In-Reply-To: <20260329081324.123156-1-chris.longros@gmail.com>
References: <20260329081324.123156-1-chris.longros@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1755960039992162401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1074128

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      27.98 seconds
CheckAllWarning               PASS      28.57 seconds
CheckSparse                   PASS      27.42 seconds
BuildKernel32                 PASS      25.13 seconds
TestRunnerSetup               PASS      562.03 seconds
TestRunner_l2cap-tester       PASS      27.83 seconds
TestRunner_iso-tester         PASS      39.80 seconds
TestRunner_bnep-tester        PASS      6.33 seconds
TestRunner_mgmt-tester        FAIL      113.87 seconds
TestRunner_rfcomm-tester      PASS      9.29 seconds
TestRunner_sco-tester         FAIL      14.15 seconds
TestRunner_ioctl-tester       PASS      10.14 seconds
TestRunner_mesh-tester        FAIL      11.39 seconds
TestRunner_smp-tester         PASS      8.58 seconds
TestRunner_userchan-tester    PASS      6.71 seconds
IncrementalBuild              PENDING   0.91 seconds

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
Total: 494, Passed: 485 (98.2%), Failed: 5, Not Run: 4

Failed Test Cases
Adv. connectable & connected (central) - Success     Failed       0.130 seconds
Adv. non-connectable & connected (central) - Success Failed       0.122 seconds
Ext Adv. connectable & connected (central)           Failed       0.179 seconds
Ext Adv. non-connectable & connected (central)       Failed       0.173 seconds
Read Exp Feature - Success                           Failed       0.112 seconds
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
Mesh - Send cancel - 1                               Timed out    1.854 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1755960039992162401==--
