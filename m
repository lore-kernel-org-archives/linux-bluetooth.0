Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F8958B6A7
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067757; cv=none; b=D7+KgBQNT0JmyF5zOrE9wK523cdcW7oYk/jdqh6Vfz5Zs3+LHpp3yKO0Iy99HrDhdWmWfQzqUDzfUHzkS9p4HHXberyBPILvb+1/JX1iEGUFLFJtbgIcq/c5Bq6UsO18kjIecKklT6QxMVCITVoyP8fN18ENoOIdZBJBQtuDSL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067757; c=relaxed/simple;
	bh=u05WNvxjAV0K6VsjaAa2RdFxO7IDB38U8hkYcg70Wg0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DKeE4yCKkXpqNoY+CSEdJvHHdxM/rMAWfBSPyJkV82TmTrsfEgzc0RjpZ32z7lb9EMqijDdDEs5I/LJvR4izfQMjAtELh3dv+733sdrqbc3OFCG/y+IxShM9Xo/bT6qlMaZpwWsZqr72cxPRNbpqxptETLLDGkk3UuLWoVGJEdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4W3f7JO; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4W3f7JO"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6711a939a8bso81502d50.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 12:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789067755; x=1789672555; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vcBjbtrb/A9KPVhtBeOv6CXcAwOewchzeBmMqb2px08=;
        b=T4W3f7JO4qWSrYBX7LtsdCTsN2d1CX8CbigvXh6xobzpNgIcmfwoFWeebxU9mhDspm
         Fyjhun5YDh4xTKwRfXrGGMEqVQ2swYF8uR0MSMJ0X6Svk8x4kn9uUcufJ1LWlZrz7TGu
         Pxdd6tqZRhXxeJpHAK1CLlJHCdwDB5pnhcdGlWYNXpsNo8nrRK2+puuVgW2OZ5JfrzEl
         mZG3zFjhMANpqjjbTElvx7SI/hKnWVonBnHZPvI6HrGYk1xnpwgxfuwErl3yr9Emjw4M
         kPBsrvW6adjWtqjvtpHBvvCzG86tY/i4risqDQye/+JWXMufqb75+mofJaa3IY+LRE5n
         LqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789067755; x=1789672555;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vcBjbtrb/A9KPVhtBeOv6CXcAwOewchzeBmMqb2px08=;
        b=mvbv9QfzgaSEChIvaoeRUidTR8cnMXjPtZIKKr9DX3hCjk3g+CLK9N111fSSdlmzbR
         dj74o+TniqmxjQaCUEU+/18abVJXCESNvg4Q537GTr80Z9IdFSgjidGw3CB2EqgMViPI
         gAE7lCOT3lTmKWeo3SNZc8klSABn0PkA2ru0VrLTCbhm5s34IYY2BXlltX7HqgjtXScb
         lXmZe7KO2KFKGFRFaPF/f53+3/XKV8Kgax9azJXmLDRkER/X5PQXDMXyb1XY/EFbnajv
         n2uJ44Sr8QekWoOOdB0U1hzQtehJquZLFh4QBxSwWF4gZ+Qewx/L9bCW3T86ss9z+Wpo
         mfJA==
X-Gm-Message-State: AFuF++kbxkPY/0GJijUOwXHqJNAj7p9zmos3oQkN5aCklvE9dbaVRoHp
	/IwUT6GGSdxNILhH/cJaaBnqSYL1xKaU9fUOzsH6eKdHWkVH65zSdDn2d2s4Zg==
X-Gm-Gg: AYBFou1yO1XSi6QqVtAWueyg5cEnDR70X0yJ0SYlMnoUV8KpUzKD3S4a92sRjgFUncK
	7nuTMzHjXIGLYEuDeNDJz85fuzSWlLqogYGUukcKW7/U/QOSHVx9VED200XSAgm1KSatvXWt5D/
	6ksQUUrr71bRBvvGGtGoL8ZOwZS1xU9J5HcT5Tcj0AaSPxuehe8xE1ImkMZFVNwihQ2EawSd4bI
	eZYCkrPZBYngzVgAcc88jZF8d3CmCI8d5DpauAjvHmeuMo7zhabd2P/b7gAra8P5ZLXiGoo22BB
	1D9Xg6HreLuFbUFw985tPDcZJDyjJo/lIizq4Hio06Bbp9whpyqEYoKT7lwu0RCHwg8D8TIiepJ
	nozEoTgYyO9BGYtNS+kCu2Bc25a4B0MDm34K5ewJ85w1hiOvrPmRYTdM84vF9cr7g+vgk03ZWH2
	K0CyGBwMGTKWIlucNHlmXkZ5kyPsvOVpJKxX8w+oWjfJoyLHn3DQdp5BdryUjN572AwN+DGXtfA
	oIe
X-Received: by 2002:a05:690e:c4c:b0:66f:79dd:19b4 with SMTP id 956f58d0204a3-6712464da9amr536623d50.33.1789067755038;
        Thu, 10 Sep 2026 12:15:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.95.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f494620sm2893906d6.28.2026.09.10.12.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 12:15:54 -0700 (PDT)
Message-ID: <6aa301ea.c404bc25.2eb48f.ec4c@mx.google.com>
Date: Thu, 10 Sep 2026 12:15:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2276012069938985056=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, acharyalaxman8848@gmail.com
Subject: RE: [v2] Bluetooth: hci_codec: validate vendor codec count length
In-Reply-To: <20260824155736.54542-1-acharyalaxman8848@gmail.com>
References: <20260824155736.54542-1-acharyalaxman8848@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2276012069938985056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1151041/

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.47 seconds
BuildKernel                   PASS      29.66 seconds
CheckAllWarning               PASS      35.44 seconds
CheckSparse                   WARNING   36.90 seconds
BuildKernel32                 PASS      29.11 seconds
CheckKernelLLVM               PASS      35.62 seconds
TestRunnerSetup               PASS      789.33 seconds
TestRunner_l2cap-tester       PASS      43.14 seconds
TestRunner_iso-tester         PASS      121.86 seconds
TestRunner_bnep-tester        PASS      13.25 seconds
TestRunner_mgmt-tester        FAIL      150.14 seconds
TestRunner_rfcomm-tester      PASS      16.86 seconds
TestRunner_sco-tester         PASS      22.11 seconds
TestRunner_ioctl-tester       PASS      18.02 seconds
TestRunner_mesh-tester        FAIL      19.27 seconds
TestRunner_smp-tester         PASS      15.71 seconds
TestRunner_userchan-tester    PASS      13.48 seconds
TestRunner_6lowpan-tester     PASS      16.69 seconds
IncrementalBuild              PASS      28.17 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_codec.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structures
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.146 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.660 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds


https://github.com/bluez/bluetooth-next/pull/743

---
Regards,
Linux Bluetooth


--===============2276012069938985056==--
