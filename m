Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE0518635
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 05:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715837615; cv=none; b=POgRMZ7xaptaVSIjk3gL+oUqNvH9FsKIQ0ozw7i+DwVE7iuEfA9l/LtpDjDRs8W5Q1TFgnE9tGN1Dx5sQcjFkgDK+MaGAnmdp+DQkjz7JVG0AazXpEz0KvQCdHNO/iVLsZUEECywrf1ZlIHukfTnvTiLtkddi/hALu0tSyGgcNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715837615; c=relaxed/simple;
	bh=O7bo2rd62OzjUcQcF6wGVHrckWBruMZ2f8uOW4Q4j/0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=shZdJ2eubVoCeO45X/mexWG+Psi8en/u7UWg9W4kLoWnTW3YU0RNTp1pDzuNbYaQKVwrTjKS3cmfO8wDZI7ojWkcKb2ib1szeRo4/JC0YdsC88wMb9KJIWuL4czCavAikNd/T/9RgbWWYGvQPycWyWUEBkqfnLp/X3SgYI2213s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amKWsZK2; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amKWsZK2"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6a04bae513cso27986786d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 22:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715837612; x=1716442412; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uHPjbVmS18vC3rd9C/zLu1TZX68moMG1e9TXuWV3orA=;
        b=amKWsZK2rXm7ZYo4NhZD87KXuWkYqqctsnTm8yOgAvo20tJo/8lcU8FjYVxMi59kNj
         ZccqKZNYX8VNfbwZod6dvSryeZo3MwY05JVF3GvZEagL1dxfJYLKD1kQnM3uU75SBGLM
         2xIcQTdJIARXkQpJxoDrOZXd+JE4FmYXH8lE7LXeCrjQ1aNoAQxMurUWC73CqywgksS1
         sLfiuvOcVG6wFTbzTk5F4r7q1z9PQg7nDT69S21wWiLHq5P9u/rBvwv8imh7vFUfHPG8
         aZhLY/qKq90x37CHykcHh5KVUJPaxT0b7RLYkb4Uc8IZDIUdRgfuYErIhK/+saKjOoIJ
         4M4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715837612; x=1716442412;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uHPjbVmS18vC3rd9C/zLu1TZX68moMG1e9TXuWV3orA=;
        b=dLP9l1HKW3dg9VgLo6EWs3dbp1l39WvQHZuqXMXQcgRJVlXsMYralEycgJoR1UnJdT
         dTiHAUTAOCf/bVZSlxd/KMccPhJeGj/22knXxIitfkiIR2QmCqhVvCtZCSi7+r3LZD0R
         ZVEKsX12jGJP9PBP1lNLIx9SbxErTmvav9AWfrx8i2uGwi8kflhJ6mwUj2BQsM1HVAL6
         9nSk5rLp7/k4St7e/CAPB0p7Mx/KZsTO+iMnMmp+t80pdRUk2SzyLGNcbYOtLNQFqF2F
         DfcPohA6ekT437jRshHCfAvvVQcn3Rohn+ld9APcTqBcAjC2D5fUiw5ll19VUTQYveRK
         wTdw==
X-Gm-Message-State: AOJu0Yw2TlWyoZIPCQKOBbwyCNxERgcb3fZiRdwaNy2HNPmHAFdQJnu7
	dHiRh6dIcdmsFvQ5oGnKdNo6+to0LNQocYd1AFz/Ut7PBa+FgMopx2EGPQ==
X-Google-Smtp-Source: AGHT+IEuqYn3HWj7ybJUVSX0NiGo/x8DozwRq4XOd72vMRKNj3YlH7drOpG0A/J6a4oBKNWydGB1iQ==
X-Received: by 2002:a05:6214:43c4:b0:6a0:5ad6:54f4 with SMTP id 6a1803df08f44-6a1681b9879mr201454446d6.33.1715837612317;
        Wed, 15 May 2024 22:33:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.75.95.97])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f194945sm71223746d6.61.2024.05.15.22.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 22:33:32 -0700 (PDT)
Message-ID: <66459aac.0c0a0220.27bb8.84a1@mx.google.com>
Date: Wed, 15 May 2024 22:33:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2483978029752640205=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oneukum@suse.com
Subject: RE: bluetooth: btintel_pcie: nonsense error recording in irq
In-Reply-To: <20240516045118.18552-1-oneukum@suse.com>
References: <20240516045118.18552-1-oneukum@suse.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2483978029752640205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853575

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 FAIL      0.47 seconds
BuildKernel                   PASS      30.54 seconds
CheckAllWarning               PASS      33.41 seconds
CheckSparse                   PASS      38.03 seconds
CheckSmatch                   FAIL      35.28 seconds
BuildKernel32                 PASS      28.82 seconds
TestRunnerSetup               PASS      519.42 seconds
TestRunner_l2cap-tester       PASS      20.24 seconds
TestRunner_iso-tester         PASS      30.48 seconds
TestRunner_bnep-tester        PASS      4.70 seconds
TestRunner_mgmt-tester        PASS      110.01 seconds
TestRunner_rfcomm-tester      PASS      7.22 seconds
TestRunner_sco-tester         PASS      14.91 seconds
TestRunner_ioctl-tester       PASS      7.73 seconds
TestRunner_mesh-tester        PASS      5.84 seconds
TestRunner_smp-tester         PASS      6.74 seconds
TestRunner_userchan-tester    PASS      6.93 seconds
IncrementalBuild              PASS      27.88 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


---
Regards,
Linux Bluetooth


--===============2483978029752640205==--
