Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7676F191F91
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750259093; cv=none; b=eWZvSuwiAfNiAUFYGYM4lX7mgDW8UINPO9K4dSAbTIrRnZPvH37/FFTeJvJdhyOnifNKKR3uQ1z7EDZxXdJmwXABEwvWLq8AlKHoLkH8AqhgH1hdXULOAMjcdhzEYiFcMuYIcskW0DSmKVAxqDRFlLrcrvc0d84CwbWNOHheSpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750259093; c=relaxed/simple;
	bh=Z7OO/x6uakbOgLqc600hb8aVH6ouVpSnMh6FZehpK/c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OSV40FoWnKzj3d8fw3FAJglwyrt14txQcHIBc2fhE8RvcsBvcMAJWrYYz1qglvDvfztEjWE1U/wuVvxz4xZtNDb09o4Hp1+JvL7DSy1YHBFxlnbKa4H9tHevVbJTtc+0Lb8szyuTMNeMEWevsYwmy/1uajkMLHfirm5d8fzCFQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H89+LMBu; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H89+LMBu"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d3e5df4785so102436685a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 08:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750259091; x=1750863891; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SkldpFc6ZWQGyemuJy3c81SZG6HVbFsyNLzlNyX+raM=;
        b=H89+LMBuPj5UpzNJ8OODjKzH+Ogbql2xZ724Tnt56JBKoZi3JZI6fpp5w8Fc35VFyp
         dLpb5Hg1ztn9eOFKdIEvRw+toLVhzBbMX0phnhrMDpOmys9ESewO2AIvU5Ri4z0lD+pc
         xl4Vks2hIstq1u4x6GvHpKWm4XiudJwLUCGQXRRCjV3hf+paLxuckwliMbG4ZMQOlWFJ
         WlQ4e4pJP5ire9DLwlpqjsLxiCudqyBJNAgfkX1q5m5sZO/xE72dtpXxKxy0zwbZgzGE
         m3KVO7FoQ0P619AVQC4h0bgGeA51xdRM8ujboFqt+qtS4ULbTQN3rDf8mKkJmZhoclqC
         2Diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750259091; x=1750863891;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SkldpFc6ZWQGyemuJy3c81SZG6HVbFsyNLzlNyX+raM=;
        b=Ik2Rki4oBzcU5fqzAWgymuIYpeozg5vTspzVrrOU7sxFDBnrUxqteFlJuDoxOm4ZnM
         oFXZrdSeUSxX2E9saYUz813tqABSAYiPIMR01yY5mhYu9/R1CwND+H1Gg39gzl4Y0vr4
         ovoYRZopU25Zk7hLKcq35FEFUQnivHKN3y3BRVks7Dz6S8d0GTsADqXo+LIsHdVlgU2Q
         RiNcVIdXcv137qK0LmsFgJeg5FfbCLcEpJXaiaNGcBIeF8d/GPPJp7yRPDr4YnzNzY1C
         YMCX2Vpm3B/IlB8/iP6o72uecxjy38PcjB3t28FOp7MwfoQPVGxxZ41AtE8a7r8I9gL+
         S6Kw==
X-Gm-Message-State: AOJu0Ywb4NPtGMLemnHJXncOSZnw5iRAuPiZI5mQ/onOkvYi2QetKNvC
	fwomU5DImA5S6isJf+6lGC8+dAO1GGWEqgyupdPvOvVjhzHp06YvmDM+Cb2F1w==
X-Gm-Gg: ASbGncuanO1nz8B4wsUPSsOlWPoBD58v6SxYLQTbvFmafc4yDmQ3u4X+wuIkbw5WhNq
	HE5uwI4RZdkjSZ0NgqMaMN3QQT1WiSUHX1iNWWBvGTnK5setmI0bdro7RCp3tz534RHFOZUkYOQ
	Y3SSMxiT7PS/yk0ap+j8II4no8b+fi7QEJOfMT++8qP6y1rwS7FkT7EqUkfjpynrH2ZGpwTyrXO
	b++6x15XRCWbbKJMu5iusETDkzrKBmM2ret/oRfa1yZn5cQDuynLtrC2xBdzmOSJg1QdSbJziWK
	gy5+1hS98mP5229TMU9M0blZlt2hkuidd+fleetSA8o0Fzca1XmJl9x2jksJn7PtAarp8Q==
X-Google-Smtp-Source: AGHT+IH1vi0B3dRNcpSotYNllRIkGJPITZ82xA4mDHJ4mBik/Z6WZ17RV/2v+kb6KERosPN2vwviZg==
X-Received: by 2002:a05:620a:4086:b0:7d3:e8b4:3386 with SMTP id af79cd13be357-7d3e8b43a15mr363436985a.0.1750259091176;
        Wed, 18 Jun 2025 08:04:51 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.76.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8eaca67sm767550985a.59.2025.06.18.08.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 08:04:50 -0700 (PDT)
Message-ID: <6852d592.050a0220.769d7.0894@mx.google.com>
Date: Wed, 18 Jun 2025 08:04:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3755423500564558231=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v2,1/2] dt-bindings: net: bluetooth: nxp: Add support for 4M baudrate
In-Reply-To: <20250618142012.25153-1-neeraj.sanjaykale@nxp.com>
References: <20250618142012.25153-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3755423500564558231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=973478

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 FAIL      0.42 seconds
BuildKernel                   PASS      25.00 seconds
CheckAllWarning               PASS      27.60 seconds
CheckSparse                   PASS      30.72 seconds
BuildKernel32                 PASS      24.31 seconds
TestRunnerSetup               PASS      462.31 seconds
TestRunner_l2cap-tester       PASS      25.85 seconds
TestRunner_iso-tester         PASS      38.85 seconds
TestRunner_bnep-tester        PASS      5.98 seconds
TestRunner_mgmt-tester        PASS      135.82 seconds
TestRunner_rfcomm-tester      PASS      9.32 seconds
TestRunner_sco-tester         PASS      14.99 seconds
TestRunner_ioctl-tester       PASS      10.20 seconds
TestRunner_mesh-tester        PASS      7.50 seconds
TestRunner_smp-tester         PASS      8.74 seconds
TestRunner_userchan-tester    PASS      6.06 seconds
IncrementalBuild              PENDING   0.49 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3755423500564558231==--
