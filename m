Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459A82C9A
	for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753961703; cv=none; b=g4aeXw4PWrrpldubX7N2d82zFsSZY7iVdn50kJl6cbz+umSFvHBCMm08KbZkaJmb6zY6keHEYJ23SDlciZ3u/GHSX3AztiRo0xpXz1VxwDUeS6QOU7gjF86DTGOdDETxJRw68obOrBb4RxQoND6QpD0FoMx+VursdlXXlHQX/YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753961703; c=relaxed/simple;
	bh=1/XgsysYJPqX5Co/v58XAJdBw9zwR/GNd9+UN22tQn8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Y3eQKXhcuj/hwCnIAvKAcmuFvkbSneHZWBddWkczI/TN2iYfMYrZhsIbpwBiS6qQKa9RUbW4DM0gnNktloogoq2wuOcIvtYhwvQAI5owNOhLymFJr+evnwhGVItlavZha0mknn4XQusVWLGVm6tTTAwCqud5DRyaL8UqHmPADOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lh0P+srI; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lh0P+srI"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2405c0c431cso7723145ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 04:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753961701; x=1754566501; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q6T7NRBSklWA8SWqrQXUnoMGB9UjW4k1ZuVKky+cags=;
        b=lh0P+srIyK1pRGivMScSU0jHOa/vHYV9dmOZYKUsvd8mX+cbfxX9wUWQ/ngopxupZX
         OexeNcYfqSLI21EA6+GgaRPvu+6ik49QSIZkLybUq6SLZWR622h9pF1Y9McvnGnmKdLa
         xdk2ScNh3agmTXUDDRy5C5jJA/6iY5QCWzfEOLe8uvpWEG03FgZ2/zvKWmzt0mrcla9o
         PHmUWL1CV2NfTw2zX15v9ANTGB6nIdjDLFWoWhgv/rLUjGLGMn9mY9vaYzTtz5AWWir0
         x0Y2rBYxh5F0MCsZ6WuzEuFNGHU7+M9Bwm57KTouafH8YrA14iC2MsG6Mi++EOVfUkbJ
         9GaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753961701; x=1754566501;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6T7NRBSklWA8SWqrQXUnoMGB9UjW4k1ZuVKky+cags=;
        b=wq2K2hkH+eNIdjqe/+OdC8dp18ySMcioW5Nc1YthqJuut247U6x5J7D4LRJ00endsy
         JeSm7jRc59HACS9wAXCKQoXDOTRNnjguv6xITqfT1i/xH/M+Nf8kQG3L86C6rAUac6Xx
         C8CqLi4JNiJL8tDBGYZ/J0FRu7/OOYPBcOpLIvbzxfjayeaZYuwTABxXiToQ0UNgS7Nq
         1/bNEwelSU76iFmthPxraaRPf4p+2vv4OsM966TQkgWN4A63ZZ11WePW7N19zk/yi4OH
         8fLhBooDr3AQBEbUjr7bMy8wQj+DyCWp1aV6ljdN8717DxsHQlcI8hymNYIqvYtO5oKi
         hVpw==
X-Gm-Message-State: AOJu0Yw+u9/dGtDpbngDS3wTU8d9ogzRRX1S2IHhRPEV2JogAQic/CPJ
	84JE5S23SujXtmR1eFgasA138qrbVNfqXtMwYUV0iyVugPOUbMo8/0g3emSXMw==
X-Gm-Gg: ASbGncsuv0Swd7kThFDfQs254uWG4HafBkKkd1d0hNqH+Poz+ePA3sb9jGO/dzRoL9k
	AWreJeDGAdGUv4zVs7SQjNNE4Z22hvECQ51B8nXEzFQbiaXKW7AWkknna0XeaSew5/43sqla1KP
	cGwDpJ1D4vNJxI9qHjggneRw9umktzD99Dr8maVd/SVYCElIoya2AWqPdszDuU6bVU4KeLGiYRu
	eJtcFXWQ7UvbKMv66Gz3YmaEu7s1DUIZnXbzRJhJut0YhRBOUnpZXMB9G4Qjkw1G8W5V+Y+fjwL
	nkeLlbTs62xFVrKtkrES1td3z0IZ4VRaoUj3HeNgcLLhgfEgFB2trW47ZIx73EgArRP+OJBs6J5
	BE4s+/2UQBT7ifg6xHDVKJNaEDTlJfw==
X-Google-Smtp-Source: AGHT+IHvkxi22vJri+x67QgeuQ9W+pvxX996/xKKVPKTU5tyyRrTD+uyfAGgC/BGFJ19VmpoaAAIQQ==
X-Received: by 2002:a17:903:1b43:b0:240:2eb6:d5c3 with SMTP id d9443c01a7336-24096a684e2mr83240385ad.15.1753961701020;
        Thu, 31 Jul 2025 04:35:01 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.244.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b785696sm1176880a12.9.2025.07.31.04.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 04:35:00 -0700 (PDT)
Message-ID: <688b54e4.050a0220.2c2f5e.2c4a@mx.google.com>
Date: Thu, 31 Jul 2025 04:35:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3877560368222359503=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Define hdev->wakeup() callback
In-Reply-To: <20250731111711.1456427-1-kiran.k@intel.com>
References: <20250731111711.1456427-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3877560368222359503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=987331

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.31 seconds
CheckAllWarning               PASS      27.56 seconds
CheckSparse                   PASS      31.00 seconds
BuildKernel32                 PASS      24.33 seconds
TestRunnerSetup               PASS      485.25 seconds
TestRunner_l2cap-tester       PASS      25.36 seconds
TestRunner_iso-tester         PASS      39.63 seconds
TestRunner_bnep-tester        PASS      6.16 seconds
TestRunner_mgmt-tester        PASS      127.48 seconds
TestRunner_rfcomm-tester      PASS      9.87 seconds
TestRunner_sco-tester         PASS      14.67 seconds
TestRunner_ioctl-tester       PASS      10.15 seconds
TestRunner_mesh-tester        FAIL      11.39 seconds
TestRunner_smp-tester         PASS      8.65 seconds
TestRunner_userchan-tester    PASS      6.36 seconds
IncrementalBuild              PENDING   0.72 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.908 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3877560368222359503==--
