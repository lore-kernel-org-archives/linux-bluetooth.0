Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D104928D8C3
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092631; cv=none; b=shPGac9e2V6HuAt7zjw/TTi+LmNwxhS/a9v/soqbWYOimiuE7CvcALvTXiOJDrfJ1jm2JoFYibmpRyccsqwsaIfOVP6p8QnOCIS5JtiE6+xPn5EqCF4yGo+0kCkJu36GYWE0C29jOmwy/HSVXw+fpdFqcGTUm7kSb+G72zl7z4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092631; c=relaxed/simple;
	bh=t5I+2bkdaqXQ+Ag+CyCIvhSQk1mmQ36C/Szd63Vo2cc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bK9nmx0ti83p3obbyZDbn76Beh5g3aG6B97NyIOuLhNlOZgsO2O4VI79pN95+uiqcqNfnAq00irsNW0GAE9G3FvhjCBmIQ7hqo4fo48U2aKiWK+k72PokaBTQeugdV4ffMRdk63FL/a5FEWteGw0er92WB2cV3E4WjvAsQtqt8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnAbMjER; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnAbMjER"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4abc0a296f5so30262901cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 03:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753092628; x=1753697428; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zvDvoR20kYtSIPmXtS/QSa7esoY5JJRjrAX5ec0QGIQ=;
        b=NnAbMjERpoCbQyGMpcxG4dlW+5PqQLkVdWc9gUTyyHrmFbWF1Yv6WsdavuDDpPi3VN
         whLgvpzk11K/01aALiG7k6FAJfthNz39aLtoLJVWJRop51j3p/d3f1ZHrtZeQK2fU+cy
         1uAKofAOyl0Ux/RYLud4t2HEcJ5Bjo6ITdu+1wBJTavUa4eV6C1jlWxlb86YJMYhJCEX
         huNYmPLad6y5Po7ECf+qV/yVp7JKwcHxz35+doCl4PwNCFH1C2ahIwacF4B3w9U+bS97
         a/i/tFPNuqXSRW87V14RCouoKThxcvbOX9oLZ8Y1UIlx75PSm+xWYYr3qcq4v8il/7N3
         +Yew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753092628; x=1753697428;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zvDvoR20kYtSIPmXtS/QSa7esoY5JJRjrAX5ec0QGIQ=;
        b=Mx0S5HQMHBCVdgyTkyEqrTd4x9lKS65v/eqooNGGmIm/ErrlSnwcZgo6ADsE4gAH3q
         iBzj293lPwccRF9Q7Lv9GLV3lWtZV8Fxwyt5TCShPmH9ZU/2wTIQhRHyAr3qn5DRbE1g
         KD2X4P7YeSjsoyvYs0plRzNJVo5Tqt0E1XRHM8aQh1lDRx4r/dylpEDaEWEVZbdRS0HU
         0cY9sx8r4Xvy/z+1oVBTnaRg0qjYlVuKY3b7jxyZK2eMkKj1IQkVsddRn+yygVpsmBGa
         pgWqP/xeGXklHPkV9nirAalPXEPI5Mpc0fQOA6gw8oVFtJ/v6p0Ueu0E2NlGxaHdHR5T
         S4MQ==
X-Gm-Message-State: AOJu0YxdV8/bW3QEQlPhhNkkDYwtqgyxmdWxyxr1GIulpZdlP9ADGY1I
	q+d1INehUGqmtoI5CDkEBLbNZXOwPQAO0jipnUjCfy1EXGmiqXPQOr1GFUZ0fw==
X-Gm-Gg: ASbGncvKmKL45Gdh6yfTZqPr04hHSdMOng3eLeUL8iZqAx/nJ04sKIVHZ5cTkcUYXAR
	esO6MNx+RyOkfjFq5kalxt6PMAc7iwL3zCzg/2FAe/s91kyIpLDML6rGil+w30N9AewIUwdrch6
	6ex5DpQhph++QxSIJ39h/s8cCHzXDdImk9FwMYWrjq6ZcFMAATpcXd9etJkD1wmso7MXYV8HCnr
	0AfHYZ+b8bNIDJyvxUMDaiAhWyZ4uvWWSXkeOWrX6coNL1siM2Eu2NY9CNE4I8vYLVlT1fmAHTk
	C8GptE7Vvgg86Wo+MOVg6sdj87fHcFh9RF2p+/FpKNk+OTBfQexUcYoR0unw01ph25uxen0ycnv
	5COxiViKStRaRfDb1oMi+1oN3xybTIA==
X-Google-Smtp-Source: AGHT+IGob1EmTjcoz9yHVYTHbUDrkqAPTuyf0C0P8xY/8DFrITrVK8aNhkXUpoQfdxbf56D/hj+PYA==
X-Received: by 2002:a05:6214:c2f:b0:702:da1d:7b6 with SMTP id 6a1803df08f44-704f6b5c804mr328654156d6.39.1753092628357;
        Mon, 21 Jul 2025 03:10:28 -0700 (PDT)
Received: from [172.17.0.2] ([172.178.119.18])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051badec84sm38155256d6.112.2025.07.21.03.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:10:28 -0700 (PDT)
Message-ID: <687e1214.d40a0220.360dcf.a314@mx.google.com>
Date: Mon, 21 Jul 2025 03:10:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5880999050982382098=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v3,1/2] Bluetooth: btintel_pcie: Make driver wait for alive interrupt
In-Reply-To: <20250721094437.1163753-1-kiran.k@intel.com>
References: <20250721094437.1163753-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5880999050982382098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=984250

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      3.36 seconds
BuildKernel                   PASS      24.37 seconds
CheckAllWarning               PASS      26.94 seconds
CheckSparse                   PASS      31.39 seconds
BuildKernel32                 PASS      24.48 seconds
TestRunnerSetup               PASS      479.39 seconds
TestRunner_l2cap-tester       PASS      25.48 seconds
TestRunner_iso-tester         PASS      42.71 seconds
TestRunner_bnep-tester        PASS      6.03 seconds
TestRunner_mgmt-tester        FAIL      132.29 seconds
TestRunner_rfcomm-tester      PASS      9.54 seconds
TestRunner_sco-tester         PASS      14.92 seconds
TestRunner_ioctl-tester       PASS      10.28 seconds
TestRunner_mesh-tester        FAIL      11.46 seconds
TestRunner_smp-tester         PASS      8.85 seconds
TestRunner_userchan-tester    PASS      6.37 seconds
IncrementalBuild              PENDING   0.43 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.204 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.237 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.220 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.981 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5880999050982382098==--
