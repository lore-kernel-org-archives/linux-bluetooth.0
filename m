Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5534421661C
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663937; cv=none; b=uuT3ghL9XUKW2wO2XmqSv1kXUHioVuxDFTVcNL3gfX8/slEGA3Q5U7ZqFm+lNmeZbVaTWTT+pDTouaUMA6oPTrsghhD3KZSKfeJOMde2/0oObXGrDLBwh5XeMSm9aBUC48C+LpACvIuRLYUi0cInMAH3C8qk/XV06CpjOEqBZz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663937; c=relaxed/simple;
	bh=YdEz8Tu4Z0rH7kGmxqGRoiFef3EwiyuntDGUnnunT9k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aIlhBrfgPVevq2nUPLDNM7r3cljVMHFojDs1XawlcMYN4PXOFhtl1vT6D3iZ5K4l+PnQYeP7OpNiFFky4AqZKfs/Vpkl83w3aGc4RaQMNgAywp6T4LMykuYA3uRM89ccKaa6qccR1I85J5JvhtVkn89diuloGBv2nBiL6bdkR0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tr7cz4W5; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tr7cz4W5"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fe848040b1so1988843a91.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 05:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740663933; x=1741268733; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cHQ/xb4YbiqbWc8bR9y0IO+e7PBXR59rXsLX2sln7Oc=;
        b=Tr7cz4W5SBh833lLf3GMVoiFLhgxJwhgxPVkFpVs5ytGl/Cx9OIblA9Hvy87+2LlLx
         GA3Olceta5eiL3YBuG72upltAColupJO899VzIceBEzgNN98KyhrC4+7fEPGUa/C0pPZ
         hsugWlX7abtD7U2VuGbmJMRPaboqQM6pcCBoG3DSxWm4jigy7mKAVcGfkfbOGpuawUTo
         Al1X0j7S78Xl/ej1tONL8B0LbuO2DbJ3d9TPKYd1Ll3Ad+OsWK6OEBltg6ZMcFKPdTiZ
         lnZMH19zj2aj4Vkki+7H2SLEkOHm7p0JF2GDLakpvjP/O3f3stu8QZwcaPVTo9gT9H4t
         9ACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740663933; x=1741268733;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHQ/xb4YbiqbWc8bR9y0IO+e7PBXR59rXsLX2sln7Oc=;
        b=rE6yi2YdVVD2jKv/0Lekbm1xNrNyqt/25CVAbShHx+P0oeJsz5H1SbreSI//0ADd03
         Z4vUcGWm9MwZyDs6mRuivUF1L7HyK3pPIDNYQIefOsH7DQfJTjup2umryvtnQe4Xmk7w
         LrtTr6fVJKz/78yPgZsraywEu0RVN24v3WDEcRo4n+1deKnYvQ0jS6bemjhe6KLMDA2Y
         ReYqC6GU76RBsH5rqFD1JJ16HDqAzJCPwAaQCDQSFBfLP4fradn6xdxoJaAbnWwfC40o
         vk+78sBq2pah5GfzjBB6qQA1hazJkS3nDzcRqmJ9JPA1hUaAA8GJ1SJhaFt4NptK5y04
         6ZyA==
X-Gm-Message-State: AOJu0YyCn6F3CBBbP45deXepI35mWkLt0JXsLIj8ZzlUzIGKzct5X85g
	ErVUfAkTwhHsg9DIfHV70gmbIfKNuxoiZTGD75P2qEDjvEkd6TJXVY9rMg==
X-Gm-Gg: ASbGncsAkorrbyaPcSYshV95iDtnOkUMb0e7ATcKXBsR7jIGM5UFqjxCB3anOo9o5Hf
	z5zinnYmlA60cwlovbCPRo/vDRe9LOb8zKOeWeyJj60qWVOIi55i5PP4tXF2+bh6OQkEKbaNOMb
	rv7DTqq84qWrKVecX1e4Fz02f1rSa29REhjwbcKmxKMdo68zsSALsG4bqkRHQcczhE1iUSsWHFD
	lvowSVwRqM/gRdO9IE+n/9GsE+D9Wifupytxc1nYOXNw7mtaws3/nHF4g6Xobq71/zu6Y6zvsNt
	7S1qWu4qXjCu6msEmzX/JSKjeRhPpgw=
X-Google-Smtp-Source: AGHT+IEZw295ApgaaVjz/QO0IaWG90XIm7WtIIqn7nB2mLqHWbxNY5Owjh/N8gbpqcyP1k08B18Fcg==
X-Received: by 2002:a05:6a21:789e:b0:1ee:cf13:d4ba with SMTP id adf61e73a8af0-1eef5560b61mr38547808637.27.1740663933144;
        Thu, 27 Feb 2025 05:45:33 -0800 (PST)
Received: from [172.17.0.2] ([52.234.2.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe2b854sm1563147b3a.33.2025.02.27.05.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 05:45:32 -0800 (PST)
Message-ID: <67c06c7c.050a0220.2d7d7c.7df0@mx.google.com>
Date: Thu, 27 Feb 2025 05:45:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2639089776803169102=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arnd@kernel.org
Subject: RE: Bluetooth: btintel_pcie: fix 32-bit warning
In-Reply-To: <20250227132132.1171583-1-arnd@kernel.org>
References: <20250227132132.1171583-1-arnd@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2639089776803169102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=938526

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.32 seconds
CheckAllWarning               PASS      26.64 seconds
CheckSparse                   PASS      30.21 seconds
BuildKernel32                 PASS      23.91 seconds
TestRunnerSetup               PASS      429.81 seconds
TestRunner_l2cap-tester       PASS      20.92 seconds
TestRunner_iso-tester         PASS      31.77 seconds
TestRunner_bnep-tester        PASS      4.76 seconds
TestRunner_mgmt-tester        FAIL      121.96 seconds
TestRunner_rfcomm-tester      PASS      7.90 seconds
TestRunner_sco-tester         PASS      9.59 seconds
TestRunner_ioctl-tester       PASS      8.55 seconds
TestRunner_mesh-tester        PASS      6.13 seconds
TestRunner_smp-tester         PASS      7.24 seconds
TestRunner_userchan-tester    PASS      4.92 seconds
IncrementalBuild              PENDING   0.47 seconds

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
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.167 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2639089776803169102==--
