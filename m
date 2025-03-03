Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173D523CEF0
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Mar 2025 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021400; cv=none; b=D8kBpBzRQT8FKvWnxgbA46x/dgDYx1rBmyG7Jf+IIt6HZirxWC5L6Q9iOKYVuJaIaBaP4vvilkeWqJdTiDj3JJ+QiAZ/+5vQq9apea/dJIrfax+R3RCFsrKTZGlVWFhqbbvuIB5slbIuJ/XoiN9UPSxhEdwpcEVbBDMrlOOCzro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021400; c=relaxed/simple;
	bh=+K2MEUtBI1iCLC6D/PboGoLSvDCRwd6mfcZtMPZSBq4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=g8QD+nDFzOUdt4lEsYPgGBBrD8c+kLbwj7R84RQBoTKdcKNq0cRUJmnycapv4SAHrZrNNecHbMuk0cEQtmZzZwGszyzBYfNi6xkuhgs1aktllD6CBH1HOXAFZbmB+J4U/2rMzMZynW7v19nZ0mh5H16ZBKKIdfcV9Av+KE5aB0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCUucRe7; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCUucRe7"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4721f53e6ecso46782381cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Mar 2025 09:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741021398; x=1741626198; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e3z0AJH2JMkrMH2bMR/1R0Py1ivP+jVXQZ5Xgc/sssM=;
        b=JCUucRe7zCO3WvynURhAWVyFPUDqZlyrdsy6HKoLw7PgMgrdZlDxQm9OSzpY+E13SF
         1u4XxgbbOiElEHuZ31HVWL9uWXrzXV2HgN8J225CvBfVpR9wKauWprwmpYyp+BLT0Ytb
         BvLoHqz1OqdJVcZGOuZJdKjd3kdp7HJ+RmpwWxi7y7to0al1q4x71XzJUYyFxuuP7ivH
         CfFUeb25w3ABO9AAqwjLBWlfXbx913dqA4NkrOsD85eWC6YFnMTRemIZhnrK0J/63WIX
         rPhBuN8933bPckT6ToHLw2YoT/AoJ6hE0ENFT/gF0bO/fxOU7/1hDYNH1JPRC55PGtvC
         bEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741021398; x=1741626198;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e3z0AJH2JMkrMH2bMR/1R0Py1ivP+jVXQZ5Xgc/sssM=;
        b=DoZ9Cn+fgpNs75rwoR3IZYYRane8q5eobfWrGrQeyxiai3F7Jrqyka2tF+hRmpg1ms
         ypg5yMORoveOIQ8XDGahpVXDkgo63vRC6IkpXogVomZOUaxMhPjXkAhzfEMkCLIRRe2y
         xOG8seqwejzGqUI7Iy6AnsRkAWSrbCy2bDVR8Vf5NRuiOLZLp4e40IBtbEKCF+48zi5b
         eOygXqCvXocXfRm9yD2aNoO7FUIXtO0Rby2a6QP9hc+4tKEcGSPgTCFyy3/uv+VwisEh
         kEC8IRXLyb8rQK+DuX4Wh1lSVSkpimcOejuOOYUJm/CwFD2KKlFas7lzCVuPWpjlI3W1
         lS4g==
X-Gm-Message-State: AOJu0Yw3d1rTBdcqhv/d9XxGjt9asqHxBkGSEjYJWcjNsL/qADrYwJf1
	JZ5PDSqJSrpSkatQpKY98ohBelPa19wlsJTPKdl/vq6wim1V/GRZ8vguuw==
X-Gm-Gg: ASbGncvo+f+9zwqf+eTzlYyJJ8FY3MV8tsTdRorhSvzd1SgMNRJpb8xQOqD+F9fwVtf
	azS8XCWY3tDULIPduC9cA5F4+WqOPdWcJVvdD3aZeq4RId9vkYF+GQGWnxu7FKo9C+ZfSuUQbnE
	/z1fy2XxOdRlN2kDPMD+bUAZIik/xHMUDt/gYQhAaFWG2DHopb7BAu3QrfkmLQVumz25kjlTz3k
	iEb/X6kQxhK8pkx/+aqifHKHR838N97pBldsp884ba5/5LTtIw4ai+V8yoFTZ9geBAcUen62mC8
	NCKu95pWWpEFqno0zmbn7BgspG+Nq2TmOzamvjXNF34aZkfYZw==
X-Google-Smtp-Source: AGHT+IFMtlnE0tejCZX668zz3sLLwG0lZzf/59CcgUr9oT9aeOpydurzegF2cT/YcpAD7ofB12cC5A==
X-Received: by 2002:a05:622a:148f:b0:473:884e:dcfe with SMTP id d75a77b69052e-474bc0f40fdmr175674391cf.39.1741021397666;
        Mon, 03 Mar 2025 09:03:17 -0800 (PST)
Received: from [172.17.0.2] ([20.246.78.50])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474ec447f24sm12511661cf.57.2025.03.03.09.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 09:03:17 -0800 (PST)
Message-ID: <67c5e0d5.050a0220.b1653.3dc4@mx.google.com>
Date: Mon, 03 Mar 2025 09:03:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7997972145394441738=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2] Bluetooth: btintel_pcie: Add support for device coredump
In-Reply-To: <20250303164527.218458-1-kiran.k@intel.com>
References: <20250303164527.218458-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7997972145394441738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=939693

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.55 seconds
CheckAllWarning               PASS      27.02 seconds
CheckSparse                   PASS      31.04 seconds
BuildKernel32                 PASS      24.14 seconds
TestRunnerSetup               PASS      439.18 seconds
TestRunner_l2cap-tester       PASS      21.29 seconds
TestRunner_iso-tester         PASS      36.18 seconds
TestRunner_bnep-tester        PASS      4.96 seconds
TestRunner_mgmt-tester        FAIL      122.69 seconds
TestRunner_rfcomm-tester      PASS      7.95 seconds
TestRunner_sco-tester         PASS      11.85 seconds
TestRunner_ioctl-tester       PASS      8.40 seconds
TestRunner_mesh-tester        PASS      6.05 seconds
TestRunner_smp-tester         PASS      7.25 seconds
TestRunner_userchan-tester    PASS      4.99 seconds
IncrementalBuild              PENDING   0.58 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.216 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.151 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7997972145394441738==--
