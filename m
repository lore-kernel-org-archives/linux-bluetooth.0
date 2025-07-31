Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C549F2F41
	for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 03:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753933111; cv=none; b=ict7dloilTYSWPe6Ghj2GuobdUZtBxiWOIOiYH3GxGlMzBozFSHjYa1CV4n8pIQXnGBmnBLVsEzjIHFg6vF5DWGziFUnyiptYX3GiBW7KtrOO2z8MBJAg1OSYvrHl/2/yej+xqbmSB5aUuRmiIxAjRfkZfW6WjzDtrzsRQDFfMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753933111; c=relaxed/simple;
	bh=cGVtN0W1akqMUefUgYNd+vz0X41qnzu5jmT40ZpLaj4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XH9qCJc1U+1E6CzBjG9XYqdfv8MFPmhs78lWUoJy5wPePD/bjgw4UcNSA4yLYBO/JV44f5paYB0ache9MLCPRvbTb/q2u3DajDiapYPQ8dh1F0AgRSXDMPySuSkVKsbDwy09L2PA6SrhChZJ0vvG4E7U1j5nIRJFO6avRnGSAfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiGfGC9t; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiGfGC9t"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e33d36491dso64487385a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jul 2025 20:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753933108; x=1754537908; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4Tkd1JucVkRLbep+1L00GZrptvM5SX5z60nCgvbaduk=;
        b=PiGfGC9tN9dt6H4fjgLk2r3rlT5IgBwQsdciPtg8YKsR4uIvz6RjX9jFoah+shkovh
         /Jv/OzpWN0hWg8f2C4EWeedgWvkzfi454BG5Bgq63+Za6DdxelxeiFP0qRjaPXcr97uR
         YhAvon5SgbH3z6sIGd7+ZUj4sOmJus6QV5poJky/l3CuSkmeZ4UkkB5Bf7VAs1NbNu1z
         lRO+Co3yc8hlQYxnQeemWruvXaVfvH/nd3/GKmKptJuzTUrtN93gc6fyTYO5B/S++76g
         UTxxsVqEjuF3GKPvDg/4UX+2TU8BXfqrUw1RShFaKvSry1yU24Rfo+vqggiqqaF8JwPW
         75Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753933108; x=1754537908;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Tkd1JucVkRLbep+1L00GZrptvM5SX5z60nCgvbaduk=;
        b=q1DSZJ9nzrc9FW1Uo2o/cappgr5IxdhBYvqb2ZMZT4rnk8b7apntzcmqy9PhfbHGGw
         Aeq019Vj21a+3OJAtwc5zJtoRvU7Wycw+kA0UFx/75MUrQgmO60GqJoHFZPISjCf5R8X
         xAlzkqC02FRotu8E63MmUQi9MuMqoSKhwH1pIrNFhD6eKytrPh2+yJ3qbCkHIBsmHci5
         FS/8izFFpj9YsYtYBT/g357WTRm3fSoRGcGrdkDXG0aiyAvHgd8ykcLhFb2lAbzNgncG
         CWDlexpk/bfrKgfFqpsdxItu+A56R6HAGJkU1PFgaZc6Jb3N/M6F4pSbbdZwm7maQgCj
         +VIA==
X-Gm-Message-State: AOJu0YygWnQj8PmOE9OxASGsvZyRD/uriYNTjYTBJZT3oD/E8j02nwJi
	mWQLgkPA7edz7RgNg3yBMpF/5lH6I10lW2829O11YrMWjkRIdP3w1Lad2QX0ew==
X-Gm-Gg: ASbGnctC6Emfe+DDRVsrGuEI1Ky0kHa85FPrHbb8bcckBC9WsjynDh42eeE7fWJe+MP
	ieXqVS20tUjRqDkboKGLjUJjZcqtkiDj0O5UWJljM6Fx7maQRaexQXEOoF4sVrNkaxWGaNeqDLZ
	orGKJhXJ0UbStQrAmz33ELFG59htRsNw1MMo0eGEw1Fwyt6CwHnnXmVAgyk+zWwyOGFBOtsNeBf
	ci7dpzhaGvq8wFOalJVN/EJhjexj1YDd3OdThkDOmQTl9zvVikRGEoyJiLCO1PrwCIdkF108O+3
	HfcV1OLu76m08njZ7kFLRonyZt3oj0QhSR+uCw/dXXc7YN4u3q3hEtc6JVBB6feaEUAdKU6cBEq
	hCtVvLw57aBgjrl9OfrN8hZUob0Q=
X-Google-Smtp-Source: AGHT+IEiVDdM+SCwmQg0itEQHB0UQ5erctW1KuRklTjwsTlc7am5/LSiKuAK7WEVvXjrx4Oa5TEnww==
X-Received: by 2002:a05:620a:a20e:b0:7e6:2f06:aca5 with SMTP id af79cd13be357-7e66f3aa6f7mr792601985a.61.1753933108387;
        Wed, 30 Jul 2025 20:38:28 -0700 (PDT)
Received: from [172.17.0.2] ([4.236.173.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f706406sm34994485a.49.2025.07.30.20.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 20:38:28 -0700 (PDT)
Message-ID: <688ae534.050a0220.3c34f.1065@mx.google.com>
Date: Wed, 30 Jul 2025 20:38:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7464531803029677498=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, salah.triki@gmail.com
Subject: RE: [V3] Bluetooth: bfusb: Fix use-after-free and memory leak in device lifecycle
In-Reply-To: <aIrSp18mz3GS67a1@pc>
References: <aIrSp18mz3GS67a1@pc>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7464531803029677498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=987211

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.58 seconds
CheckAllWarning               PASS      27.10 seconds
CheckSparse                   PASS      30.69 seconds
BuildKernel32                 PASS      24.34 seconds
TestRunnerSetup               PASS      485.22 seconds
TestRunner_l2cap-tester       PASS      24.93 seconds
TestRunner_iso-tester         PASS      44.50 seconds
TestRunner_bnep-tester        PASS      6.09 seconds
TestRunner_mgmt-tester        FAIL      127.01 seconds
TestRunner_rfcomm-tester      PASS      10.20 seconds
TestRunner_sco-tester         PASS      14.79 seconds
TestRunner_ioctl-tester       PASS      10.29 seconds
TestRunner_mesh-tester        FAIL      11.56 seconds
TestRunner_smp-tester         PASS      8.67 seconds
TestRunner_userchan-tester    PASS      6.30 seconds
IncrementalBuild              PENDING   0.44 seconds

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
LL Privacy - Add Device 3 (AL is full)               Failed       0.220 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.071 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7464531803029677498==--
